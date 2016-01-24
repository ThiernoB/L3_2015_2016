(*
 * @author : Pierre Dibo, L3 Universite Paris-Diderot 7
 * @brief  : Projet Ocaml S5, 2015-2016
 * @email  : rgv26.warforce[at]hotmail.fr
 *)

#load "graphics.cma"
#use "cell.mli"
#use "grid.mli"
#use "parse.mli"


(*La classe state de type state_t qui définit l'etat d'une cellule, morte ou vivante, par un booleen*)
class state (b : bool) : state_t =
object
  val mutable alive = ref b
  method get = !alive
  method set (new_state : bool) = alive := new_state
end

(*La classe point de type point_t avec pour parametres initiaux les coordonnees x et y dans le plan*)
class point (x : int) (y : int) : point_t = 
object
  val x = x
  val y = y
  method tostring = Printf.printf "[x=%d; y=%d]\n" x y
end

(*La classe cell de type cell_t avec pour paramettre initiaux les coordonnees x et y dans le plan et son etat*)
class cell (x_coor : int) (y_coor : int) (in_state : state_t) : cell_t =
object(self)
  val mutable position = new point x_coor y_coor
  val mutable inner_state = in_state
  val mutable color = if in_state#get = false then Graphics.black else Graphics.white
  method next_state = if inner_state#get = true then inner_state#set false else inner_state#set true
  method getPoint = position
  method getColor = color
  method tostring = position#tostring; Printf.printf "[color=%d; state=%b]\n" color inner_state#get
end

(*La classe generation de type generation_t*)
class generation : generation_t =
object(self)
  val mutable list_cell = ref []
  method get = !list_cell
  method add value = list_cell := List.append !list_cell [value]
  method addAll cells  = list_cell := List.append !list_cell cells    
  method next p_gene = 
    let rec _next (cells : cell_t list) = match cells with
	[] -> ()
      | hd::tl -> hd#next_state; _next tl
    in _next self#get;
  method tostring = List.iter (fun c -> c#tostring; ()) !list_cell 
end

(*La classe grid de type grid_t avec pour parametres initiaux le nombre de ligne, de colonne et la taille de la fenetre*)
class grid (row : int) (col : int) (size : string) : grid_t =
object(self)
  val rows = row
  val columns = col
  val generation_cells = ref new generation
  method get_gene = !generation_cells
  method set gene = generation_cells := gene
  method diplay_grid size = Graphics.open_graph size
  method tostring = Printf.printf "[rows=%d; columns=%d]\n" rows columns
  initializer
    self#diplay_grid size
end

class rule_ (s : string) : rule_t =
object
  val mutable _rule = s
  method tostring = Printf.printf "%s\n" s
end

let read_rules (rules : rule_t list) : unit = List.iter (fun x -> x#tostring) rules

class parse (chan_in : in_channel) : parse_t =
object(self)
  val separator = ref ""
  val mutable size_grid = ref 0
  val mutable grid_rules = ref []
  val mutable init_gene = new generation
  method get_gene = init_gene
  method set_size i = size_grid := i
  method set_rules r = grid_rules := List.append !grid_rules [r]
  initializer	
    self#set_size (int_of_string (input_line chan_in));
    (try
       while (String.compare !separator "GenerationZero") != 0 do
	 separator := input_line chan_in;
	 if (String.compare !separator "GenerationZero") != 0 then
	   self#set_rules (new rule_ !separator);
       done
     with End_of_file -> ());
    grid_rules := List.tl !grid_rules;
		
    for i = 0 to (!size_grid - 1) do
      separator := input_line chan_in;
      for j = 0 to (!size_grid - 1) do
	if !separator.[j] = 'A' then 
	  init_gene#add (new cell i*10 j*10 (new state true))
	else
	  init_gene#add (new cell i*10 j*10 (new state false))
      done
    done
end

let main () =
  let p = new parse (open_in "test.txt") in
  let grid = new grid 0 0 "600x800 " in
  grid#set p#get_gene;
  grid#get_gene#tostring;
in main ();;


let init_graph : unit -> int =
Graphics.open_graph "500x500";
Graphics.set_window_title "Jeu de la vie";
Graphics.draw_rect 0 0 10 10;
Graphics.size_y
;;

Graphics.size_x;;
