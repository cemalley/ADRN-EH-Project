#!/usr/bin/perl
use strict;
use warnings;

my $pwd = "/nexsan2/disk2/ctsa/mathias/Software/plinkseq/pseq";

for(my $c=1; $c<=22; $c++){
        my $output = "istats_doub_vstats_vassoc_adrn_chr".$c.".sh";
        open(OUT, ">$output") or die"Can't open output file\n";
        if($c <10) {
                print OUT "cd /amber2/scratch/schavan/ADRN/ADRN_chr0".$c."/761MultiVCF";
                print OUT "\n";
                print OUT $pwd." Analysis_012215_chr0".$c."_stats new-project\n";
                print OUT $pwd." Analysis_012215_chr0".$c."_stats index-vcf --vcf ./ADRN_chr0".$c."_761_SNPs_filled_GQ30_DP7_segdup.recode.vcf.bgzf.gz\n";
		 print OUT $pwd." Analysis_012215_chr0".$c."_stats load-pheno --file /home/jhmi/mboorgu1/ADRN_fake_pheno_761_for_vassoc.txt\n";
		print OUT $pwd." Analysis_012215_chr0".$c."_stats i-stats --mask biallelic indiv.ex=\@/home/jhmi/mboorgu1/adrn_19samples_to_exclude.txt > ./ADRN_chr0".$c."_012215_742_istats.out\n";
                print OUT $pwd." Analysis_012215_chr0".$c."_stats i-stats --mask biallelic mac\=2-2 indiv.ex=\@/home/jhmi/mboorgu1/adrn_19samples_to_exclude.txt > ./ADRN_chr0".$c."_012215_742_istats_doub.out\n";
		print OUT $pwd." Analysis_012215_chr0".$c."_stats v-stats --mask biallelic indiv.ex=\@/home/jhmi/mboorgu1/adrn_19samples_to_exclude.txt > ./ADRN_chr0".$c."_012215_742_vstats.out\n";
		print OUT $pwd." Analysis_012215_chr0".$c."_stats v-assoc --phenotype Group --mask biallelic phe.ex=Index:1 monomorphic.ex > ./ADRN_chr0".$c."_012215_742_vassoc.out\n";
		}
        else {
                print OUT "cd /amber2/scratch/schavan/ADRN/ADRN_chr".$c."/761MultiVCF";
                print OUT "\n";
		print OUT $pwd." Analysis_012215_chr".$c."_stats new-project\n";
                print OUT $pwd." Analysis_012215_chr".$c."_stats index-vcf --vcf ./ADRN_chr".$c."_761_SNPs_filled_GQ30_DP7_segdup.recode.vcf.bgzf.gz\n";
		print OUT $pwd." Analysis_012215_chr".$c."_stats load-pheno --file /home/jhmi/mboorgu1/ADRN_fake_pheno_761_for_vassoc.txt\n";
                print OUT $pwd." Analysis_012215_chr".$c."_stats i-stats --mask biallelic indiv.ex=\@/home/jhmi/mboorgu1/adrn_19samples_to_exclude.txt > ./ADRN_chr".$c."_012215_742_istats.out\n";
		print OUT $pwd." Analysis_012215_chr".$c."_stats i-stats --mask biallelic mac\=2-2 indiv.ex=\@/home/jhmi/mboorgu1/adrn_19samples_to_exclude.txt > ./ADRN_chr".$c."_012215_742_istats_doub.out\n";
                print OUT $pwd." Analysis_012215_chr".$c."_stats v-stats --mask biallelic indiv.ex=\@/home/jhmi/mboorgu1/adrn_19samples_to_exclude.txt > ./ADRN_chr".$c."_012215_742_vstats.out\n";
		print OUT $pwd." Analysis_012215_chr".$c."_stats v-assoc --phenotype Group --mask biallelic phe.ex=Index:1 monomorphic.ex > ./ADRN_chr".$c."_012215_742_vassoc.out\n";
		}
        }
exit;

