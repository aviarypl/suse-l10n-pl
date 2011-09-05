#MSGFMT='/cygdrive/e/program files/poEdit/bin/msgfmt.exe'
MSGFMT=msgfmt

pofiles = $(wildcard *.pl.po)
mofiles = $(patsubst %.pl.po,mo/%.mo,$(pofiles)) 

.PHONY : clean install

all : yast

yast: mo $(mofiles)
	
mo:
	mkdir -p mo

mo/%.mo : %.pl.po
	$(MSGFMT) -o $@ $(patsubst mo/%.mo,%.pl.po,$@)

clean: 
	rm -Rf mo
	
install:
	cp -f mo/* /usr/share/YaST2/locale/pl/LC_MESSAGES/
