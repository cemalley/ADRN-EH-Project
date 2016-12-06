# Program name: subset_multiannos.R
# Programmer: Claire Malley
# Date: December 6, 2016
# Description: This is the first step of analysis of Annovar annotation data. It subsets annotation files for damaging sites, in either the union or intersection of two databases, SIFT and PolyPhen 2. It is only applicable to SNPs, since indels are not part of either database. The output are headerless tables containing only chromosome and position for each variant. These tables are then used to subset VCF files in bcftools.

# libraries

library(data.table)


# select damaging variants in multianno ----------------------------
setwd("/dcl01/mathias/data/ADRN_EH/common_analysis/annotation/Illumina-snps")

EH.m.files <- Sys.glob("EH*\\.hg19_multianno.csv")
ADNA.m.files <- Sys.glob("ADNA*\\.table.hg19_multianno.csv")

if(exists("EH.m.data")){rm(EH.m.data)}
if(exists("ADNA.m.data")){rm(ADNA.m.data)}

# D | D = union
# D & D = intersection

for (EH.m.file in EH.m.files){
  if (!exists("EH.m.data")){
    EH.m.data <- fread(EH.m.file, sep=",", header=TRUE, stringsAsFactors=FALSE, data.table=FALSE)
    EH.m.data <- subset(EH.m.data, EH.m.data$SIFT_pred == 'D' | EH.m.data$Polyphen2_HDIV_pred == 'D', select = c("Chr", "Start", "End", "Ref", "Alt", "Func.refGene", "Gene.refGene", "ExonicFunc.refGene", "AAChange.refGene", "snp147", "SIFT_pred", "Polyphen2_HDIV_pred", "1000g2015aug_all"))
  }
  
  else {
    EH.m.data.temp <- fread(EH.m.file, sep=",", header=TRUE, stringsAsFactors=FALSE, data.table=FALSE)
    EH.m.data.temp <- subset(EH.m.data.temp, EH.m.data.temp$SIFT_pred == 'D' | EH.m.data.temp$Polyphen2_HDIV_pred == 'D', select = c("Chr", "Start", "End", "Ref", "Alt", "Func.refGene", "Gene.refGene", "ExonicFunc.refGene", "AAChange.refGene", "snp147", "SIFT_pred", "Polyphen2_HDIV_pred", "1000g2015aug_all"))
    EH.m.data <- rbind(EH.m.data, EH.m.data.temp)
    rm(EH.m.data.temp)
  }
}

EH.m.data <- unique(EH.m.data)

for (ADNA.m.file in ADNA.m.files){
  if(!exists("ADNA.m.data")){
    ADNA.m.data <- fread(ADNA.m.file, sep=",", header=TRUE, stringsAsFactors=FALSE, data.table=FALSE)
    ADNA.m.data <- subset(ADNA.m.data, ADNA.m.data$SIFT_pred == 'D' | ADNA.m.data$Polyphen2_HDIV_pred == 'D', select = c("Chr", "Start", "End", "Ref", "Alt", "Func.refGene", "Gene.refGene", "ExonicFunc.refGene", "AAChange.refGene", "snp147", "SIFT_pred", "Polyphen2_HDIV_pred", "1000g2015aug_all"))
  }
  
  else {
    ADNA.m.data.temp <- fread(ADNA.m.file, sep=",", header=TRUE, stringsAsFactors=FALSE, data.table=FALSE)
    ADNA.m.data.temp <- subset(ADNA.m.data.temp, ADNA.m.data.temp$SIFT_pred == 'D' | ADNA.m.data.temp$Polyphen2_HDIV_pred == 'D', select = c("Chr", "Start", "End", "Ref", "Alt", "Func.refGene", "Gene.refGene", "ExonicFunc.refGene", "AAChange.refGene", "snp147", "SIFT_pred", "Polyphen2_HDIV_pred", "1000g2015aug_all"))
    ADNA.m.data <- rbind(ADNA.m.data, ADNA.m.data.temp)
    rm(ADNA.m.data.temp)
  }
}

ADNA.m.data <- unique(ADNA.m.data)


# Subset multianno data to only chr, pos----------

ADNA.dpos <- subset(ADNA.m.data, select=c("Chr", "Start"))
EH.dpos <- subset(EH.m.data, select=c("Chr", "Start"))

setwd("/dcl01/mathias/data/ADRN_EH/common_analysis/annotation/Illumina-snps/union")
write.table(ADNA.dpos, "ADNA.dpos.union.csv", col.names=T, row.names = F, quote = F, sep="\t")
write.table(EH.dpos, "EH.dpos.union.csv", col.names=T, row.names = F, quote = F, sep="\t")


rm(EH.m.data, ADNA.m.data, ADNA.dpos, EH.dpos)

# Repeat ----------

setwd("/dcl01/mathias/data/ADRN_EH/common_analysis/annotation/Illumina-snps")

for (EH.m.file in EH.m.files){
  if (!exists("EH.m.data")){
    EH.m.data <- fread(EH.m.file, sep=",", header=TRUE, stringsAsFactors=FALSE, data.table=FALSE)
    EH.m.data <- subset(EH.m.data, EH.m.data$SIFT_pred == 'D' & EH.m.data$Polyphen2_HDIV_pred == 'D', select = c("Chr", "Start", "End", "Ref", "Alt", "Func.refGene", "Gene.refGene", "ExonicFunc.refGene", "AAChange.refGene", "snp147", "SIFT_pred", "Polyphen2_HDIV_pred", "1000g2015aug_all"))
  }
  
  else {
    EH.m.data.temp <- fread(EH.m.file, sep=",", header=TRUE, stringsAsFactors=FALSE, data.table=FALSE)
    EH.m.data.temp <- subset(EH.m.data.temp, EH.m.data.temp$SIFT_pred == 'D' & EH.m.data.temp$Polyphen2_HDIV_pred == 'D', select = c("Chr", "Start", "End", "Ref", "Alt", "Func.refGene", "Gene.refGene", "ExonicFunc.refGene", "AAChange.refGene", "snp147", "SIFT_pred", "Polyphen2_HDIV_pred", "1000g2015aug_all"))
    EH.m.data <- rbind(EH.m.data, EH.m.data.temp)
    rm(EH.m.data.temp)
  }
}

EH.m.data <- unique(EH.m.data)

for (ADNA.m.file in ADNA.m.files){
  if(!exists("ADNA.m.data")){
    ADNA.m.data <- fread(ADNA.m.file, sep=",", header=TRUE, stringsAsFactors=FALSE, data.table=FALSE)
    ADNA.m.data <- subset(ADNA.m.data, ADNA.m.data$SIFT_pred == 'D' & ADNA.m.data$Polyphen2_HDIV_pred == 'D', select = c("Chr", "Start", "End", "Ref", "Alt", "Func.refGene", "Gene.refGene", "ExonicFunc.refGene", "AAChange.refGene", "snp147", "SIFT_pred", "Polyphen2_HDIV_pred", "1000g2015aug_all"))
  }
  
  else {
    ADNA.m.data.temp <- fread(ADNA.m.file, sep=",", header=TRUE, stringsAsFactors=FALSE, data.table=FALSE)
    ADNA.m.data.temp <- subset(ADNA.m.data.temp, ADNA.m.data.temp$SIFT_pred == 'D' & ADNA.m.data.temp$Polyphen2_HDIV_pred == 'D', select = c("Chr", "Start", "End", "Ref", "Alt", "Func.refGene", "Gene.refGene", "ExonicFunc.refGene", "AAChange.refGene", "snp147", "SIFT_pred", "Polyphen2_HDIV_pred", "1000g2015aug_all"))
    ADNA.m.data <- rbind(ADNA.m.data, ADNA.m.data.temp)
    rm(ADNA.m.data.temp)
  }
}

ADNA.m.data <- unique(ADNA.m.data)


# Subset multianno data to only chr, pos----------

ADNA.dpos <- subset(ADNA.m.data, select=c("Chr", "Start"))
EH.dpos <- subset(EH.m.data, select=c("Chr", "Start"))

setwd("/dcl01/mathias/data/ADRN_EH/common_analysis/annotation/Illumina-snps/inter")
write.table(ADNA.dpos, "ADNA.dpos.inter.csv", col.names=T, row.names = F, quote = F, sep="\t")
write.table(EH.dpos, "EH.dpos.inter.csv", col.names=T, row.names = F, quote = F, sep="\t")


# quit ------------------------------------------------
q(save = "no")
