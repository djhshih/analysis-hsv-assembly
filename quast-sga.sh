#!/bin/bash
set -euo pipefail
IFS=$'\n\t'

# Run Quast on assembly.


sample=$1

infile=sga/${sample}/sga-scaffolds.fa
#outdir=quast/sga/${sample}

infile=sga/trimmed-filtered/${sample}/sga-scaffolds.fa
outdir=quast/sga/trimmed-filtered/${sample}

quast.py $infile \
		 -R ref/hsv/hsv.fasta \
		 -G ref/hsv/hsv.gff3 \
		 -m 100 \
		 -o $outdir

