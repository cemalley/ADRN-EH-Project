#!/bin/perl
# MALLEY 14 JULY 2016
use strict;
use warnings;
use Data::Dumper;
use List::Compare;
## Description: this program takes output from multiple independent runs of ANNOVAR (independent by chromosomes and by the filter database used). It uses a subroutine to collect rs IDs (dbSNP IDs) and chromosome positions from SNPs that are determined to be "probably damaging" in SIFT and POLYPHEN 2 annotations. Then it takes the output from dbSNP (138) and 1000 Genomes (August 2015) database annotations, and removes all these "common" SNPs. The goal is to find rare SNPs that we are relatively confident in calling damaging, for the group of ADEH+ individuals we are studying.


#my @testfile= 'sift-pphen-sample.csv';
#print sort keys &annotation(@testfile);

## √ TO-DO: possibly I need to run filter with dbsnp and compare three sets of lists, or more, since I can't get the CSV out option to work.
## TO-DO: run filter with 1000g2015aug and also remove SNPs found in that.###


my @sift = glob '*_sift_dropped';
my @pphen= glob '*hdiv_dropped';
my (@dbsnp, @hg19_1000g);

open (DBSNP, '<', "chr22.hg19_snp138_dropped") or die ("$!");
while (<DBSNP>){
  my $line = $_ unless ($_ eq "\n");
  my $rsid = (split '\s+', $line)[1];
  push @dbsnp, $rsid;
}
close DBSNP;

open (HG19_1000G, '<', "chr22.hg19_1000g2015aug_dropped") or die ("$!");
while (<HG19_1000G>){
  my $line = $_ unless ($_ eq "\n");
  my $rsid = (split '\s+', $line)[1];
  push @hg19_1000g, $rsid;
}
close HG19_1000G;


my @Llist = sort keys &annotation(@sift);
my @Rlist = sort keys &annotation(@pphen);

my $lc = List::Compare->new(\@Rlist, \@Llist);
my @intersection = $lc->get_intersection;

print "\nIntersection of SIFT and PolyPhen 2 annotations - only 'probably damaging' in both:";
print scalar @intersection;
print "\n";
print "Minus the SNPs found in DBSNP:";
my $lc2 = List::Compare->new(\@intersection,\@dbsnp);
my @not_found_in_dbsnp = $lc2->get_unique;
print scalar @not_found_in_dbsnp;
print "\n";
my $lc3 = List::Compare->new(\@not_found_in_dbsnp,\@hg19_1000g);
my @not_found_in_dbsnp_nor_1000g = $lc3->get_unique;
print scalar @not_found_in_dbsnp_nor_1000g;
print "\n\n";

##################

sub annotation {
foreach my $file (@_){

my %data;
my %predictions;
open (IN, '<', "$file") or die ("$!");
while (<IN>){
    chomp;
    my $line = $_ unless ($_ eq "\n");
    my $position = (split '\s+', $line)[12];
    $data{$position} = $line;
}
close IN;

foreach my $position (sort keys %data){
  my @fields = split '\s+', $data{$position};
  my $category = $fields[17];
  my @annotations = (split '\|+', $category);
  foreach my $element (@annotations){
    if ($element =~ /probably_damaging/){
      my @snp_info;
      foreach my $index (19..66){
      if ($fields[$index]){
        if (!($fields[$index] =~ /\s+/)){
          push @snp_info, $fields[$index];
        }
        }
      }
      if (!(exists $predictions{$position})){$predictions{$position} = join ',', @snp_info;}
    }
  }


}

return \%predictions;

}

}
exit;
