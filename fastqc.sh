#!/bin/bash
set -euo pipefail
IFS=$'\n\t'

# Perform quality assessment of sequencing reads

sample=$1

#indir=fastq
#outdir=fastqc

#indir=cutadapt
#outdir=fastqc/cutadapt

indir=fastq/trimmed-filtered
outdir=fastqc/trimmed-filtered

r1=$indir/${sample}_R1.fastq.gz
r2=$indir/${sample}_R2.fastq.gz

mkdir -p $outdir

fastqc $r1 $r2 -o $outdir 
