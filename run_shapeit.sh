#!/bin/sh

nr_threads=8

#shapeit_dir=/home/test/shapeit_input/genetic_map_hapmap/chr22.txt
#file=/home/test/bard/BARD_chr22

#/sbgenomics/Projects/d7973597-4d40-4cd3-85d3-017daccc01a9/BARD_chr22.bed=$1
#/sbgenomics/workspaces/d7973597-4d40-4cd3-85d3-017daccc01a9/tasks/38bc33a0-1521-453b-99a2-6c7e2e060fa3/sbg_decompressor_cwl1_0/decompressed_files/chr22.txt=$2



file = $1
shapeit_dir = $2

#shapeit_dir = /sbgenomics/workspaces/d7973597-4d40-4cd3-85d3-017daccc01a9/tasks/38bc33a0-1521-453b-99a2-6c7e2e060fa3/sbg_decompressor_cwl1_0/decompressed_files/chr22.txt

# I think 'file' is OK. But 'shapeit_dir' is currently every chromosome's txt file in the tar ball. 


# get chr from file
chr=`basename $file | cut -f2 -d'_' | sed 's/chr//'`

# I want this: /home/test/BARD_chr22.bim
# Filter for duplicates, non-zero position, and chromosome
cat get_valid_variants.R | R --vanilla --args ${file}.bim $chr


# Create PLINK input files
plink --bfile ${file} \
      --extract ../test/chr${chr}_snps.txt \
      --make-bed --out ../test/chr${chr}

# Run shapeit.
shapeit --input-bed  /home/test/chr${chr}.bed \
        /home/test/chr${chr}.bim \
        /home/test/chr${chr}.fam \
        --input-map ${shapeit_dir} \
        --thread ${nr_threads} \
        --output-max  chr${chr}.haps \
        /home/test/chr${chr}.samples

