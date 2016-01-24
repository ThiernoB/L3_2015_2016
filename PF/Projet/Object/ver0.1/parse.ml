(*
 * @author : Pierre Dibo, L3 Universite Paris-Diderot 7
 * @brief  : Projet Ocaml S5, 2015-2016
 * @email  : rgv26.warforce[at]hotmail.fr
 *)
 
#use "parse.mli"

class rule_ (s : string) : rule_t =
object
  val mutable _rule = s
end
      
class parse (chan_in : in_channel) : parse_t =
object
  val separator = ref ""
  val mutable size_grid = 0
  val mutable grid_rules = ref []
  val mutable init_gene = new generation
  initializer	
    size_grid = int_of_string (input_line chan_in)
   (* (try
       while (String.compare !separator "GenerationZero") != 0 do
	 separator := input_line chan_in
	   if (String.compare !separator "GenerationZero") != 0 then
	     grid_rules := List.append !grid_rules [new rule_ !separator]
       done
     with End_of_file -> ())
    *)
end

(*
let parse (chan_in : in_channel) : string list list =
  let dime = ref 0 in
  let separator = ref "" in
  let rules = ref [] in
  let gene = ref [] in

  dime := int_of_string (input_line chan_in);

  (try
    while (String.compare !separator "GenerationZero") != 0 do
      separator := input_line chan_in;
      if (String.compare !separator "GenerationZero") != 0 then
	rules := List.append !rules [!separator];
    done;
  with End_of_file -> ());
  rules := List.tl !rules;
  (try
     while true; do
       gene := List.append !gene [input_line chan_in];
     done;
   with End_of_file -> ());

[!rules;!gene]


let t = parse (open_in "test.txt") in

List.iter (fun s -> Printf.printf "\n"; List.iter (fun r -> Printf.printf "%s\n" r) s) t

*)
