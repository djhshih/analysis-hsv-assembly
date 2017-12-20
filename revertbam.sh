#!/bin/bash
set -euo pipefail
IFS=$'\n\t'

# Convert aligned BAM to unaligned BAM


inbam=$1
outdir=$2

[[ ! -d $outdir ]] && mkdir -p $outdir

fname=${inbam##*/}
fstem=${fname%%.*}
outbam=$outdir/${fstem}.ubam

# extract reads using picard
picard RevertSam \
	I=$inbam O=$outbam \
	2>&1 |
	tee $outdir/picard-revertsam_${fstem}.log

