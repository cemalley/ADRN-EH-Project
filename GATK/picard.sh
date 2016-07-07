#!/bin/bash

# NOTES: `pwd`/tmp is to aid Picard in storing reads as it processes them. Memory settings may need to be adjusted for the particular machine. I've shown my absolute file locations to demonstrate how the sample variable stored in $1 is handled.

i="$1"

m="eval java -d64 -Djava.io.tmpdir=`pwd`/tmp -XX:MaxHeapSize=512m -Xms12g -Xmx13g -jar /users/cmalley/apps/picard-tools-2.4.1/picard.jar MarkDuplicates I=/dcl01/mathias/data/ADRN_EH/${i}/Assembly/${i}.bam O=/dcl01/mathias/data/ADRN_EH/${i}/Assembly/${i}.marked_duplicates.bam M=${i}.marked_dup_metrics.txt VALIDATION_STRINGENCY=LENIENT MAX_FILE_HANDLES_FOR_READ_ENDS_MAP=1000 TMP_DIR=`pwd`/tmp"

eval $m

wait

exit 0
