#!/usr/bin/perl
use strict;
use warnings;

opendir DIR, "./python_scripts_adrn_burden_adna_clean_new_qc";

my @files = readdir(DIR);
#my $que = "mathias.q\@compute-055";
#print $que,"\n";
foreach my $f (@files){ 
	system "qsub  -b y python $f";
	}
exit;
