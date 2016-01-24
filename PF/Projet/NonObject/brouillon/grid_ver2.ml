(*Pierre Dibo, L3 Université Paris-Diderot 7*)

type state = {
  mutable alive : bool;
}

type cell = {
  mutable x : int;
  mutable y : int;
  mutable inner_state : state;
}

type generation = {
  mutable cells : cell list;
}

type rule_ = string

type automaton = {
  mutable rules : rule_ list;
  mutable square : cell list;
  mutable rows : int;
  mutable columns : int;
}

let init_state : state = {
  alive = true;
};;

let init_generation : generation = {
  cells = []
};;

let init_automaton : automaton = {
  rules = [];
  square = [];
  rows = 0;
  columns = 0;
};;

let next_state (cell_state : state) : state = {
  alive = false;
};;


let create_cell (pos_x : int) (pos_y : int) (in_state : state) : cell = {
  x = pos_x;
  y = pos_y;
  inner_state = in_state
};;

let next_generation (p_gene : generation) : generation =
  let rec next_ (cells_l : cell list) = match cells_l with
      [] -> ()
    | hd::tl -> next_state hd.inner_state; next_ tl
  in next_ p_gene.cells;
p_gene;;

(*	List.iter (fun s -> next_state s) p_gene.cells;*)


let parse (chan_in : in_channel) : string list =
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

!rules * !gene;;

parse (open_in "test.txt");;

List.iter (fun s -> Printf.printf "%s\n" s)( parse (open_in "test.txt"));;

#load "graphics.cma"

let draw_string_v  s = 
   let (xi,yi) = Graphics.current_point() 
   and l = String.length s 
   and (_,h) = Graphics.text_size s 
   in 
      Graphics.draw_char s.[0] ;
      for i=1 to l-1 do
        let (_,b) = Graphics.current_point() 
        in Graphics.moveto xi (b-h) ;
           Graphics.draw_char s.[i] 
       done ;
     let (a,_) = Graphics.current_point() in Graphics.moveto a yi ;;
	


Graphics.open_graph(" 500x600 ");;

Graphics.

(*	
	try
		dime := input_int chan_in;
	with End_of_file -> ();
	
	try
		while !spec != "GenerationZero"; do
			spec := input_line chan_in;
		done;
	with End_of_file -> ();
	
	(try
		while true; do
			gene := input_line chan_in;
     done;
   with End_of_file -> ());;

*)


























