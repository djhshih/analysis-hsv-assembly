source activate viral-ngs-env

sample=$1
indir=sga/trimmed-filtered/$sample
ref=custom-ref/$sample/ref.fasta
outdir=ordered/custom-ref/$sample

mkdir -p $outdir

assembly.py order_and_orient \
	$indir/sga-scaffolds.fa \
	$ref \
	$outdir/scaffolds-ordered.fa \
	--tmp_dir=./tmp
