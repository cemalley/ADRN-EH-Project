x <- "/amber2/scratch/schavan/ADRN/ADRN_chr"
chromo <- commandArgs(TRUE)[1]
chromo <- as.numeric(chromo)
newchr <- paste("0",chromo,sep="")
chrom <- ifelse (chromo<10, newchr, chromo)
num <- ifelse (chromo<10, 6, 7)
y<- paste(x,chrom,"/761MultiVCF/", sep="")
file1 <- paste(y,"ADRN_chr",chrom,"_761_filled_filtered_Staph_Pos_Neg_vassoc_excl_failed.out",sep="")
file2 <- paste(y,"ADRN_chr",chrom,"_761_filled_filtered_Staph_Pos_Neg_glm_excl_failed.out",sep="")
data1 <- read.table(file1, header=T)
colnames(data1) <- paste(colnames(data1),"spn_vassoc", sep="_")
data2 <- read.table(file2, header=T)
colnames(data2) <- paste(colnames(data2),"spn_glm", sep="_")
data <- merge(data1, data2, by.x=c("VAR_spn_vassoc"),by.y=c("VAR_spn_glm"))
file3 <- paste(y,"ADRN_chr",chrom,"_761_filled_filtered_AD_NA_vassoc_excl_failed.out",sep="")
file4 <- paste(y,"ADRN_chr",chrom,"_761_filled_filtered_AD_NA_glm_excl_failed.out",sep="")
data3 <- read.table(file3, header=T)
colnames(data3) <- paste(colnames(data3),"adna_vassoc", sep="_")
data4 <- read.table(file4, header=T)
colnames(data4) <- paste(colnames(data4),"adna_glm", sep="_")
adna_data <- merge(data3, data4, by.x=c("VAR_adna_vassoc"),by.y=c("VAR_adna_glm"))
attach(data)
data$MAFF_spn_vassoc <- ifelse(MAF_spn_vassoc>0.5,(1-MAF_spn_vassoc),MAF_spn_vassoc)
data$P_Final_spn <- ifelse(data$MAFF_spn_vassoc<0.05, P_spn_vassoc, P_spn_glm)
detach(data)
attach(adna_data)
adna_data$MAFF_adna_vassoc <- ifelse(MAF_adna_vassoc>0.5,(1-MAF_adna_vassoc),MAF_adna_vassoc)
adna_data$P_Final_adna <- ifelse(adna_data$MAFF_adna_vassoc<0.05, P_adna_vassoc, P_adna_glm)
detach(adna_data)
hwe <- paste(y,"ADRN_chr",chrom,"_excl_failed_all_traits_SIG_hwe.txt",sep="")
lmiss <- paste(y,"ADRN_chr",chrom,"_761_SNPs_filled_GQ30_DP7_segdup_All_excl_failed.lmiss",sep="")
easi <- paste(y,"ADRN_chr",chrom,"_761_filled_filtered_EASI_AD_glm_excl_failed.out",sep="")
eos_ad <- paste(y,"ADRN_chr",chrom,"_761_filled_filtered_EOS_AD_glm_excl_failed.out",sep="")
eos_na <- paste(y,"ADRN_chr",chrom,"_761_filled_filtered_EOS_NA_glm_excl_failed.out",sep="")
ige_ad <- paste(y,"ADRN_chr",chrom,"_761_filled_filtered_IgE_AD_glm_excl_failed.out",sep="")
ige_na <- paste(y,"ADRN_chr",chrom,"_761_filled_filtered_IgE_NA_glm_excl_failed.out",sep="")
phad_ad <- paste(y,"ADRN_chr",chrom,"_761_filled_filtered_phad_AD_glm_excl_failed.out",sep="")
rl_ad <- paste(y,"ADRN_chr",chrom,"_761_filled_filtered_RL_AD_glm_excl_failed.out",sep="")
hwe_all_data <- read.table(hwe, header=T)
colnames(hwe_all_data) <- paste(colnames(hwe_all_data),"hwe_all", sep="_")
lmiss_all_data <- read.table(lmiss, header=T)
colnames(lmiss_all_data) <- paste(colnames(lmiss_all_data),"All", sep="_")
easi_data <- read.table(easi, header=T)
colnames(easi_data) <- paste(colnames(easi_data),"easi_ad", sep="_")
eos_ad_data <- read.table(eos_ad, header=T)
colnames(eos_ad_data) <- paste(colnames(eos_ad_data),"eos_ad", sep="_")
eos_na_data <- read.table(eos_na, header=T)
colnames(eos_na_data) <- paste(colnames(eos_na_data),"eos_na", sep="_")
ige_ad_data <- read.table(ige_ad, header=T)
colnames(ige_ad_data) <- paste(colnames(ige_ad_data),"ige_ad", sep="_")
ige_na_data <- read.table(ige_na, header=T)
colnames(ige_na_data) <- paste(colnames(ige_na_data),"ige_na", sep="_")
phad_ad_data <- read.table(phad_ad, header=T)
colnames(phad_ad_data) <- paste(colnames(phad_ad_data),"phad_ad", sep="_")
rl_ad_data <- read.table(rl_ad, header=T)
colnames(rl_ad_data) <- paste(colnames(rl_ad_data),"rl_ad", sep="_")

spn_sig <- subset(data, P_Final_spn<0.05)
nrow(spn_sig)
data_adna <- merge(spn_sig, adna_data, by.x=c("VAR_spn_vassoc"),by.y=c("VAR_adna_vassoc"), all.x="TRUE")
data_adna_easi <- merge(data_adna, easi_data, by.x=c("VAR_spn_vassoc"),by.y=c("VAR_easi_ad"), all.x="TRUE")
data_adna_easi_eos <- merge(data_adna_easi, eos_ad_data, by.x=c("VAR_spn_vassoc"),by.y=c("VAR_eos_ad"), all.x="TRUE")
data_adna_easi_eos2 <- merge(data_adna_easi_eos, eos_na_data, by.x=c("VAR_spn_vassoc"),by.y=c("VAR_eos_na"), all.x="TRUE")
data_adna_easi_eos2_ige <- merge(data_adna_easi_eos2, ige_ad_data, by.x=c("VAR_spn_vassoc"),by.y=c("VAR_ige_ad"), all.x="TRUE")
data_adna_easi_eos2_ige2 <- merge(data_adna_easi_eos2_ige, ige_na_data, by.x=c("VAR_spn_vassoc"),by.y=c("VAR_ige_na"), all.x="TRUE")
data_adna_easi_eos2_ige2_phad <- merge(data_adna_easi_eos2_ige2, phad_ad_data, by.x=c("VAR_spn_vassoc"),by.y=c("VAR_phad_ad"), all.x="TRUE")
data_adna_easi_eos2_ige2_phad_rl <- merge(data_adna_easi_eos2_ige2_phad, rl_ad_data, by.x=c("VAR_spn_vassoc"),by.y=c("VAR_rl_ad"), all.x="TRUE")
spn_sig_no_qc <- data_adna_easi_eos2_ige2_phad_rl[c(1,2,7,14:21,30,31,33:35,48:55,64,65,67:69,74,75,77,82,83,85,90,91,93,98,99,101,106,107,109,114,115,117,122,123,125)]
#variants_spn_sig <- spn_sig_no_qc[1]
#variants_spn_sig_pos <- substr(variants_spn_sig$VAR,num,25)
spn_sig_no_qc$POS <- lapply(strsplit(as.character(spn_sig_no_qc$VAR_spn_vassoc), ":"),"[",2)
spn_sig_no_qc$POS <- as.numeric(spn_sig_no_qc$POS)

map <- paste(y,"ADRN_chr",chrom,"_excl_failed_all_traits_SIG.map",sep="")
map_file <- read.table(map)
hwe_all_map <- merge(hwe_all_data, map_file, by.x=c("SNP_hwe_all"),by.y=c("V2"))
colnames(hwe_all_map)[10] <- "CHR"
colnames(hwe_all_map)[11] <- "DIST"
colnames(hwe_all_map)[12] <- "POS"
hwe_all_map_sub <- hwe_all_map[c(2,12,1,9)]
#attach(spn_sig_no_qc)
#spn_sig_no_qc$POS <- as.numeric(variants_spn_sig_pos)
#detach(spn_sig_no_qc)
hwe_spn_sig_data <- merge(hwe_all_map_sub, spn_sig_no_qc, by="POS") 
hwe_lmiss_spn_sig_data <- merge(hwe_spn_sig_data, lmiss_all_data, by.x=c("POS"),by.y=c("POS_All"))
final_spn_sig <- hwe_lmiss_spn_sig_data[c(2,1,3,4,59,5:54)]

z<- paste(x,chrom,"/Annovar_fromTim_17_12_14/", sep="")
anno_file <- paste(z,"anno_input_chr",chrom,".txt.hg19_multianno.txt.gz",sep="")
anno <- read.delim(gzfile(anno_file), header=T, sep="\t")
anno_sub <- anno[c(1:7,9,10,12,23,24,27,31,34,37,40,43,46,48:52)]

final_spn_sig_anno <- merge(anno_sub, final_spn_sig, by.x=c("Start"), by.y=c("POS"))
final_spn_sig_anno2 <- final_spn_sig_anno[c(2,1,4:24,27:78)]
colnames(final_spn_sig_anno2)[2] <- "POS"
nrow(final_spn_sig_anno2)
result1 <- paste(y,"ADRN_chr",chrom,"_spn_sig_qc_anno.txt",sep="")
write.table(final_spn_sig_anno2,file=result1,sep="\t",quote=F,row.names=F)

adna_sig <- subset(adna_data, P_Final_adna<0.05)
nrow(adna_sig)
adna_data_spn <- merge(adna_sig, data, by.x=c("VAR_adna_vassoc"),by.y=c("VAR_spn_vassoc"), all.x="TRUE")
adna_data_spn_easi <- merge(adna_data_spn, easi_data, by.x=c("VAR_adna_vassoc"),by.y=c("VAR_easi_ad"), all.x="TRUE")
adna_data_spn_easi_eos <- merge(adna_data_spn_easi, eos_ad_data, by.x=c("VAR_adna_vassoc"),by.y=c("VAR_eos_ad"), all.x="TRUE")
adna_data_spn_easi_eos2 <- merge(adna_data_spn_easi_eos, eos_na_data, by.x=c("VAR_adna_vassoc"),by.y=c("VAR_eos_na"), all.x="TRUE")
adna_data_spn_easi_eos2_ige <- merge(adna_data_spn_easi_eos2, ige_ad_data, by.x=c("VAR_adna_vassoc"),by.y=c("VAR_ige_ad"), all.x="TRUE")
adna_data_spn_easi_eos2_ige2 <- merge(adna_data_spn_easi_eos2_ige, ige_na_data, by.x=c("VAR_adna_vassoc"),by.y=c("VAR_ige_na"), all.x="TRUE")
adna_data_spn_easi_eos2_ige2_phad <- merge(adna_data_spn_easi_eos2_ige2, phad_ad_data, by.x=c("VAR_adna_vassoc"),by.y=c("VAR_phad_ad"), all.x="TRUE")
adna_data_spn_easi_eos2_ige2_phad_rl <- merge(adna_data_spn_easi_eos2_ige2_phad, rl_ad_data, by.x=c("VAR_adna_vassoc"),by.y=c("VAR_rl_ad"), all.x="TRUE")
adna_sig_no_qc <- adna_data_spn_easi_eos2_ige2_phad_rl[c(1,2,7,14:21,30,31,33:35,48:55,64,65,67:69,74,75,77,82,83,85,90,91,93,98,99,101,106,107,109,114,115,117,122,123,125)]
#variants_adna_sig <- adna_sig_no_qc[1]
#variants_adna_sig_pos <- substr(variants_adna_sig$VAR,num,25)
#attach(adna_sig_no_qc)
#adna_sig_no_qc$POS <- as.numeric(variants_adna_sig_pos)
#detach(adna_sig_no_qc)

adna_sig_no_qc$POS <- lapply(strsplit(as.character(adna_sig_no_qc$VAR_adna_vassoc), ":"),"[",2)
adna_sig_no_qc$POS <- as.numeric(adna_sig_no_qc$POS)

hwe_adna_sig_data <- merge(hwe_all_map_sub, adna_sig_no_qc, by="POS") 
hwe_lmiss_adna_sig_data <- merge(hwe_adna_sig_data, lmiss_all_data, by.x=c("POS"),by.y=c("POS_All"))
final_adna_sig <- hwe_lmiss_adna_sig_data[c(2,1,3,4,59,5:54)]
final_adna_sig_anno <- merge(anno_sub, final_adna_sig, by.x=c("Start"), by.y=c("POS"))
final_adna_sig_anno2 <- final_adna_sig_anno[c(2,1,4:24,27:78)]
colnames(final_adna_sig_anno2)[2] <- "POS"
nrow(final_adna_sig_anno2)
result2 <- paste(y,"ADRN_chr",chrom,"_adna_sig_qc_anno.txt",sep="")
write.table(final_adna_sig_anno2,file=result2,sep="\t",quote=F,row.names=F)

easi_sig <- subset(easi_data, P_easi_ad<0.05)
nrow(easi_sig)
easi_data_spn <- merge(easi_sig, data, by.x=c("VAR_easi_ad"),by.y=c("VAR_spn_vassoc"), all.x="TRUE")
easi_data_spn_adna <- merge(easi_data_spn, adna_data, by.x=c("VAR_easi_ad"),by.y=c("VAR_adna_vassoc"), all.x="TRUE")
easi_data_spn_adna_eos <- merge(easi_data_spn_adna, eos_ad_data, by.x=c("VAR_easi_ad"),by.y=c("VAR_eos_ad"), all.x="TRUE")
easi_data_spn_adna_eos2 <- merge(easi_data_spn_adna_eos, eos_na_data, by.x=c("VAR_easi_ad"),by.y=c("VAR_eos_na"), all.x="TRUE")
easi_data_spn_adna_eos2_ige <- merge(easi_data_spn_adna_eos2, ige_ad_data, by.x=c("VAR_easi_ad"),by.y=c("VAR_ige_ad"), all.x="TRUE")
easi_data_spn_adna_eos2_ige2 <- merge(easi_data_spn_adna_eos2_ige, ige_na_data, by.x=c("VAR_easi_ad"),by.y=c("VAR_ige_na"), all.x="TRUE")
easi_data_spn_adna_eos2_ige2_phad <- merge(easi_data_spn_adna_eos2_ige2, phad_ad_data, by.x=c("VAR_easi_ad"),by.y=c("VAR_phad_ad"), all.x="TRUE")
easi_data_spn_adna_eos2_ige2_phad_rl <- merge(easi_data_spn_adna_eos2_ige2_phad, rl_ad_data, by.x=c("VAR_easi_ad"),by.y=c("VAR_rl_ad"), all.x="TRUE")
easi_sig_no_qc <- easi_data_spn_adna_eos2_ige2_phad_rl[c(1,2,3,6,7,9,22:29,38,39,41:43,56:63,72,73,75:77,82,83,85,90,91,93,98,99,101,106,107,109,114,115,117,122,123,125)]
#variants_easi_sig <- easi_sig_no_qc[1]
#variants_easi_sig_pos <- substr(variants_easi_sig$VAR,num,25)

#attach(easi_sig_no_qc)
#easi_sig_no_qc$POS <- as.numeric(variants_easi_sig_pos)
#detach(easi_sig_no_qc)

easi_sig_no_qc$POS <- lapply(strsplit(as.character(easi_sig_no_qc$VAR_easi_ad), ":"),"[",2)
easi_sig_no_qc$POS <- as.numeric(easi_sig_no_qc$POS)

hwe_easi_sig_data <- merge(hwe_all_map_sub, easi_sig_no_qc, by="POS") 
hwe_lmiss_easi_sig_data <- merge(hwe_easi_sig_data, lmiss_all_data, by.x=c("POS"),by.y=c("POS_All"))
final_easi_sig <- hwe_lmiss_easi_sig_data[c(2,1,3,4,59,5:54)]
final_easi_sig_anno <- merge(anno_sub, final_easi_sig, by.x=c("Start"), by.y=c("POS"))
final_easi_sig_anno2 <- final_easi_sig_anno[c(2,1,4:24,27:78)]
colnames(final_easi_sig_anno2)[2] <- "POS"
nrow(final_easi_sig_anno2)
result3 <- paste(y,"ADRN_chr",chrom,"_easi_ad_sig_qc_anno.txt",sep="")
write.table(final_easi_sig_anno2,file=result3,sep="\t",quote=F,row.names=F)

eos_ad_sig <- subset(eos_ad_data, P_eos_ad<0.05)
nrow(eos_ad_sig)
eos_ad_data_spn <- merge(eos_ad_sig, data, by.x=c("VAR_eos_ad"),by.y=c("VAR_spn_vassoc"), all.x="TRUE")
eos_ad_data_spn_adna <- merge(eos_ad_data_spn, adna_data, by.x=c("VAR_eos_ad"),by.y=c("VAR_adna_vassoc"), all.x="TRUE")
eos_ad_data_spn_adna_easi <- merge(eos_ad_data_spn_adna, easi_data, by.x=c("VAR_eos_ad"),by.y=c("VAR_easi_ad"), all.x="TRUE")
eos_ad_data_spn_adna_eos2 <- merge(eos_ad_data_spn_adna_easi, eos_na_data, by.x=c("VAR_eos_ad"),by.y=c("VAR_eos_na"), all.x="TRUE")
eos_ad_data_spn_adna_eos2_ige <- merge(eos_ad_data_spn_adna_eos2, ige_ad_data, by.x=c("VAR_eos_ad"),by.y=c("VAR_ige_ad"), all.x="TRUE")
eos_ad_data_spn_adna_eos2_ige2 <- merge(eos_ad_data_spn_adna_eos2_ige, ige_na_data, by.x=c("VAR_eos_ad"),by.y=c("VAR_ige_na"), all.x="TRUE")
eos_ad_data_spn_adna_eos2_ige2_phad <- merge(eos_ad_data_spn_adna_eos2_ige2, phad_ad_data, by.x=c("VAR_eos_ad"),by.y=c("VAR_phad_ad"), all.x="TRUE")
eos_ad_data_spn_adna_eos2_ige2_phad_rl <- merge(eos_ad_data_spn_adna_eos2_ige2_phad, rl_ad_data, by.x=c("VAR_eos_ad"),by.y=c("VAR_rl_ad"), all.x="TRUE")
eos_ad_sig_no_qc <- eos_ad_data_spn_adna_eos2_ige2_phad_rl[c(1,2,3,6,7,9,22:29,38,39,41:43,56:63,72,73,75:77,82,83,85,90,91,93,98,99,101,106,107,109,114,115,117,122,123,125)]
#variants_eos_ad_sig <- eos_ad_sig_no_qc[1]
#variants_eos_ad_sig_pos <- substr(variants_eos_ad_sig$VAR,num,25)

#attach(eos_ad_sig_no_qc)
#eos_ad_sig_no_qc$POS <- as.numeric(variants_eos_ad_sig_pos)
#detach(eos_ad_sig_no_qc)

eos_ad_sig_no_qc$POS <- lapply(strsplit(as.character(eos_ad_sig_no_qc$VAR_eos_ad), ":"),"[",2)
eos_ad_sig_no_qc$POS <- as.numeric(eos_ad_sig_no_qc$POS)

hwe_eos_ad_sig_data <- merge(hwe_all_map_sub, eos_ad_sig_no_qc, by="POS") 
hwe_lmiss_eos_ad_sig_data <- merge(hwe_eos_ad_sig_data, lmiss_all_data, by.x=c("POS"),by.y=c("POS_All"))
final_eos_ad_sig <- hwe_lmiss_eos_ad_sig_data[c(2,1,3,4,59,5:54)]
final_eos_ad_sig_anno <- merge(anno_sub, final_eos_ad_sig, by.x=c("Start"), by.y=c("POS"))
final_eos_ad_sig_anno2 <- final_eos_ad_sig_anno[c(2,1,4:24,27:78)]
colnames(final_eos_ad_sig_anno2)[2] <- "POS"
nrow(final_eos_ad_sig_anno2)
result4 <- paste(y,"ADRN_chr",chrom,"_eos_ad_sig_qc_anno.txt",sep="")
write.table(final_eos_ad_sig_anno2,file=result4,sep="\t",quote=F,row.names=F)

eos_na_sig <- subset(eos_na_data, P_eos_na<0.05)
nrow(eos_na_sig)
eos_na_data_spn <- merge(eos_na_sig, data, by.x=c("VAR_eos_na"),by.y=c("VAR_spn_vassoc"), all.x="TRUE")
eos_na_data_spn_adna <- merge(eos_na_data_spn, adna_data, by.x=c("VAR_eos_na"),by.y=c("VAR_adna_vassoc"), all.x="TRUE")
eos_na_data_spn_adna_easi <- merge(eos_na_data_spn_adna, easi_data, by.x=c("VAR_eos_na"),by.y=c("VAR_easi_ad"), all.x="TRUE")
eos_na_data_spn_adna_eos2 <- merge(eos_na_data_spn_adna_easi, eos_ad_data, by.x=c("VAR_eos_na"),by.y=c("VAR_eos_ad"), all.x="TRUE")
eos_na_data_spn_adna_eos2_ige <- merge(eos_na_data_spn_adna_eos2, ige_ad_data, by.x=c("VAR_eos_na"),by.y=c("VAR_ige_ad"), all.x="TRUE")
eos_na_data_spn_adna_eos2_ige2 <- merge(eos_na_data_spn_adna_eos2_ige, ige_na_data, by.x=c("VAR_eos_na"),by.y=c("VAR_ige_na"), all.x="TRUE")
eos_na_data_spn_adna_eos2_ige2_phad <- merge(eos_na_data_spn_adna_eos2_ige2, phad_ad_data, by.x=c("VAR_eos_na"),by.y=c("VAR_phad_ad"), all.x="TRUE")
eos_na_data_spn_adna_eos2_ige2_phad_rl <- merge(eos_na_data_spn_adna_eos2_ige2_phad, rl_ad_data, by.x=c("VAR_eos_na"),by.y=c("VAR_rl_ad"), all.x="TRUE")
eos_na_sig_no_qc <- eos_na_data_spn_adna_eos2_ige2_phad_rl[c(1,2,3,6,7,9,22:29,38,39,41:43,56:63,72,73,75:77,82,83,85,90,91,93,98,99,101,106,107,109,114,115,117,122,123,125)]
#variants_eos_na_sig <- eos_na_sig_no_qc[1]
#variants_eos_na_sig_pos <- substr(variants_eos_na_sig$VAR,num,25)

#attach(eos_na_sig_no_qc)
#eos_na_sig_no_qc$POS <- as.numeric(variants_eos_na_sig_pos)
#detach(eos_na_sig_no_qc)

eos_na_sig_no_qc$POS <- lapply(strsplit(as.character(eos_na_sig_no_qc$VAR_eos_na), ":"),"[",2)
eos_na_sig_no_qc$POS <- as.numeric(eos_na_sig_no_qc$POS)

hwe_eos_na_sig_data <- merge(hwe_all_map_sub, eos_na_sig_no_qc, by="POS") 
hwe_lmiss_eos_na_sig_data <- merge(hwe_eos_na_sig_data, lmiss_all_data, by.x=c("POS"),by.y=c("POS_All"))
final_eos_na_sig <- hwe_lmiss_eos_na_sig_data[c(2,1,3,4,59,5:54)]
final_eos_na_sig_anno <- merge(anno_sub, final_eos_na_sig, by.x=c("Start"), by.y=c("POS"))
final_eos_na_sig_anno2 <- final_eos_na_sig_anno[c(2,1,4:24,27:78)]
colnames(final_eos_na_sig_anno2)[2] <- "POS"
nrow(final_eos_na_sig_anno2)
result5 <- paste(y,"ADRN_chr",chrom,"_eos_na_sig_qc_anno.txt",sep="")
write.table(final_eos_na_sig_anno2,file=result5,sep="\t",quote=F,row.names=F)

ige_ad_sig <- subset(ige_ad_data, P_ige_ad<0.05)
nrow(ige_ad_sig)
ige_ad_data_spn <- merge(ige_ad_sig, data, by.x=c("VAR_ige_ad"),by.y=c("VAR_spn_vassoc"), all.x="TRUE")
ige_ad_data_spn_adna <- merge(ige_ad_data_spn, adna_data, by.x=c("VAR_ige_ad"),by.y=c("VAR_adna_vassoc"), all.x="TRUE")
ige_ad_data_spn_adna_easi <- merge(ige_ad_data_spn_adna, easi_data, by.x=c("VAR_ige_ad"),by.y=c("VAR_easi_ad"), all.x="TRUE")
ige_ad_data_spn_adna_eos <- merge(ige_ad_data_spn_adna_easi, eos_ad_data, by.x=c("VAR_ige_ad"),by.y=c("VAR_eos_ad"), all.x="TRUE")
ige_ad_data_spn_adna_eos2 <- merge(ige_ad_data_spn_adna_eos, eos_na_data, by.x=c("VAR_ige_ad"),by.y=c("VAR_eos_na"), all.x="TRUE")
ige_ad_data_spn_adna_eos2_ige2 <- merge(ige_ad_data_spn_adna_eos2, ige_na_data, by.x=c("VAR_ige_ad"),by.y=c("VAR_ige_na"), all.x="TRUE")
ige_ad_data_spn_adna_eos2_ige2_phad <- merge(ige_ad_data_spn_adna_eos2_ige2, phad_ad_data, by.x=c("VAR_ige_ad"),by.y=c("VAR_phad_ad"), all.x="TRUE")
ige_ad_data_spn_adna_eos2_ige2_phad_rl <- merge(ige_ad_data_spn_adna_eos2_ige2_phad, rl_ad_data, by.x=c("VAR_ige_ad"),by.y=c("VAR_rl_ad"), all.x="TRUE")
ige_ad_sig_no_qc <- ige_ad_data_spn_adna_eos2_ige2_phad_rl[c(1,2,3,6,7,9,22:29,38,39,41:43,56:63,72,73,75:77,82,83,85,90,91,93,98,99,101,106,107,109,114,115,117,122,123,125)]
#variants_ige_ad_sig <- ige_ad_sig_no_qc[1]
#variants_ige_ad_sig_pos <- substr(variants_ige_ad_sig$VAR,num,25)

#attach(ige_ad_sig_no_qc)
#ige_ad_sig_no_qc$POS <- as.numeric(variants_ige_ad_sig_pos)
#detach(ige_ad_sig_no_qc)

ige_ad_sig_no_qc$POS <- lapply(strsplit(as.character(ige_ad_sig_no_qc$VAR_ige_ad), ":"),"[",2)
ige_ad_sig_no_qc$POS <- as.numeric(ige_ad_sig_no_qc$POS)

hwe_ige_ad_sig_data <- merge(hwe_all_map_sub, ige_ad_sig_no_qc, by="POS") 
hwe_lmiss_ige_ad_sig_data <- merge(hwe_ige_ad_sig_data, lmiss_all_data, by.x=c("POS"),by.y=c("POS_All"))
final_ige_ad_sig <- hwe_lmiss_ige_ad_sig_data[c(2,1,3,4,59,5:54)]
final_ige_ad_sig_anno <- merge(anno_sub, final_ige_ad_sig, by.x=c("Start"), by.y=c("POS"))
final_ige_ad_sig_anno2 <- final_ige_ad_sig_anno[c(2,1,4:24,27:78)]
colnames(final_ige_ad_sig_anno2)[2] <- "POS"
nrow(final_ige_ad_sig_anno2)
result6 <- paste(y,"ADRN_chr",chrom,"_ige_ad_sig_qc_anno.txt",sep="")
write.table(final_ige_ad_sig_anno2,file=result6,sep="\t",quote=F,row.names=F)


ige_na_sig <- subset(ige_na_data, P_ige_na<0.05)
nrow(ige_na_sig)
ige_na_data_spn <- merge(ige_na_sig, data, by.x=c("VAR_ige_na"),by.y=c("VAR_spn_vassoc"), all.x="TRUE")
ige_na_data_spn_adna <- merge(ige_na_data_spn, adna_data, by.x=c("VAR_ige_na"),by.y=c("VAR_adna_vassoc"), all.x="TRUE")
ige_na_data_spn_adna_easi <- merge(ige_na_data_spn_adna, easi_data, by.x=c("VAR_ige_na"),by.y=c("VAR_easi_ad"), all.x="TRUE")
ige_na_data_spn_adna_eos <- merge(ige_na_data_spn_adna_easi, eos_ad_data, by.x=c("VAR_ige_na"),by.y=c("VAR_eos_ad"), all.x="TRUE")
ige_na_data_spn_adna_eos2 <- merge(ige_na_data_spn_adna_eos, eos_na_data, by.x=c("VAR_ige_na"),by.y=c("VAR_eos_na"), all.x="TRUE")
ige_na_data_spn_adna_eos2_ige2 <- merge(ige_na_data_spn_adna_eos2, ige_ad_data, by.x=c("VAR_ige_na"),by.y=c("VAR_ige_ad"), all.x="TRUE")
ige_na_data_spn_adna_eos2_ige2_phad <- merge(ige_na_data_spn_adna_eos2_ige2, phad_ad_data, by.x=c("VAR_ige_na"),by.y=c("VAR_phad_ad"), all.x="TRUE")
ige_na_data_spn_adna_eos2_ige2_phad_rl <- merge(ige_na_data_spn_adna_eos2_ige2_phad, rl_ad_data, by.x=c("VAR_ige_na"),by.y=c("VAR_rl_ad"), all.x="TRUE")
ige_na_sig_no_qc <- ige_na_data_spn_adna_eos2_ige2_phad_rl[c(1,2,3,6,7,9,22:29,38,39,41:43,56:63,72,73,75:77,82,83,85,90,91,93,98,99,101,106,107,109,114,115,117,122,123,125)]
#variants_ige_na_sig <- ige_na_sig_no_qc[1]
#variants_ige_na_sig_pos <- substr(variants_ige_na_sig$VAR,num,25)

#attach(ige_na_sig_no_qc)
#ige_na_sig_no_qc$POS <- as.numeric(variants_ige_na_sig_pos)
#detach(ige_na_sig_no_qc)

ige_na_sig_no_qc$POS <- lapply(strsplit(as.character(ige_na_sig_no_qc$VAR_ige_na), ":"),"[",2)
ige_na_sig_no_qc$POS <- as.numeric(ige_na_sig_no_qc$POS)

hwe_ige_na_sig_data <- merge(hwe_all_map_sub, ige_na_sig_no_qc, by="POS") 
hwe_lmiss_ige_na_sig_data <- merge(hwe_ige_na_sig_data, lmiss_all_data, by.x=c("POS"),by.y=c("POS_All"))
final_ige_na_sig <- hwe_lmiss_ige_na_sig_data[c(2,1,3,4,59,5:54)]
final_ige_na_sig_anno <- merge(anno_sub, final_ige_na_sig, by.x=c("Start"), by.y=c("POS"))
final_ige_na_sig_anno2 <- final_ige_na_sig_anno[c(2,1,4:24,27:78)]
colnames(final_ige_na_sig_anno2)[2] <- "POS"
nrow(final_ige_na_sig_anno2)
result7 <- paste(y,"ADRN_chr",chrom,"_ige_na_sig_qc_anno.txt",sep="")
write.table(final_ige_na_sig_anno2,file=result7,sep="\t",quote=F,row.names=F)


phad_ad_sig <- subset(phad_ad_data, P_phad_ad<0.05)
nrow(phad_ad_sig)
phad_ad_data_spn <- merge(phad_ad_sig, data, by.x=c("VAR_phad_ad"),by.y=c("VAR_spn_vassoc"), all.x="TRUE")
phad_ad_data_spn_adna <- merge(phad_ad_data_spn, adna_data, by.x=c("VAR_phad_ad"),by.y=c("VAR_adna_vassoc"), all.x="TRUE")
phad_ad_data_spn_adna_easi <- merge(phad_ad_data_spn_adna, easi_data, by.x=c("VAR_phad_ad"),by.y=c("VAR_easi_ad"), all.x="TRUE")
phad_ad_data_spn_adna_eos <- merge(phad_ad_data_spn_adna_easi, eos_ad_data, by.x=c("VAR_phad_ad"),by.y=c("VAR_eos_ad"), all.x="TRUE")
phad_ad_data_spn_adna_eos2 <- merge(phad_ad_data_spn_adna_eos, eos_na_data, by.x=c("VAR_phad_ad"),by.y=c("VAR_eos_na"), all.x="TRUE")
phad_ad_data_spn_adna_eos2_ige <- merge(phad_ad_data_spn_adna_eos2, ige_ad_data, by.x=c("VAR_phad_ad"),by.y=c("VAR_ige_ad"), all.x="TRUE")
phad_ad_data_spn_adna_eos2_ige2 <- merge(phad_ad_data_spn_adna_eos2_ige, ige_na_data, by.x=c("VAR_phad_ad"),by.y=c("VAR_ige_na"), all.x="TRUE")
phad_ad_data_spn_adna_eos2_ige2_rl <- merge(phad_ad_data_spn_adna_eos2_ige2, rl_ad_data, by.x=c("VAR_phad_ad"),by.y=c("VAR_rl_ad"), all.x="TRUE")
phad_ad_sig_no_qc <- phad_ad_data_spn_adna_eos2_ige2_rl[c(1,2,3,6,7,9,22:29,38,39,41:43,56:63,72,73,75:77,82,83,85,90,91,93,98,99,101,106,107,109,114,115,117,122,123,125)]
#variants_phad_ad_sig <- phad_ad_sig_no_qc[1]
#variants_phad_ad_sig_pos <- substr(variants_phad_ad_sig$VAR,num,25)

#attach(phad_ad_sig_no_qc)
#phad_ad_sig_no_qc$POS <- as.numeric(variants_phad_ad_sig_pos)
#detach(phad_ad_sig_no_qc)

phad_ad_sig_no_qc$POS <- lapply(strsplit(as.character(phad_ad_sig_no_qc$VAR_phad_ad), ":"),"[",2)
phad_ad_sig_no_qc$POS <- as.numeric(phad_ad_sig_no_qc$POS)

hwe_phad_ad_sig_data <- merge(hwe_all_map_sub, phad_ad_sig_no_qc, by="POS") 
hwe_lmiss_phad_ad_sig_data <- merge(hwe_phad_ad_sig_data, lmiss_all_data, by.x=c("POS"),by.y=c("POS_All"))
final_phad_ad_sig <- hwe_lmiss_phad_ad_sig_data[c(2,1,3,4,59,5:54)]
final_phad_ad_sig_anno <- merge(anno_sub, final_phad_ad_sig, by.x=c("Start"), by.y=c("POS"))
final_phad_ad_sig_anno2 <- final_phad_ad_sig_anno[c(2,1,4:24,27:78)]
colnames(final_phad_ad_sig_anno2)[2] <- "POS"
nrow(final_phad_ad_sig_anno2)
result8 <- paste(y,"ADRN_chr",chrom,"_phad_ad_sig_qc_anno.txt",sep="")
write.table(final_phad_ad_sig_anno2,file=result8,sep="\t",quote=F,row.names=F)


rl_ad_sig <- subset(rl_ad_data, P_rl_ad<0.05)
nrow(rl_ad_sig)
rl_ad_data_spn <- merge(rl_ad_sig, data, by.x=c("VAR_rl_ad"),by.y=c("VAR_spn_vassoc"), all.x="TRUE")
rl_ad_data_spn_adna <- merge(rl_ad_data_spn, adna_data, by.x=c("VAR_rl_ad"),by.y=c("VAR_adna_vassoc"), all.x="TRUE")
rl_ad_data_spn_adna_easi <- merge(rl_ad_data_spn_adna, easi_data, by.x=c("VAR_rl_ad"),by.y=c("VAR_easi_ad"), all.x="TRUE")
rl_ad_data_spn_adna_eos <- merge(rl_ad_data_spn_adna_easi, eos_ad_data, by.x=c("VAR_rl_ad"),by.y=c("VAR_eos_ad"), all.x="TRUE")
rl_ad_data_spn_adna_eos2 <- merge(rl_ad_data_spn_adna_eos, eos_na_data, by.x=c("VAR_rl_ad"),by.y=c("VAR_eos_na"), all.x="TRUE")
rl_ad_data_spn_adna_eos2_ige <- merge(rl_ad_data_spn_adna_eos2, ige_ad_data, by.x=c("VAR_rl_ad"),by.y=c("VAR_ige_ad"), all.x="TRUE")
rl_ad_data_spn_adna_eos2_ige2 <- merge(rl_ad_data_spn_adna_eos2_ige, ige_na_data, by.x=c("VAR_rl_ad"),by.y=c("VAR_ige_na"), all.x="TRUE")
rl_ad_data_spn_adna_eos2_ige2_phad <- merge(rl_ad_data_spn_adna_eos2_ige2, phad_ad_data, by.x=c("VAR_rl_ad"),by.y=c("VAR_phad_ad"), all.x="TRUE")
rl_ad_sig_no_qc <- rl_ad_data_spn_adna_eos2_ige2_phad[c(1,2,3,6,7,9,22:29,38,39,41:43,56:63,72,73,75:77,82,83,85,90,91,93,98,99,101,106,107,109,114,115,117,122,123,125)]
#variants_rl_ad_sig <- rl_ad_sig_no_qc[1]
#variants_rl_ad_sig_pos <- substr(variants_rl_ad_sig$VAR,num,25)

#attach(rl_ad_sig_no_qc)
#rl_ad_sig_no_qc$POS <- as.numeric(variants_rl_ad_sig_pos)
#detach(rl_ad_sig_no_qc)

rl_ad_sig_no_qc$POS <- lapply(strsplit(as.character(rl_ad_sig_no_qc$VAR_rl_ad), ":"),"[",2)
rl_ad_sig_no_qc$POS <- as.numeric(rl_ad_sig_no_qc$POS)

hwe_rl_ad_sig_data <- merge(hwe_all_map_sub, rl_ad_sig_no_qc, by="POS") 
hwe_lmiss_rl_ad_sig_data <- merge(hwe_rl_ad_sig_data, lmiss_all_data, by.x=c("POS"),by.y=c("POS_All"))
final_rl_ad_sig <- hwe_lmiss_rl_ad_sig_data[c(2,1,3,4,59,5:54)]
final_rl_ad_sig_anno <- merge(anno_sub, final_rl_ad_sig, by.x=c("Start"), by.y=c("POS"))
final_rl_ad_sig_anno2 <- final_rl_ad_sig_anno[c(2,1,4:24,27:78)]
colnames(final_rl_ad_sig_anno2)[2] <- "POS"
nrow(final_rl_ad_sig_anno2)
result9 <- paste(y,"ADRN_chr",chrom,"_rl_ad_sig_qc_anno.txt",sep="")
write.table(final_rl_ad_sig_anno2,file=result9,sep="\t",quote=F,row.names=F)

