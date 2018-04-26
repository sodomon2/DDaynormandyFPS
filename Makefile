.DEFAULT_GOAL := root

.PHONY: build clean q2proroot ddayroot q2admintsmodroot

q2pro:
	$(MAKE) -C q2proSRC
	cp -a q2proSRC/q2pro DDayNormandy
	cp -a q2proSRC/q2proded DDayNormandyded
	
dday/config.cfg:
	cp -a dday/config.cfg.sample dday/config.cfg

dday: dday/config.cfg
	echo "ARCH=$(shell arch)" > variable.mk
	$(MAKE) -C DDaySRC
	cp -a DDaySRC/game?*.real.* dday/

q2admintsmod:
	$(MAKE) -C q2admintsmod
	cp -a q2admintsmod/game?*.* dday/
CompAll:
	echo "ARCH=$(uname -m)" > variable.mk
	mv q2proSRC/.config q2proSRC/.configlocal
	mv q2proSRC/.configroot q2proSRC/.config
	$(MAKE) -C q2proSRC
	$(MAKE) -C DDaySRC
	$(MAKE) -C q2admintsmod
	mv q2proSRC/.config q2proSRC/.configroot
	mv q2proSRC/.configlocal q2proSRC/.config
install:
	cp -a q2proSRC/q2pro /usr/local/lib/games/ddaynormandy/ddaynormandy
	cp -a q2proSRC/q2proded /usr/local/lib/games/ddaynormandy/ddaynormandyded
	cp -a DDaySRC/game?*.real.* /usr/local/share/games/ddaynormandy/dday/
	cp -a dday/config.cfg.sample /usr/local/share/games/ddaynormandy/dday/config.cfg
	cp -a q2admintsmod/game?*.* /usr/local/share/games/ddaynormandy/dday/

build: q2pro dday q2admintsmod
root: CompAll

clean:
	$(MAKE) -C q2proSRC clean
	rm -f DDayNormandy
	rm -f DDayNormandyded
	$(MAKE) -C DDaySRC clean
	rm -f dday/game?*.real.*
	rm -f variable.mk
	$(MAKE) -C DDaySRC/ai clean
	$(MAKE) -C DDaySRC/gbr clean
	$(MAKE) -C DDaySRC/grm clean
	$(MAKE) -C DDaySRC/ita clean
	$(MAKE) -C DDaySRC/jpn clean
	$(MAKE) -C DDaySRC/pol clean
	$(MAKE) -C DDaySRC/rus clean
	$(MAKE) -C DDaySRC/usa clean
	$(MAKE) -C DDaySRC/usm clean
	$(MAKE) -C q2admintsmod clean
	rm -f dday/game?*.*

