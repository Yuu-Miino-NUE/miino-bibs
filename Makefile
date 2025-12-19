bibtex_DIR=bibtex
csljson_DIR=csljson

.PHONY: all summary csl
all: summary

summary: summary.py $(bibtex_DIR)/*.bib
	python summary.py $(bibtex_DIR)/*.bib

csl: $(bibtex_DIR)/*.bib
	mkdir -p $(csljson_DIR)
	$(MAKE) $(patsubst $(bibtex_DIR)/%.bib,$(csljson_DIR)/%.json,$(wildcard $(bibtex_DIR)/*.bib))

$(csljson_DIR)/%.json: $(bibtex_DIR)/%.bib
	pandoc --from=bibtex --to=csljson $< -o $@
	echo "Converted: $< -> $@"
