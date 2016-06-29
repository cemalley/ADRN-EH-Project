#!/usr/bin/perl
use strict;
use warnings;

my $pwd = "/nexsan2/disk2/ctsa/mathias/Software/vcftools/vcftools";
my $pwd1 = "/nexsan2/disk2/ctsa/mathias/Software/plinkseq/pseq";

for(my $c=1; $c<=22; $c++){
        my $output = "split_vcf_by_maf_adrn_chr".$c.".sh";
        open(OUT, ">$output") or die"Can't open output file\n";
        if($c <10) {
		print OUT "cd /amber2/scratch/schavan/ADRN/ADRN_data_split_by_maf\n";
		print OUT $pwd." --gzvcf /amber2/scratch/schavan/ADRN/ADRN_chr0".$c."/761MultiVCF/ADRN_chr0".$c."_761_SNPs_filled_GQ30_DP7_segdup.recode.vcf.bgzf.gz --positions \./ADRN_chr0".$c."_742_001_list.out"." --remove /home/jhmi/mboorgu1/adrn_19samples_to_exclude.txt --recode --out /scratch/mboorgu1/ADRN_chr0".$c."_742_GQ30_DP7_segdup_001\n";
		print OUT $pwd1." /scratch/mboorgu1/ADRN_chr0".$c."_742_GQ30_DP7_segdup_001.recode.vcf write-vcf --format BGZF --file \./ADRN_chr0".$c."_742_GQ30_DP7_segdup_001.recode.vcf.bgzf.gz\n";
		print OUT "rm /scratch/mboorgu1/ADRN_chr0".$c."_742_GQ30_DP7_segdup_001.recode.vcf\n";
		print OUT "cp /scratch/mboorgu1/ADRN_chr0".$c."_742_GQ30_DP7_segdup_001.log \./\n";	

		print OUT $pwd." --gzvcf /amber2/scratch/schavan/ADRN/ADRN_chr0".$c."/761MultiVCF/ADRN_chr0".$c."_761_SNPs_filled_GQ30_DP7_segdup.recode.vcf.bgzf.gz --positions ./ADRN_chr0".$c."_742_singleton_list.out"." --remove /home/jhmi/mboorgu1/adrn_19samples_to_exclude.txt --recode --out /scratch/mboorgu1/ADRN_chr0".$c."_742_GQ30_DP7_segdup_singleton\n";
		print OUT $pwd1." /scratch/mboorgu1/ADRN_chr0".$c."_742_GQ30_DP7_segdup_singleton.recode.vcf write-vcf --format BGZF --file \./ADRN_chr0".$c."_742_GQ30_DP7_segdup_singleton.recode.vcf.bgzf.gz\n";
        print OUT "rm /scratch/mboorgu1/ADRN_chr0".$c."_742_GQ30_DP7_segdup_singleton.recode.vcf\n";
		print OUT "cp /scratch/mboorgu1/ADRN_chr0".$c."_742_GQ30_DP7_segdup_singleton.log \./\n"; 
		
		print OUT $pwd." --gzvcf /amber2/scratch/schavan/ADRN/ADRN_chr0".$c."/761MultiVCF/ADRN_chr0".$c."_761_SNPs_filled_GQ30_DP7_segdup.recode.vcf.bgzf.gz --positions ./ADRN_chr0".$c."_742_001-005_list.out"." --remove /home/jhmi/mboorgu1/adrn_19samples_to_exclude.txt --recode --out /scratch/mboorgu1/ADRN_chr0".$c."_742_GQ30_DP7_segdup_001-005\n";
		print OUT $pwd1." /scratch/mboorgu1/ADRN_chr0".$c."_742_GQ30_DP7_segdup_001-005.recode.vcf write-vcf --format BGZF --file \./ADRN_chr0".$c."_742_GQ30_DP7_segdup_001-005.recode.vcf.bgzf.gz\n";
        print OUT "rm /scratch/mboorgu1/ADRN_chr0".$c."_742_GQ30_DP7_segdup_001-005.recode.vcf\n";
		print OUT "cp /scratch/mboorgu1/ADRN_chr0".$c."_742_GQ30_DP7_segdup_001-005.log \./\n"; 	
		
		print OUT $pwd." --gzvcf /amber2/scratch/schavan/ADRN/ADRN_chr0".$c."/761MultiVCF/ADRN_chr0".$c."_761_SNPs_filled_GQ30_DP7_segdup.recode.vcf.bgzf.gz --positions ./ADRN_chr0".$c."_742_005_list.out"." --remove /home/jhmi/mboorgu1/adrn_19samples_to_exclude.txt --recode --out /scratch/mboorgu1/ADRN_chr0".$c."_742_GQ30_DP7_segdup_005\n";
		print OUT $pwd1." /scratch/mboorgu1/ADRN_chr0".$c."_742_GQ30_DP7_segdup_005.recode.vcf write-vcf --format BGZF --file \./ADRN_chr0".$c."_742_GQ30_DP7_segdup_005.recode.vcf.bgzf.gz\n";
        print OUT "rm /scratch/mboorgu1/ADRN_chr0".$c."_742_GQ30_DP7_segdup_005.recode.vcf\n";
		print OUT "cp /scratch/mboorgu1/ADRN_chr0".$c."_742_GQ30_DP7_segdup_005.log \./\n"; 
		}
	else {
		print OUT "cd /amber2/scratch/schavan/ADRN/ADRN_data_split_by_maf\n";
		print OUT $pwd." --gzvcf /amber2/scratch/schavan/ADRN/ADRN_chr".$c."/761MultiVCF/ADRN_chr".$c."_761_SNPs_filled_GQ30_DP7_segdup.recode.vcf.bgzf.gz --positions ./ADRN_chr".$c."_742_001_list.out"." --remove /home/jhmi/mboorgu1/adrn_19samples_to_exclude.txt --recode --out /scratch/mboorgu1/ADRN_chr".$c."_742_GQ30_DP7_segdup_001\n";
        print OUT $pwd1." /scratch/mboorgu1/ADRN_chr".$c."_742_GQ30_DP7_segdup_001.recode.vcf write-vcf --format BGZF --file \./ADRN_chr".$c."_742_GQ30_DP7_segdup_001.recode.vcf.bgzf.gz\n";
        print OUT "rm /scratch/mboorgu1/ADRN_chr".$c."_742_GQ30_DP7_segdup_001.recode.vcf\n";
		print OUT "cp /scratch/mboorgu1/ADRN_chr".$c."_742_GQ30_DP7_segdup_001.log \./\n";

        print OUT $pwd." --gzvcf /amber2/scratch/schavan/ADRN/ADRN_chr".$c."/761MultiVCF/ADRN_chr".$c."_761_SNPs_filled_GQ30_DP7_segdup.recode.vcf.bgzf.gz --positions ./ADRN_chr".$c."_742_singleton_list.out"." --remove /home/jhmi/mboorgu1/adrn_19samples_to_exclude.txt --recode --out /scratch/mboorgu1/ADRN_chr".$c."_742_GQ30_DP7_segdup_singleton\n";
        print OUT $pwd1." /scratch/mboorgu1/ADRN_chr".$c."_742_GQ30_DP7_segdup_singleton.recode.vcf write-vcf --format BGZF --file \./ADRN_chr".$c."_742_GQ30_DP7_segdup_singleton.recode.vcf.bgzf.gz\n";
        print OUT "rm /scratch/mboorgu1/ADRN_chr".$c."_742_GQ30_DP7_segdup_singleton.recode.vcf\n";
		print OUT "cp /scratch/mboorgu1/ADRN_chr".$c."_742_GQ30_DP7_segdup_singleton.log \./\n";

        print OUT $pwd." --gzvcf /amber2/scratch/schavan/ADRN/ADRN_chr".$c."/761MultiVCF/ADRN_chr".$c."_761_SNPs_filled_GQ30_DP7_segdup.recode.vcf.bgzf.gz --positions ./ADRN_chr".$c."_742_001-005_list.out"." --remove /home/jhmi/mboorgu1/adrn_19samples_to_exclude.txt --recode --out /scratch/mboorgu1/ADRN_chr".$c."_742_GQ30_DP7_segdup_001-005\n";
        print OUT $pwd1." /scratch/mboorgu1/ADRN_chr".$c."_742_GQ30_DP7_segdup_001-005.recode.vcf write-vcf --format BGZF --file \./ADRN_chr".$c."_742_GQ30_DP7_segdup_001-005.recode.vcf.bgzf.gz\n";
        print OUT "rm /scratch/mboorgu1/ADRN_chr".$c."_742_GQ30_DP7_segdup_001-005.recode.vcf\n";
		print OUT "cp /scratch/mboorgu1/ADRN_chr".$c."_742_GQ30_DP7_segdup_001-005.log \./\n";

        print OUT $pwd." --gzvcf /amber2/scratch/schavan/ADRN/ADRN_chr".$c."/761MultiVCF/ADRN_chr".$c."_761_SNPs_filled_GQ30_DP7_segdup.recode.vcf.bgzf.gz --positions ./ADRN_chr".$c."_742_005_list.out"." --remove /home/jhmi/mboorgu1/adrn_19samples_to_exclude.txt --recode --out /scratch/mboorgu1/ADRN_chr".$c."_742_GQ30_DP7_segdup_005\n";
        print OUT $pwd1." /scratch/mboorgu1/ADRN_chr".$c."_742_GQ30_DP7_segdup_005.recode.vcf write-vcf --format BGZF --file \./ADRN_chr".$c."_742_GQ30_DP7_segdup_005.recode.vcf.bgzf.gz\n";
        print OUT "rm /scratch/mboorgu1/ADRN_chr".$c."_742_GQ30_DP7_segdup_005.recode.vcf\n";
		print OUT "cp /scratch/mboorgu1/ADRN_chr".$c."_742_GQ30_DP7_segdup_005.log \./\n";
		}

	}
exit;
