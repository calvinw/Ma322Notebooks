SHELL:=/bin/bash
SOURCES:=$(wildcard *.qmd)
# SOURCES:= FStringChains.qmd

SOURCES:=$(filter-out index.qmd, $(SOURCES))
SOURCES:=$(filter-out _*.qmd, $(SOURCES))

IPYNB_FILES = $(SOURCES:%.qmd=%.ipynb)
HTML_FILES = $(SOURCES:%.qmd=%.html)
_FILES = $(SOURCES:%.qmd=%_files)
LLM_FILES=$(wildcard _llm_*.qmd)

all : html ipynb
	@echo All files are now up to date

clean :
	@echo Removing files...
	rm -rf $(HTML_FILES) $(IPYNB_FILES) $(_FILES)

html   : $(HTML_FILES)

ipynb  : $(IPYNB_FILES)

%.html : %.qmd
	quarto render $< --to html

%.md : %.qmd
	quarto render $< --to md

%.ipynb : %.qmd
	cp $< $(basename $<)-question.qmd
	sed -i 's/# Solution:/#| include: false/' $(basename $<)-question.qmd
	quarto render $(basename $<)-question.qmd --to ipynb --output $(basename $<).ipynb --no-execute
	rm $(basename $<)-question.qmd

.PHONY: all clean
