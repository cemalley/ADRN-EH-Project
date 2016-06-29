x <- "/dcl01/barnes/data/ADRN_WGS/ADRN_chr"
chromo <- commandArgs(TRUE)[1]
chromo <- as.numeric(chromo)
newchr <- paste("0",chromo,sep="")
chrom <- ifelse (chromo<10, newchr, chromo)
y<- paste(x,chrom,"/761MultiVCF/ADRN_chr",chrom,"_761_filled_filtered_AD_NA_vassoc_excl_failed.out", sep="")
data <- read.table(y, header=T)
attach(data)
data$REFALL<- REFA+REFU
data$HETALL<- HETA+HETU
data$HOMALL<- HOMA+HOMU
data$MAFF <- ifelse (MAF<0.5,MAF,(1-MAF))
data$SING <- ifelse(data$HETALL==1 & data$HOMALL==0,1,0)
data$DOUB <- ifelse(data$HETALL==2 & (data$REFALL==0 | data$HOMALL==0),1,0)
data$CHR<- paste("chr",chromo,sep="")
count <- ifelse(chromo<10, 6, 7)
#count <- as.numeric(count)
data$POS <- substr(data$VAR,count,25)   ## for chr1-9, use 6,25 instead of 7,25
data$position <- as.numeric(data$POS)
data1 <- data[c(1,8,9,14,15,16,17,18,19,26,27,28,29,30,31,32,34)]  ## subset to variables that we want
data2 <- subset(data1, MAFF<0.01 & SING==1)
data3 <- subset(data1, MAFF<0.01 & SING==0)  
data4 <- subset(data1, MAFF>=0.01 & MAFF<0.05)  
data5 <- subset(data1, MAFF>=0.05)
#data_doub <- subset(data1, DOUB==1)
data6 <- data2[c(16,17)]
data7 <- data3[c(16,17)]
data8 <- data4[c(16,17)]
data9 <- data5[c(16,17)]
#data10 <- data_doub[c(16,17)]
#a <- paste(x,chrom,"/761MultiVCF/ADRN_chr",chrom,"_742_MAF.out",sep="")
#write.table(data1,  file=a, quote = FALSE,sep="\t", row.names=F)
b <- paste(x,chrom,"/761MultiVCF/ADRN_chr",chrom,"_731_singleton_list_new.out",sep="") 
write.table(data6,  file=b, quote=F, sep="\t", row.names=F)
c <- paste(x,chrom,"/761MultiVCF/ADRN_chr",chrom,"_731_001_list_new.out",sep="")
write.table(data7,  file=c, quote=F, sep="\t", row.names=F)
d <- paste(x,chrom,"/761MultiVCF/ADRN_chr",chrom,"_731_001_le_005_list.out",sep="")
write.table(data8,  file=d, quote=F, sep="\t", row.names=F)
e <- paste(x,chrom,"/761MultiVCF/ADRN_chr",chrom,"_731_ge_005_list.out",sep="")
write.table(data9,  file=e, quote=F, sep="\t", row.names=F)
#f <- paste(x,chrom,"/761MultiVCF/ADRN_chr",chrom,"_731_doubleton_list.out",sep="")
#write.table(data10,  file=f, quote=F, sep="\t", row.names=F)
