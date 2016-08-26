#!/bin/perl
use strict;
use warnings;
## C Malley Aug 2016 ##
## Simple program to print direct paths to all samples recalibrated bams. Use for variantdiscovery.sh ##
## Store your list of sample IDs, one per line, in the following array. ##

my @IDs = qw/
LP1
LP2
LP3/;

## Edit the following path to reflect the location of a given bam file. ##

foreach my $id (@IDs){
  print "-I /Illumina_data_folder/$id/Assembly/$id.recalibrated.bam \/\n"
}

exit;
