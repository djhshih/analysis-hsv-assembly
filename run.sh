#!/bin/bash

#./list-samples.sh input

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

	# depends: masurca
	#./blast-masurca-scaffolds.sh $sample

	# depends: bam2fastq_unmapped
	#./align-unmapped-to-lacz.sh $sample

	# depends: bam2fastq
	#./align-unmapped-to-lacz.sh $sample
	
	# depends: bam2fastq
	#./filter-reads.sh $sample
	
	# dpends: filter-reads
	./masurca-filtered.sh $sample
done
