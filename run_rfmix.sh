#!/bin/bash


chr=$2

#Create input files
bash create_rfmix_input.sh $chr

# Keep a copy of the file in order to retain the SNPs
cp tmp_chr${chr}_snps_keep.txt rfmix_output/chr${chr}_snps.txt


#Run RFMix
/usr/local/bin/RFMix_v1.5.4/PopPhased/RFMix_PopPhased    -a chr${chr}_alleles.txt \
                  -p chr${chr}_classes.txt \
                  -m chr${chr}_snp_locations.txt \
                  -co 1 -o rfmix_output
