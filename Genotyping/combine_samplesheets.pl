#!/usr/bin/perl
use strict;
use warnings;

opendir DIR, ".";
system "rm SampleSheet_Combined.csv";

my @files = readdir(DIR);
my $output = "SampleSheet_Combined.csv";
open(OUT, '>>', "./$output") or die"Can't open output file\n";
my $c = 1;
foreach my $f (@files){
	open(INFILE, $f) or die"Can't open input file\n";
	my $l=1;
	while(my $line = <INFILE>){
		if($c eq 1){
			chomp $line;
			if($l <10){
			print OUT $line;
			$l++;
			next;
			}
		   $c++;
		}
	else {
	   chomp $line;
	   if($l eq 10){
		print OUT $line;
		 }
	       $l++;
		}
	}
}
close OUT;
close INFILE;

exit;
