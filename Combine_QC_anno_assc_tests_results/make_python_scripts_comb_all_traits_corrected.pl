#!/usr/bin/perl
use strict;
use warnings;

for(my $c=1; $c<=22; $c++){
        my $output = "python_scripts_comb_all_tests_sig_corrected_chr".$c.".py";
        open(OUT, ">$output") or die"Can't open output file\n";
	print OUT "#!/bin/env python\n";
        print OUT "import subprocess\n";
	print OUT "command \= \(\"Rscript\"\, \"\/home\/jhmi\/mboorgu1\/combine_tests_sig_qc_anno_all_traits_corrected\.R\"\, str\(".$c."\)\)";
	print OUT "\n";
        print OUT "process \= subprocess\.Popen\(command, stdout\=subprocess\.PIPE\)\n";
        print OUT "print\(process\.communicate\(\)\[0\]\)\n";
	}

exit;

