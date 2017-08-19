#!/bin/bash
set -euo pipefail
IFS=$'\n\t'

# Calculate the N50 statistic for a fasta of contigs or scaffolds.


#fasta=masurca/032217_G207_CP3660_S1/CA/9-terminator/genome.scf.fasta
#genome_size=152151

fasta=$1
genome_size=$2

lengths=$fasta.lens

faCount $fasta | cut -f 2 | sed '1d; $d' > $lengths

R --slave <<- EOF
	x <- read.table("$lengths")[,1];
	y <- sort(x, decreasing=TRUE);
	message("N50 = ", y[ which((cumsum(y) >= $genome_size * 0.5))[1] ]);
EOF

ncontigs=$(wc -l $lengths | cut -d ' ' -f 1)
echo "n_contigs = $ncontigs"

