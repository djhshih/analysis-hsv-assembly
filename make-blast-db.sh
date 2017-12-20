
opts="-dbtype nucl -parse_seqids"

makeblastdb -in ref/hsv/hsv.fasta $opts
makeblastdb -in ref/csabaeus/csabaeus_mito.fasta $opts
makeblastdb -in ref/ecoli/ecoli.fasta $opts
makeblastdb -in ref/lacz/lacz_ecoli.fasta $opts

