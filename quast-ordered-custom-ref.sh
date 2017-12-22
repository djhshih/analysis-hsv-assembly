#!/bin/bash
set -euo pipefail
IFS=$'\n\t'

# Run Quast on assembly.


sample=$1

infile=ordered/custom-ref/${sample}/scaffolds-ordered.fa
outdir=quast/ordered/custom-ref/${sample}
ref=custom-ref/${sample}/ref.fasta

quast.py $infile \
		 -R $ref \
		 -m 100 \
		 -o $outdir

#		 -G ref/hsv/hsv.gff3 \
