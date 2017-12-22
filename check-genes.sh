
blastn -query ref/hsv/us12.fasta -db ordered/hsv-lacz-ref/*S1/scaffolds-ordered.fa
blastn -query ref/hsv/us12.fasta -db ordered/hsv-lacz-ref/*S2/scaffolds-ordered.fa
blastn -query ref/hsv/us12.fasta -db ordered/hsv-lacz-ref/*S3/scaffolds-ordered.fa
blastn -query ref/hsv/us12.fasta -db ordered/hsv-lacz-ref/*S4/scaffolds-ordered.fa

blastn -query ref/hsv/rl1.fasta -db ordered/hsv-lacz-ref/*S1/scaffolds-ordered.fa
blastn -query ref/hsv/rl1.fasta -db ordered/hsv-lacz-ref/*S2/scaffolds-ordered.fa
blastn -query ref/hsv/rl1.fasta -db ordered/hsv-lacz-ref/*S3/scaffolds-ordered.fa
blastn -query ref/hsv/rl1.fasta -db ordered/hsv-lacz-ref/*S4/scaffolds-ordered.fa

blastn -query ref/lacz/lacz_ecoli.fasta -db ordered/hsv-lacz-ref/*S1/scaffolds-ordered.fa
blastn -query ref/lacz/lacz_ecoli.fasta -db ordered/hsv-lacz-ref/*S2/scaffolds-ordered.fa
blastn -query ref/lacz/lacz_ecoli.fasta -db ordered/hsv-lacz-ref/*S3/scaffolds-ordered.fa
blastn -query ref/lacz/lacz_ecoli.fasta -db ordered/hsv-lacz-ref/*S4/scaffolds-ordered.fa

