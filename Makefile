TARGET=hasmof
FLAGS=

all:
	ghc -o ${TARGET} *.hs

.Phony: clean
clean:
	rm -f *.o *.hi ${TARGET}
