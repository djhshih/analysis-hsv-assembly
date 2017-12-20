#!/bin/bash
set -euo pipefail
IFS=$'\n\t'

# Blast adapters against reference.

blastn \
	-query ref/adapter/thruplex.fa \
	-db ref/hsv/hsv.fasta \
	-task blastn-short \
	-outfmt 1 \
	| tee ref/adapter/thruplex.blast.txt

