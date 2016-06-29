library(data.table)
nRow <- as.numeric(system("cat ~/Downloads/SeattleSeqAnnotation138.seatseqinput_chr01_EDC_full_new.315724511246.txt | wc -l", intern=TRUE)) - as.numeric(system("grep '^#' ~/Downloads/SeattleSeqAnnotation138.seatseqinput_chr01_EDC_full_new.315724511246.txt | wc -l", intern=TRUE))

myWhat<-rep(list(NULL), 38)
myWhat[[3]]<-numeric(0)
myWhat[[9]]<-"character"

posCat<-scan("SeattleSeqAnnotation138.seatseqinput_chr01_EDC_full_new.315724511246.txt", what = myWhat, skip=1, comment.char=" ", nlines=nRow)

cats<-c("stop-gained","stop-gained-near-splice","stop-lost","missense","missense-near-splice","splice-acceptor","splice-donor","synonymous","synonymous-near-splice","coding-unknown","coding-unknown-near-splice","3-prime-UTR","5-prime-UTR","downstream-gene","upstream-gene","non-coding-exon","non-coding-exon-near-splice","intron","intron-near-splice","intergenic")
# get position in category list for each category
catIdx<-match(posCat[[9]], cats)
# sort by position and then category index -- this returns indexes
sortOrder<-order(posCat[[3]], catIdx)
# keep only the first entry for a given position in the sorted data set
# need to add 1 because skipped the first line of the original file when we read it in
toKeep<-sortOrder[!duplicated(posCat[[3]][sortOrder])]+1

# had issues with ouput in scientific notation, i.e. 1e+4 rather than 10000
options(scipen=999)
write(c(1,toKeep), file="~/Desktop/toKeepAnnochr1_EDC.txt", ncolumns=1)
# clever awk script found at http://stackoverflow.com/questions/3319517/how-can-i-print-specific-lines-from-a-file-in-unix
system("awk 'FNR==NR{num[$1];next}(FNR in num)' ~/Desktop/toKeepAnnochr1_EDC.txt ~/Downloads/SeattleSeqAnnotation138.seatseqinput_chr01_EDC_full_new.315724511246.txt  > ~/Desktop/chr1_EDC.filtered.anno")

## test to see that it is working
testCat<-scan("chr22.filtered.anno", what=myWhat, comment.char=" ", skip=1)
all(testCat[[4]] == posCat[[4]][toKeep-1])
all(testCat[[10]] == posCat[[10]][toKeep-1])

# find an example with more than one different label so I can test that it's working
tmpCat<-split(posCat[[10]], posCat[[4]])
ctUnique<-sapply(tmpCat, function(x) length(unique(x)))
head(ctUnique[ctUnique > 1])
posCat[[10]][posCat[[4]] == 17600977]
posCat[[10]][toKeep-1][posCat[[4]][toKeep-1] == 17600977]
posCat[[10]][posCat[[4]] == 17601199]
posCat[[10]][toKeep-1][posCat[[4]][toKeep-1] == 17601199]

# positions may not be valid for chr22
head(ctUnique[ctUnique > 2])
posCat[[10]][posCat[[4]] == 18226590]
posCat[[10]][toKeep-1][posCat[[4]][toKeep-1] == 18226590]
posCat[[10]][posCat[[4]] == 18226604]
posCat[[10]][toKeep-1][posCat[[4]][toKeep-1] == 18226604]
posCat[[10]][posCat[[4]] == 18226772]
posCat[[10]][toKeep-1][posCat[[4]][toKeep-1] == 18226772]
