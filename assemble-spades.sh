source activate viral-ngs-env

sample=$1
indir=ubam
outdir=spades/$sample

mkdir -p $outdir

assembly.py assemble_spades \
	$indir/$sample.ubam \
	ref/adapter/thruplex.fa \
	$outdir \
	--tmp_dir=./tmp
