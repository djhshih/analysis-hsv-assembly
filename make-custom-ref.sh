#!/bin/bash

indir=custom-ref

sample=032217_FA6_CP3660_S2
mkdir -p $indir/$sample
cp ref/hsv/hsv_lacz-ins.fasta $indir/$sample/ref.fasta
bwa index $indir/$sample/ref.fasta
samtools faidx $indir/$sample/ref.fasta

sample=032217_G207_CP3660_S1
mkdir -p $indir/$sample
cp ref/hsv/hsv_lacz-ins_rl1-del.fasta $indir/$sample/ref.fasta
bwa index $indir/$sample/ref.fasta
samtools faidx $indir/$sample/ref.fasta

sample=032217_G47A_CP3660_S3
mkdir -p $indir/$sample
cp ref/hsv/hsv_lacz-ins_rl1-del_us12-del.fasta $indir/$sample/ref.fasta
bwa index $indir/$sample/ref.fasta
samtools faidx $indir/$sample/ref.fasta

sample=032217_G47A-BAC_CP3660_S4
mkdir -p $indir/$sample
cp ref/hsv/hsv_lacz-ins_rl1-del_us12-del.fasta $indir/$sample/ref.fasta
bwa index $indir/$sample/ref.fasta
samtools faidx $indir/$sample/ref.fasta

