setwd("/dcl01/barnes/data/ADRN_WGS/ADRN_chr22/761MultiVCF")
glm<-read.delim("ADRN_chr22_761_filled_filtered_AD_NA_glm_excl_failed.out")
vassoc<-read.delim("ADRN_chr22_761_filled_filtered_AD_NA_vassoc_excl_failed.out")
lmiss<-read.delim("ADRN_chr22_761_SNPs_filled_GQ30_DP7_segdup_adna_wgs.lmiss")
hwe<-read.delim("ADRN_chr22_761_SNPs_filled_GQ30_DP7_segdup_adna_wgs.hwe")
diffmisshardy<-read.delim("ADRN_chr22_761_SNPs_filled_GQ30_DP7_segdup_adna_wgs_bed_diff_miss_hardy.txt")
colnames(hwe)[6]<-"P_hwe"
hwe<-hwe[c(2,6)]
lmiss<-lmiss[c(2,6)]
qc.old<-merge(lmiss,hwe,by="POS",all.x=T)
diffmisshardy<-diffmisshardy[c(12,5,11,18,24)]
diffmisshardy$POS<-gsub("22:","",diffmisshardy$chrpos)
qc<-merge(qc.old,diffmisshardy,by="POS")
colnames(vassoc)<-paste(colnames(vassoc),"adna_vassoc", sep="_")
colnames(glm)<-paste(colnames(glm),"adna_glm", sep="_")
glm<-glm[c(1,6,9)]
vassoc<-vassoc[c(1,8,20,21)]
dat<-merge(vassoc,glm,by.x="VAR_adna_vassoc",by.y="VAR_adna_glm")
dat$MAFF_adna_vassoc <- ifelse(dat$MAF_adna_vassoc>0.5,(1-dat$MAF_adna_vassoc),dat$MAF_adna_vassoc)
dat$P_Final_adna <- ifelse(dat$MAFF_adna_vassoc<0.05, dat$P_adna_vassoc, dat$P_adna_glm)
dat$OR_Final_adna <- ifelse(dat$MAFF_adna_vassoc<0.05, dat$OR_adna_vassoc, dat$OR_adna_glm)
dat<-dat[c(1,7,8,9)]
dat$POS<-gsub("chr22:","",dat$VAR_adna_vassoc)
dat.qc<-merge(dat,qc,by="POS")
dat.qc$chr<-"chr22"
write.table(dat.qc,"adna_qq_data_chr22.txt",sep="\t",row.names=F,quote=F)






