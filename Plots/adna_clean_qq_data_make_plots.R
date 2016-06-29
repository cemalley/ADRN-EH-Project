setwd("/dcl01/barnes/data/ADRN_WGS/ADRN_all_chr_data")
dat <- read.delim(gzfile("adna_qq_data_all_chr_new.txt.gz"))


########## clean data using new QC thresholds ##############
dat<-dat[which(dat$F_MISS <0.05),]
dat<-dat[which(dat$P_hwe_all > 0.000001),]
dat<-dat[which(dat$P_hwe_cases > 0.000001),]
dat<-dat[which(dat$P_hwe_controls > 0.001),]
nrow(dat)
dat<-dat[which(dat$P_diffmiss_adna > 0.001),]
nrow(dat)
write.table(dat,"adna_qq_data_all_chr_new_clean.txt",sep="\t",row.names=F,quote=F)

########## data split for Common and rare for qq plots ###########
dat.common<-dat[which(dat$MAFF_adna_vassoc >= 0.05),]
nrow(dat.common)
dat.rare<-dat[which(dat$MAFF_adna_vassoc < 0.05),]
nrow(dat.rare)
range(-log10(dat.common$P_Final_adna))
range(-log10(dat.rare$P_Final_adna))

######### qq plots ##########

observed <- sort(dat.common$P_Final_adna)
lobs <- -(log10(observed))
expected <- c(1:length(observed)) 
lexp <- -(log10(expected / (length(expected)+1)))
pdf("adna_qq_data_all_chr_new_clean_qqplot_common.pdf", width=6, height=6)
plot(c(0,10), c(0,10), col="red", lwd=3, type="l", xlab="Expected (-logP)", ylab="Observed (-logP)", xlim=c(0,10), ylim=c(0,10), las=1, xaxs="i", yaxs="i", bty="l")
points(lexp, lobs, pch=23, cex=.4, bg="black") 
dev.off()


observed <- sort(dat.rare$P_Final_adna)
lobs <- -(log10(observed))
expected <- c(1:length(observed)) 
lexp <- -(log10(expected / (length(expected)+1)))
pdf("adna_qq_data_all_chr_new_clean_qqplot_rare.pdf", width=6, height=6)
plot(c(0,10), c(0,10), col="red", lwd=3, type="l", xlab="Expected (-logP)", ylab="Observed (-logP)", xlim=c(0,10), ylim=c(0,10), las=1, xaxs="i", yaxs="i", bty="l")
points(lexp, lobs, pch=23, cex=.4, bg="black") 
dev.off()


################ manhattan plot ############

dat.sig <- dat[which(dat$P_Final_adna < 0.05),]
nrow(dat.sig)
write.table(dat.sig, "adna_qq_data_all_chr_new_clean_P_le_005.txt", sep="\t",row.names=F,quote=F)
library(qqman)
pdf("ADNA_allchr_new_clean_p_le_005_manhattan.pdf",width=21,height=10)
par(font.axis = 2)
manhattan(dat.sig,chr = "Chr", bp = "POS", p = "P_Final_adna", snp = "SNP_hwe_all",col = rainbow(5) ,chrlabs = NULL,highlight = NULL, logp = TRUE,suggestiveline = F, genomewideline = F,main="Association analysis:AD Vs NA  P < 0.05")
dev.off()


