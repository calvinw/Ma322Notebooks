SHELL:=/bin/bash

SOURCES:=$(wildcard *.qmd)
SOURCES:= SimpleCompletion.qmd ReviewChain.qmd SimpleLLMChain.qmd MoreSimpleLLMChain.qmd MovieChain.qmd ClassifyCustomerQueries.qmd Roles.qmd MoreRoles.qmd CustomersSay.qmd

#SOURCES:= Roles.qmd
SOURCES:=$(filter-out index.qmd, $(SOURCES))
LLM_FILES=$(wildcard _llm_*.qmd)
SOURCES:=$(filter-out $(LLM_FILES), $(SOURCES))

IPYNB_FILES = $(SOURCES:%.qmd=%.ipynb)
HTML_FILES = $(SOURCES:%.qmd=%.html)
_FILES = $(SOURCES:%.qmd=%_files)

all : html ipynb
	@echo All files are now up to date

debug:
	@echo $(HTML_FILES)
	@echo $(IPYNB_FILES)
	@echo $(LLM_FILES)

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
