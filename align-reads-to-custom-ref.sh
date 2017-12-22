#!/bin/bash

sample=$1

indir=custom-ref/$sample
fastq1=fastq/trimmed-filtered/${sample}_R1.fastq.gz
fastq2=fastq/trimmed-filtered/${sample}_R2.fastq.gz

ref=$indir/ref.fasta

outdir=aligned-reads/custom-ref/$sample
tmpbam=$outdir/${sample}.unsorted.bam
outbam=$outdir/${sample}.bam

bwa index $ref

[[ ! -d $outdir ]] && mkdir -p $outdir

# align to reference and keep only mapped reads
bwa mem $ref $fastq1 $fastq2 \
	| samtools view -b -F 4 - \
	> $tmpbam

samtools sort $tmpbam > $outbam
samtools index $outbam
rm -f $tmpbam

