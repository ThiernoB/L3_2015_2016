(*
 * @author : Pierre Dibo, L3 Universite Paris-Diderot 7
 * @brief  : Projet Ocaml S5, 2015-2016
 * @email  : rgv26.warforce[at]hotmail.fr
 *)

#use "grid.mli"
 
class type rule_t =
object 
	val mutable _rule : string
	method tostring : unit
end
 
class type parse_t =
object
	val separator : string ref
  val mutable size_grid : int ref
	val mutable grid_rules : rule_t list ref
	val mutable init_gene : generation_t
	method get_gene : generation_t
	method set_size : int -> unit
	method set_rules : rule_t -> unit
end