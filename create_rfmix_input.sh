#!/bin/bash


# chr22.haps is empty
#####################

#Get list of hapmap SNPs that are in genetic map and also their ref alleles
cut -f2 -d' ' rfmix_input/genetic_map_tgp/chr${chr}.txt | sort -k1 > tmp_chr${chr}_map_sorted.txt
cat rfmix_input/tgp/chr${chr}.impute.legend | grep ^rs | sort -k2 > tmp_chr${chr}_tgp_sorted.txt
cat rfmix_input/tgp/chr${chr}.impute.legend | grep ^rs | sort -k2 | cut -f2 -d' ' | uniq -u > tmp_chr${chr}_tgp_unique.txt
join tmp_chr${chr}_map_sorted.txt tmp_chr${chr}_tgp_unique.txt > tmp_chr${chr}_unique.txt
join -1 1 -2 2 tmp_chr${chr}_unique.txt tmp_chr${chr}_tgp_sorted.txt > tmp_chr${chr}_tgp_mapped.txt

#Get admixed SNPs that are in the tmp_map and
#-is not AT/CG
#-do not have allele mismatches
#-determine if ref SNP has changed
cat chr${chr}.haps | cut -f2-5 -d ' ' > tmp_chr${chr}_admixed.txt
python3 get_admixed_snps.py $chr

#Rewrite the reference population file in the right format and to contain only the SNPs to keep
sed -e '1d'  rfmix_input/tgp/chr${chr}.impute.legend | cut -f2 -d' '  | sed "s/^/${chr}:/" > \
       tmp_chr${chr}_ref_snps.txt
paste tmp_chr${chr}_ref_snps.txt  rfmix_input/tgp/chr${chr}.impute.hap > \
       tmp_chr${chr}_ref_select.txt

# Produces empty file because tmp_chr22_snps_keep.txt is empty
python3 get_ref_haps.py $chr


#Rewrite the admixed file in the right format and to contain only the SNPs to keep, and change 0/1 codings where necessary for different ref/alt alleles
python3 get_admixed_haps.py $chr 

#Create the alleles.txt file
paste -d' ' tmp_chr${chr}_admixed_haps.txt tmp_chr${chr}_ref_haps.txt  > tmp_chr${chr}_alleles.txt

# 
sed 's/ //g' tmp_chr${chr}_alleles.txt > chr${chr}_alleles.txt

#Create the classes.txt file
nr_samples=`wc -l chr${chr}.samples | xargs | cut -f1 -d' '`
let "nr_samples=nr_samples-2"
python3 create_classes.py $chr $nr_samples


cut -f1 -d' ' tmp_chr${chr}_snps_keep.txt > tmp_chr${chr}_final_pos.txt
cut -f2-3 -d' ' rfmix_input/genetic_map_tgp/chr${chr}.txt | uniq > tmp_chr${chr}_pos_cm.txt
join -1 1 -2 1 tmp_chr${chr}_final_pos.txt tmp_chr${chr}_pos_cm.txt | cut -f2 -d' ' > chr${chr}_snp_locations.txt

