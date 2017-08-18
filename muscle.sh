#!/bin/bash
set -euo pipefail
IFS=$'\n\t'

# Perform mutiple sequence alignment using muscle.


# reverse complement the sequence
faRc scaffold-insert1.fa scaffold-insert1-rc.fa

# multiple sequence alignment
cat ../lacz.fasta scaffold-insert1-rc.fa scaffold-insert2.fa > scaffold-inserts_lacz.fa
muscle -in scaffold-inserts_lacz.fa -out scaffold-inserts_lacz.clw -clwstrict
