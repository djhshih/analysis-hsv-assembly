#!/usr/bin/env python3

# Modify reference sequences based on known structural variants

from Bio import SeqIO
from Bio.Seq import Seq
from Bio.SeqRecord import SeqRecord
from Bio.Alphabet import generic_dna

ref_fasta = "../ref/hsv/hsv_lacz-ins_rl1-del.fasta"
out_fasta = "../ref/hsv/hsv_lacz-ins_rl1-del_us12-del.fasta"

contig = "GU734771.1.FA6.G207"
# previous modifications:
# g.576_1527del, insertion of 3089 bp at g.87644C, g.124670_125621del
# current modification:
# g.145164_145521del
# coordinates need to be incremented by previous modifications
offset = 0 - 952 + (3089 - 1) - 952
# 0-based half-open regions
regions = [(145164 - 1 + offset, 145521 + offset)]

# read reference fasta
ref = SeqIO.to_dict(SeqIO.parse(ref_fasta, "fasta"))[contig]

# deletion target regions
out_seq = ref.seq[:regions[0][0]] + ref.seq[regions[0][1]:]

# deleted sequence
print(ref.seq[regions[0][0]:regions[0][1]])

# check that sequence created by deletion breakpoints exist
print(out_seq.find("GGGTTACACGAGGACGTT"))
#                   uuuuuuuddddddddddd

# output modified sequence
out_record = SeqRecord(out_seq,
    id = contig + ".G47A",
    description = "Human herpesvirus 1 strain G47A, derived from strain G207, with {contig}:{s1}_{e1}del".format(
        contig = contig,
        s1 = regions[0][0] + 1,
        e1 = regions[0][1]
    )
)
SeqIO.write(out_record, out_fasta, "fasta")

