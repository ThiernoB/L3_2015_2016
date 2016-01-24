automate_cellulaire : projet.cmo types.cmo
	ocamlc -o automate_cellulaire graphics.cma projet.cmo types.cmo

projet.cmo : projet.ml types.cmi
	ocamlc -c projet.ml
	
types.cmi : types.mli
	ocamlc types.mli
	
clean :
	rm -f *.cm[iox] *~ .*~ *.ml# *.mli#