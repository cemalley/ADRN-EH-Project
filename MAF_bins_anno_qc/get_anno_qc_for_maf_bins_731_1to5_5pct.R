x <- "/dcl01/barnes/data/ADRN_WGS"

chromo <- commandArgs(TRUE)[1]
chromo <- as.numeric(chromo)
newchr <- paste("0",chromo,sep="")
chrom <- ifelse (chromo<10, newchr, chromo)

d <- paste(x,"/ADRN_chr",chrom,"/761MultiVCF/", sep="")

path <- paste(x,"/ADRN_chr",chrom,"/Annovar_fromTim_17_12_14/", sep="")

########## read in annotation ##########

anno_file <- paste(path,"anno_input_chr",chrom,".txt.hg19_multianno.txt.gz", sep="")
anno <- read.delim(gzfile(anno_file))[c(1,2,4:7,9,10,12,25:27,30,31)]

######### read in QC file #########

qc <- paste(d,"adna_qq_data_chr",chromo,".txt",sep="")
qc_file <- read.delim(qc)

####### read in variant lists by MAF ##########

var1 <- paste(d,"/ADRN_chr",chrom,"_731_001_list_new.out", sep="")
var2 <- paste(d,"/ADRN_chr",chrom,"_731_001_le_005_list.out", sep="")
var3 <- paste(d,"/ADRN_chr",chrom,"_731_ge_005_list.out", sep="")
var4 <- paste(d,"/ADRN_chr",chrom,"_731_singleton_list_new.out", sep="")


maf001 <- read.delim(var1)
maf001_005 <- read.delim(var2)
maf005 <- read.delim(var3)
singleton <- read.delim(var4)

########### MAF < 1% ##################

maf001_anno <- merge(maf001, anno, by.x="position", by.y="Start")
maf001_anno_qc <- merge(maf001_anno, qc_file, by.x="position", by.y="POS")
maf001_final <- maf001_anno_qc[c(2,1,4:20,22:26)]
maf001_final_pass <- maf001_final[which((maf001_final$P_hwe_all > 0.000001) & (maf001_final$P_hwe_cases > 0.000001) & (maf001_final$P_hwe_controls > 0.001) & (maf001_final$P_diffmiss_adna > 0.001) & (maf001_final$F_MISS < 0.05)),]
maf001_final_pass_SIG <- maf001_final_pass[which(maf001_final_pass$P_Final_adna < 0.05),]
maf001_final_pass_SIG2 <- maf001_final_pass[which(maf001_final_pass$P_Final_adna < 0.001),]

out1 <- paste(d,"/ADRN_chr",chrom,"_731_001_list_clean_new.out", sep="")
out1_sig <- paste(d,"/ADRN_chr",chrom,"_731_001_list_sig_p005_clean_new.out", sep="")
out1_sig2 <- paste(d,"/ADRN_chr",chrom,"_731_001_list_sig_p0001_clean_new.out", sep="")

write.table(maf001_final_pass, file=out1, sep="\t", row.names=F, quote=F)
write.table(maf001_final_pass_SIG, file=out1_sig, sep="\t", row.names=F, quote=F)
write.table(maf001_final_pass_SIG2, file=out1_sig2, sep="\t", row.names=F, quote=F)

########### 1% <= MAF < 5% ##################

maf001_005_anno <- merge(maf001_005, anno, by.x="position", by.y="Start")
maf001_005_anno_qc <- merge(maf001_005_anno, qc_file, by.x="position", by.y="POS")
maf001_005_final <- maf001_005_anno_qc[c(2,1,4:20,22:26)]
maf001_005_final_pass <- maf001_005_final[which((maf001_005_final$P_hwe_all > 0.000001) & (maf001_005_final$P_hwe_cases > 0.000001) & (maf001_005_final$P_hwe_controls > 0.001) & (maf001_005_final$P_diffmiss_adna > 0.001) & (maf001_005_final$F_MISS < 0.05)),]
maf001_005_final_pass_SIG <- maf001_005_final_pass[which(maf001_005_final_pass$P_Final_adna < 0.05),]
maf001_005_final_pass_SIG2 <- maf001_005_final_pass[which(maf001_005_final_pass$P_Final_adna < 0.001),]

out2 <- paste(d,"/ADRN_chr",chrom,"_731_001_le_005_list_clean.out", sep="")
out2_sig <- paste(d,"/ADRN_chr",chrom,"_731_001_le_005_list_sig_p005_clean.out", sep="")
out2_sig2 <- paste(d,"/ADRN_chr",chrom,"_731_001_le_005_list_sig_p0001_clean.out", sep="")

write.table(maf001_005_final_pass, file=out2, sep="\t", row.names=F, quote=F)
write.table(maf001_005_final_pass_SIG, file=out2_sig, sep="\t", row.names=F, quote=F)
write.table(maf001_005_final_pass_SIG2, file=out2_sig2, sep="\t", row.names=F, quote=F)

######### MAF >= 5%  ###############

maf005_anno <- merge(maf005, anno, by.x="position", by.y="Start")
maf005_anno_qc <- merge(maf005_anno, qc_file, by.x="position", by.y="POS")
maf005_final <- maf005_anno_qc[c(2,1,4:20,22:26)]
maf005_final_pass <- maf005_final[which((maf005_final$P_hwe_all > 0.000001) & (maf005_final$P_hwe_cases > 0.000001) & (maf005_final$P_hwe_controls > 0.001) & (maf005_final$P_diffmiss_adna > 0.001) & (maf005_final$F_MISS < 0.05)),]
maf005_final_pass_SIG <- maf005_final_pass[which(maf005_final_pass$P_Final_adna < 0.05),]
maf005_final_pass_SIG2 <- maf005_final_pass[which(maf005_final_pass$P_Final_adna < 0.001),]

out3 <- paste(d,"/ADRN_chr",chrom,"_731_ge_005_list_clean.out", sep="")
out3_sig <- paste(d,"/ADRN_chr",chrom,"_731_ge_005_list_sig_p005_clean.out", sep="")
out3_sig2 <- paste(d,"/ADRN_chr",chrom,"_731_ge_005_list_sig_p0001_clean.out", sep="")

write.table(maf005_final_pass, file=out3, sep="\t", row.names=F, quote=F)
write.table(maf005_final_pass_SIG, file=out3_sig, sep="\t", row.names=F, quote=F)
write.table(maf005_final_pass_SIG2, file=out3_sig2, sep="\t", row.names=F, quote=F)

############# Singleton ############

singleton_anno <- merge(singleton, anno, by.x="position", by.y="Start")
singleton_anno_qc <- merge(singleton_anno, qc_file, by.x="position", by.y="POS")
singleton_final <- singleton_anno_qc[c(2,1,4:20,22:26)]
singleton_final_pass <- singleton_final[which((singleton_final$P_hwe_all > 0.000001) & (singleton_final$P_hwe_cases > 0.000001) & (singleton_final$P_hwe_controls > 0.001) & (singleton_final$P_diffmiss_adna > 0.001) & (singleton_final$F_MISS < 0.05)),]
singleton_final_pass_SIG <- singleton_final_pass[which(singleton_final_pass$P_Final_adna < 0.05),]
singleton_final_pass_SIG2 <- singleton_final_pass[which(singleton_final_pass$P_Final_adna < 0.001),]

out4 <- paste(d,"/ADRN_chr",chrom,"_731_singleton_list_clean_new.out", sep="")
out4_sig <- paste(d,"/ADRN_chr",chrom,"_731_singleton_list_sig_p005_clean_new.out", sep="")
out4_sig2 <- paste(d,"/ADRN_chr",chrom,"_731_singleton_list_sig_p0001_clean_new.out", sep="")

write.table(singleton_final_pass, file=out4, sep="\t", row.names=F, quote=F)
write.table(singleton_final_pass_SIG, file=out4_sig, sep="\t", row.names=F, quote=F)
write.table(singleton_final_pass_SIG2, file=out4_sig2, sep="\t", row.names=F, quote=F)
