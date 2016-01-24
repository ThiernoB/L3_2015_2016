type formula =
    True | False
  | Var of int
  | Neg of formula
  | And of formula * formula
  | Or of formula * formula

type rule =  {
  mutable str : string
}

type automaton = {
  mutable rules : rule list
}

let global_policy : automaton = {
  rules = [
    {str = "AAAAA"}; {str = "AAADA"}; {str = "AADAA"}; {str = "ADAAA"}; {str = "DAAAA"};
    {str = "AADDA"}; {str = "ADADA"}; {str = "DAADA"}; {str = "ADDAA"}; {str = "DDAAA"};
    {str = "ADDDA"}; {str = "DADDA"}; {str = "DDADA"}; {str = "DDDAA"}; {str = "DDDDA"};
  ]
}

let create_automaton : automaton = {
  rules = []
}

let set_rules (auto : automaton) (r : rule list) : automaton = {
  rules = r
}

let north (arr : formula array array) (length : int) (i : int) (j : int) : formula = 
  if i = 0 then 
    Array.get arr.(length) j 
  else 
    Array.get arr.(i - 1) j

let south (arr : formula array array) (length : int) (i : int) (j : int) : formula = 
  if i = length then 
    Array.get arr.(0) j 
  else 
    Array.get arr.(i + 1) j

let east (arr : formula array array) (length : int) (i : int) (j : int) : formula =
  if j = length then 
    Array.get arr.(i) 0 
  else 
    Array.get arr.(i) (j + 1)

let west (arr : formula array array) (length : int) (i : int) (j : int) : formula=
  if j = 0 then 
    Array.get arr.(i) length 
  else 
    Array.get arr.(i) (j - 1)

let stables (auto, d : automaton * int) : formula array array = 
  let array = Array.make_matrix d d False in

  for i = 0 to (d - 1) do
    for j = 0 to (d - 1) do
      Array.set array.(i) (j) (Var ((d * i) + j + 1));
    done;
  done;
  array

let string_of_rule (r : rule) : string = r.str

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

let rec eval_formule f l = match f with
    True -> true
  | False -> false
  | Var s -> (List.assoc s l)
  | Neg f1 -> not (eval_formule f1 l)
  | And(f1, f2) -> (eval_formule f1 l) && (eval_formule f2 l)
  | Or(f1, f2) -> (eval_formule f1 l) || (eval_formule f2 l)

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
  | f -> f
	
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
  | f -> f

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

let formula_of_char (c : char) : formula = match c with
    'A' -> Var 1
  | 'D' -> Neg (Var 1)
  | _ -> raise Exit
	
let formula_of_string (str : string) : formula =
  let c1 = String.get str 0 in
  let c2 = String.get str 1 in
  let c3 = String.get str 2 in
  let c4 = String.get str 3 in
  let c5 = String.get str 4 in
	
  (Or 
     (formula_of_char c1, Or 
       (formula_of_char c2, Or 
	 (formula_of_char c3, Or 
	   (formula_of_char c4, formula_of_char c5)))))
	
let rec verif_rule_from_policy (rules : rule list) (form : formula list) : formula list = match rules with
    [] -> form
  | hd::tl -> verif_rule_from_policy tl ((formula_of_string (string_of_rule hd))::form)

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

let stables (auto, d : automaton * int) : formula array array = 
  let array = Array.make_matrix d d False in
  let rules = ref [] in
  let tmp = ref [] in
  let pol = simpl_policy auto in

  for i = 0 to (d - 1) do
    for j = 0 to (d - 1) do
      let v = Var ((d * i) + j + 1) in
      Array.set array.(i) (j) (Or (v, Neg v));
      tmp := (verif_rule_from_policy pol.rules [])::!tmp;
    done;
  done;

  List.iter (fun r -> rules := formula_of_list_formula r::!rules) !tmp;

  let x = formula_of_list_formula !rules in
  Printf.printf "%s\n"(string_of_formula x);
  Printf.printf "%d\n" (nb_clauses x);
  array

let aut = {
  rules = [{str = "AAADA"}; {str = "AADAA"}; {str = "ADAAA"}; {str = "DAAAA"};
    {str = "AADDA"}; {str = "ADADA"}; {str = "DAADA"}; {str = "ADDAA"}; {str = "DDAAA"};
    {str = "ADDDA"}; {str = "DADDA"}; {str = "DDADA"}; {str = "DDDAA"}; {str = "DDDDA"}]
}

let s = stables (aut, 2)
let t = simpl_rule aut.rules "AAADA" []
let n = nb_clauses s

