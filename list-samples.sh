#!/bin/bash
set -euo pipefail
IFS=$'\n\t'

# Generate sample list.

indir=$1

rm -f samples.txt
for f in $(ls -1 $indir/*.bam); do
	fname=${f##*/}
	fstem=${fname%%.*}
	echo $fstem >> samples.txt
done

