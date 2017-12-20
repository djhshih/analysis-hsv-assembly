#!/bin/bash
set -euo pipefail
IFS=$'\n\t'

# Create sga script file and run sga assembly.


sample=$1
template=sga_template.sh

# use last tag in sample name as code
sample_code=${sample##*_}

indir=fastq/trimmed-filtered
outdir=sga/trimmed-filtered/${sample}

fastq_r1=$(readlink -f ${indir}/${sample}_R1.fastq.gz)
fastq_r2=$(readlink -f ${indir}/${sample}_R2.fastq.gz)

mkdir -p $outdir

# fill in template script
sed -e "s|IN1=.*|IN1=${fastq_r1}|" $template \
	| sed -e "s|IN2=.*|IN2=${fastq_r2}|" \
	> $outdir/sga.sh
chmod +x $outdir/sga.sh

# run script
cd $outdir
./sga.sh 2>&1 | tee sga.log
cd -

