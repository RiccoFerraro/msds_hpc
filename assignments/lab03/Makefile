args = $(foreach a,$($(subst -,_,$1)_args),$(if $(value $a),$a="$($a)"))

.PHONY: all numpy

numpy: SHELL:=/bin/bash
numpy: 
	# compiler flags an be supplied here if necessary. Let's rely on autodetect for now. 
	cd numpy && python3.8 setup.py build_ext --inplace  

all: numpy
	@echo "Done"



