#!/bin/bash
set -euo pipefail
IFS=$'\n\t'

# Run Quast on assembly.


sample=$1

infile=ordered/hsv-ref/${sample}/scaffolds-ordered.fa
outdir=quast/ordered/hsv-ref/${sample}

quast.py $infile \
		 -R $ref \
		 -G ref/hsv/hsv.gff3 \
		 -m 100 \
		 -o $outdir

