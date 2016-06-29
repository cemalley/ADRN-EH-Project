#!/usr/bin/perl
use strict;
use warnings;

my $pwd = "/nexsan2/disk2/ctsa/mathias/Software/vcftools/vcftools";
my $pwd1 = "/nexsan2/disk2/ctsa/mathias/Software/plink";

for(my $c=1; $c<=22; $c++){
        my $output = "hwe_plink_all_chr".$c.".sh";
        open(OUT, ">$output") or die"Can't open output file\n";
        if($c <10) {
		print OUT "cd /amber2/scratch/schavan/ADRN/ADRN_chr0".$c."/761MultiVCF\n";
		print OUT "cut -f1,2 ADRN_chr0".$c."_761_assc_tests_results_excl_failed_Staph_pos_neg_SIG_anno.out | awk -F, \'\{OFS=\"\\t\"\; \{print \$1\=\"chr\"\$1, \$2\}\}\' > ADRN_chr0".$c."_spn_SIG_pos_excl_failed.txt\n";
		print OUT $pwd." --gzvcf ADRN_chr0".$c."_761_SNPs_filled_GQ30_DP7_segdup.recode.vcf.bgzf.gz --keep /home/jhmi/mboorgu1/Staph_Pos_Neg_excl_failed.txt --positions ./ADRN_chr0".$c."_spn_SIG_pos_excl_failed.txt --plink --out ADRN_chr0".$c."_Staph_Pos_Neg_SIG_excl_failed\n";
		print OUT $pwd1." --file ADRN_chr0".$c."_Staph_Pos_Neg_SIG_excl_failed --pheno /home/jhmi/mboorgu1/Staph_Pos_Neg_excl_failed_pheno.txt --hardy --out ADRN_chr0".$c."_Staph_Pos_Neg_SIG_excl_failed\n";
		print OUT "df -h | sed -n \'1p\; /UNAFF/p\' ADRN_chr0".$c."_Staph_Pos_Neg_SIG_excl_failed.hwe | tr -s \' \' \'\\t\' | cut -f2-10 > ADRN_chr0".$c."_Staph_Neg_excl_failed_SIG_hwe2.txt\n";
		print OUT "df -h | sed -n \'1p\; / AFF/p\' ADRN_chr0".$c."_Staph_Pos_Neg_SIG_excl_failed.hwe | tr -s \' \' \'\\t\' | cut -f2-10 > ADRN_chr0".$c."_Staph_Pos_excl_failed_SIG_hwe2.txt\n";
		print OUT $pwd." --gzvcf ADRN_chr0".$c."_761_SNPs_filled_GQ30_DP7_segdup.recode.vcf.bgzf.gz --keep /home/jhmi/mboorgu1/ADRN_all_excl_failed.txt --positions ./ADRN_chr0".$c."_spn_SIG_pos_excl_failed.txt --plink --out ADRN_chr0".$c."_All_spn_SIG_excl_failed\n";
                print OUT $pwd1." --file ADRN_chr0".$c."_All_spn_SIG_excl_failed --pheno /home/jhmi/mboorgu1/NA_all_others_excl_failed_pheno.txt --hardy --out ADRN_chr0".$c."_All_spn_SIG_excl_failed\n";
                print OUT "df -h | sed -n \'1p\; /UNAFF/p\' ADRN_chr0".$c."_All_spn_SIG_excl_failed.hwe | tr -s \' \' \'\\t\' | cut -f2-10 > ADRN_chr0".$c."_NA_excl_failed_SIG_hwe.txt\n";
                print OUT "df -h | sed -n \'1p\; /ALL/p\' ADRN_chr0".$c."_All_spn_SIG_excl_failed.hwe | tr -s \' \' \'\\t\' | cut -f2-10 > ADRN_chr0".$c."_ADRN_all_excl_failed_SIG_hwe.txt\n";
		}
	else {
		 print OUT "cd /amber2/scratch/schavan/ADRN/ADRN_chr".$c."/761MultiVCF\n";
                print OUT "cut -f1,2 ADRN_chr".$c."_761_assc_tests_results_excl_failed_Staph_pos_neg_SIG_anno.out | awk -F, \'\{OFS=\"\\t\"\; \{print \$1\=\"chr\"\$1, \$2\}\}\' > ADRN_chr".$c."_spn_SIG_pos_excl_failed.txt\n";
                print OUT $pwd." --gzvcf ADRN_chr".$c."_761_SNPs_filled_GQ30_DP7_segdup.recode.vcf.bgzf.gz --keep /home/jhmi/mboorgu1/Staph_Pos_Neg_excl_failed.txt --positions ./ADRN_chr".$c."_spn_SIG_pos_excl_failed.txt --plink --out ADRN_chr".$c."_Staph_Pos_Neg_SIG_excl_failed\n";
                print OUT $pwd1." --file ADRN_chr".$c."_Staph_Pos_Neg_SIG_excl_failed --pheno /home/jhmi/mboorgu1/Staph_Pos_Neg_excl_failed_pheno.txt --hardy --out ADRN_chr".$c."_Staph_Pos_Neg_SIG_excl_failed\n";
                print OUT "df -h | sed -n \'1p\; /UNAFF/p\' ADRN_chr".$c."_Staph_Pos_Neg_SIG_excl_failed.hwe | tr -s \' \' \'\\t\' | cut -f2-10 > ADRN_chr".$c."_Staph_Neg_excl_failed_SIG_hwe2.txt\n";
                print OUT "df -h | sed -n \'1p\; / AFF/p\' ADRN_chr".$c."_Staph_Pos_Neg_SIG_excl_failed.hwe | tr -s \' \' \'\\t\' | cut -f2-10 > ADRN_chr".$c."_Staph_Pos_excl_failed_SIG_hwe2.txt\n";

		print OUT $pwd." --gzvcf ADRN_chr".$c."_761_SNPs_filled_GQ30_DP7_segdup.recode.vcf.bgzf.gz --keep /home/jhmi/mboorgu1/ADRN_all_excl_failed.txt --positions ./ADRN_chr".$c."_spn_SIG_pos_excl_failed.txt --plink --out ADRN_chr".$c."_All_spn_SIG_excl_failed\n";
                print OUT $pwd1." --file ADRN_chr".$c."_All_spn_SIG_excl_failed --pheno /home/jhmi/mboorgu1/NA_all_others_excl_failed_pheno.txt --hardy --out ADRN_chr".$c."_All_spn_SIG_excl_failed\n";
                print OUT "df -h | sed -n \'1p\; /UNAFF/p\' ADRN_chr".$c."_All_spn_SIG_excl_failed.hwe | tr -s \' \' \'\\t\' | cut -f2-10 > ADRN_chr".$c."_NA_excl_failed_SIG_hwe.txt\n";
                print OUT "df -h | sed -n \'1p\; /ALL/p\' ADRN_chr".$c."_All_spn_SIG_excl_failed.hwe | tr -s \' \' \'\\t\' | cut -f2-10 > ADRN_chr".$c."_ADRN_all_excl_failed_SIG_hwe.txt\n";
		}
	}
exit;


