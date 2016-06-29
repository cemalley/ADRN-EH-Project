x <- "/dcl01/barnes/data/ADRN_WGS"
chromo <- commandArgs(TRUE)[1]
chromo <- as.numeric(chromo)
newchr <- paste("0",chromo,sep="")
chrom <- ifelse (chromo<10, newchr, chromo)
a <- paste(x, "/ADRN_chr",chrom,"/SKATO/", sep="")
b <- paste(x, "/ADRN_chr",chrom,"/761MultiVCF/", sep="")

varset1_file <- paste(a,"chr",chrom,"_varset1.txt",sep="")
varset2_file <- paste(a,"chr",chrom,"_varset2.txt",sep="")
varset3_file <- paste(a,"chr",chrom,"_varset3.txt",sep="")
varset4_file <- paste(a,"chr",chrom,"_varset4.txt",sep="")

v1 <- read.delim(varset1_file, header=F)
v2 <- read.delim(varset2_file, header=F)
v3 <- read.delim(varset3_file,header=F)
v4 <- read.delim(varset4_file, header=F)

map <- paste(b,"ADRN_chr",chrom,"_761_SNPs_filled_GQ30_DP7_segdup_adna_wgs.map",sep="")
qc <- paste(b,"adna_qq_data_chr",chromo,".txt",sep="")
map_file <- read.delim(map, header=F)
qc_file <- read.delim(qc)

qc_map_file <- merge(qc_file, map_file, by.x="POS", by.y="V4")
qc_map_sub <- qc_map_file[c(14,1,15,3:6,9:12)]
colnames(qc_map_sub)[1] <- "Chr"
colnames(qc_map_sub)[3] <- "SNP"

v1_full <- merge(v1,qc_map_sub, by.x="V2",by.y="SNP")
v1_full_sub <- v1_full[which((v1_full$P_hwe_all > 0.000001) & (v1_full$P_hwe_cases > 0.000001) & (v1_full$P_hwe_controls > 0.001) & (v1_full$P_diffmiss_adna > 0.001) & (v1_full$F_MISS < 0.05)),]
nrow(v1)
nrow(v1_full_sub)
v1_final <- v1_full_sub[c(2,1)]
v1_clean <- paste(a,"chr",chrom,"_varset1_clean_new_qc.txt",sep="")
write.table(v1_final,file=v1_clean,sep="\t",row.names=F,quote=F)

v2_full <- merge(v2,qc_map_sub, by.x="V2",by.y="SNP")
v2_full_sub <- v1_full[which((v2_full$P_hwe_all > 0.000001) & (v2_full$P_hwe_cases > 0.000001) & (v2_full$P_hwe_controls > 0.001) & (v2_full$P_diffmiss_adna > 0.001) & (v2_full$F_MISS < 0.05)),]
nrow(v2)
nrow(v2_full_sub)
v2_final <- v2_full_sub[c(2,1)]
v2_clean <- paste(a,"chr",chrom,"_varset2_clean_new_qc.txt",sep="")
write.table(v2_final,file=v2_clean,sep="\t",row.names=F,quote=F)

v3_full <- merge(v3,qc_map_sub, by.x="V2",by.y="SNP")
v3_full_sub <- v3_full[which((v3_full$P_hwe_all > 0.000001) & (v3_full$P_hwe_cases > 0.000001) & (v3_full$P_hwe_controls > 0.001) & (v3_full$P_diffmiss_adna > 0.001) & (v3_full$F_MISS < 0.05)),]
nrow(v3)
nrow(v3_full_sub)
v3_final <- v3_full_sub[c(2,1)]
v3_clean <- paste(a,"chr",chrom,"_varset3_clean_new_qc.txt",sep="")
write.table(v3_final,file=v3_clean,sep="\t",row.names=F,quote=F)

v4_full <- merge(v4,qc_map_sub, by.x="V2",by.y="SNP")
v4_full_sub <- v4_full[which((v4_full$P_hwe_all > 0.000001) & (v4_full$P_hwe_cases > 0.000001) & (v4_full$P_hwe_controls > 0.001) & (v4_full$P_diffmiss_adna > 0.001) & (v4_full$F_MISS < 0.05)),]
nrow(v4)
nrow(v4_full_sub)
v4_final <- v4_full_sub[c(2,1)]
v4_clean <- paste(a,"chr",chrom,"_varset4_clean_new_qc.txt",sep="")
write.table(v4_final,file=v4_clean,sep="\t",row.names=F,quote=F)
