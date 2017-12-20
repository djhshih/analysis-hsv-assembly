#!/bin/bash
set -euo pipefail
IFS=$'\n\t'

# Cut adapter sequences and trim reads

sample=$1

indir=fastq
r1=$indir/${sample}_R1.fastq.gz
r2=$indir/${sample}_R2.fastq.gz

outdir=cutadapt
o1=$outdir/${sample}_R1.fastq.gz
o2=$outdir/${sample}_R2.fastq.gz

mkdir -p $outdir

# trim the adapter sequences for the ThruPLEX DNA-seq dual-indexed library
# expect to see the forward sequence of the 3' adapter in read 1
# expect to see the reverse complement of the 5' adapter in read 2
# since the downstream goal is sequence assembly,
#  we use an overlap of 1 to be very aggressive in adapter trimming;
#  however, this will cause all trailing 'A' to be removed from all reads
cutadapt \
 -a AGATCGGAAGAGCACACGTCTGAACTCCAGTCACNNNNNNNNATCTCGTATGCCGTCTTCTGCTTG \
 -A AGATCGGAAGAGCGTCGTGTAGGGAAAGAGTGTNNNNNNNNGTGTAGATCTCGGTGGTCGCCGTATCATT \
	-q 5,5 \
	--trim-n \
	--minimum-length 20 \
	--overlap 1 \
	-o $o1 \
	-p $o2 \
	$r1 $r2 2>&1 \
	| tee $outdir/${sample}_cutadapt.log

# reverse complement of the Illumina 5' universal adapter
# -A AGATCGGAAGAGCGTCGTGTAGGGAAAGAGTGTAGATCTCGGTGGTCGCCGTATCATT \
