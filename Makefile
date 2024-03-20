SHELL:=/bin/bash
#SOURCES:=$(wildcard *.qmd)
SOURCES:= Prompts.qmd MorePrompts.qmd LLMs.qmd MoreLLMs.qmd Reviews.qmd Lists.qmd MoreStrings.qmd Strings.qmd Calculator.qmd MoreCalculator.qmd Variables.qmd MoreVariables.qmd VariablesHW.qmd MoreDataTypes.qmd DataTypes.qmd Dicts.qmd ForLoops.qmd Booleans.qmd PromptsLLMByHand.qmd

# SOURCES:= LLMs.qmd MoreLLMs.qmd Reviews.qmd
# SOURCES:= LLMs.qmd

SOURCES:=$(filter-out index.qmd, $(SOURCES))

IPYNB_FILES = $(SOURCES:%.qmd=%.ipynb)
HTML_FILES = $(SOURCES:%.qmd=%.html)
_FILES = $(SOURCES:%.qmd=%_files)

include .env

all : html ipynb
	@echo All files are now up to date

clean :
	@echo Removing files...
	rm -rf $(HTML_FILES) $(IPYNB_FILES) $(_FILES)

html   : $(HTML_FILES)

ipynb  : $(IPYNB_FILES)

%.html : %.qmd
	TOGETHER_API_KEY=$(TOGETHER_API_KEY) quarto render $< --to html
	#quarto render $< --to html

%.ipynb : %.qmd
	cp $< $(basename $<)-question.qmd
	sed -i 's/# Solution:/#| include: false/' $(basename $<)-question.qmd
	quarto render $(basename $<)-question.qmd --to ipynb --output $(basename $<).ipynb --no-execute
	rm $(basename $<)-question.qmd

watch:
	ls *.Rmd | entr make html

debug:
	@echo $(_FILES)

.PHONY: all clean
