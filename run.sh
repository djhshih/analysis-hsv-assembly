#!/bin/bash

#./list-samples.sh input

for sample in $(cat samples.txt); do
	echo $sample

	bam=input/${sample}.sorted.bam
	unmapped=unmapped/${sample}.unmapped.bam

	./revertbam.sh $bam ubam

	#./fastqc.sh $sample

	#./cutadapt.sh $sample

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

	# depends: sga
	#./blast-sga-scaffolds.sh $sample

	# depends: bam2fastq_unmapped
	#./align-unmapped-to-lacz.sh $sample

	# depends: bam2fastq
	#./align-unmapped-to-lacz.sh $sample
	
	# depends: bam2fastq
	#./filter-reads.sh $sample
	
	# depends: filter-reads
	#./masurca-filtered.sh $sample

	# depends: cutadapt
	#./masurca-trimmed.sh $sample

	# depends: cutadapt
	#./sga-trimmed.sh $sample

	# depends: filter-reads
	#./sga-filtered.sh $sample

	#./masurca-clean.sh $sample
	#./sga-clean.sh $sample

	# depends: sga
	#./quast-sga.sh $sample

done
