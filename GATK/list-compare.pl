#!/bin/perl
use strict;
use warnings;
use Data::Dumper;
use List::Compare;

#### Claire Malley July 7 2016
#### This script is for validating which BAM samples have been successfully run through Picard, though it is a general purpose tool for finding elements in one list not found in another. The first array, @Llist, contains the sample IDs of the successful output (captured from ls -lath). The second array, @Rlist, contains the IDs of all samples that need to be processed.
#~#~#

my @Llist;
my @Rlist;

open (IN, '<', "completed-jul6.txt") or die ("$!");
while (<IN>){
    chomp;
    my $line = $_ unless ($_ eq "\n");
    my $match;
    if ($line =~ /(LP.{15})/){
      $match = $1;
    }
    push @Llist, $match;

}
close IN;

open (IN2, '<', "lplist-usable.txt") or die ("$!");
while (<IN2>){
    chomp;
    my $line = $_ unless ($_ eq "\n");
    push @Rlist, $line;
}
close IN2;

my $lc = List::Compare->new(\@Rlist, \@Llist);  ## Order matters. Here, find items in @Rlist that are not found in @Llist.
my @Lonly = $lc->get_unique;

print (join "\n", @Lonly);
print "\n";


exit;
