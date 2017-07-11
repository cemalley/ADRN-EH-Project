library(data.table)
library(stringr)
# Author: Claire Malley
# Date: July 11, 2017
# Purpose: generate four variant/gene sets for running in SKAT-O. Takes a PSEQ output file merged on phenotype comparison, and annotation data that is currently split by chromosome.


# load pseq
  setwd("/dcl01/mathias1/data/ADRN_799_multiVCF_filled_filtered/assoc")
  pseq <- fread("ADRN_AD_NA_merged_qc_clean.txt", sep=" ", header=T, select=c(3, 36, 37))
  pseq[, c("Chr", "Start") := tstrsplit(VAR_vassoc_adna, ":")]
  pseq[, Start := as.numeric(Start)]
  pseq[, VAR_vassoc_adna := NULL]
  pseq <- pseq[P_Final_adna <= 0.001,]
  gc()
#chrs <- c("01", "02", "03", "04", "05", "06", "07", "08", "09", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20", "21", "22")

  #testing
chrs <- c("21")

for (chr in chrs){
  # load anno
  setwd("/dcl01/mathias1/data/ADRN_799_multiVCF_filled_filtered/anno")
  file <- paste0("ADRN_799_chr", chr, ".table.hg19_multianno.txt")
  anno <- fread(file, header=F, stringsAsFactors = F, sep="\t", skip=1L, select=c(1:77))
  names(anno) <- unlist(fread("multianno-header.txt", header=F), use.names=F)[1:77]
  anno <- anno[,c("Chr", "Start", "Gene.refGene", "Func.refGene", "ExonicFunc.refGene", "1000g2015aug_eur", "Polyphen2_HDIV_pred", "SIFT_pred")]
  anno[, novelty := ifelse((`1000g2015aug_eur`=="."| is.na(`1000g2015aug_eur`)), "novel", "known")]
  anno[, rarity := ifelse((`1000g2015aug_eur`<= 0.05), "rare", "common")]

  anno <- merge(anno, pseq[Chr ==paste0("chr", chr),], by=c("Chr", "Start"), all.x=F, all.y=T)

  #1. nonsynonymous
  nonsyn <- anno[(ExonicFunc.refGene =="nonsynonymous SNV" | ExonicFunc.refGene =="stopgain" | ExonicFunc.refGene =="stoploss"), c("Chr", "Start", "Gene.refGene")]

  #2. rare or novel
  rare.novel <- anno[(rarity == "rare" | novelty == "novel"), c("Chr", "Start", "Gene.refGene")]

  #3. nonsynonymous, damaging
  nonsyn.damaging <- anno[((ExonicFunc.refGene =="nonsynonymous SNV" | ExonicFunc.refGene =="stopgain" | ExonicFunc.refGene =="stoploss") & (Polyphen2_HDIV_pred == "D" | SIFT_pred == "D")), c("Chr", "Start", "Gene.refGene")]

  #4. rare or novel, damaging
  rare.novel.damaging <- anno[((ExonicFunc.refGene =="nonsynonymous SNV" | ExonicFunc.refGene =="stopgain" | ExonicFunc.refGene =="stoploss") & (Polyphen2_HDIV_pred == "D" | SIFT_pred == "D")), c("Chr", "Start", "Gene.refGene")]

  # split any multi-gene annotations into separate rows
  splitgene <- function(x){
    #Based on Meher Boorgula code
    wk.dt <- as.data.frame(x)
    varset_final <- data.frame(wk.dt$Chr, wk.dt$Start, do.call(rbind, str_split(wk.dt$Gene.refGene, ",")))
    for(i in 3:length(varset_final)) {colnames(varset_final)[i] <- "Gene.refGene"}
    varset_list <- data.frame()
    for(i in 1:(length(varset_final)-2)) {
      varset_append <- varset_final[,c(1,2,(i+2))]
      varset_list <- rbind(varset_list, varset_append)
    }
    varset_list <- unique(varset_list)
    varset_list <- subset(varset_list, Gene.refGene != "NONE")
    return(as.data.table(varset_list))
  }

  if (any(str_detect(nonsyn$Gene.refGene, ","))){nonsyn <- splitgene(nonsyn)}
  if (any(str_detect(rare.novel$Gene.refGene, ","))){rare.novel <- splitgene(rare.novel)}
  if (any(str_detect(nonsyn.damaging$Gene.refGene, ","))){nonsyn.damaging <- splitgene(nonsyn.damaging)}
  if (any(str_detect(rare.novel.damaging$Gene.refGene, ","))){rare.novel.damaging <- splitgene(rare.novel.damaging)}

  #write sets
  setwd("/dcl01/mathias1/data/ADRN_799_multiVCF_filled_filtered/anno/burden")
  write.table(nonsyn, paste0("Varset1.", chr, ".ADNA.txt"), sep="\t", col.names = F, row.names = F, quote=F)
  write.table(rare.novel, paste0("Varset2.", chr, ".ADNA.txt"), sep="\t", col.names = F, row.names = F, quote=F)
  write.table(nonsyn.damaging, paste0("Varset3.", chr, ".ADNA.txt"), sep="\t", col.names = F, row.names = F, quote=F)
  write.table(rare.novel.damaging, paste0("Varset4.", chr, ".ADNA.txt"), sep="\t", col.names = F, row.names = F, quote=F)

  #clean up
  rm(anno, nonsyn, nonsyn.damaging, rare.novel, rare.novel.damaging)
  gc()
}

q(save="no")
