(*	Projet PF5 : Automate cellulaire
**
**	@file types.mli
**	@language : Ocaml
**	@authors : Pierre Dibo - Oulebsir Hocine
**	@origin Université Diderot-Paris 7
**	@email : rgv26.warforce@hotmail.fr -
**
*)

type formula =
    True | False
  | Var of int
  | Neg of formula
  | And of formula * formula
  | Or of formula * formula

type state = {
  mutable alive : bool
}

type rule =  {
  mutable str : string
}

type generation = {
  mutable cells : state array array
}

type automaton = {
  mutable rules : rule list
}