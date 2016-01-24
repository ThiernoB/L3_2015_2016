(*
 * @author : Pierre Dibo, L3 Universite Paris-Diderot 7
 * @brief  : Projet Ocaml S5, 2015-2016
 * @email  : rgv26.warforce[at]hotmail.fr
 *)

#use "cell.mli"

(*Le type generation_t, comprend la liste de cell_t et des des methodes de controle de la liste*)
class type generation_t =
object
  val mutable list_cell : cell_t list ref
  method get : cell_t list
  method add : cell_t -> unit
  method addAll : cell_t list -> unit
  method next : generation_t -> unit
  method tostring : unit
end

(*Le type grid_t, comprend le nombre de lignes et de colonnes de la grille, la generation de cell_t et une methode d'affihage de la grille *)
class type grid_t =
object
  val rows : int
  val columns : int
  val generation_cells : generation_t ref
	method get_gene : generation_t
  method set : generation_t -> unit
  method diplay_grid : string -> unit
  method tostring : unit
end
