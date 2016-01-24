(*
 * @author : Pierre Dibo, L3 Universite Paris-Diderot 7
 * @brief  : Projet Ocaml S5, 2015-2016
 * @email  : rgv26.warforce[at]hotmail.fr
 *)

(*Le type state definnissant l'etat d'une cellule par un booleen *)
class type state_t =
object
  val mutable alive : bool ref
  method get : bool
  method set : bool -> unit
end

(*Le type point_t, comprend ses coordonnees x et y dans le plan en int et une methode de description de l'objet*)
class type point_t =
object
  val x : int
  val y : int
  method tostring : unit
end

(*Le type cell_t, comprend sa position dans le plan, son etat et sa couleur *)
class type cell_t =
object
  val mutable position : point_t
  val mutable inner_state : state_t
  val mutable color : int
  method next_state : unit
  method getPoint : point_t
  method getColor : int
  method tostring : unit
end
