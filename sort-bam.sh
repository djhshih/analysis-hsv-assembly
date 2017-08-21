#!/bin/bash
set -euo pipefail
IFS=$'\n\t'

# Sort BAM file.

inbam=$1

samtools sort $inbam -o ${inbam%%.*}.sorted.bam
