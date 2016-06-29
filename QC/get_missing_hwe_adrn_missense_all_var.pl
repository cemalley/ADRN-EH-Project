#!/usr/bin/perl
use strict;
use warnings;

my $pwd1 = "/nexsan2/disk2/ctsa/mathias/Software/plink";

for(my $c=1; $c<=22; $c++){
        my $output = "hwe_plink_all_traits_missense_adrn_chr".$c.".sh";
        open(OUT, ">$output") or die"Can't open output file\n";
        if($c <10) {
		print OUT "cd /amber2/scratch/schavan/ADRN/ADRN_chr0".$c."/SKATO\n";
		print OUT $pwd1." --file ADRN_chr0".$c."_731_filled_filtered_missense_all --hardy --missing --out ADRN_chr0".$c."_731_filled_filtered_missense_all\n";
		print OUT "df -h | sed -n \'1p\; /ALL/p\' ADRN_chr0".$c."_731_filled_filtered_missense_all.hwe | tr -s \' \' \'\\t\' | cut -f2-10 > ADRN_chr0".$c."_731_filled_filtered_missense_all_hwe.txt\n";
		}
	else {
		print OUT "cd /amber2/scratch/schavan/ADRN/ADRN_chr".$c."/SKATO\n";
                print OUT $pwd1." --file ADRN_chr".$c."_731_filled_filtered_missense_all --hardy --missing --out ADRN_chr".$c."_731_filled_filtered_missense_all\n";
                print OUT "df -h | sed -n \'1p\; /ALL/p\' ADRN_chr".$c."_731_filled_filtered_missense_all.hwe | tr -s \' \' \'\\t\' | cut -f2-10 > ADRN_chr".$c."_731_filled_filtered_missense_all_hwe.txt\n";
		}
	}
exit;


