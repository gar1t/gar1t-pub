SOURCES = $(wildcard *.in)
GIFS = $(patsubst %.in,%.gif,$(SOURCES))

.SECONDARY:

gifs: $(GIFS)

%.gif: %.raw.gif
	./make-final $*.in $< $@

%.raw.gif: %.video
	./make-animated $*.in $< $@

%.video: %.in
	./get-video $< $@

sync:
	s3cmd sync -P $(GIFS) s3://gar1t-pub
