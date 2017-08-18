#!/bin/bash
set -euo pipefail
IFS=$'\n\t'

# Collect insert size metrics using Picard.


inbam=$1
outdir=picard/insert-size

infname=${inbam##*/}
sample=${infname%%.*}

[[ ! -d $outdir ]] && mkdir -p $outdir

picard CollectInsertSizeMetrics \
	I=$inbam \
	O=$outdir/${sample}_insert-size_metrics.txt \
	H=$outdir/${sample}_insert-size_histogram.pdf \
	M=0.5

