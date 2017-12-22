source activate viral-ngs-env

sample=$1

#indir=ordered/hsv-ref/$sample
#outdir=imputed/hsv-ref/$sample
#ref=ref/hsv/hsv.fasta

indir=ordered/custom-ref/$sample
outdir=imputed/custom-ref/$sample
ref=custom-ref/$sample/ref.fasta

mkdir -p $outdir

assembly.py impute_from_reference \
	$indir/scaffolds-ordered.fa \
	$ref \
	$outdir/imputed-assembly.fa \
	--aligner mummer \
	--tmp_dir=./tmp
