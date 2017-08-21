#!/bin/bash
set -euo pipefail
IFS=$'\n\t'

# Index BAM file.

inbam=$1

samtools index $inbam

