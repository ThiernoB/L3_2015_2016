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
  mutable grid_state : state list;
}

type grid = {
  mutable square : cell list;
  mutable rows : int;
  mutable columns : int;
}

let init_state : state = {
  alive = true;
};;

let init_grid (list_cell : cell list) (p_rows : int) (p_columns : int) : grid = {
  square = list_cell;
  rows = p_rows;
  columns = p_columns;
};;

let next_state (cell_state : state) : state = {
    alive = false;
};;

let next_generation (p_grid_state : state list) : unit =
	List.iter (fun s -> next_state s) p_grid_state
;;


let show_grid (p_grid : grid) : unit =
  for i = 0 to p_grid.rows do
    for j = 0 to p_grid.columns do
      Printf.printf "[%d;%d]" i j;
    done;
    Printf.printf "\n"
  done;
;;

let create_cell (pos_x : int) (pos_y : int) (in_state : state) : cell = {
  x = pos_x;
  y = pos_y;
  inner_state = in_state
};;

let create_grid (rows : int ref) (columns : int ref) : grid =
  let grid = ref [] in 

  if !rows < 0 then
    rows := -1 * !rows;
  if !columns < 0 then
    columns := -1 * !columns;
 
  let cell_numbers = !rows * !columns in

  if cell_numbers < 4 then
    raise Exit;
  
  for i = 0 to !rows do
    for j = 0 to !columns do
      grid := (create_cell i j init_state)::!grid;
    done;
  done;
  
init_grid !grid !rows !columns;;


show_grid (create_grid (ref 2) (ref 2));;


let game : unit = ();;

