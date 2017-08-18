#!/bin/bash
set -euo pipefail
IFS=$'\n\t'

# Create masurca config file and run masurca assembly.


sample=$1
template=masurca_config-template.txt

# get insert size mean and sd
insert_stats=$(sed -n '8p'  picard/insert-size/${sample}_insert-size_metrics.txt | cut -f 5,6 | sed 's/\t/ /g')

# use last tag in sample name as code
sample_code=${sample##*_}

fastq_r1=$(readlink -f fastq/${sample}_R1_001.fastq.gz)
fastq_r2=$(readlink -f fastq/${sample}_R2_001.fastq.gz)

data_line="$sample_code $insert_stats $fastq_r1 $fastq_r2"
echo $data_line

outdir=masurca/${sample}
mkdir -p $outdir

# fill in template
sed -e "s|PE=.*|PE=${data_line}|" $template > $outdir/config.txt

# generate assemble.sh
masurca $outdir/config.txt -o $outdir/assemble.sh

# run script
cd $outdir
./assemble.sh 2>&1 | tee assemble.log
cd -

