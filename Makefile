bibtex_DIR=bibtex
public_DIR=public

.PHONY: all summary csl
all: summary

summary: summary.py $(bibtex_DIR)/*.bib
	python summary.py $(bibtex_DIR)/*.bib

csl: $(bibtex_DIR)/*.bib
	mkdir -p $(public_DIR)
	pandoc --from=biblatex --to=csljson $^ -o $(public_DIR)/all.json
	echo "Converted: $^ -> $(public_DIR)/all.json"

bib: csl
	pandoc --from=csljson --to=biblatex $(public_DIR)/all.json --wrap=none -o $(public_DIR)/all_converted.bib
	echo "Converted: $(public_DIR)/all.json -> $(public_DIR)/all_converted.bib"