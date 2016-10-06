TARGET=hasmof
FLAGS=-O -prof -fprof-auto

all:
	ghc -o ${TARGET} ${FLAGS} *.hs

.PHONY: clean
clean:
	rm -f *.o *.hi *prof ${TARGET}

.PHONY: prof
prof:
	make clean
	make
	./hasmof big.faa /dev/null +RTS -p
