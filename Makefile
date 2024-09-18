SHELL:=/bin/bash

SOURCES:= \
Calculator.qmd \
Strings.qmd \
Functions.qmd \
Variables.qmd \
DataTypes.qmd \
DataFrames.qmd \
DecisionTree.qmd \
Dicts.qmd \
ForLoops.qmd \
FStrings.qmd \
Lists.qmd \
PromptsLLMByHand.qmd \
Prompts.qmd \
TwoProducts.qmd \
BuildCustomerProfiles.qmd \
ChainOfThoughtReasoning-DLai.qmd \
ChainOfThoughtReasoning.qmd \
ClassifyCustomerQueries.qmd \
CustomersSay.qmd \
Delimiters.qmd \
FStringChains.qmd \
LLMs.qmd \
MovieChain.qmd \
ProductInquiries.qmd \
ProductInquiries.short.qmd \
ProductSpec.qmd \
ReviewChainAssign.qmd \
ReviewChain.qmd \
Roles.qmd \
SegmentingCustomers.qmd \
SimpleCompletion.qmd \
SimpleLLMChain.qmd \
Simple.qmd \
TranslateChain.qmd

ASSIGNMENT_SOURCES:= \
MoreCalculator.qmd \
MoreDataFrames.qmd \
MorePrompts.qmd \
MoreStrings.qmd \
MoreFunctions.qmd \
MoreVariables.qmd \
VariablesHW.qmd \
MoreDataTypes.qmd \
MoreLLMs.qmd \
MoreReviews.qmd \
MoreRoles.qmd \
MoreSimpleLLMChain.qmd

# ASSIGNMENT_SOURCES:= \
# MoreCalculator.qmd

REGULAR_HTML_FILES = $(SOURCES:%.qmd=%.html)
REGULAR_IPYNB_FILES = $(SOURCES:%.qmd=%.ipynb)

ASSIGNMENT_HTML_FILES = $(ASSIGNMENT_SOURCES:%.qmd=%.html)
ASSIGNMENT_IPYNB_FILES = $(ASSIGNMENT_SOURCES:%.qmd=%.ipynb)

SOLUTION_HTML_FILES = $(ASSIGNMENT_SOURCES:%.qmd=%Solution.html)

all: html assignment_html solution_html ipynb assignment_ipynb
	@echo All files are now up to date

clean:
	@echo Removing files...
	rm -rf $(REGULAR_HTML_FILES) $(REGULAR_IPYNB_FILES) $(ASSIGNMENT_HTML_FILES) $(ASSIGNMENT_IPYNB_FILES) $(SOLUTION_HTML_FILES) *_files *Solution.qmd

html: $(REGULAR_HTML_FILES)

ipynb: $(REGULAR_IPYNB_FILES)

assignment_html: $(ASSIGNMENT_HTML_FILES)

assignment_ipynb: $(ASSIGNMENT_IPYNB_FILES)

solution_html: $(SOLUTION_HTML_FILES)

# Rule for regular SOURCES
$(REGULAR_HTML_FILES): %.html: %.qmd
	quarto render $< --to html

$(REGULAR_IPYNB_FILES): %.ipynb: %.qmd
	quarto render $< --to ipynb --no-execute

# Rules for ASSIGNMENT_SOURCES
$(ASSIGNMENT_HTML_FILES): %.html: %.qmd
	@echo "Making Assignment HTML: $@"
	@sed -e 's/# __SOLUTION__/#| echo: false/g' -e 's/# __REGULAR_BLOCK__//g' $< > $*Assignment.qmd
	quarto render $*Assignment.qmd --to html -o $@
	@rm $*Assignment.qmd

$(ASSIGNMENT_IPYNB_FILES): %.ipynb: %.qmd
	@echo "Making Assignment IPYNB: $@"
	@sed -e 's/# __SOLUTION__/#| echo: false/g' -e 's/# __REGULAR_BLOCK__//g' $< > $*Assignment.qmd
	quarto render $*Assignment.qmd --to ipynb --no-execute -o $@
	@rm $*Assignment.qmd

%Solution.html: %.qmd
	@echo "Making Solution HTML: $@"
	@sed -e 's/# __SOLUTION__/#| eval: true\n# Solution:/g' -e 's/# __REGULAR_BLOCK__/#| eval: true/g' $< > $*Solution.qmd
	quarto render $*Solution.qmd --to html -o $@
	@rm $*Solution.qmd

.PHONY: all clean html ipynb assignment_html assignment_ipynb solution_html
