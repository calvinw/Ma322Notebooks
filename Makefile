SHELL:=/bin/bash

PAGES= \
SystemPrompting.qmd \
BarbieSystemPrompt.qmd \
SpeakLikeAPirate.qmd

SOURCES:= \
AttributionModels.qmd \
AccuracyInClass.qmd \
Calculator.qmd \
Strings.qmd \
Functions.qmd \
Variables.qmd \
DataTypes.qmd \
DataFrames.qmd \
DecisionTree.qmd \
Dicts.qmd \
Ecofriendly.qmd \
ForLoops.qmd \
FStrings.qmd \
HandMDresses-100.qmd \
HotChocolate.qmd \
Lists.qmd \
PromptsLLMByHand.qmd \
Prompts.qmd \
NotebookBot.qmd \
OrderBot.qmd \
TwoProducts.qmd \
BuildCustomerProfiles.qmd \
ChainOfThoughtReasoning-DLai.qmd \
ChainOfThoughtReasoning.qmd \
CustomersSay.qmd \
Delimiters.qmd \
FStringChains.qmd \
LLMs.qmd \
MovieChain.qmd \
ProductInquiries.qmd \
ProductInquiries.short.qmd \
ProductSpec.qmd \
ReviewChainAssign.qmd \
Restaurant.qmd \
Roles.qmd \
SegmentingCustomers.qmd \
Sneakers.qmd \
SimpleCompletion.qmd \
SimpleLLMChain.qmd \
Simple.qmd \
TranslateChain.qmd

ASSIGNMENT_SOURCES:= \
ClassifyCustomerQueries.qmd \
MoreCalculator.qmd \
MoreDataFrames.qmd \
EvenMoreDataFrames.qmd \
MoviesDataFrame.qmd \
MorePrompts.qmd \
MoreStrings.qmd \
MoreFunctions.qmd \
MoreVariables.qmd \
ReviewChain.qmd \
VariablesHW.qmd \
MoreDataTypes.qmd \
MoreLLMs.qmd \
MoreReviews.qmd \
MoreRoles.qmd \
MoreSimpleLLMChain.qmd

PAGES_HTML_FILES = $(PAGES:%.qmd=%.html)

REGULAR_HTML_FILES = $(SOURCES:%.qmd=%.html)
REGULAR_IPYNB_FILES = $(SOURCES:%.qmd=%.ipynb)

ASSIGNMENT_HTML_FILES = $(ASSIGNMENT_SOURCES:%.qmd=%.html)
ASSIGNMENT_IPYNB_FILES = $(ASSIGNMENT_SOURCES:%.qmd=%.ipynb)

SOLUTION_HTML_FILES = $(ASSIGNMENT_SOURCES:%.qmd=%Solution.html)

all: pages html assignment_html solution_html ipynb assignment_ipynb
	@echo All files are now up to date

clean:
	@echo Removing files...
	rm -rf $(PAGES_HTML_FILES) $(REGULAR_HTML_FILES) $(REGULAR_IPYNB_FILES) $(ASSIGNMENT_HTML_FILES) $(ASSIGNMENT_IPYNB_FILES) $(SOLUTION_HTML_FILES) *_files *Solution.qmd

pages: $(PAGES_HTML_FILES)

html: $(REGULAR_HTML_FILES)

ipynb: $(REGULAR_IPYNB_FILES)

assignment_html: $(ASSIGNMENT_HTML_FILES)

assignment_ipynb: $(ASSIGNMENT_IPYNB_FILES)

solution_html: $(SOLUTION_HTML_FILES)

$(PAGES_HTML_FILES): %.html: %.qmd
	quarto render $< --to html

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
