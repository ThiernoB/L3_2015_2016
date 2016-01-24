#load "graphics.cma";;

type state = {
  mutable alive : bool;
};;

type formula =
    True | False
  | Var of int
  | Neg of formula
  | And of formula * formula
  | Or of formula * formula;;
	
type rule =  {
  mutable str : string
};;

type generation = {
  mutable cells : state array array;
};;

type automaton = {
  mutable rules : rule list;
};;

let alive_true : state = {
  alive = true;
};;

let alive_false : state = {
  alive = false;
};;

let create_rule (s : string) : rule = {
  str = s
};;

let add_rule (auto : automaton) (r : rule) : automaton = {
  rules = r::auto.rules;
};;

let set_rules (auto : automaton) (r : rule list) : automaton = {
  rules = r;
};;

let create_generation (n : int) : generation = {
  cells = Array.make_matrix n n alive_false;
};;

let create_automaton : automaton = {
  rules = [];
};;

let verif_state (s1 : state) (s2 : state) : bool = s1.alive = s2.alive;;

let string_of_rule (r : rule) : string = r.str;;

let neighbor_north (gene : generation) (length : int) (i : int) (j : int) : state = 
  if i = 0 then 
    Array.get gene.cells.(length) j 
  else 
    Array.get gene.cells.(i - 1) j;;

let neighbor_south (gene : generation) (length : int) (i : int) (j : int) : state = 
  if i = length then 
    Array.get gene.cells.(0) j 
  else 
    Array.get gene.cells.(i + 1) j;;

let neighbor_east (gene : generation) (length : int) (i : int) (j : int) : state =
  if j = length then 
    Array.get gene.cells.(i) 0 
  else 
    Array.get gene.cells.(i) (j + 1);;

let neighbor_west (gene : generation) (length : int) (i : int) (j : int) : state =
  if j = 0 then 
    Array.get gene.cells.(i) length 
  else 
    Array.get gene.cells.(i) (j - 1);;
	
let neighborhood (str : string) : state list * state =
  let v1 = if str.[0] = 'A' then alive_true else alive_false in
  let v2 = if str.[1] = 'A' then alive_true else alive_false in
  let v3 = if str.[2] = 'A' then alive_true else alive_false in
  let v4 = if str.[3] = 'A' then alive_true else alive_false in
  let cell = if str.[4] = 'A' then alive_true else alive_false in
	
  ([v1; v2; v3; v4], cell);;

let show_generation (gene : generation) : unit =
  Graphics.open_graph " 500x500";
  Graphics.set_window_title " Projet PF";
  let n = Array.length gene.cells.(0) in
  for i = n - 1 downto 0 do
    for j = n - 1 downto 0 do
      let cell = Array.get gene.cells.(i) j in
      if cell.alive = true then
	Graphics.set_color Graphics.red
      else
	Graphics.set_color Graphics.black;
      Graphics.fill_circle (250 + j*10) (200 - i*10) 3
    done
  done;;

let parse (in_chan : in_channel) : int * automaton * generation =
  let separator : string ref = ref (input_line in_chan) in
  let length : int = int_of_string !separator in
  let auto = ref create_automaton in
  let gene = create_generation length in
  
  while (String.compare !separator "GenerationZero") != 0 do
    separator := (input_line in_chan);
    auto := add_rule !auto (create_rule !separator);
  done;
  auto := set_rules !auto (List.tl (List.rev (List.tl !auto.rules)));
  
  for i = 0 to length - 1 do
    separator := (input_line in_chan);
    for j = 0 to length - 1 do
      if !separator.[j] = 'A' then
	Array.set gene.cells.(i) j alive_true;
    done;
  done;
  
  (length, !auto, gene);;
	
let verif_rule (gene : generation) (n : int) (i : int) (j : int) (v : state list) : bool =
  let state1 = neighbor_north gene n i j in
  let state2 = neighbor_east gene n i j in
  let state3 = neighbor_south gene n i j in
  let state4 = neighbor_west gene n i j in
  let v1 = List.nth v 0 in
  let v2 = List.nth v 1 in
  let v3 = List.nth v 2 in
  let v4 = List.nth v 3 in
  
  (verif_state state1 v1) && (verif_state state2 v2) && (verif_state state3 v3) && (verif_state state4 v4);;
	
let show_voisin (gene : generation) (n : int) (i : int) (j : int) : unit =
  let cell = Array.get gene.cells.(i) j in
  let v1 = neighbor_north gene n i j in
  let v2 = neighbor_east gene n i j in
  let v3 = neighbor_south gene n i j in
  let v4 = neighbor_west gene n i j in
  
  Printf.printf "\t%b\n%b\t%b\t%b\n\t%b\n\n" v1.alive v4.alive cell.alive v2.alive v3.alive;;
	
let next_generation (auto, gene : automaton * generation) : generation = 
  let n = (Array.length gene.cells.(0)) - 1 in
  let cell_evol = ref false in
	let new_gene = create_generation (n + 1) in
	
  for i = 0 to n do 
    for j = 0 to n do
      (try
	for k = 0 to ((List.length auto.rules) - 1) / 2 do
	  let str = string_of_rule (List.nth auto.rules (k * 2)) in
	  let v, c = neighborhood str in 
	  if (verif_rule gene n i j v) then
	    begin
	      Array.set new_gene.cells.(i) j alive_true;
	      cell_evol := true;
	      raise Exit;
	    end;
	done;
      with Exit -> ());

      if !cell_evol = true then
	cell_evol := false
      else
	Array.set new_gene.cells.(i) j alive_false;
    done;
  done;
  new_gene;;


(*
  AAAA
  NESW
*)

let rec string_of_formule f = match f with
    True -> "true"
  | False -> "false"
  | Var s -> "Cell("^string_of_int s^")"
  | Neg f -> "Neg("^string_of_formule f^")"
  | And(f1, f2) -> "("^string_of_formule f1^" And "^string_of_formule f2^")"
  | Or(f1, f2) -> "("^string_of_formule f1^" Or "^string_of_formule f2^")";;

let rec union_sorted l1 l2 = match l1, l2 with
    _, [] -> l1
  | [], _ -> l2
  | a1::l1, a2::l2 ->
    if a1 < a2 then a1::(union_sorted l1 l2 ) else
      if a2 < a1 then a2::(union_sorted l1 l2) else
	a1::(union_sorted l1 l2);;

let rec list_of_vars f = match f with
   Var s -> [s]
  | Neg f -> list_of_vars f
  | And(f1, f2) | Or(f1, f2) -> union_sorted (list_of_vars f1) (list_of_vars f2)
  | _ -> [];;


let rec eval_formule f l = match f with
    True -> true
  | False -> false
  | Var s -> (List.assoc s l)
  | Neg f1 -> not (eval_formule f1 l)
  | And(f1, f2) -> (eval_formule f1 l) && (eval_formule f2 l)
  | Or(f1, f2) -> (eval_formule f1 l) || (eval_formule f2 l);;


let rec eval_sous_formule f = match f with
  | And(f1, f2) -> begin
    match (eval_sous_formule f1, eval_sous_formule f2) with
      | False, False -> False | False, True -> False
      | True, False -> False | True, True -> True
      | (f1, f2) -> And(f1, f2)
  end
  | Or(f1, f2) -> begin
    match (eval_sous_formule f1, eval_sous_formule f2) with
      | False, False -> False | False, True -> True
      | True, False -> True | True, True -> True
      | (f1, f2) -> Or(f1, f2)
  end
  | Neg f -> begin
    match eval_sous_formule f with
      | True -> False | False -> True
      | f -> Neg f
  end
  | f -> f;;
	
	
let simplifie_formule f = match f with
  | And(f1, f2) -> begin
    match (eval_sous_formule f1, eval_sous_formule f2) with
      | False, _ -> False
      | _, False -> False
      | True, True -> True
      | (f1, f2) -> And(f1, f2)
  end
  | Or(f1, f2) -> begin
    match (eval_sous_formule f1, eval_sous_formule f2) with
      | True,_ -> True
      | _, True -> True
      | False, False -> False
      | (f1, f2) -> Or(f1, f2)
  end
  | Neg(f) -> begin
    match eval_sous_formule f with
      | True -> False | False -> True
      | f -> Neg f
  end
  | f -> f;;

let rec desc_neg f = match f with
    Neg(Neg g) -> desc_neg g
  | Neg(Or(g, h)) -> And(desc_neg(Neg g), desc_neg(Neg f))
  | Neg(And(g, h)) -> Or(desc_neg(Neg g), desc_neg(Neg f))
  | Or(g, h) -> Or(desc_neg g, desc_neg h)
  | And(g, h) -> And(desc_neg g, desc_neg h)
  | f -> f
;;

let rec desc_ou f = match f with
    And(g, h) -> And(desc_ou g, desc_ou h)
  | Or(g, h) ->
    let g = desc_ou g 
    and h = desc_ou h in (match g, h with
	_, And(g, h) -> And(desc_ou (Or(g, g)),desc_ou (Or(g, h)))
      | And(f, g),_ -> And(desc_ou (Or(f, h)),desc_ou (Or(g, h)))
      | _ -> Or(g, h))
  | f -> f
;;

let rec fnc f = desc_ou (desc_neg f);;


let int_of_var (v : formula) : int = match v with
    Var s -> int_of_string s
  | _ -> raise Exit;;

let formula_of_state (s : state) =
  let aux (b : bool) : formula = match b with
      true -> True
    | false -> False
  in aux s.alive;;
	

let north (arr : int array array) (length : int) (i : int) (j : int) : int = 
  if i = 0 then 
    Array.get gene.cells.(length) j 
  else 
    Array.get gene.cells.(i - 1) j;;

let south (arr : int array array) (length : int) (i : int) (j : int) : int = 
  if i = length then 
    Array.get gene.cells.(0) j 
  else 
    Array.get gene.cells.(i + 1) j;;

let east (arr : int array array) (length : int) (i : int) (j : int) : int =
  if j = length then 
    Array.get gene.cells.(i) 0 
  else 
    Array.get gene.cells.(i) (j + 1);;

let west (arr : int array array) (length : int) (i : int) (j : int) : int =
  if j = 0 then 
    Array.get gene.cells.(i) length 
  else 
    Array.get gene.cells.(i) (j - 1);;

let neighbor_formula (v : state list) =
  let c1 = List.nth v 1 in
  let c2 = List.nth v 2 in
  let c3 = List.nth v 3 in
  let c4 = List.nth v 4 in
  let c5 = List.nth v 0 in

  Et (Var (string_of_formule (formula_of_state c1)),
      Et (Var (string_of_formule (formula_of_state c2)), 
	  Et (Var (string_of_formule (formula_of_state c3)), Et (Var (string_of_formule (formula_of_state c4)),
								 Var (string_of_formule (formula_of_state c5))))));;


let rec aux (r : formula list) = match r with
    [] -> raise Exit
  | [e] -> e
  | hd::tl -> And (hd, (aux tl));;

let global_policy : automaton = {
  rules = [{str = "AAAAA"}; {str = "AAADA"}; {str = "AADAA"}; {str = "ADAAA"}; {str = "DAAAA"};
	   {str = "AADDA"}; {str = "ADADA"}; {str = "DAADA"}; {str = "ADDAA"}; {str = "DDAAA"};
	  {str = "ADDDA"}; {str = "DADDA"}; {str = "DDADA"}; {str = "DDDAA"}; {str = "DDDDA"};]
};;

let simpl_policy (auto : automaton) : automaton =
  let rules = ref [] in

  for i = 0 to (List.length global_policy.rules) - 1 do
    try
      for j = 0 to (List.length auto.rules) - 1 do
	let r = List.nth global_policy.rules i in
	if (String.compare (string_of_rule r) (string_of_rule (List.nth auto.rules j))) != 0 then
	  rules := r::!rules
      done;
    with Exit -> ();
  done;

  for k = 0 to ((List.length auto.rules) - 1) / 2 do
    rules := (List.nth auto.rules ((k * 2) + 1))::!rules
  done;
  set_rules create_automaton !rules;;

let formula_of_char (c : char) : formula = match c with
    'A' -> Var 1
  | 'D' -> Neg (Var 1)
  | _ -> raise Exit;;
	
let formula_of_string (str : string) : formula =
  let c1 = String.get str 0 in
  let c2 = String.get str 1 in
  let c3 = String.get str 2 in
  let c4 = String.get str 3 in
  let c5 = String.get str 4 in
	
  (Or (formula_of_char c1, Or (formula_of_char c2, Or (formula_of_char c3, Or (formula_of_char c4, formula_of_char c5)))));;
		
let rec verif_rule_from_policy (rules : rule list) (form : formula list) : formula list = match rules with
    [] -> form
  | hd::tl -> verif_rule_from_policy tl ((formula_of_string (string_of_rule hd))::form);;

		
let stables (auto, d : automaton * int) : formula = 
  let rules = ref [] in
  let tmp = ref [] in
  let array = Array.make_matrix d d 0 in
  let pol = simpl_policy auto in

  for i = 0 to (d - 1) do
    for j = 0 to (d - 1) do
      Array.set array.(i) (j) ((d * i) + j + 1);
      tmp := (verif_rule_from_policy pol.rules [])::!tmp
    done;
  done;

  List.iter (fun r -> rules := aux r::!rules) !tmp;
 

  aux !rules;;
  

let n, auto, gene = parse (open_in "test.txt");;
show_generation gene;;
next_generation (auto, gene);;
Array.set gene.cells.(0) 0 alive_true;;
let s = stables (auto, 1);;

eval_formule s;;
string_of_formule (fnc s);;
nb_clauses s;;

let rec nb_clauses (f : formula) : int = match f with
    True | False -> 1
  | Var s -> 1
  | Neg f -> nb_clauses f
  | And(f1, f2) -> nb_clauses f1 + nb_clauses f2
  | Or(f1, f2) -> nb_clauses f1 + nb_clauses f2;;

(*
let show_stable () : unit = 
  
  let formule = True in
  let length = 7 in
  let file = open_out "entree.dimacs" in
  let n = nb_clauses formule in
  let stables
  output_string file "p cnf ";
  output_string file  ((string_of_int length)^" ");
  output_string file (string_of_int n);
  output_string file "\n";
  close_out file;
();;

*)

(*
let n, auto, gene = parse (open_in "test.txt");;
show_generation gene;;
next_generation (auto, gene);;
Array.set gene.cells.(0) 0 alive_true;;
stables (auto, 1);;



let f = Et (, )
let f1 = Neg (Ou (Et (Vrai, Et (Faux, Et(Vrai, Et (Faux, Vrai)))) , (Et (Vrai, Et (Vrai, Et (Vrai, Et (Vrai, Vrai)))))));;
let f2 = Ou (Var alive_false, Var alive_true);;
let f3 = Ou (f1, f2);;

eval_formule f1;;
string_of_formule (fnc f1);;
nb_clauses from;;


let str = string_of_formule (Ou (Var alive_true, Var alive_false));;

let main () =
  let n, auto, gene = parse (open_in "test.txt") in
  show_generation gene;
  next_generation (auto, gene);
in main ();;

*)







(String.compare "lol "lol");;









	
	
	
	
