setwd("/dcl01/barnes/data/ADRN_WGS/ADRN_all_chr_data")
adnatopvars<-read.delim("adna_qq_data_all_chr_new_clean_anno_P_le_10-3.txt")
#dat<-read.delim("Downloads/atac-seq/GSE67382_RAW/adna_topvars_keratinocytes_samples_peaks_atc-seqonly.txt")
atac.seq<-read.delim("/dcl01/barnes/data/ADRN_WGS/AD_NA/Files/keratinocytes_samples_peaks.narrowPeak")

summary(as.factor(atac.seq$chr))
        
#atac.seq2<-atac.seq[!duplicated(atac.seq[,11]),]
# using data table - faster but same results (check it yourself though)
library(data.table)

colnames(adnatopvars)[1] <- "Chr"
colnames(adnatopvars)[2] <- "POS"
colnames(atac.seq)[1] <- "chr"
  
# make -> chrom start end columns
setnames(atac.seq,c('chr','start','end'),c('chrom','start','end'))
setnames(x = adnatopvars, old = c('Chr','POS'),new = c('chrom','start'))
adnatopvars$end <- adnatopvars$start

#extra steps
atac.seq$chrom<-gsub("chr","",atac.seq$chrom)
atac.seq$chrom<-as.integer(atac.seq$chrom)

# convert to datatable and set key for atac.seq
setDT(adnatopvars)
setDT(atac.seq)
atac.seq <- atac.seq[,c('chrom','start','end','samplelabel','score','tags','V7','P_ATAC.seq','V9','V10','chr_strt_end'),with=F]
setkey(atac.seq)

# find overlaps i.e. positions in test that are 'within' ucsc 
dat <- foverlaps(adnatopvars,atac.seq,by.x = c('chrom','start','end'), by.y = c('chrom','start','end'), type='within', nomatch=0L)
dat<-as.data.frame(dat)

write.table(dat,"adna_topvars_atac-seq_new_clean.txt",sep="\t",row.names = F,quote = F)

dat<-dat[which(!duplicated(dat$chrpos)),]

write.table(dat,"adna_topvars_atac-seq_186SNPs_new_clean.txt",sep="\t",row.names = F,quote = F)



#dat.chr1<-dat[which(dat$chrom==1),]
#adnatopvars.atac.seq<-merge(adnatopvars,dat,by="chrpos",all.x=T)
#adnatopvars.atac.seq<-adnatopvars.atac.seq[c(1:59)]
#write.table(adnatopvars.atac.seq,"Downloads/atac-seq/GSE67382_RAW/adna_topvars_keratinocytes_samples_peaks.txt",sep="\t",row.names=F,quote = F)



#dat.chr1<-dat[which(dat$chrom==1),]
#dat.chr2<-dat[which(dat$chrom==1),]
#dat.chr3<-dat[which(dat$chrom==1),]
#dat.chr4<-dat[which(dat$chrom==1),]
#dat.chr5<-dat[which(dat$chrom==1),]
#dat.chr6<-dat[which(dat$chrom==1),]
#dat.chr7<-dat[which(dat$chrom==1),]
#dat.chr8<-dat[which(dat$chrom==1),]








#dat.chr22<-dat[which(dat$chrom==22),]

#scatter.smooth(dat.chr1$start,dat.chr1$P_Final_adna)

#smoothScatter(dat.chr1$start,dat.chr1$P_ATAC.seq,cex = 2,nrpoints = Inf,las=2)
#smoothScatter(dat.chr1$start,dat.chr1$P_Final_adna)

#plot(dat.chr1$start,dat.chr1$P_Final_adna)


#
#dat<-read.delim("Downloads/atac-seq/GSE67382_RAW/test_chr1.txt")

##ggplot 
#library(ggplot2)
#ggplot() + 
 # geom_point(data = dat[which(dat$chrom==1),], aes(x = start, y = P_ATAC.seq, color="ATAC-seq")) +
  #geom_point(data = dat[which(dat$chrom==1),], aes(x = i.start, y = -log10(P_Final_adna), color="P_Final_adna")) +
 # xlab('position') +
  #ylab('pvalues') + labs(color="Pvalues")

####
#par(mar=c(5,4,4,5)+.1)
#plot(dat$i.start,-log10(dat$P_Final_adna),type = 'p' ,col="red")
#par(new=TRUE)
#plot(dat.chr1$i.start, dat.chr1$P_ATAC.seq,type="l",col="blue",xaxt="n",yaxt="n",xlab="",ylab="")
#axis(4)
#mtext("y2",side=4,line=3)
#legend("topleft",col=c("red","blue"),lty=1,legend=c("y1","y2"))


######
#x <- seq(1992, 2002, by=2)
#rm(x)
#x<-dat.chr1
#d1 <- data.frame(x=dat.chr1$start, y=rnorm(length(x)))
#xy <- expand.grid(x=x, y=x)
#d2 <- data.frame(x=xy$x, y=xy$y, z= jitter(xy$x + xy$y))

#d1$panel <- "a"
#d2$panel <- "b"
#d1$z <- d1$x

#d <- rbind(d1, d2)

#p <- ggplot(data = d, mapping = aes(x = x, y = y))
#p <- p + facet_grid(panel~., scale="free")
#p <- p + layer(data= d1,  geom = c( "line"), stat = "identity")
#p <- p + layer(data=d2, mapping=aes(colour=z, fill=z),  geom =
   #              c("tile"), stat = "identity")
#p


##
#library(plotrix)
#example(twoord.plot)
#
#going_up<-dat.chr1$P_ATAC.seq+dat.chr1$i.start

#going_down<-dat.chr1$P_Final_adna+dat.chr1$i.start

#twoord.plot(2:10,going_up,1:15,going_down,xlab="Sequence",
 #             ylab="Ascending values",rylab="Descending values",lcol=4,
  #             main="Plot with two ordinates - points and lines",
   #           do.first="plot_bg();grid(col=\"white\",lty=1)")






#
#library(qqman)
#manhattan(dat.chr1,chr = "chrom", bp = "i.start", p = "P_Final_adna",snp = "snp137",col = c("gray60", "gray10") ,chrlabs = NULL, logp = TRUE,suggestiveline = F, genomewideline = F,ylim=c(3,8),main="Assosciation analysis:Staph + Vs Staph - (Novel variants highlighted in red)")
#axis(4,ylim=c(1,50))
#lines(dat.chr1$i.start,dat.chr1$P_ATAC.seq)

#manhattan(dat,chr = "chrom", bp = "i.start", p = "P_ATAC.seq",snp = "snp137",col = c("gray60", "gray10") ,chrlabs = NULL, logp = TRUE,suggestiveline = F, genomewideline = F,ylim=c(3,7),main="Assosciation analysis:Staph + Vs Staph - (Novel variants highlighted in red)")


#dev.off()
###





##
#atac.seq.chr1<-atac.seq[which(atac.seq$chr=="chr1"),]
#colnames(atac.seq.chr1)
#atac.seq.chr1$pos_summit<-atac.seq.chr1$start+atac.seq.chr1$V10
#atac.seq.chr1.edc<-atac.seq.chr1[which(atac.seq.chr1$pos_summit > 151972910 & atac.seq.chr1$pos_summit < 153642037),]
#write.table(atac.seq.chr1.edc,"Downloads/atac-seq/GSE67382_RAW/atac-seq_keratinocytes_samples_peaks_EDC.txt",sep="\t",row.names=F,quote = F)
#atac.seq.chr1.edc<-read.delim("Downloads/atac-seq/GSE67382_RAW/atac-seq_keratinocytes_samples_peaks_EDC.txt")




##adnatopvars in edc
#adnatopvars.chr1<-adnatopvars[which(adnatopvars$Chr==1),]
#colnames(adnatopvars.chr1)
#adnatopvars.chr1$pos_summit<-adnatopvars.chr1$start+adnatopvars.chr1$V10
#adnatopvars.chr1.edc<-adnatopvars.chr1[which(adnatopvars.chr1$POS > 151972910 & adnatopvars.chr1$POS < 153642037),]
#adnatopvars.chr1.edc<-adnatopvars.chr1.edc[which(!duplicated(adnatopvars.chr1.edc$POS)),]
