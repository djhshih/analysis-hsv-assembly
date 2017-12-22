#!/bin/bash

sample=$1

scaffolds=sga/trimmed-filtered/$sample/sga-scaffolds.fa
outdir=aligned-scaffolds/sga/trimmed-filtered-custom-ref/$sample
outbam=$outdir/sga-scaffolds.bam

ref=custom-ref/$sample/ref.fasta

mkdir -p $outdir

bwa mem $ref $scaffolds \
	| samtools view -b - \
	> $outdir/scaffolds.unsorted.bam

samtools sort $outdir/scaffolds.unsorted.bam -o $outdir/scaffolds.bam &&
	rm $outdir/scaffolds.unsorted.bam
samtools index $outdir/scaffolds.bam

