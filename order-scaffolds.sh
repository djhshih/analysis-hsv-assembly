source activate viral-ngs-env

sample=$1
indir=sga/trimmed-filtered/$sample
outdir=ordered/hsv-lacz-ref/$sample

mkdir -p $outdir

assembly.py order_and_orient \
	$indir/sga-scaffolds.fa \
	ref/hsv/hsv_lacz-inserted.fasta \
	$outdir/scaffolds-ordered.fa \
	--tmp_dir=./tmp
