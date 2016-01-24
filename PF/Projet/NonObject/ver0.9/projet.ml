(*	Projet PF5 : Automate cellulaire
**
**	@file projet.ml
**	@language : Ocaml
**	@authors : Pierre Dibo - Oulebsir Hocine
**	@origin Université Diderot-Paris 7
**	@email : rgv26.warforce@hotmail.fr
**
*)
type formula =
    True | False
  | Var of int
  | Neg of formula
  | And of formula * formula
  | Or of formula * formula

type state = {
  mutable alive : bool
}

type rule =  {
  mutable str : string
}

type generation = {
  mutable cells : state array array
}

type automaton = {
  mutable rules : rule list
}

let alive_true : state = {
  alive = true
}

let alive_false : state = {
  alive = false
}

let set_state (b : bool) : state = {
  alive = b
}

let state_compare (s1 : state) (s2 : state) : bool = 
  s1.alive = s2.alive

let string_of_rule (r : rule) : string = r.str

let create_rule (s : string) : rule = {
  str = s
}

let add_rule (auto : automaton) (r : rule) : automaton = {
  rules = r::auto.rules
}

let set_rules (auto : automaton) (r : rule list) : automaton = {
  rules = r
}

let create_automaton : automaton = {
  rules = []
}

let create_generation (length : int) : generation = {
  cells = Array.make_matrix length length alive_false
}

let cell (length : int) (i : int) (j : int) : int = (length * i) + j + 1

let north (length : int) (i : int) (j : int) : int = 
  if i = 0 then 
    (length * (length - 1)) + j + 1
  else 
     (length * (i - 1)) + j + 1

let south (length : int) (i : int) (j : int) : int = 
  if i = length - 1 then 
    j + 1
  else 
    (length * (i + 1)) + j + 1

let east (length : int) (i : int) (j : int) : int =
  if i = length - 1 then 
    (length * i) + 1
  else 
    (length * i) + j + 2

let west (length : int) (i : int) (j : int) : int=
  if j = 0 then 
    (length * i) + length
  else 
    (length * i) + j

let neighbor_north (gene : generation) (length : int) (i : int) (j : int) : state = 
  if i = 0 then 
    Array.get gene.cells.(length) j 
  else 
    Array.get gene.cells.(i - 1) j
		
let neighbor_east (gene : generation) (length : int) (i : int) (j : int) : state =
  if j = length then 
    Array.get gene.cells.(i) 0 
  else 
    Array.get gene.cells.(i) (j + 1)		

let neighbor_south (gene : generation) (length : int) (i : int) (j : int) : state = 
  if i = length then 
    Array.get gene.cells.(0) j 
  else 
    Array.get gene.cells.(i + 1) j

let neighbor_west (gene : generation) (length : int) (i : int) (j : int) : state =
  if j = 0 then 
    Array.get gene.cells.(i) length 
  else 
    Array.get gene.cells.(i) (j - 1)
			
let neighborhood (str : string) : state list =
  let v1 = if str.[0] = 'A' then alive_true else alive_false in
  let v2 = if str.[1] = 'A' then alive_true else alive_false in
  let v3 = if str.[2] = 'A' then alive_true else alive_false in
  let v4 = if str.[3] = 'A' then alive_true else alive_false in
  let cell = if str.[4] = 'A' then alive_true else alive_false in
	
  ([v1; v2; v3; v4; cell])
	
let verif_rule (gene : generation) (n : int) (i : int) (j : int) (v : state list) : bool =
  let state1 = neighbor_north gene n i j in
  let state2 = neighbor_east gene n i j in
  let state3 = neighbor_south gene n i j in
  let state4 = neighbor_west gene n i j in
  let state5 = Array.get gene.cells.(i) (j) in

  let v1 = List.nth v 0 in
  let v2 = List.nth v 1 in
  let v3 = List.nth v 2 in
  let v4 = List.nth v 3 in
  let v5 = List.nth v 4 in
  (state_compare state1 v1) && (state_compare state2 v2) && (state_compare state3 v3) && (state_compare state4 v4) && (state_compare state5 v5)

let show_voisin (gene : generation) (n : int) (i : int) (j : int) : unit =
  let cell = Array.get gene.cells.(i) j in
  let v1 = neighbor_north gene n i j in
  let v2 = neighbor_east gene n i j in
  let v3 = neighbor_south gene n i j in
  let v4 = neighbor_west gene n i j in
  
  Printf.printf "\t%b\n%b\t%b\t%b\n\t%b\n\n" v1.alive v4.alive cell.alive v2.alive v3.alive

(*
#load "graphics.cma"
*)
let show_generation (gene : generation) : unit =
  Graphics.open_graph " 500x500";
  Graphics.set_window_title " Projet PF";

  let n = Array.length gene.cells.(0) in
  let str = ref "" in

  for i = n - 1 downto 0 do
    for j = n - 1 downto 0 do
      let cell = Array.get gene.cells.(i) j in
      if cell.alive = true then
	begin
	  Graphics.set_color Graphics.red;
	  str := !str^"A ";
	end 
      else
	begin
	  Graphics.set_color Graphics.black;
	  str := !str^"D ";
	end;
      Graphics.fill_circle (250 + j*10) (200 - i*10) 3;
   
    done;
    str := !str^"\n";
  done;

  Printf.printf "%s" !str

let show_formula (int_list : int list) : unit =
  Graphics.open_graph " 500x500";
  Graphics.set_window_title " Projet PF";

  let str = ref "" in
  let n = List.length int_list in
  let root = int_of_float (sqrt (float_of_int n)) in

  for i = 0 to root - 1 do
    for j = 0 to root - 1 do
      if (List.nth int_list ((cell root i j) - 1)) < 0 then
	begin
	  str := !str^"D ";
	  Graphics.set_color Graphics.black;
	end
      else
	begin
	  Graphics.set_color Graphics.red;
	  str := !str^"A ";
	end;
      Graphics.fill_circle (250 + j*10) (200 - i*10) 3;
    done;
    str := !str^"\n";
  done;

  Printf.printf "%s" !str
  

let next_generation (auto, gene : automaton * generation) : generation = 
  let n = (Array.length gene.cells.(0)) - 1 in
  let cell_evol = ref false in
  let new_gene = create_generation (n + 1) in
	
  for i = 0 to n do 
    for j = 0 to n do
      (try
	 for k = 0 to (List.length auto.rules) - 1 do
	   let str = string_of_rule (List.nth auto.rules k) in
	   let v = neighborhood str in 
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
  new_gene

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
  close_in in_chan;
  (length, !auto, gene)

(*******************************************************)

let global_policy : automaton = {
  rules = [
    {str = "AAAAA"}; {str = "ADAAA"}; {str = "DAAAA"}; {str = "DDAAA"};
    {str = "AAADA"}; {str = "ADADA"}; {str = "DAADA"}; {str = "DDADA"};
    {str = "AADAA"}; {str = "ADDAA"}; {str = "DADAA"}; {str = "DDDAA"}; 
    {str = "AADDA"}; {str = "ADDDA"}; {str = "DADDA"}; {str = "DDDDA"}
  ]
}

let rec nb_clauses (f : formula) : int = match f with
    True | False -> 1
  | Var s -> 1
  | Neg f -> nb_clauses f
  | And(f1, f2) -> nb_clauses f1 + nb_clauses f2
  | Or(f1, f2) -> nb_clauses f1 + nb_clauses f2

let rec string_of_formula f = match f with
    True -> "true"
  | False -> "false"
  | Var s -> "Var "^string_of_int s
  | Neg f -> "Neg("^string_of_formula f^")"
  | And(f1, f2) -> "("^string_of_formula f1^" And "^string_of_formula f2^")"
  | Or(f1, f2) -> "("^string_of_formula f1^" Or "^string_of_formula f2^")"
	
let rec union_sorted l1 l2 = match l1, l2 with
    _, [] -> l1
  | [], _ -> l2
  | a1::l1, a2::l2 ->
    if a1 < a2 then a1::(union_sorted l1 l2 ) else
      if a2 < a1 then a2::(union_sorted l1 l2) else
	a1::(union_sorted l1 l2)

let rec list_of_vars f = match f with
   Var s -> [s]
  | Neg f -> list_of_vars f
  | And(f1, f2) | Or(f1, f2) -> union_sorted (list_of_vars f1) (list_of_vars f2)
  | _ -> []

let rec desc_neg f = match f with
    Neg(Neg g) -> desc_neg g
  | Neg(Or(g, h)) -> And(desc_neg(Neg g), desc_neg(Neg f))
  | Neg(And(g, h)) -> Or(desc_neg(Neg g), desc_neg(Neg f))
  | Or(g, h) -> Or(desc_neg g, desc_neg h)
  | And(g, h) -> And(desc_neg g, desc_neg h)
  | f -> f

let rec desc_ou f = match f with
    And(g, h) -> And(desc_ou g, desc_ou h)
  | Or(g, h) ->
    let g = desc_ou g 
    and h = desc_ou h in (match g, h with
	_, And(g, h) -> And(desc_ou (Or(g, g)),desc_ou (Or(g, h)))
      | And(f, g),_ -> And(desc_ou (Or(f, h)),desc_ou (Or(g, h)))
      | _ -> Or(g, h))
  | f -> f

let rec fnc f = desc_ou (desc_neg f)

let int_of_formula (form : formula) : int = match form with
    Var s -> s
  | _ -> raise Exit

let rec formula_of_list_formula (r : formula list) = match r with
    [] -> raise Exit
  | [e] -> e
  | hd::tl -> And (hd, (formula_of_list_formula tl))

let formula_of_char (c : char) (i : int): formula = match c with
    'A' -> Neg (Var i)
  | 'D' -> (Var i)
  | _ -> raise Exit
	
let formula_of_string (str : string) (length : int) (i : int) (j : int) : formula =
  let c1 = String.get str 0 in
  let c2 = String.get str 1 in
  let c3 = String.get str 2 in
  let c4 = String.get str 3 in
  let c5 = String.get str 4 in
	
  (Or 
     (formula_of_char c1 (north length i j), Or 
       (formula_of_char c2 (east length i j), Or 
	 (formula_of_char c3 (south length i j), Or 
	   (formula_of_char c4 (west length i j), formula_of_char c5  (cell length i j))))))
	
let rec verif_rule_from_policy (rules : rule list) (form : formula list) (length : int) (i : int) (j : int) : formula list = match rules with
    [] -> form
  | hd::tl -> 
verif_rule_from_policy tl ((formula_of_string (string_of_rule hd) length i j)::form) length i j

let rec list_of_A (rules : rule list) (listA : rule list) : rule list = match rules with
  [] -> listA
  | hd::tl -> if (string_of_rule hd).[4] = 'A' then list_of_A tl (hd::listA) else list_of_A tl listA

let rec list_of_D (rules : rule list) (listD : rule list) : rule list = match rules with
  [] -> listD
  | hd::tl -> if (string_of_rule hd).[4] = 'D' then list_of_D tl (hd::listD) else list_of_D tl listD

let rec simpl_rule (rules : rule list) (str : string) (rslt : rule list) : rule list = match rules with
   [] -> rslt
  | hd::tl -> if (string_of_rule hd) = str then simpl_rule tl str rslt else simpl_rule tl str (hd::rslt)

let rec mem_str (rules : rule list) (str : string) : bool = match rules with
    [] -> false
  | hd::tl ->  (string_of_rule hd) = str || (mem_str tl str)

let simpl_policy (auto : automaton) : automaton =
  let rules = ref global_policy.rules in
  let lA = ref (list_of_A auto.rules []) in
  let lD = ref (list_of_D auto.rules []) in

  for i = 0 to (List.length !lA) - 1 do
    let s = string_of_rule (List.nth !lA i) in
	
    if mem_str !rules s then
      begin
	rules := simpl_rule !rules s [];
      end;
  done;

  for i = 0 to (List.length !lD) - 1 do
    let r = List.nth !lD i in
    rules := r::!rules
  done;
 set_rules create_automaton !rules

let stables (auto, d : automaton * int) : automaton * formula  =  
  let rules = ref [] in
  let tmp = ref [] in
  let pol = simpl_policy auto in

  for i = 0 to (d - 1) do
    for j = 0 to (d - 1) do
      tmp := (verif_rule_from_policy pol.rules [] d i j)::!tmp;
    done;
  done;

  List.iter (fun r -> rules := formula_of_list_formula r::!rules) !tmp;
  (pol, fnc (formula_of_list_formula !rules))
	
let rec dimacs_of_formula (form : formula) : string = match form with
    True | False -> ""
  | Var s -> string_of_int s^" "
  | Neg f -> "-"^(dimacs_of_formula f)
  | Or(f1, f2) -> (dimacs_of_formula f1)^(dimacs_of_formula f2)
  | And(f1, f2) ->
    begin match f1 with
      | True | False -> (dimacs_of_formula f2)
      | _ -> 
	match f2 with
	  | True | False -> (dimacs_of_formula f1)
	  | _ -> (dimacs_of_formula f1) ^ "0\n" ^ (dimacs_of_formula f2)
    end
	
(*http://rosettacode.org/wiki/Strip_a_set_of_characters_from_a_string#OCaml*)
let stripchars s cs =
  let len = String.length s in
  let res = String.create len in
  let rec aux i j =
    if i >= len then String.sub res 0 j
    else if String.contains cs s.[i] then
      aux (succ i) (j)
    else begin
      res.[j] <- s.[i];
      aux (succ i) (succ j)
    end
  in
  aux 0 0

let int_list_of_string (str : string) : int list =
  let l =  ref [] in
  for i = 0 to (String.length str) - 2 do
    if str.[i] = '-' then
      l := (int_of_string (String.sub str i 2))::!l
    else
      l := (int_of_char str.[i])::!l;
  done;
  !l

let create_dimacs (form, nb_v, nb_l : formula * int * int) (out_chan : out_channel) : unit =
  output_string out_chan("p cnf "^(string_of_int nb_v)^" "^string_of_int nb_l^"\n");
  output_string out_chan ((dimacs_of_formula form) ^ " 0");
  ()

let incr_lines (out_chan : out_channel) (nb_v : int) (nb_l : int) : unit =
  let tmp = pos_out out_chan in
  seek_out out_chan (tmp - tmp);
  output_string out_chan("p cnf "^(string_of_int nb_v)^" "^string_of_int nb_l^"\n");
  seek_out out_chan tmp;
  ()

let int_list_of_minisat (str : string) : int list =
  let int_list = ref [] in
  let i = ref 0 in
  (try
    while !i <= (String.length str) - 1 do
      if str.[!i] = '-' then
	begin
	  let k = (String.make 1 str.[!i + 1]) in
	  int_list := int_of_string k::!int_list;
	  i := !i + 2;
	end
      else
	  if str.[!i] = '0' then
	    raise Exit
	  else
	    begin
	      let k = (String.make 1 str.[!i]) in
	      int_list := -(int_of_string k)::!int_list;
	      i := !i + 1;
	    end
    done
   with Exit -> ());
  
  (List.rev !int_list)

let rec string_of_int_list (int_list : int list) : string = match int_list with
    [] -> "0"
  | hd::tl -> (string_of_int hd)^" "^string_of_int_list tl
      

let show_stables () : unit =
  let d, auto, g = parse (open_in "test.txt") in
  let auto, form = stables (auto, d) in
  let out_chan = open_out "entree.dimacs" in
  let nb_v = (d * d) in
  let nb_l = ref (nb_v * List.length auto.rules) in
  
  create_dimacs (form, nb_v, !nb_l) out_chan;
  close_out out_chan;
  
  let rec global_loop (str_list : string list) =  match (read_line ()) with
      "y" | "yes" | "o" | "oui" ->
	let exec_command () = match (Sys.command ("minisat entree.dimacs sortie")) with
	    2 -> exit 2
	  | _ ->
	    let rec local_loop in_chan = match (input_line in_chan) with
	      | "SAT" -> local_loop in_chan;
	      | "UNSAT" -> Printf.printf "UNSAT\n";
	      | str -> 
		let l = int_list_of_minisat (stripchars str " ") in
		let s = "\n"^(string_of_int_list l) in
		show_formula l;
		       if String.length str > 0 then
			 begin
			   nb_l := !nb_l + 1;
			   let out_chan = open_out "entree.dimacs" in
			   create_dimacs (form, nb_v, !nb_l) out_chan;
			   List.iter (fun x -> output_string out_chan x) (List.rev str_list);
			   output_string out_chan s;
			   close_out out_chan;
			   close_in in_chan;
			   global_loop (s::str_list);
			 end;
	    in local_loop (open_in "sortie");
	in exec_command ();
    | _ -> Printf.printf "GoodBye !\n";
  in global_loop [];

  ()
	
	
let main () : unit =
  try
    let automate_file = Sys.argv.(1) in   
    (*let dimacs_file = Sys.argv.(2) in
		let out_file = Sys.argv.(2) in *)
    let (d, auto, gene) = parse (open_in automate_file) in
    let g = ref gene in		
    show_generation !g;
    show_stables ();
  with
      _ -> ()



(*
let (d, auto, gene) = parse (open_in "test.txt");;
show_stables ();;

let t = exec_minisat "entree.dimacs";;
show_generation gene;;
let g = ref gene;;
g := next_generation (auto, !g);;
show_generation !g;;

auto;;
stables (auto, 3);;
formula_of_dimacs (open_in "sortie");;
let d = (Sys.command ("minisat entree.dimacs sortie"));;

int_list_of_minisat (stripchars "1 2 3 4 5 6 7 8 9 0" " ");;
Graphics.open_graph " 50x50";;
Graphics.close_graph ();;

show_formula [-1; -2; 3; -4; 5; -6; -7; -8; -9];;
Printf.printf "use : %s automate_file dimacs_file\n" Sys.argv.(0)
*)



