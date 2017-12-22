bp_genbank2gff3.pl --GFF_VERSION 3 hsv.gb
sed -i 's/GU734771/GU734771.1/g; /##FASTA/q' hsv.gb.gff
