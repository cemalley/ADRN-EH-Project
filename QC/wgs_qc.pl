#!/usr/bin/perl
use strict;
use warnings;

my $pwd = "/nexsan2/disk2/ctsa/mathias/Software/vcftools/vcftools";
my $pwd1 = "/nexsan2/disk2/ctsa/mathias/Software/plinkseq/pseq";

for(my $c=1; $c<=22; $c++){
        my $output = "wgs_qc_chr".$c.".sh";
        open(OUT, ">$output") or die"Can't open output file\n";
        if($c <10) {	
		print OUT $pwd." --gzvcf /amber2/scratch/schavan/ADRN/ADRN_chr0".$c."/761MultiVCF/ADRN_chr0".$c."_761_SNPs_filled_GQ30_DP7_segdup.recode.vcf.bgzf.gz --hardy --missing --keep /home/jhmi/mboorgu1/AD_all_excl_failed.txt --out /amber2/scratch/schavan/ADRN/ADRN_chr0".$c."/761MultiVCF/ADRN_chr0".$c."_761_SNPs_filled_GQ30_DP7_segdup_AD_all_excl_failed\n";
		print OUT $pwd." --gzvcf /amber2/scratch/schavan/ADRN/ADRN_chr0".$c."/761MultiVCF/ADRN_chr0".$c."_761_SNPs_filled_GQ30_DP7_segdup.recode.vcf.bgzf.gz --hardy --missing --keep /home/jhmi/mboorgu1/NA_excl_failed.txt --out /amber2/scratch/schavan/ADRN/ADRN_chr0".$c."/761MultiVCF/ADRN_chr0".$c."_761_SNPs_filled_GQ30_DP7_segdup_NA_excl_failed\n";
		print OUT $pwd." --gzvcf /amber2/scratch/schavan/ADRN/ADRN_chr0".$c."/761MultiVCF/ADRN_chr0".$c."_761_SNPs_filled_GQ30_DP7_segdup.recode.vcf.bgzf.gz --hardy --missing --keep /home/jhmi/mboorgu1/Staph_Neg_excl_failed.txt --out /amber2/scratch/schavan/ADRN/ADRN_chr0".$c."/761MultiVCF/ADRN_chr0".$c."_761_SNPs_filled_GQ30_DP7_segdup_Staph_Neg_excl_failed\n";
		print OUT $pwd." --gzvcf /amber2/scratch/schavan/ADRN/ADRN_chr0".$c."/761MultiVCF/ADRN_chr0".$c."_761_SNPs_filled_GQ30_DP7_segdup.recode.vcf.bgzf.gz --hardy --missing --keep /home/jhmi/mboorgu1/Staph_Pos_excl_failed.txt --out /amber2/scratch/schavan/ADRN/ADRN_chr0".$c."/761MultiVCF/ADRN_chr0".$c."_761_SNPs_filled_GQ30_DP7_segdup_Staph_Pos_excl_failed\n";
		print OUT $pwd." --gzvcf /amber2/scratch/schavan/ADRN/ADRN_chr0".$c."/761MultiVCF/ADRN_chr0".$c."_761_SNPs_filled_GQ30_DP7_segdup.recode.vcf.bgzf.gz --hardy --missing --keep /home/jhmi/mboorgu1/ADRN_all_excl_failed.txt --out /amber2/scratch/schavan/ADRN/ADRN_chr0".$c."/761MultiVCF/ADRN_chr0".$c."_761_SNPs_filled_GQ30_DP7_segdup_All_excl_failed\n";
		}
	else {
		 print OUT $pwd." --gzvcf /amber2/scratch/schavan/ADRN/ADRN_chr".$c."/761MultiVCF/ADRN_chr".$c."_761_SNPs_filled_GQ30_DP7_segdup.recode.vcf.bgzf.gz --hardy --missing --keep /home/jhmi/mboorgu1/AD_all_excl_failed.txt --out /amber2/scratch/schavan/ADRN/ADRN_chr".$c."/761MultiVCF/ADRN_chr".$c."_761_SNPs_filled_GQ30_DP7_segdup_AD_all_excl_failed\n";
                print OUT $pwd." --gzvcf /amber2/scratch/schavan/ADRN/ADRN_chr".$c."/761MultiVCF/ADRN_chr".$c."_761_SNPs_filled_GQ30_DP7_segdup.recode.vcf.bgzf.gz --hardy --missing --keep /home/jhmi/mboorgu1/NA_excl_failed.txt --out /amber2/scratch/schavan/ADRN/ADRN_chr".$c."/761MultiVCF/ADRN_chr".$c."_761_SNPs_filled_GQ30_DP7_segdup_NA_excl_failed\n";
                print OUT $pwd." --gzvcf /amber2/scratch/schavan/ADRN/ADRN_chr".$c."/761MultiVCF/ADRN_chr".$c."_761_SNPs_filled_GQ30_DP7_segdup.recode.vcf.bgzf.gz --hardy --missing --keep /home/jhmi/mboorgu1/Staph_Neg_excl_failed.txt --out /amber2/scratch/schavan/ADRN/ADRN_chr".$c."/761MultiVCF/ADRN_chr".$c."_761_SNPs_filled_GQ30_DP7_segdup_Staph_Neg_excl_failed\n";
                print OUT $pwd." --gzvcf /amber2/scratch/schavan/ADRN/ADRN_chr".$c."/761MultiVCF/ADRN_chr".$c."_761_SNPs_filled_GQ30_DP7_segdup.recode.vcf.bgzf.gz --hardy --missing --keep /home/jhmi/mboorgu1/Staph_Pos_excl_failed.txt --out /amber2/scratch/schavan/ADRN/ADRN_chr".$c."/761MultiVCF/ADRN_chr".$c."_761_SNPs_filled_GQ30_DP7_segdup_Staph_Pos_excl_failed\n";
                print OUT $pwd." --gzvcf /amber2/scratch/schavan/ADRN/ADRN_chr".$c."/761MultiVCF/ADRN_chr".$c."_761_SNPs_filled_GQ30_DP7_segdup.recode.vcf.bgzf.gz --hardy --missing --keep /home/jhmi/mboorgu1/ADRN_all_excl_failed.txt --out /amber2/scratch/schavan/ADRN/ADRN_chr".$c."/761MultiVCF/ADRN_chr".$c."_761_SNPs_filled_GQ30_DP7_segdup_All_excl_failed\n";
		}

	}
exit;
