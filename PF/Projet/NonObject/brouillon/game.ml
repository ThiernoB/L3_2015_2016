(**)

type state = alive | dead

type cell = state

type generation = []

type rule = string

type automaton = string


let parse (chan_in : in_channel) : None =
	let dime = ref 0 in
	let spec = ref "" in
	let gene = ref "" in
	
	try
		dime := input_int chan_in;
	with End_of_file -> ();
	
	try
		while !spec != "GenerationZero"; do
			spec := input_string chan_in;
		done;
	with End_of_file -> ();
	
	(try
		while true; do
			gene := input_string chan_in;
     done;
   with End_of_file -> ());;
	


let next_state (cell_state : cell) : state = function
	| true -> alive
	| false -> dead
;;

let next_generation grid = Array.map (Array.map next_state) grid


	