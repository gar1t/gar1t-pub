SOURCES = $(wildcard *.in)
GIFS = $(patsubst %.in,%.gif,$(SOURCES))

.SECONDARY:

gifs: $(GIFS)

%.gif: %.raw.gif make-final
	./make-final $*.in $< $@

%.raw.gif: %.video make-animated
	./make-animated $*.in $< $@

%.video: %.in
	test ! -e $@ && ./get-video $< $@ || touch $@

sync:
	s3cmd sync -P $(GIFS) s3://gar1t-pub
