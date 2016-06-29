#!/usr/bin/perl
use strict;
use warnings;
my $pwd = "/nexsan2/disk2/ctsa/mathias/Software/plinkseq/pseq";

for(my $c=1; $c<=22; $c++){
        my $output = "tests_for_association_adrn_excl_failed_chr".$c.".sh";
        open(OUT, ">$output") or die"Can't open output file\n";
        if($c <10) {
                print OUT "cd /amber2/scratch/schavan/ADRN/ADRN_chr0".$c."/761MultiVCF";
                print OUT "\n";
                print OUT $pwd." Association_tests_chr0".$c." load-pheno --file /home/jhmi/mboorgu1/ADRN_phenotype_master2_761_IDs_only.txt\n";
                print OUT $pwd." Association_tests_chr0".$c." v-assoc --phenotype AD.AFFSTAT --mask biallelic monomorphic.ex phe.ex=AD.AFFSTAT:0 indiv.ex=@/home/jhmi/mboorgu1/adrn_19samples_to_exclude.txt > ./ADRN_chr0".$c."_761_filled_filtered_AD_NA_vassoc_excl_failed.out\n";
		print OUT $pwd." Association_tests_chr0".$c." glm --phenotype AD.AFFSTAT --covar PC1 PC2 --mask biallelic monomorphic.ex phe.ex=AD.AFFSTAT:0,PC1:NA,PC2:NA indiv.ex=@/home/jhmi/mboorgu1/adrn_19samples_to_exclude.txt > ./ADRN_chr0".$c."_761_filled_filtered_AD_NA_glm_excl_failed.out\n";
		print OUT $pwd." Association_tests_chr0".$c." v-assoc --phenotype Staph.AFFSTAT --mask biallelic monomorphic.ex phe.ex=Staph.AFFSTAT:0 indiv.ex=@/home/jhmi/mboorgu1/adrn_19samples_to_exclude.txt > ./ADRN_chr0".$c."_761_filled_filtered_Staph_Pos_Neg_vassoc_excl_failed.out\n";
		print OUT $pwd." Association_tests_chr0".$c." glm --phenotype Staph.AFFSTAT --covar PC1 PC2 --mask biallelic monomorphic.ex phe.ex=Staph.AFFSTAT:0,PC1:NA,PC2:NA indiv.ex=@/home/jhmi/mboorgu1/adrn_19samples_to_exclude.txt > ./ADRN_chr0".$c."_761_filled_filtered_Staph_Pos_Neg_glm_excl_failed.out\n";
		print OUT $pwd." Association_tests_chr0".$c." glm --phenotype NA.TIGE --covar PC1 PC2 --mask biallelic monomorphic.ex phe.ex=NA.TIGE:NA,PC1:NA,PC2:NA indiv.ex=@/home/jhmi/mboorgu1/adrn_19samples_to_exclude.txt > ./ADRN_chr0".$c."_761_filled_filtered_IgE_NA_glm_excl_failed.out\n";
		print OUT $pwd." Association_tests_chr0".$c." glm --phenotype AD.TIGE --covar PC1 PC2 --mask biallelic monomorphic.ex phe.ex=AD.TIGE:NA,PC1:NA,PC2:NA indiv.ex=@/home/jhmi/mboorgu1/adrn_19samples_to_exclude.txt > ./ADRN_chr0".$c."_761_filled_filtered_IgE_AD_glm_excl_failed.out\n";
		print OUT $pwd." Association_tests_chr0".$c." glm --phenotype NA.EOS --covar PC1 PC2 --mask biallelic monomorphic.ex phe.ex=NA.EOS:NA:0,PC1:NA,PC2:NA indiv.ex=@/home/jhmi/mboorgu1/adrn_19samples_to_exclude.txt > ./ADRN_chr0".$c."_761_filled_filtered_EOS_NA_glm_excl_failed.out\n";
		print OUT $pwd." Association_tests_chr0".$c." glm --phenotype AD.EOS --covar PC1 PC2 --mask biallelic monomorphic.ex phe.ex=AD.EOS:0,PC1:NA,PC2:NA indiv.ex=@/home/jhmi/mboorgu1/adrn_19samples_to_exclude.txt > ./ADRN_chr0".$c."_761_filled_filtered_EOS_AD_glm_excl_failed.out\n";
		print OUT $pwd." Association_tests_chr0".$c." glm --phenotype AD.PHAD --covar PC1 PC2 --mask biallelic monomorphic.ex phe.ex=AD.PHAD:0,PC1:NA,PC2:NA indiv.ex=@/home/jhmi/mboorgu1/adrn_19samples_to_exclude.txt > ./ADRN_chr0".$c."_761_filled_filtered_phad_AD_glm_excl_failed.out\n";
		print OUT $pwd." Association_tests_chr0".$c." glm --phenotype AD.EASI --covar PC1 PC2 --mask biallelic monomorphic.ex phe.ex=AD.EASI:0,PC1:NA,PC2:NA indiv.ex=@/home/jhmi/mboorgu1/adrn_19samples_to_exclude.txt > ./ADRN_chr0".$c."_761_filled_filtered_EASI_AD_glm_excl_failed.out\n";
		print OUT $pwd." Association_tests_chr0".$c." glm --phenotype AD.RL --covar PC1 PC2 --mask biallelic monomorphic.ex phe.ex=AD.RL:0,PC1:NA,PC2:NA indiv.ex=@/home/jhmi/mboorgu1/adrn_19samples_to_exclude.txt > ./ADRN_chr0".$c."_761_filled_filtered_RL_AD_glm_excl_failed.out\n";
		}
	else {
		print OUT "cd /amber2/scratch/schavan/ADRN/ADRN_chr".$c."/761MultiVCF";
                print OUT "\n";
                print OUT $pwd." Association_tests_chr".$c." load-pheno --file /home/jhmi/mboorgu1/ADRN_phenotype_master2_761_IDs_only.txt\n";
                print OUT $pwd." Association_tests_chr".$c." v-assoc --phenotype AD.AFFSTAT --mask biallelic monomorphic.ex phe.ex=AD.AFFSTAT:0 indiv.ex=@/home/jhmi/mboorgu1/adrn_19samples_to_exclude.txt > ./ADRN_chr".$c."_761_filled_filtered_AD_NA_vassoc_excl_failed.out\n";
                print OUT $pwd." Association_tests_chr".$c." glm --phenotype AD.AFFSTAT --covar PC1 PC2 --mask biallelic monomorphic.ex phe.ex=AD.AFFSTAT:0,PC1:NA,PC2:NA indiv.ex=@/home/jhmi/mboorgu1/adrn_19samples_to_exclude.txt > ./ADRN_chr".$c."_761_filled_filtered_AD_NA_glm_excl_failed.out\n";
                print OUT $pwd." Association_tests_chr".$c." v-assoc --phenotype Staph.AFFSTAT --mask biallelic monomorphic.ex phe.ex=Staph.AFFSTAT:0 indiv.ex=@/home/jhmi/mboorgu1/adrn_19samples_to_exclude.txt > ./ADRN_chr".$c."_761_filled_filtered_Staph_Pos_Neg_vassoc_excl_failed.out\n";
                print OUT $pwd." Association_tests_chr".$c." glm --phenotype Staph.AFFSTAT --covar PC1 PC2 --mask biallelic monomorphic.ex phe.ex=Staph.AFFSTAT:0,PC1:NA,PC2:NA indiv.ex=@/home/jhmi/mboorgu1/adrn_19samples_to_exclude.txt > ./ADRN_chr".$c."_761_filled_filtered_Staph_Pos_Neg_glm_excl_failed.out\n";
		print OUT $pwd." Association_tests_chr".$c." glm --phenotype NA.TIGE --covar PC1 PC2 --mask biallelic monomorphic.ex phe.ex=NA.TIGE:NA,PC1:NA,PC2:NA indiv.ex=@/home/jhmi/mboorgu1/adrn_19samples_to_exclude.txt > ./ADRN_chr".$c."_761_filled_filtered_IgE_NA_glm_excl_failed.out\n";
                print OUT $pwd." Association_tests_chr".$c." glm --phenotype AD.TIGE --covar PC1 PC2 --mask biallelic monomorphic.ex phe.ex=AD.TIGE:NA,PC1:NA,PC2:NA indiv.ex=@/home/jhmi/mboorgu1/adrn_19samples_to_exclude.txt > ./ADRN_chr".$c."_761_filled_filtered_IgE_AD_glm_excl_failed.out\n";
                print OUT $pwd." Association_tests_chr".$c." glm --phenotype NA.EOS --covar PC1 PC2 --mask biallelic monomorphic.ex phe.ex=NA.EOS:NA:0,PC1:NA,PC2:NA indiv.ex=@/home/jhmi/mboorgu1/adrn_19samples_to_exclude.txt > ./ADRN_chr".$c."_761_filled_filtered_EOS_NA_glm_excl_failed.out\n";
                print OUT $pwd." Association_tests_chr".$c." glm --phenotype AD.EOS --covar PC1 PC2 --mask biallelic monomorphic.ex phe.ex=AD.EOS:0,PC1:NA,PC2:NA indiv.ex=@/home/jhmi/mboorgu1/adrn_19samples_to_exclude.txt > ./ADRN_chr".$c."_761_filled_filtered_EOS_AD_glm_excl_failed.out\n";
                print OUT $pwd." Association_tests_chr".$c." glm --phenotype AD.PHAD --covar PC1 PC2 --mask biallelic monomorphic.ex phe.ex=AD.PHAD:0,PC1:NA,PC2:NA indiv.ex=@/home/jhmi/mboorgu1/adrn_19samples_to_exclude.txt > ./ADRN_chr".$c."_761_filled_filtered_phad_AD_glm_excl_failed.out\n";
                print OUT $pwd." Association_tests_chr".$c." glm --phenotype AD.EASI --covar PC1 PC2 --mask biallelic monomorphic.ex phe.ex=AD.EASI:0,PC1:NA,PC2:NA indiv.ex=@/home/jhmi/mboorgu1/adrn_19samples_to_exclude.txt > ./ADRN_chr".$c."_761_filled_filtered_EASI_AD_glm_excl_failed.out\n";
                print OUT $pwd." Association_tests_chr".$c." glm --phenotype AD.RL --covar PC1 PC2 --mask biallelic monomorphic.ex phe.ex=AD.RL:0,PC1:NA,PC2:NA indiv.ex=@/home/jhmi/mboorgu1/adrn_19samples_to_exclude.txt > ./ADRN_chr".$c."_761_filled_filtered_RL_AD_glm_excl_failed.out\n";
		}
	}

exit;
