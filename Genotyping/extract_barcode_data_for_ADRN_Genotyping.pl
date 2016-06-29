#!/usr/bin/perl
use strict;
use warnings;
use File::Copy 'move';
my $dir = ".";
opendir DIR, $dir;
my @barcodes = ();
my @files = readdir(DIR);

foreach my $f(@files) {
	if($f =~ /(\d{10})(.*)idat/){
		push(@barcodes, $1);
		}
	for my $b (@barcodes){
		next if -d "$dir/$b";
		mkdir "$dir/$b";
	}
	for my $b(@barcodes) {
		if($f =~ /$b(.*)idat/){ 
			move $f, "$dir/$b/$f";
			}
	}
}

exit;



