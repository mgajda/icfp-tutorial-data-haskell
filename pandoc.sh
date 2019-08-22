#!/bin/bash

INPUT=presi.md
OUTPUT=presi.pdf

pandoc -s --mathml -i --from=markdown --to=beamer ${INPUT} --output=${OUTPUT} --slide-level=1 && open ${OUTPUT}
