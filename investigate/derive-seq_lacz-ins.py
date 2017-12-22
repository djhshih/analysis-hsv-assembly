#!/usr/bin/env python3

# Modify reference sequences based on known structural variants

from Bio import SeqIO
from Bio.Seq import Seq
from Bio.SeqRecord import SeqRecord
from Bio.Alphabet import generic_dna

ref_fasta = "../ref/hsv/hsv.fasta"
insert_fasta = "lacz-insertion.fasta"
out_fasta = "../ref/hsv/hsv_lacz-ins.fasta"

#GU734771.1:g.87644C
contig = "GU734771.1"
pos = 87644 - 1
ref_allele = 'C'

insert_seq = Seq("", generic_dna)

# combine insertion sequences together
for record in SeqIO.parse(insert_fasta, "fasta"):
    insert_seq += record.seq

# read reference fasta
ref = SeqIO.to_dict(SeqIO.parse(ref_fasta, "fasta"))[contig]

if ref[pos] != ref_allele:
   raise Exception("Reference allele mismatch") 

# exclude the reference position,
# which is replaced by the insertion sequence
out_seq = ref.seq[:pos] + insert_seq + ref.seq[(pos+1):]

# output modified sequence
out_record = SeqRecord(out_seq,
    id = contig + ".FA6",
    description = "Human herpesvirus 1 strain FA6, derived from strain F, with E. coli LacZ inserted at {}:{}{}".format(contig, pos+1, ref_allele)
)
SeqIO.write(out_record, out_fasta, "fasta")

