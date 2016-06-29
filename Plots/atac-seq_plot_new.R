library(qqman)
setwd("/dcl01/barnes/data/ADRN_WGS/AD_NA/Files")
adnatopvars <- read.delim("adna_topvars_atac-seq_186SNPs_new_clean.txt")
dat <- read.delim("adna_qq_data_all_chr_new_clean_anno_P_le_10-3.txt")
final <- merge(dat, adnatopvars, by = "VAR_adna_vassoc_new", all.x=T)
final.highlight <- final[which(final$P_ATAC.seq != "NA"),]
pdf("/dcl01/barnes/data/ADRN_WGS/ADRN_all_chr_data/ADNA_allchr_new_clean_p_le_0001_GB_atacseq_highlights_manhattan.pdf",width=21,height=10)
par(font.axis = 2)
manhattan(final,chr = "Chr_old", bp = "POS_old", p = "P_Final_adna_new.x", snp = "snp137_old.x",col = c("darkgrey", "black"),chrlabs = NULL, highlight=as.character(final.highlight$snp137_old.x), logp = TRUE,suggestiveline = F, genomewideline = F,ylim=c(3,11),main="ADNA top SNPs under ATAC-seq peak regions")
