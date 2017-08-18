#!/bin/bash
set -euo pipefail
IFS=$'\n\t'

# Align fastq reads to reference.


sample=$1
#sample=032217_FA6_CP3660_S2
#sample=032217_Vero_-_CP3660_S5

ref=ref/lacz/lacz.fasta
indir=unmapped
fastq1=$indir/fastq/${sample}_R1.fastq.gz
fastq2=$indir/fastq/${sample}_R2.fastq.gz

outdir=lacz
outbam=$outdir/${sample}_lacz.bam


[[ ! -d $outdir ]] && mkdir -p $outdir

bwa mem $ref $fastq1 $fastq2 \
	| samtools view -b - \
	> $outbam

