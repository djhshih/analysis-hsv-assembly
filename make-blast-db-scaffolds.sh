#!/bin/bash

sample=$1
#infile=ordered/hsv-ref/$sample/scaffolds-ordered.fa
#infile=gap2seq/$sample/scaffolds-filled.fa
#infile=sga/trimmed-filtered/$sample/sga-scaffolds.fa
#infile=ordered/hsv-lacz-ref/$sample/scaffolds-ordered.fa
infile=ordered/custom-ref/$sample/scaffolds-ordered.fa

makeblastdb \
	-in $infile \
	-dbtype nucl -parse_seqids

