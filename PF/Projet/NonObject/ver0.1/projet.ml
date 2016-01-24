#load "graphics.cma";;

type state = {
  mutable alive : bool;
};;

let verif_state (s1 : state) (s2 : state) : bool = s1.alive = s2.alive;;

type rule_t =  {
  mutable rule : string
};;

let string_of_rule (r : rule_t) : string = r.rule;;

type generation = {
  mutable cells : state array array;
};;

type automaton = {
  mutable rules : rule_t list;
};;

type formula =
    Vrai | Faux
  | Var of string
  | Neg of formula
  | Et of formula * formula
  | Ou of formula * formula;;
	
let rec eval_formule f l = match f with
    Vrai -> true
  | Faux -> false
  | Var s -> (List.assoc s l)
  | Neg f1 -> not (eval_formule f1 l)
  | Et(f1,f2) -> (eval_formule f1 l) && (eval_formule f2 l)
  | Ou(f1,f2) -> (eval_formule f1 l) || (eval_formule f2 l);;


let alive_true : state = {
  alive = true;
};;

let alive_false : state = {
  alive = false;
};;

let create_rule (str : string) : rule_t = {
  rule = str
};;

let add_rule (auto : automaton) (r : rule_t) : automaton = {
  rules = r::auto.rules;
};;

let set_rules (auto : automaton) (r : rule_t list) : automaton = {
  rules = r;
};;

let create_generation (n : int) : generation = {
  cells = Array.make_matrix n n alive_false;
};;

let create_automaton : automaton = {
  rules = [];
};;

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

let voisins (rules : string) : state list =
  let v1 = if rules.[0] = 'A' then alive_true else alive_false in
  let v2 = if rules.[1] = 'A' then alive_true else alive_false in
  let v3 = if rules.[2] = 'A' then alive_true else alive_false in
  let v4 = if rules.[3] = 'A' then alive_true else alive_false in
  
  [v1; v2; v3; v4];;

(*	
let voisins (rules : rule_t list) : state list =
  let v1 = [] in
  let v2 = [] in
  let v3 = [] in
  let v4 = [] in
	
	for i = 0 to (List.length rules) - 1 do
		(List.nth (List.nth rules i) 0)::v1;
		(List.nth (List.nth rules i) 1)::v2;
		(List.nth (List.nth rules i) 2)::v3;
		(List.nth (List.nth rules i) 3)::v4;
	done;

	[simpl_rules v1, simpl_rules v2, simpl_rules v3, simpl_rules v4];;
	
let rec simpl_rules (lstate : state list) : state = match lstate with
	| [] -> alive_true
	| hd::tl -> if hd.alive = false then false else (simpl_rules tl);;
*)

let reborn_cell (gene : generation) (n : int) (i : int) (j : int) (v : state list) : bool =
  let state1 = neighbor_north gene n i j in
  let state2 = neighbor_east gene n i j in
  let state3 = neighbor_south gene n i j in
  let state4 = neighbor_west gene n i j in
  let v1 = List.nth v 0 in
  let v2 = List.nth v 1 in
  let v3 = List.nth v 2 in
  let v4 = List.nth v 3 in
  
  (verif_state state1 v1) && (verif_state state2 v2) && (verif_state state3 v3) && (verif_state state4 v4);;



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
      Graphics.fill_circle (250 - j*10) (200 + i*10) 3
    done
  done
;;

let show_voisin (gene : generation) (n : int) (i : int) (j : int) : unit =
  let cell = Array.get gene.cells.(i) j in
  let v1 = neighbor_north gene n i j in
  let v2 = neighbor_east gene n i j in
  let v3 = neighbor_south gene n i j in
  let v4 = neighbor_west gene n i j in
	
  Printf.printf "\t%b\n%b\t%b\t%b\n\t%b\n\n" v1.alive v4.alive cell.alive v2.alive v3.alive;;

let next_generation (auto, gene : automaton * generation) : generation = 
  let length = (Array.length gene.cells.(0)) - 1 in
  let is_rule = ref false in
	
  for i = 0 to length do
    for j = 0 to length do
      try
	for k = 0 to ((List.length auto.rules) - 1) / 2 do
	  let rules = List.nth auto.rules (k * 2) in
	  let v = voisins (string_of_rule rules) in
	  if (reborn_cell gene length i j v) = true then
	    begin
       	      Array.set gene.cells.(i) j alive_true;
	      is_rule := true;
	      Printf.printf "ICI 1\n";
	      raise Exit;
	    end;
	done;
      with Exit -> ();
	if !is_rule = false then
	  begin
	    Printf.printf "ICI 2\n";
	    show_voisin gene length i j;
	    Array.set gene.cells.(i) j alive_false
	  end
	else
	  begin
	    is_rule := false;
	    Printf.printf "ICI 3 \n"
	  end
    done;
  done;

  gene;;
	
(*
let rec appli_rules (rules : rule_t list) (s : state) : bool = match rules with
  | [] -> s
	| hd::tl -> voisins (string_of_rule hd)

	
let stables (auto : automaton) : formula =

*)

let n, auto, gene = parse (open_in "test.txt");;
show_generation gene;;
next_generation (auto, gene);;

let r = reborn_cell gene (n - 1) 0 0 [alive_true; alive_true; alive_true; alive_true];;
Printf.printf "%b\n" r.alive;;	

let show_stable () : unit =
();;
	
	
	
	
	
