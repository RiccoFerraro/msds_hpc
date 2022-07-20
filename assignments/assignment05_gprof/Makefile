args = $(foreach a,$($(subst -,_,$1)_args),$(if $(value $a),$a="$($a)"))

.PHONY: all numpy

numpy_gprof: SHELL:=/bin/bash
numpy_gprof: 
	cd numpy && CFLAGS="-pg -O0" python3.8 setup.py build_ext --inplace  

all: numpy_gprof
	@echo "Done"



