#! /bin/make

# CADP (CONSTRUCTION AND ANALYSIS OF DISTRIBUTED PROCESSES)
# http://cadp.inria.fr

CAESARADT = caesar.adt -english

SPEC = list

user: user.c $(SPEC).h
	$(CADP)/src/com/cadp_cc -I$(CADP)/incl user.c -L$(CADP)/bin.`$(CADP)/com/arch` -lcaesar -lcaesar_plug -o $@
	./user

$(SPEC).h: $(SPEC).lotos $(SPEC).t
	$(CAESARADT) $(SPEC).lotos 

clean:
	rm -f $(SPEC).h user

