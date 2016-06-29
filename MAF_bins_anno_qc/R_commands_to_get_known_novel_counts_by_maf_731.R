################# MAF < 1%  #################
setwd("/dcl01/barnes/data/ADRN_WGS/ADRN_all_chr_data")
data <- read.delim("ADRN_allchrs_731_001_list_clean.out", header=T)
known_data <- subset(data, snp137 != "NA")
novel_data <- subset(data, is.na(data$snp137))
known_data_sorted <- known_data[order(known_data$Func.refGene, known_data$ExonicFunc.refGene),]
attach(known_data_sorted)
known_data_sorted$agg <- paste(known_data_sorted$Func.refGene,":",known_data_sorted$ExonicFunc.refGene)
detach(known_data_sorted)
known_agg2 <- aggregate(known_data_sorted$CHR, by = list(known_data_sorted$agg), length)
novel_data_sorted <- novel_data[order(novel_data$Func.refGene, novel_data$ExonicFunc.refGene),]
attach(novel_data_sorted)
novel_data_sorted$agg <- paste(novel_data_sorted$Func.refGene,":",novel_data_sorted$ExonicFunc.refGene)
detach(novel_data_sorted)
novel_agg2 <- aggregate(novel_data_sorted$CHR, by = list(novel_data_sorted$agg), length)
write.table(known_agg2,file="ADRN_all_chr_731_001_counts_known_var.out",sep="\t",quote=F,row.names=F)
write.table(novel_agg2,file="ADRN_all_chr_731_001_counts_novel_var.out",sep="\t",quote=F,row.names=F)

data_sig <- read.delim("ADRN_allchrs_731_001_list_sig_p005_clean.out", header=T)
known_data_sig <- subset(data_sig, snp137 != "NA")
novel_data_sig <- subset(data_sig, is.na(data_sig$snp137))
known_data_sig_sorted <- known_data_sig[order(known_data_sig$Func.refGene, known_data_sig$ExonicFunc.refGene),]
attach(known_data_sig_sorted)
known_data_sig_sorted$agg <- paste(known_data_sig_sorted$Func.refGene,":",known_data_sig_sorted$ExonicFunc.refGene)
detach(known_data_sig_sorted)
known_agg2 <- aggregate(known_data_sig_sorted$CHR, by = list(known_data_sig_sorted$agg), length)
novel_data_sig_sorted <- novel_data_sig[order(novel_data_sig$Func.refGene, novel_data_sig$ExonicFunc.refGene),]
attach(novel_data_sig_sorted)
novel_data_sig_sorted$agg <- paste(novel_data_sig_sorted$Func.refGene,":",novel_data_sig_sorted$ExonicFunc.refGene)
detach(novel_data_sig_sorted)
novel_agg2 <- aggregate(novel_data_sig_sorted$CHR, by = list(novel_data_sig_sorted$agg), length)
write.table(known_agg2,file="ADRN_all_chr_731_001_sig_p005_counts_known_var.out",sep="\t",quote=F,row.names=F)
write.table(novel_agg2,file="ADRN_all_chr_731_001_sig_p005_counts_novel_var.out",sep="\t",quote=F,row.names=F)


data_sig2 <- read.delim("ADRN_allchrs_731_001_list_sig_p0001_clean.out", header=T)
known_data_sig2 <- subset(data_sig2, snp137 != "NA")
novel_data_sig2 <- subset(data_sig2, is.na(data_sig2$snp137))
known_data_sig2_sorted <- known_data_sig2[order(known_data_sig2$Func.refGene, known_data_sig2$ExonicFunc.refGene),]
attach(known_data_sig2_sorted)
known_data_sig2_sorted$agg <- paste(known_data_sig2_sorted$Func.refGene,":",known_data_sig2_sorted$ExonicFunc.refGene)
detach(known_data_sig2_sorted)
known_agg2 <- aggregate(known_data_sig2_sorted$CHR, by = list(known_data_sig2_sorted$agg), length)
novel_data_sig2_sorted <- novel_data_sig2[order(novel_data_sig2$Func.refGene, novel_data_sig2$ExonicFunc.refGene),]
attach(novel_data_sig2_sorted)
novel_data_sig2_sorted$agg <- paste(novel_data_sig2_sorted$Func.refGene,":",novel_data_sig2_sorted$ExonicFunc.refGene)
detach(novel_data_sig2_sorted)
novel_agg2 <- aggregate(novel_data_sig2_sorted$CHR, by = list(novel_data_sig2_sorted$agg), length)
write.table(known_agg2,file="ADRN_all_chr_731_001_sig_p0001_counts_known_var.out",sep="\t",quote=F,row.names=F)
write.table(novel_agg2,file="ADRN_all_chr_731_001_sig_p0001_counts_novel_var.out",sep="\t",quote=F,row.names=F)




############### 1% <= MAF <= 5%  ####################

data2 <- read.delim("ADRN_allchrs_731_001-005_list_clean.out", header=T)
known_data2 <- subset(data2, snp137 != "NA")
novel_data2 <- subset(data2, is.na(data2$snp137))
known_data2_sorted <- known_data2[order(known_data2$Func.refGene, known_data2$ExonicFunc.refGene),]
attach(known_data2_sorted)
known_data2_sorted$agg <- paste(known_data2_sorted$Func.refGene,":",known_data2_sorted$ExonicFunc.refGene)
detach(known_data2_sorted)
known_agg2 <- aggregate(known_data2_sorted$CHR, by = list(known_data2_sorted$agg), length)
novel_data2_sorted <- novel_data2[order(novel_data2$Func.refGene, novel_data2$ExonicFunc.refGene),]
attach(novel_data2_sorted)
novel_data2_sorted$agg <- paste(novel_data2_sorted$Func.refGene,":",novel_data2_sorted$ExonicFunc.refGene)
detach(novel_data2_sorted)
novel_agg2 <- aggregate(novel_data2_sorted$CHR, by = list(novel_data2_sorted$agg), length)
write.table(known_agg2,file="ADRN_all_chr_731_001-005_counts_known_var.out",sep="\t",quote=F,row.names=F)
write.table(novel_agg2,file="ADRN_all_chr_731_001-005_counts_novel_var.out",sep="\t",quote=F,row.names=F)

data2_sig <- read.delim("ADRN_allchrs_731_001-005_list_sig_p005_clean.out", header=T)
known_data2_sig <- subset(data2_sig, snp137 != "NA")
novel_data2_sig <- subset(data2_sig, is.na(data2_sig$snp137))
known_data2_sig_sorted <- known_data2_sig[order(known_data2_sig$Func.refGene, known_data2_sig$ExonicFunc.refGene),]
attach(known_data2_sig_sorted)
known_data2_sig_sorted$agg <- paste(known_data2_sig_sorted$Func.refGene,":",known_data2_sig_sorted$ExonicFunc.refGene)
detach(known_data2_sig_sorted)
known_agg2 <- aggregate(known_data2_sig_sorted$CHR, by = list(known_data2_sig_sorted$agg), length)
novel_data2_sig_sorted <- novel_data2_sig[order(novel_data2_sig$Func.refGene, novel_data2_sig$ExonicFunc.refGene),]
attach(novel_data2_sig_sorted)
novel_data2_sig_sorted$agg <- paste(novel_data2_sig_sorted$Func.refGene,":",novel_data2_sig_sorted$ExonicFunc.refGene)
detach(novel_data2_sig_sorted)
novel_agg2 <- aggregate(novel_data2_sig_sorted$CHR, by = list(novel_data2_sig_sorted$agg), length)
write.table(known_agg2,file="ADRN_all_chr_731_001-005_sig_p005_counts_known_var.out",sep="\t",quote=F,row.names=F)
write.table(novel_agg2,file="ADRN_all_chr_731_001-005_sig_p005_counts_novel_var.out",sep="\t",quote=F,row.names=F)


data2_sig2 <- read.delim("ADRN_allchrs_731_001-005_list_sig_p0001_clean.out", header=T)
known_data2_sig2 <- subset(data2_sig2, snp137 != "NA")
novel_data2_sig2 <- subset(data2_sig2, is.na(data2_sig2$snp137))
known_data2_sig2_sorted <- known_data2_sig2[order(known_data2_sig2$Func.refGene, known_data2_sig2$ExonicFunc.refGene),]
attach(known_data2_sig2_sorted)
known_data2_sig2_sorted$agg <- paste(known_data2_sig2_sorted$Func.refGene,":",known_data2_sig2_sorted$ExonicFunc.refGene)
detach(known_data2_sig2_sorted)
known_agg2 <- aggregate(known_data2_sig2_sorted$CHR, by = list(known_data2_sig2_sorted$agg), length)
novel_data2_sig2_sorted <- novel_data2_sig2[order(novel_data2_sig2$Func.refGene, novel_data2_sig2$ExonicFunc.refGene),]
attach(novel_data2_sig2_sorted)
novel_data2_sig2_sorted$agg <- paste(novel_data2_sig2_sorted$Func.refGene,":",novel_data2_sig2_sorted$ExonicFunc.refGene)
detach(novel_data2_sig2_sorted)
novel_agg2 <- aggregate(novel_data2_sig2_sorted$CHR, by = list(novel_data2_sig2_sorted$agg), length)
write.table(known_agg2,file="ADRN_all_chr_731_001-005_sig_p0001_counts_known_var.out",sep="\t",quote=F,row.names=F)
write.table(novel_agg2,file="ADRN_all_chr_731_001-005_sig_p0001_counts_novel_var.out",sep="\t",quote=F,row.names=F)


################ MAF > 5% ################

data3 <- read.delim("ADRN_allchrs_731_005_list_clean.out", header=T)
known_data3 <- subset(data3, snp137 != "NA")
novel_data3 <- subset(data3, is.na(data3$snp137))
known_data3_sorted <- known_data3[order(known_data3$Func.refGene, known_data3$ExonicFunc.refGene),]
attach(known_data3_sorted)
known_data3_sorted$agg <- paste(known_data3_sorted$Func.refGene,":",known_data3_sorted$ExonicFunc.refGene)
detach(known_data3_sorted)
known_agg2 <- aggregate(known_data3_sorted$CHR, by = list(known_data3_sorted$agg), length)
novel_data3_sorted <- novel_data3[order(novel_data3$Func.refGene, novel_data3$ExonicFunc.refGene),]
attach(novel_data3_sorted)
novel_data3_sorted$agg <- paste(novel_data3_sorted$Func.refGene,":",novel_data3_sorted$ExonicFunc.refGene)
detach(novel_data3_sorted)
novel_agg2 <- aggregate(novel_data3_sorted$CHR, by = list(novel_data3_sorted$agg), length)
write.table(known_agg2,file="ADRN_all_chr_731_005_counts_known_var.out",sep="\t",quote=F,row.names=F)
write.table(novel_agg2,file="ADRN_all_chr_731_005_counts_novel_var.out",sep="\t",quote=F,row.names=F)

data3_sig <- read.delim("ADRN_allchrs_731_005_list_sig_p005_clean.out", header=T)
known_data3_sig <- subset(data3_sig, snp137 != "NA")
novel_data3_sig <- subset(data3_sig, is.na(data3_sig$snp137))
known_data3_sig_sorted <- known_data3_sig[order(known_data3_sig$Func.refGene, known_data3_sig$ExonicFunc.refGene),]
attach(known_data3_sig_sorted)
known_data3_sig_sorted$agg <- paste(known_data3_sig_sorted$Func.refGene,":",known_data3_sig_sorted$ExonicFunc.refGene)
detach(known_data3_sig_sorted)
known_agg2 <- aggregate(known_data3_sig_sorted$CHR, by = list(known_data3_sig_sorted$agg), length)
novel_data3_sig_sorted <- novel_data3_sig[order(novel_data3_sig$Func.refGene, novel_data3_sig$ExonicFunc.refGene),]
attach(novel_data3_sig_sorted)
novel_data3_sig_sorted$agg <- paste(novel_data3_sig_sorted$Func.refGene,":",novel_data3_sig_sorted$ExonicFunc.refGene)
detach(novel_data3_sig_sorted)
novel_agg2 <- aggregate(novel_data3_sig_sorted$CHR, by = list(novel_data3_sig_sorted$agg), length)
write.table(known_agg2,file="ADRN_all_chr_731_005_sig_p005_counts_known_var.out",sep="\t",quote=F,row.names=F)
write.table(novel_agg2,file="ADRN_all_chr_731_005_sig_p005_counts_novel_var.out",sep="\t",quote=F,row.names=F)


data3_sig2 <- read.delim("ADRN_allchrs_731_005_list_sig_p0001_clean.out", header=T)
known_data3_sig2 <- subset(data3_sig2, snp137 != "NA")
novel_data3_sig2 <- subset(data3_sig2, is.na(data3_sig2$snp137))
known_data3_sig2_sorted <- known_data3_sig2[order(known_data3_sig2$Func.refGene, known_data3_sig2$ExonicFunc.refGene),]
attach(known_data3_sig2_sorted)
known_data3_sig2_sorted$agg <- paste(known_data3_sig2_sorted$Func.refGene,":",known_data3_sig2_sorted$ExonicFunc.refGene)
detach(known_data3_sig2_sorted)
known_agg2 <- aggregate(known_data3_sig2_sorted$CHR, by = list(known_data3_sig2_sorted$agg), length)
novel_data3_sig2_sorted <- novel_data3_sig2[order(novel_data3_sig2$Func.refGene, novel_data3_sig2$ExonicFunc.refGene),]
attach(novel_data3_sig2_sorted)
novel_data3_sig2_sorted$agg <- paste(novel_data3_sig2_sorted$Func.refGene,":",novel_data3_sig2_sorted$ExonicFunc.refGene)
detach(novel_data3_sig2_sorted)
novel_agg2 <- aggregate(novel_data3_sig2_sorted$CHR, by = list(novel_data3_sig2_sorted$agg), length)
write.table(known_agg2,file="ADRN_all_chr_731_005_sig_p0001_counts_known_var.out",sep="\t",quote=F,row.names=F)
write.table(novel_agg2,file="ADRN_all_chr_731_005_sig_p0001_counts_novel_var.out",sep="\t",quote=F,row.names=F)

################## Singletons ################

data4 <- read.delim("ADRN_allchrs_731_singleton_list_clean.out", header=T)
known_data4 <- subset(data4, snp137 != "NA")
novel_data4 <- subset(data4, is.na(data4$snp137))
known_data4_sorted <- known_data4[order(known_data4$Func.refGene, known_data4$ExonicFunc.refGene),]
attach(known_data4_sorted)
known_data4_sorted$agg <- paste(known_data4_sorted$Func.refGene,":",known_data4_sorted$ExonicFunc.refGene)
detach(known_data4_sorted)
known_agg2 <- aggregate(known_data4_sorted$CHR, by = list(known_data4_sorted$agg), length)
novel_data4_sorted <- novel_data4[order(novel_data4$Func.refGene, novel_data4$ExonicFunc.refGene),]
attach(novel_data4_sorted)
novel_data4_sorted$agg <- paste(novel_data4_sorted$Func.refGene,":",novel_data4_sorted$ExonicFunc.refGene)
detach(novel_data4_sorted)
novel_agg2 <- aggregate(novel_data4_sorted$CHR, by = list(novel_data4_sorted$agg), length)
write.table(known_agg2,file="ADRN_all_chr_731_singleton_counts_known_var.out",sep="\t",quote=F,row.names=F)
write.table(novel_agg2,file="ADRN_all_chr_731_singleton_counts_novel_var.out",sep="\t",quote=F,row.names=F)

######### There were no variants in the singleton list that were significant ############

