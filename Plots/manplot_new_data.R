library(qqman)
setwd("/dcl01/barnes/data/ADRN_WGS/ADRN_all_chr_data/")
dat_final <- read.delim("adna_qq_data_all_chr_new_clean_anno_P_le_005.txt")
dat_final$Chr <- sub("chr(.*):(.*)", "\\1", dat_final$VAR_adna_vassoc_new)
dat_final$POS <- sub("chr(.*):(.*)", "\\2", dat_final$VAR_adna_vassoc_new)
dat_final$Chr <- as.numeric(dat_final$Chr)
dat_final$POS <- as.numeric(dat_final$POS)
pdf("ADNA_allchr_new_clean_p_le_005_manhattan.pdf",width=21,height=10)
par(font.axis = 2)
manhattan(dat_final, chr= "Chr", bp="POS", p = "P_Final_adna_new", snp = "snp137_old", col = rainbow(5) ,chrlabs = NULL,highlight = NULL, logp = TRUE,suggestiveline = F, genomewideline = F,main="Association analysis:AD Vs NA  P < 0.05")
dev.off()


