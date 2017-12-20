#!/bin/bash
set -euo pipefail
IFS=$'\n\t'

# Run Quast on assembly.


sample=$1

outdir=quast/masurca/${sample}

quast.py masurca/${sample}/CA/9-terminator/genome.scf.utg.fasta \
		 -R ref/hsv/hsv.fasta \
		 -G ref/hsv/hsv.gff3 \
		 -m 100 \
		 -o $outdir

