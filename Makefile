SHELL:=/bin/bash
#SOURCES:=$(wildcard *.qmd)
SOURCES:= PromptStrings.qmd MorePromptStrings.qmd LLMs.qmd MoreLLMs.qmd Reviews.qmd Lists.qmd MoreStrings.qmd Strings.qmd Calculator.qmd MoreCalculator.qmd Variables.qmd MoreVariables.qmd VariablesHW.qmd MoreDataTypes.qmd DataTypes.qmd

#SOURCES:= LLMs.qmd MoreLLMs.qmd Reviews.qmd
#SOURCES:= test.qmd

SOURCES:=$(filter-out index.qmd, $(SOURCES))

IPYNB_FILES = $(SOURCES:%.qmd=%.ipynb)
HTML_FILES = $(SOURCES:%.qmd=%.html)

include .env

all : ipynb html
	@echo All files are now up to date

clean :
	@echo Removing files...
	rm -f $(HTML_FILES) $(IPYNB_FILES)
	rm -rf *_files

html   : $(HTML_FILES)

ipynb  : $(IPYNB_FILES)

%.html : %.qmd
	OPENAI_API_KEY=$(OPENAI_API_KEY) quarto render $< --to html
	#quarto render $< --to html

%.ipynb : %.qmd
	cp $< $(basename $<)-question.qmd
	sed -i 's/# Solution:/#| include: false/' $(basename $<)-question.qmd
	quarto render $(basename $<)-question.qmd --to ipynb --output $(basename $<).ipynb --no-execute
	rm $(basename $<)-question.qmd

watch:
	ls *.Rmd | entr make html

.PHONY: all clean
