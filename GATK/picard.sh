#!/bin/bash

i="$1"

m="eval java -d64 -Djava.io.tmpdir=`pwd`/tmp -XX:MaxHeapSize=512m -Xms8g -Xmx15g -jar /users/cmalley/apps/picard-tools-2.4.1/picard.jar MarkDuplicates I=/dcl01/mathias/data/ADRN_EH/${i}/Assembly/${i}.bam O=/dcl01/mathias/data/ADRN_EH/${i}/Assembly/${i}.marked_duplicates.bam M=${i}.marked_dup_metrics.txt VALIDATION_STRINGENCY=LENIENT MAX_FILE_HANDLES_FOR_READ_ENDS_MAP=1000 TMP_DIR=`pwd`/tmp"

eval $m
