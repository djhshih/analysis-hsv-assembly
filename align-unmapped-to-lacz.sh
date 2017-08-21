#!/bin/bash
set -euo pipefail
IFS=$'\n\t'

# Align unmapped fastq reads to Lacz seequence.

sample=$1
#sample=032217_FA6_CP3660_S2
#sample=032217_Vero_-_CP3660_S5

ref=ref/lacz/lacz_ecoli.fasta
indir=unmapped/fastq
fastq1=$indir/${sample}_R1.fastq.gz
fastq2=$indir/${sample}_R2.fastq.gz

outdir=lacz
tmpbam=$outdir/${sample}_lacz.bam
outbam=$outdir/${sample}_lacz.sorted.bam

[[ ! -d $outdir ]] && mkdir -p $outdir

# align to reference and keep only mapped reads
bwa mem $ref $fastq1 $fastq2 \
	| samtools view -b -F 4 - \
	> $tmpbam

samtools sort $tmpbam > $outbam
samtools index $outbam
rm -f $tmpbam

