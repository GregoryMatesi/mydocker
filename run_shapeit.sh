#!/bin/sh

# number of threads as a parameter
nr_threads=$0

#input parameters
bed_file=$1
fam_file=$2
bim_file=$3
shapeit_dir=$4
shapeit_script=$5

plink_file=`sed 's/.bed//' $bed_file`

# get chr from file
chr=`basename $file | cut -f2 -d'_' | sed 's/chr//'`

# I want this: /home/test/BARD_chr22.bim
# Filter for duplicates, non-zero position, and chromosome
#cat /home/test/shapeit_run/get_valid_variants.R | R --vanilla --args ${file}.bim $chr
cat /home/test/shapeit_run/get_valid_variants.R | R --vanilla --args $bim_file $chr

# Create PLINK input files
plink --bfile ${plink_file} \
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

