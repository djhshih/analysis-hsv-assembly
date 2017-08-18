#!/bin/bash

ref=ref/hsv/hsv.fasta
scaffolds=sga-scaffolds.fa
outbam=sga-scaffolds.bam

bwa mem $ref $scaffolds \
	| samtools view -b - \
	> $outbam

