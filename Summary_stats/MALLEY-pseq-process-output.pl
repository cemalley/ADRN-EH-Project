#!/usr/bin/perl
use strict;
use warnings;
use Data::Dumper;
## Description: make CSV files using output from PSEQ istats and vstats. This is not parallelized yet.


# Un-comment or comment out whichever line below, and run this program for istats/vstats output separately.

my $istats = "chr22.SNPs.istats";
#my $vstats = "chr22.vstats";

my @bulk;
my $out = "chr22.SNPs.istats.csv";

open (OUT, '>', $out) or die ("$!");
print OUT "ID,NALT,NMIN,NHET,NVAR,RATE,SING,TITV,PASS,PASS_S,QUAL,DP\n"; # Print the header to our output file first.


open (INPUT, '<', $istats) or die ("$!");
while (<INPUT>){
chomp;
my $line = $_ unless ($_ eq "\n");


## NOTE: below I use "LP6" to find lines containing sample IDs. Replace with an appropriate snippet of text that applies to your sample IDs, i.e. the beginning first three characters. This was necessary because of header lines and warning message lines in the output.

if ($line =~ /^LP6/){
  push @bulk, $line;
}
}
close INPUT;

foreach my $i (@bulk){
my @comma_delimited = split('\t', $i);
my $comma_delimited_out = join(',', @comma_delimited);
print OUT $comma_delimited_out . "\n";
}

close OUT;
exit;
