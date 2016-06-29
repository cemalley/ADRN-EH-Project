#!/usr/bin/perl
use strict;
use warnings;

for(my $c=1; $c<=22; $c++){
        my $output = "python_scripts_adrn_maf_731_1to5_5pct_chr".$c.".py";
        open(OUT, ">$output") or die"Can't open output file\n";
	print OUT "#!/bin/env python\n";
        print OUT "import subprocess\n";
	print OUT "command \= \(\"Rscript\"\, \"\/home\/jhmi\/mboorgu1\/make_maf_R_scripts_adrn_1to5_5_new_731\.R\"\, str\(".$c."\)\)";
	print OUT "\n";
        print OUT "process \= subprocess\.Popen\(command, stdout\=subprocess\.PIPE\)\n";
        print OUT "print\(process\.communicate\(\)\[0\]\)\n";
	}

exit;

