(*
 * @author : Pierre Dibo, L3 Université Paris-Diderot 7
 * @brief  : Projet Ocaml S5, 2015-2016
 * @email  : rgv26.warforce[at]hotmail.fr
 *)

#load "graphics.cma"
#use "grid.mli"

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
  method set gene = generation_cells := gene
  method diplay_grid size = Graphics.open_graph size
  method tostring = Printf.printf "[rows=%d; columns=%d]\n" rows columns
  initializer
    self#diplay_grid size
end



