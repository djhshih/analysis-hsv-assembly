#!/bin/bash -x
set -euo pipefail

# Input fastq reads
IN1=
IN2=

#
# Parameters
#

# Program paths
SGA_BIN=sga
BWA_BIN=bwa
SAMTOOLS_BIN=samtools
BAM2DE_BIN=sga-bam2de.pl
ASTAT_BIN=sga-astat.py

# The number of threads to use
CPU=1

# Critical paramsters are:
# CORRECTION_K (K), MIN_OVERLAP (M), and ASSEMBLE_OVERLAP (A)
# GAGE-B use the settings K=65, M=45, A=45 for assembling
# various genomes using PE HiSeq with 100 bp reads at 100-300x coverage with
# mean insert sizes in {180, 220, 335} bp
# Current libraries specifications:
# 150 bp PE HiSeq, 200x coverage, ~230bp insert size
# Therefore, these settings should be a good starting point
# In fact, most GAGE-B HiSeq 100 bp libraries were assembled with M=45 and A=45,
# only K differed between libraries.
# It would be prudent to try different values of K.
# 65 was too high => [sga correct] Error k-mer threshold learning failed
# 55 was too high => [sga correct] Warning: Proportion of kmers greater than
# the chosen threshold is less than 0.75
# Author jts recommends that TRIM_LENGTH=400 for 150 bp reads.
# Based on testing, the settings jts recommands for 150 bp reads produce
# longer and fewer contigs, with higher N50.

# Correction k-mer 
CORRECTION_K=41

# The minimum overlap to use when computing the graph.
# The final assembly can be performed with this overlap or greater
MIN_OVERLAP=85

# The overlap value to use for the final assembly
ASSEMBLE_OVERLAP=111

# Branch trim length
TRIM_LENGTH=400

# The minimum length of contigs to include in a scaffold
MIN_CONTIG_LENGTH=200

# The minimum number of reads pairs required to link two contigs
MIN_PAIRS=5


#
# Dependency checks
#

# Check the required programs are installed and executable
prog_list="$SGA_BIN $BWA_BIN $SAMTOOLS_BIN $BAM2DE_BIN $ASTAT_BIN"
for prog in $prog_list; do
    hash $prog 2>/dev/null || { echo "Error $prog not found. Please place $prog on your PATH or update the *_BIN variables in this script"; exit 1; }
done 

# Check the files are found
file_list="$IN1 $IN2"
for input in $file_list; do
    if [ ! -f $input ]; then
        echo "Error input file $input not found"; exit 1;
    fi
done

#
# Preprocessing
#

# Preprocess the data to remove ambiguous basecalls
$SGA_BIN preprocess --pe-mode 1 -o reads.pp.fastq $IN1 $IN2

#
# Error Correction
#

# Build the index that will be used for error correction
# As the error corrector does not require the reverse BWT, suppress
# construction of the reversed index
$SGA_BIN index -a ropebwt -t $CPU --no-reverse reads.pp.fastq

# Perform k-mer based error correction.
# The k-mer cutoff parameter is learned automatically.
$SGA_BIN correct -k $CORRECTION_K --learn -t $CPU -o reads.ec.fastq reads.pp.fastq

#
# Primary (contig) assembly
#

# Index the corrected data.
$SGA_BIN index -a ropebwt -t $CPU reads.ec.fastq

# Remove exact-match duplicates and reads with low-frequency k-mers
$SGA_BIN filter  -t $CPU reads.ec.fastq

# Compute the structure of the string graph
$SGA_BIN overlap -m $MIN_OVERLAP -t $CPU reads.ec.filter.pass.fa

# Perform the contig assembly
$SGA_BIN assemble -m $ASSEMBLE_OVERLAP --min-branch-length $TRIM_LENGTH -o primary reads.ec.filter.pass.asqg.gz

#
# Scaffolding
#

PRIMARY_CONTIGS=primary-contigs.fa
PRIMARY_GRAPH=primary-graph.asqg.gz

# Align the reads to the contigs
$BWA_BIN index $PRIMARY_CONTIGS
$BWA_BIN aln -t $CPU $PRIMARY_CONTIGS $IN1 > $IN1.sai
$BWA_BIN aln -t $CPU $PRIMARY_CONTIGS $IN2 > $IN2.sai
$BWA_BIN sampe $PRIMARY_CONTIGS $IN1.sai $IN2.sai $IN1 $IN2 | $SAMTOOLS_BIN view -Sb - > libPE.bam

# Convert the BAM file into a set of contig-contig distance estimates
$BAM2DE_BIN -n $MIN_PAIRS -m $MIN_CONTIG_LENGTH --prefix libPE libPE.bam

# Compute copy number estimates of the contigs
$ASTAT_BIN -m $MIN_CONTIG_LENGTH libPE.bam > libPE.astat

# Build the scaffolds
$SGA_BIN scaffold -m $MIN_CONTIG_LENGTH -a libPE.astat -o scaffolds.scaf --pe libPE.de $PRIMARY_CONTIGS

# Convert the scaffolds to FASTA format
$SGA_BIN scaffold2fasta --use-overlap --write-unplaced -m $MIN_CONTIG_LENGTH -a $PRIMARY_GRAPH -o sga-scaffolds.fa scaffolds.scaf
