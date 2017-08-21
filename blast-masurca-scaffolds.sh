#!/bin/bash
set -euo pipefail
IFS=$'\n\t'

# Blast mascura scaffold against reference.

sample=$1

outdir=blast/masurca/${sample}
blastoutfile=${outdir}/blastn_hsv.tsv
blastbed=${outdir}/blastn_hsv.bed

mkdir -p $outdir


blastn \
	-query masurca/${sample}/CA/9-terminator/genome.scf.fasta \
	-db ref/hsv/hsv.fasta \
	-outfmt 6 \
	-out $blastoutfile

# default settings did not produce different alignemtns compared with
# least stringent blastn settings:
# -reward 5 -penalty -4 -gapopen 8 -gapextend 6

# blastn output fields:
# (1) query acc.ver, (2) subject acc.ver, (3) % identity, (4) alignment length,
# (5) mismatches, (6) gap opens, (7) q. start, (8) q. end,
# (9) s. start, (10) s. end, (11) evalue, (12) bit score

#cut -f 2,9,10,1,11 $blastoutfile

blastn \
	-query masurca/${sample}/CA/9-terminator/genome.scf.fasta \
	-db ref/csabaeus/csabaeus_mito.fasta \
	-outfmt 6 \
	-out $outdir/blastn_csabaeus_mito.tsv

blastn \
	-query masurca/${sample}/CA/9-terminator/genome.scf.fasta \
	-db ref/ecoli/ecoli.fasta \
	-outfmt 6 -max_hsps 2 \
	-out $outdir/blastn_ecoli.tsv

