(*
 * @author : Pierre Dibo, L3 Universite Paris-Diderot 7
 * @brief  : Projet Ocaml S5, 2015-2016
 * @email  : rgv26.warforce[at]hotmail.fr
 *)

#load "graphics.cma"
(*#use "projet.mli"*)

(**)
class state =
object(self)
  val mutable alive = (ref true : bool ref)
  method get_alive : bool = !alive
  method next : unit = if !alive = true then alive := false else alive := true
end

(**)
class cell (in_state : state) =
object
  val inner_state = in_state
  method get_state : state = in_state
  method next_state : unit = inner_state#next
  method tostring : unit = Printf.printf "[state=%b]\n" inner_state#get_alive
end

(**)
class generation =
object
  val mutable list_cell = (ref [] : cell list ref)
  method get_cells : cell list = !list_cell
  method add (value : cell) : unit = list_cell := value::!list_cell
  method next_generation : unit = List.iter (fun c -> c#next_state) !list_cell 
  method tostring : unit = List.iter (fun c -> c#tostring) !list_cell 
end

(**)
class rule (s : string) =
object
  val _rule = s
  method tostring = Printf.printf "%s\n" _rule
end

(**)
class automaton =
object
  val mutable rules = (ref [] : rule list ref)
  method add (value : rule) : unit = rules := value::!rules
  method set_rules : unit = rules := List.rev (List.tl !rules)
  method set_grid (n : int) (gene : generation) : unit =
    let _list = ref gene#get_cells in
    for i = n downto 1 do
      for j = n downto 1 do
	let _cell = List.hd !_list in
	_list := List.tl !_list;
	if _cell#get_state#get_alive = true then
	  Graphics.set_color Graphics.black
	else
	  Graphics.set_color Graphics.red;
	Graphics.fill_circle (250 - j*10) (200 + i*10) 3
      done
    done
  method tostring : unit = List.iter (fun c -> c#tostring) !rules
  initializer
    Graphics.open_graph "500x500";
    Graphics.set_window_title "Jeu de la vie"
end

class parse (in_chan : in_channel) =
object
  val mutable separator = (ref "" : string ref)
  val length = int_of_string (input_line in_chan)
  val in_generation = new generation
  val in_automaton = new automaton
  method get_length = length
  method get_generation = in_generation
  method get_automaton = in_automaton
  initializer
    separator := input_line in_chan;

    while (String.compare !separator "GenerationZero") != 0 do
      separator := input_line in_chan;
      in_automaton#add (new rule !separator)
    done;
    in_automaton#set_rules;

    for i = 0 to (length - 1) do
      separator := input_line in_chan;

      for j = 0 to (length - 1) do
	if !separator.[j] = 'D' then
	  let _cell = new cell (new state) in
	  _cell#next_state;
	  in_generation#add (_cell)
	else
	  in_generation#add (new cell (new state))
      done
    done
end


let p = new parse (open_in "test.txt");;
p#get_automaton#set_grid p#get_length p#get_generation;;
p#get_automaton#tostring;;
p#get_generation#next_generation;;
p#get_length;;


let main () =
  let p = new parse (open_in "test.txt") in
  p#get_automaton#set_grid p#get_length p#get_generation;
in main ();;
