#!/usr/bin/perl
use strict;
use warnings;

for(my $c=1; $c<=22; $c++){
        my $output = "python_scripts_adrn_assc_tests_excl_failed_chr".$c.".py";
        open(OUT, ">$output") or die"Can't open output file\n";
	print OUT "#!/bin/env python\n";
        print OUT "import subprocess\n";
	print OUT "command \= \(\"Rscript\"\, \"\/home\/jhmi\/mboorgu1\/Staph_pos_neg_combine_res\.R\"\, str\(".$c."\)\)";
	print OUT "\n";
        print OUT "process \= subprocess\.Popen\(command, stdout\=subprocess\.PIPE\)\n";
        print OUT "print\(process\.communicate\(\)\[0\]\)\n";
	}

exit;

