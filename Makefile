SHELL:=/bin/bash
#SOURCES:=$(wildcard *.qmd)
SOURCES:= MyFirstColabNotebook.qmd Calculator.qmd MoreCalculator.qmd Variables.qmd MoreVariables.qmd VariablesHW.qmd MoreDataTypes.qmd DataTypes.qmd
SOURCES:=$(filter-out index.qmd, $(SOURCES))

IPYNB_FILES = $(SOURCES:%.qmd=%.ipynb)
HTML_FILES = $(SOURCES:%.qmd=%.html)

all : html ipynb
	@echo All files are now up to date

clean :
	@echo Removing files...
	rm -f $(HTML_FILES) $(IPYNB_FILES)
	rm -rf *_files

html   : $(HTML_FILES)

ipynb  : $(IPYNB_FILES)

%.html : %.qmd
	quarto render $< --to html

%.ipynb : %.qmd
	cp $< $(basename $<)-question.qmd
	sed -i 's/# Solution:/#| include: false/' $(basename $<)-question.qmd
	quarto render $(basename $<)-question.qmd --to ipynb --output $(basename $<).ipynb --no-execute
	rm $(basename $<)-question.qmd

watch:
	ls *.Rmd | entr make html

.PHONY: all clean
