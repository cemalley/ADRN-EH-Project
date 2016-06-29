setwd("/dcl01/barnes/data/ADRN_WGS/ADRN_chr22/761MultiVCF/")
hwe<-read.table("ADRN_chr22_761_SNPs_filled_GQ30_DP7_segdup_adna_wgs_bed_diff_miss_hardy.hwe",header=T)
diffmiss<-read.table("ADRN_chr22_761_SNPs_filled_GQ30_DP7_segdup_adna_wgs_bed_diff_miss_hardy.missing",header=T)
colnames(diffmiss)[5]<-"P_diffmis_adna"
map<-read.delim("ADRN_chr22_761_SNPs_filled_GQ30_DP7_segdup_adna_wgs.map",header=F)
colnames(map)[2]<-"SNP"
map$chrpos<-paste(map$V1,map$V4,sep=":")
diffmiss.hwe<-merge(diffmiss,hwe,by="SNP")
diffmiss.hwe.map<-merge(diffmiss.hwe,map,by="SNP")
diffmiss.hwe.map<-diffmiss.hwe.map[c(1:5,7:13,17)]
diffmiss.hwe.map.aff<-diffmiss.hwe.map[which(diffmiss.hwe.map$TEST=="AFF"),]
diffmiss.hwe.map.unaff<-diffmiss.hwe.map[which(diffmiss.hwe.map$TEST=="UNAFF"),]
diffmiss.hwe.map.all<-diffmiss.hwe.map[which(diffmiss.hwe.map$TEST=="ALL"),]
colnames(diffmiss.hwe.map.aff) <- paste(colnames(diffmiss.hwe.map.aff),"hwe_cases" ,sep = "_")
colnames(diffmiss.hwe.map.unaff) <- paste(colnames(diffmiss.hwe.map.unaff),"hwe_controls" ,sep = "_")
colnames(diffmiss.hwe.map.all) <- paste(colnames(diffmiss.hwe.map.all),"hwe_all" ,sep = "_")
diffmiss.hwe.map.all<-cbind(diffmiss.hwe.map.all,diffmiss.hwe.map.aff,diffmiss.hwe.map.unaff)
diffmiss.hwe.map.all<-diffmiss.hwe.map.all[c(1:5,7:13,20:25,33:38)]
colnames(diffmiss.hwe.map.all)[1]<-"SNP"
colnames(diffmiss.hwe.map.all)[2]<-"CHR"
colnames(diffmiss.hwe.map.all)[3]<-"F_MISS_A"
colnames(diffmiss.hwe.map.all)[4]<-"F_MISS_U"
colnames(diffmiss.hwe.map.all)[5]<-"P_diffmiss_adna"
colnames(diffmiss.hwe.map.all)[12]<-"chrpos"
write.table(diffmiss.hwe.map.all,"ADRN_chr22_761_SNPs_filled_GQ30_DP7_segdup_adna_wgs_bed_diff_miss_hardy.txt",sep="\t",row.names=F,quote=F)
