source activate viral-ngs-env

sample=$1
bamdir=ubam
indir=ordered/$sample
outdir=gap2seq/$sample

mkdir -p $outdir

assembly.py gapfill_gap2seq \
	$indir/scaffolds-ordered.fa \
	$bamdir/$sample.ubam \
	$outdir/scaffolds-filled.fa \
	--tmp_dir=./tmp
