#!/bin/bash

i="$1"
PICARD="/users/cmalley/apps/picard-tools-2.4.1/picard.jar"

m="eval java -d64 -XX:MaxHeapSize=512m -Xms5g -Xmx10g -jar $PICARD MarkDuplicates I=/dcl01/mathias/data/ADRN_EH/${i}/Assembly/${i}.bam O=/dcl01/mathias/data/ADRN_EH/${i}/Assembly/${i}.marked_duplicates.bam M=${i}.marked_dup_metrics.txt VALIDATION_STRINGENCY=LENIENT"

eval $m
