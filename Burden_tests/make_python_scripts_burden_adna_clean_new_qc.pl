#!/usr/bin/perl
use strict;
use warnings;

for(my $c=1; $c<=22; $c++){
        my $output = "python_scripts_adrn_burden_adna_clean_new_qc_chr".$c.".py";
        open(OUT, ">$output") or die"Can't open output file\n";
	print OUT "#!/bin/env python\n";
        print OUT "import subprocess\n";
	print OUT "command \= \(\"Rscript\"\, \"\/users\/mboorgu1\/ADRN_AD_NA_burden_commands_gene_based_clean_varsets_new_qc\.R\"\, str\(".$c."\)\)";
	print OUT "\n";
        print OUT "process \= subprocess\.Popen\(command, stdout\=subprocess\.PIPE\)\n";
        print OUT "print\(process\.communicate\(\)\[0\]\)\n";
	}

exit;

