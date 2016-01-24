(*
 * @author : Pierre Dibo, L3 Universite Paris-Diderot 7
 * @brief  : Projet Ocaml S5, 2015-2016
 * @email  : rgv26.warforce[at]hotmail.fr
 *)

#load "graphics.cma"
#use "cell.mli"

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
