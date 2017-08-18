#!/bin/bash
set -euo pipefail
IFS=$'\n\t'

# Extract reads from bam file and output to fastq file.


inbam=$1
outdir=$2

[[ ! -d $outdir ]] && mkdir -p $outdir

fname=${inbam##*/}
fstem=${fname%%.*}
fastq1=$outdir/${fstem}_R1.fastq
fastq2=$outdir/${fstem}_R2.fastq

# extract reads using picard
picard SamToFastq I=$inbam FASTQ=$fastq1 SECOND_END_FASTQ=$fastq2 \
	2>&1 | picard-samtofastq_${fstem}.log

# gzip the fastq files
gzip $fastq1
gzip $fastq2

