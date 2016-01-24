#load "graphics.cma";;

type state = {
  mutable alive : bool;
};;

type formula =
    Vrai | Faux
  | Var of state * state
  | Neg of formula
  | Et of formula * formula
  | Ou of formula * formula;;
	
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
		
let voisins (str : string) : state list =
  let v1 = if str.[0] = 'A' then alive_true else alive_false in
  let v2 = if str.[1] = 'A' then alive_true else alive_false in
  let v3 = if str.[2] = 'A' then alive_true else alive_false in
  let v4 = if str.[3] = 'A' then alive_true else alive_false in
  
  [v1; v2; v3; v4];;

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
	
  for i = 0 to n do 
    for j = 0 to n do
      (try
	for k = 0 to ((List.length auto.rules) - 1) / 2 do
	  let str = string_of_rule (List.nth auto.rules (k * 2)) in
	  let v = voisins str in 
	  if (verif_rule gene n i j v) then
	    begin
	      Array.set gene.cells.(i) j alive_true;
	      cell_evol := true;
	      raise Exit;
	    end;
	done;
      with Exit -> ());

      if !cell_evol = true then
	cell_evol := false
      else
	Array.set gene.cells.(i) j alive_false;
    done;
  done;
  gene;;


(*
  AAAA
  NESW
*)

let rec string_of_formule f = match f with
    Vrai -> "Cell alive=true"
  | Faux -> "Cell alive=false"
  | Var(s1, s2) -> "Cell("^string_of_bool s1.alive^", "^string_of_bool s2.alive^")"
  | Neg f -> "Neg("^string_of_formule f^")"
  | Et(f1, f2) -> "("^string_of_formule f1^" Et "^string_of_formule f2^")"
  | Ou(f1, f2) -> "("^string_of_formule f1^" Ou "^string_of_formule f2^")";;

let rec union_sorted l1 l2 = match l1, l2 with
    _, [] -> l1
  | [], _ -> l2
  | a1::l1, a2::l2 ->
    if a1 < a2 then a1::(union_sorted l1 l2 ) else
      if a2 < a1 then a2::(union_sorted l1 l2) else
	a1::(union_sorted l1 l2);;

let rec list_of_vars f = match f with
   Var(s1, s2) -> [(s1, s2)]
  | Neg f -> list_of_vars f
  | Et(f1, f2) | Ou(f1, f2) -> union_sorted (list_of_vars f1) (list_of_vars f2)
  | _ -> [];;


let rec eval_formule f l = match f with
    Vrai -> true
  | Faux -> false
  | Var(s1, s2) -> (List.assoc (s1, s2) l)
  | Neg f1 -> not (eval_formule f1 l)
  | Et(f1, f2) -> (eval_formule f1 l) && (eval_formule f2 l)
  | Ou(f1, f2) -> (eval_formule f1 l) || (eval_formule f2 l);;


let rec eval_sous_formule f = match f with
  | Et(f1, f2) -> begin
    match (eval_sous_formule f1, eval_sous_formule f2) with
      | Faux, Faux -> Faux | Faux, Vrai -> Faux
      | Vrai, Faux -> Faux | Vrai, Vrai -> Vrai
      | (f1, f2) -> Et(f1, f2)
  end
  | Ou(f1,f2) -> begin
    match (eval_sous_formule f1, eval_sous_formule f2) with
      | Faux, Faux -> Faux | Faux, Vrai -> Vrai
      | Vrai, Faux -> Vrai | Vrai, Vrai -> Vrai
      | (f1, f2) -> Ou(f1, f2)
  end
  | Neg(f) -> begin
    match eval_sous_formule f with
      | Vrai -> Faux | Faux -> Vrai
      | f -> Neg f
  end
  | f -> f;;


let neighbor_formula (v : state list) =
  let c1 = List.nth v 0 in
  let c2 = List.nth v 1 in
  let c3 = List.nth v 2 in
  let c4 = List.nth v 3 in

Et (Var (c1, c1), Et (Var (c2, c2), Et (Var (c3, c3), Var (c4, c4))));;

let rec aux (r : formula list) = match r with
    [] -> raise Exit
  | [e] -> e
  | hd::tl -> Ou (hd, (aux tl));;

let correct_rule_neg 

let stables (auto, d : automaton * int) : unit = 
  let rules = ref [] in
  let array = Array.make_matrix d d (Var (alive_true, alive_false)) in

  for k = 0 to ((List.length auto.rules) - 1) / 2 do
    let str = string_of_rule (List.nth auto.rules (k * 2)) in
    let v = voisins str in
    rules :=  (neighbor_formula v)::!rules;
  done;

  let x = aux !rules in
  Printf.printf "%s\n" (string_of_formule x);

(*
  for k = 0 to ((List.length auto.rules) - 1) / 2 do
    rules := (List.nth auto.rules (k * 2))::!rules;
  done;

  for i = 1 to d do
    for j = 1 to d do
      Printf.printf "%d\n" i;
    done;
  done;
  *)
();;


let rec nb_clauses (f : formula) : int = match f with
    Vrai | Faux -> 1
  | Var(s1, s2) -> 1
  | Neg f -> nb_clauses f
  | Et(f1, f2) -> nb_clauses f1 + nb_clauses f2
  | Ou(f1, f2) -> nb_clauses f1 + nb_clauses f2;;

let show_stable () : unit = 
  let formule = Vrai in
  let length = 7 in
  let file = open_out "entree.dimacs" in
  let n = nb_clauses formule in
  output_string file "p cnf ";
  output_string file  ((string_of_int length)^" ");
  output_string file (string_of_int n);
  output_string file "\n";
  close_out file;
();;

let n, auto, gene = parse (open_in "test.txt");;
show_generation gene;;
next_generation (auto, gene);;
Array.set gene.cells.(0) 0 alive_true;;
stables (auto, n);;


let from = Et (Var (alive_true, alive_true), Et (Var (alive_false, alive_true), Et (Var (alive_false, alive_true), Var (alive_true, alive_true))));;
eval_sous_formule from;;
nb_clauses from;;
(*

let str = string_of_formule (Ou (Var alive_true, Var alive_false));;

let main () =
  let n, auto, gene = parse (open_in "test.txt") in
  show_generation gene;
  next_generation (auto, gene);
in main ();;

*)


















	
	
	
	
