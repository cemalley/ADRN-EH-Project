setwd("/dcl01/barnes/data/ADRN_WGS/ADRN_all_chr_data")

############# P<0.05 with annotation ###############

data.sig.clean <- read.delim("adna_qq_data_all_chr_new_clean_anno_P_le_005.txt")

data.sub.clean_top_sig <- data.sub.clean[which(data.sub.clean$P_Final_adna < 10^-7),]
nrow(data.sub.clean_top_sig)
write.table(data.sub.clean_top_sig, file="adna_qq_data_all_chr_new_clean_anno_P_le_10-7.txt",sep="\t", quote=F,row.names=F)

data.sub.clean_p3 <- data.sub.clean[which(data.sub.clean$P_Final_adna < 10^-3),]
nrow(data.sub.clean_p3)
write.table(data.sub.clean_p3, file="adna_qq_data_all_chr_new_clean_anno_P_le_10-3.txt",sep="\t", quote=F,row.names=F)

data.sub.clean.p3.missense <- data.sub.clean_p3[which(data.sub.clean_p3$ExonicFunc.refGene_old == "nonsynonymous SNV" | data.sub.clean_p3$ExonicFunc.refGene_old == "stopgain" | data.sub.clean_p3$ExonicFunc.refGene_old == "stoploss"),]
nrow(data.sub.clean.p3.missense)
write.table(data.sub.clean.p3.missense, file="adna_qq_data_all_chr_new_clean_anno_missense.txt",sep="\t", quote=F,row.names=F)


