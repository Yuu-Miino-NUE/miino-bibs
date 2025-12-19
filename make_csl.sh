#!/bin/bash

for bib in bibtex/*.bib; do
    base=$(basename "$bib" .bib)

    pandoc --from=bibtex --to=csljson "$bib" -o "csljson/${base}.json"
    echo "Converted: $bib -> csljson/${base}.json"
done