#!/bin/bash
set -euo pipefail
IFS=$'\n\t'

# Align fastq reads against reference set and filter out unmapped reads

sample=$1

ref=ref/hsv/combined_hsv_lacz.fasta
indir=fastq
fastq1=$indir/${sample}_R1_001.fastq.gz
fastq2=$indir/${sample}_R2_001.fastq.gz

outdir=fastq/filtered
bamstem=$outdir/${sample}
tmpbam=$bamstem.bam
mergedbam=$bamstem.merged.bam
outbam=$bamstem.sorted.bam

[[ ! -d $outdir ]] && mkdir -p $outdir

# align to reference set
if [[ ! -f $tmpbam ]]; then
	bwa mem $ref $fastq1 $fastq2 \
		| samtools view -b - \
		> $tmpbam
fi

# keep only reads from read pairs where either read is mapped
# mapped reads
samtools view -b -F 4 $tmpbam > $bamstem.mapped.bam
# unmapped reads with mapped mate
samtools view -b -f 4 -F 8 $tmpbam > $bamstem.unmapped.matemapped.bam
samtools merge $mergedbam $bamstem.mapped.bam $bamstem.unmapped.matemapped.bam

# extract reads from bam file
./bam2fastq.sh $mergedbam $outdir

# sort and index bam file
#samtools sort $mergedbam > $outbam
#samtools index $outbam

#rm -f $tmpbam
rm -f $mergedbam
rm -f $bamstem.mapped.bam
rm -f $bamstem.unmapped.matemapped.bam

