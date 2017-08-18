#!/bin/bash
set -euo pipefail
IFS=$'\n\t'

# Extract unmapped reads from BAM file and output to new BAM file.

inbam=$1
outdir=$2

# make output directory
[[ ! -d $outdir ]] && mkdir -p $outdir

infname=${inbam##*/}
instem=${infname%%.*}
outbam=$outdir/${instem}.unmapped.bam

#[[ -f $outbam ]] && exit

samtools view -b -f 4 $inbam > $outbam

