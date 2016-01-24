all: projet.ml
	ocamlc -c graphics.cma unix.cma str.cma projet.ml -o automate
	ocamlc  graphics.cma unix.cma str.cma projet.cmo -o automate

clean :
	rm -f *.cm[iox] *~ .*~ *.ml# *.mli# *.o