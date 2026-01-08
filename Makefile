bibtex_DIR=bibtex
csljson_DIR=public

.PHONY: all summary csl
all: summary

summary: summary.py $(bibtex_DIR)/*.bib
	python summary.py $(bibtex_DIR)/*.bib

csl: $(bibtex_DIR)/*.bib
	mkdir -p $(csljson_DIR)
	pandoc --from=bibtex --to=csljson $^ -o $(csljson_DIR)/all.json
	echo "Converted: $^ -> $(csljson_DIR)/all.json"