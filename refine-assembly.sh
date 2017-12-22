#!/bin/bash

source activate viral-ngs-env

sample=$1


indir=imputed/custom-ref/$sample
infasta=$indir/imputed-assembly.fa
bam=aligned-reads/imputed-custom-ref/$sample/$sample.bam
outdir=refined/imputed/custom-ref/$sample

mkdir -p $outdir

assembly.py refine_assembly \
	$infasta \
	$bam \
	$outdir/refined-assembly.fa \
	--already_realigned_bam $bam \
	--outVcf=$outdir/variants.vcf \
	--JVMmemory=2G \
	--tmp_dir=./tmp

