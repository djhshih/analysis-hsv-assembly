#!/bin/bash
set -euo pipefail
IFS=$'\n\t'

# Run Quast on assembly.


sample=$1

infile=gap2seq/${sample}/scaffolds-filled.fa
outdir=quast/gap2seq/${sample}

quast.py $infile \
		 -R ref/hsv/hsv.fasta \
		 -G ref/hsv/hsv.gff3 \
		 -m 100 \
		 -o $outdir

