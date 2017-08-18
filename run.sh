#!/bin/bash

for sample in $(cat samples.txt); do
	echo $sample

	bam=input/${sample}.sorted.bam
	unmapped=unmapped/${sample}.unmapped.bam

	#./picard.sh $bam

	#./bam2fastq.sh $bam fastq

	#./extract-unmapped.sh $bam unmapped

	# depends: extract-unmapped
	#./bam2fastq.sh $unmapped unmapped/fastq

	# depends: bam2fastq, picard
	#./masurca.sh $sample

	# depends: bam2fastq
	#./sga.sh $sample
done
