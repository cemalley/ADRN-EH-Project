#!/usr/bin/perl
use strict;
use warnings;
#use Data::Dumper;
#$Data::Dumper::Sortkeys  = 1;
#$Data::Dumper::Indent = 3;
#use Data::Printer;
use List::Util qw(sum);
use List::Util qw/ min max sum /;
use Sort::Versions;

## Description: summarise output from PSEQ istats. Input is 24 chromosome ".istats" named files. Sums over all individuals for all variables except Ti/Tv ratio, which is an average.

my @istats = sort { versioncmp($a,$b) }  (glob "*.istats");
my $header = "ID,NALT,NMIN,NHET,NVAR,RATE,SING,TITV,PASS,PASS_S,QUAL";
print $header . "\n";
my $data;
my @chr;
foreach my $istats (@istats){

open (INPUT, '<', $istats) or die ("$!");

while (<INPUT>){
  chomp;
  my $line = $_ unless ($_ eq "\n");

## NOTE: below I use "LP6" to find lines containing sample IDs. Replace with an appropriate snippet of text that applies to your sample IDs, i.e. the beginning first three characters. This was necessary because of header lines and warning message lines in the output.

  if ($line =~ /^LP6/){
    my @comma_delimited = split('\t', $line);
    push @{$data->{$comma_delimited[0]}[0]}, $comma_delimited[1]; #NALT
    push @{$data->{$comma_delimited[0]}[1]}, $comma_delimited[2]; #NMIN
    push @{$data->{$comma_delimited[0]}[2]}, $comma_delimited[3]; #NHET
    push @{$data->{$comma_delimited[0]}[3]}, $comma_delimited[4]; #NVAR
    push @{$data->{$comma_delimited[0]}[4]}, $comma_delimited[5]; #RATE

    if ($comma_delimited[6] =~ /e+/){
      $comma_delimited[6] = sprintf("%.10g", $comma_delimited[6]);
    }
    push @{$data->{$comma_delimited[0]}[5]}, $comma_delimited[6]; #SING

    push @{$data->{$comma_delimited[0]}[6]}, $comma_delimited[7]; #TITV

    if ($comma_delimited[8] =~ /e+/){
      $comma_delimited[8] = sprintf("%.10g", $comma_delimited[8]);
    }
    push @{$data->{$comma_delimited[0]}[7]}, $comma_delimited[8]; #PASS

    push @{$data->{$comma_delimited[0]}[8]}, $comma_delimited[9]; #PASS_S
    push @{$data->{$comma_delimited[0]}[9]}, $comma_delimited[10]; #QUAL
  }
}
  close INPUT;

}

foreach my $key (sort keys %$data){
  print $key . ",";
  my $variablesRef = \@{$data->{$key}};
  my @data_columns = qw(0 1 2 3 4 5);

  foreach my $column (@data_columns){
    my @column;
    push @column, $_ foreach (@{$data->{$key}[$column]});
    print sum(@column);
    print ",";
  }

  my @TITV = qw(6);

  foreach my $titvcol (@TITV){
    my @column;
    push @column, $_ foreach (@{$data->{$key}[$titvcol]});
    print mean(@column);
    print ",";
  }

  my @remnant_columns = qw(7 8 9);

  foreach my $remncol (@remnant_columns){
    my @column;
    push @column, $_ foreach (@{$data->{$key}[$remncol]});
    print sum(@column);
    print ",";
  }
  print "\n";
}

sub mean {
    return sum(@_)/@_;
}

exit;
