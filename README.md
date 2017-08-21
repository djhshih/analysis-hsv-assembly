## Sequence assembly of human simplex virus

Perform sequence assembly on Illumina HiSeq data for human simplex virus.

## Setup
1. Install all dependencies as specified in `dependencies.txt`.
2. Place .bam files in `input/` directory. Sort .bam files and name as .sorted.bam files. Index .sorted.bam files.
3. Place .fastq files in `fastq/` directory, if available.

## Usage

```{bash}
./run.sh
```

## Warning
The assembly algorithms can create huge intermediate files totalling >100 GB.

