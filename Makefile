SHELL:=/bin/bash
#SOURCES:=$(wildcard *.qmd)
SOURCES:=Calculator.qmd
SOURCES:=$(filter-out index.qmd, $(SOURCES))

IPYNB_FILES = $(SOURCES:%.qmd=%.ipynb)

all : ipynb
	@echo All files are now up to date

clean :
	@echo Removing files...
	rm -f $(IPYNB_FILES)
	rm -rf *_files

ipynb  : $(IPYNB_FILES)

%.ipynb : %.qmd
	quarto render $<  --to ipynb

watch:
	ls *.qmd | entr make html

.PHONY: all clean
