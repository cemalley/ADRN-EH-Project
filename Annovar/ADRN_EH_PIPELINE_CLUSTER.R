## Program name: ADNA_EH_PIPELINE.R
## Programmer: Claire Malley
## Created: September 21-26, 2016.
## Updated: November 21, 2016.
## Adapted for running entirely on the cluster: November 22-28, 2016.
## Purpose: This program takes annotation output from ANNOVAR plus the variant call files and counts carriers per variant and per gene. For SNPs, the program goes a step further to take only sites that are annotated as damaging in SIFT and PolyPhen 2, for both the union and intersection of these sets. Common SNPs in 1000 Genomes Project are also filtered out for SNPs (phase 3 release, the '1000g2015aug_all' database downloaded via Annovar). For indels, the program cannot consider damaging status, since SIFT and PolyPhen do not cover indels.
## Jargon: multianno = annotation output file from ANNOVAR. vcf = variant call file. EH are individuals with eczema herpeticum. ADNA = two groups, AD are individuals with atopic dermatitis, and NA are non-atopic individuals.
## Sample sizes: EH = 48, AD = 491, NA = 238.

# load required packages ---------------------
# if not installed, use:
# install.packages("data.table")
# install.packages("stringr")
# install.packages("plyr")
library(data.table)
library(stringr)
library(plyr)

# Working directory locations

# SNPs directory:
snps.dir <- "/dcl01/barnes/data/adrneh/anno"
#snps.dir="/Users/claire/Documents/adrneh/annovar/ADNA_EH_PIPELINE/nov17/snps"
#snps.dir="/dcl01/mathias/data/ADRN_EH/common_analysis/annotation/Illumina-snps"
#for ADNA snps:
#ADNA.vcf.dir="/dcl01/mathias/data/ADRN_EH/ADRN"
# ADNA indels: /dcl01/mathias/data/ADRN_EH/ADRN/transfer
#snps.union.dir="/dcl01/mathias/data/ADRN_EH/common_analysis/annotation/Illumina-snps/union"
#snps.inter.dir="/dcl01/mathias/data/ADRN_EH/common_analysis/annotation/Illumina-snps/inter"
#indels.dir="/dcl01/mathias/data/ADRN_EH/common_analysis/annotation/Illumina-indels"

#Local paths
# Indels directory
#indels.dir="/Users/claire/Documents/adrneh/annovar/ADNA_EH_PIPELINE/Illumina-indels"
# SNPs union directory
#snps.union.dir="/Users/claire/Documents/adrneh/annovar/ADNA_EH_PIPELINE/nov17/snps/union"
# SNPs intersection directory
#snps.intersection.dir="/Users/claire/Documents/adrneh/annovar/ADNA_EH_PIPELINE/nov17/snps/intersection"
#snps.dir <- "/Users/claire/Documents/adrneh/annovar/ADNA_EH_PIPELINE/Illumina-snps"

# Change the following working directory variable for each run of the pipeline.
current.dir = snps.dir

setwd(current.dir)

# Run the pipeline in parallel batches of four chromosomes, except the last batch which has 2 chr.

# Begin a batch

args<-commandArgs(TRUE)
# args[1] is venn: inter/union/indels
# args[2] is type: all/uncommon
# args[3] is current.batch: 1:4 etc

venn <- args[1]
type <- args[2]
current.batch <- args[3]

# i.e. will be run from command line as: Rscript ADNA_EH_PIPELINE_CLUSTER_v2.R inter all 1:4
#venn <- "inter"
#venn <- "union"
#venn <- "indels"
#type <- "all"
#type <- "uncommon"
#current.batch <- 1:4
#current.batch <- 5:8
#current.batch <- 9:12
#current.batch <- 13:16
#current.batch <- 17:20
#current.batch <- 21:22
#testing - current.batch <- 1
#testing on cluster - current.batch <- 13:14

# Glob list of annotation files ----------------------------

EH.m.files <- Sys.glob("EH*\\snps.split.table.hg19_multianno.txt")
# testing - EH.m.files <- "EH.chr22.snps.split.table.hg19_multianno.txt"
# ADNA.m.files <- "ADNA.chr22.snps.split.table.hg19_multianno.txt"
ADNA.m.files <- Sys.glob("ADNA*\\.snps.split.table.hg19_multianno.txt")

ADNA.header <- names(fread("/dcl01/barnes/data/adrneh/anno/ADNA-snp-cols.txt", sep="\t", data.table=F, header=T))
#locally: ADNA.header <- names(fread("ADNA-snp-cols.txt", sep="\t", data.table=F, header=T))
ADNA.sample.IDs <- ADNA.header[58:length(ADNA.header)]

EH.header <- names(fread("/dcl01/barnes/data/adrneh/anno/EH-snp-cols.txt", sep="\t", data.table=F, header=T))
# locally: EH.header <- names(fread("EH-snp-cols.txt", sep="\t", data.table=F, header=T))
EH.sample.IDs <- EH.header[58:length(EH.header)]

annovar.keep.cols <- c("Chr", "Start", "End", "Ref", "Alt", "Func.refGene", "Gene.refGene", "ExonicFunc.refGene", "AAChange.refGene", "snp147", "SIFT_pred", "Polyphen2_HDIV_pred", "1000g2015aug_all", "ExAC_ALL")

# Note: indel pipeline runs will have no SIFT or PolyPhen scores.
if(exists("EH.m.data")){rm(EH.m.data)}
if(exists("ADNA.m.data")){rm(ADNA.m.data)}

for (EH.m.file in EH.m.files[c(current.batch)]){
  if (!exists("EH.m.data")){
    EH.m.data <- fread(EH.m.file, sep="\t", header=F, stringsAsFactors=F, data.table=F, skip=1L)
    names(EH.m.data) <- EH.header
    EH.m.data <- subset(EH.m.data, select = c(annovar.keep.cols, EH.sample.IDs))
    
    if (venn =="union"){
      EH.m.data <- subset(EH.m.data, EH.m.data$SIFT_pred == "D" | EH.m.data$Polyphen2_HDIV_pred == "D")
    }
    
    if (venn =="inter"){
      EH.m.data <- subset(EH.m.data, EH.m.data$SIFT_pred == "D" & EH.m.data$Polyphen2_HDIV_pred == "D")
    }
    
    EH.m.data <- subset(EH.m.data, EH.m.data$Func.refGene == "exonic")
    EH.m.data <- subset(EH.m.data, EH.m.data$ExonicFunc.refGene == "nonsynonymous SNV" | EH.m.data$ExonicFunc.refGene == "frameshift" | EH.m.data$ExonicFunc.refGene == "missense" | EH.m.data$ExonicFunc.refGene == "stopgain" | EH.m.data$ExonicFunc.refGene == "stoploss")
    
    #To exclude common variants:
    if (type =="uncommon"){
      EH.m.data <- subset(EH.m.data, EH.m.data$`1000g2015aug_all` == "." | EH.m.data$`1000g2015aug_all` <= 0.05)
    }
  }
  
  else {
    EH.m.data.temp <- fread(EH.m.file, sep="\t", header=F, stringsAsFactors=F, data.table=F, skip=1L)
    names(EH.m.data.temp) <- EH.header
    EH.m.data.temp <- subset(EH.m.data.temp, select = c(annovar.keep.cols, EH.sample.IDs))
    
    if (venn =="union"){
      EH.m.data.temp <- subset(EH.m.data.temp, EH.m.data.temp$SIFT_pred == "D" | EH.m.data.temp$Polyphen2_HDIV_pred == "D")
    }
    
    if (venn =="inter"){
      EH.m.data.temp <- subset(EH.m.data.temp, EH.m.data.temp$SIFT_pred == "D" & EH.m.data.temp$Polyphen2_HDIV_pred == "D")
    }
    
    EH.m.data.temp <- subset(EH.m.data.temp, EH.m.data.temp$Func.refGene == "exonic")
    EH.m.data.temp <- subset(EH.m.data.temp, EH.m.data.temp$ExonicFunc.refGene == "nonsynonymous SNV" | EH.m.data.temp$ExonicFunc.refGene == "frameshift" | EH.m.data.temp$ExonicFunc.refGene == "missense" | EH.m.data.temp$ExonicFunc.refGene == "stopgain" | EH.m.data.temp$ExonicFunc.refGene == "stoploss")
    
    if (type =="uncommon"){
      EH.m.data.temp <- subset(EH.m.data.temp, EH.m.data.temp$`1000g2015aug_all` == "." | EH.m.data.temp$`1000g2015aug_all` <= 0.05)
    }
    EH.m.data <- rbind(EH.m.data, EH.m.data.temp)
    rm(EH.m.data.temp)
  }
}

for (ADNA.m.file in ADNA.m.files[c(current.batch)]){
  if (!exists("ADNA.m.data")){
    ADNA.m.data <- fread(ADNA.m.file, sep="\t", header=F, stringsAsFactors=F, data.table=F, skip=1L)
    names(ADNA.m.data) <- ADNA.header
    ADNA.m.data <- subset(ADNA.m.data, select = c(annovar.keep.cols, ADNA.sample.IDs))
    
    if (venn =="union"){
      ADNA.m.data <- subset(ADNA.m.data, ADNA.m.data$SIFT_pred == "D" | ADNA.m.data$Polyphen2_HDIV_pred == "D")
    }
    
    if (venn =="inter"){
      ADNA.m.data <- subset(ADNA.m.data, ADNA.m.data$SIFT_pred == "D" & ADNA.m.data$Polyphen2_HDIV_pred == "D")
    }
    
    ADNA.m.data <- subset(ADNA.m.data, ADNA.m.data$Func.refGene == "exonic")
    ADNA.m.data <- subset(ADNA.m.data, ADNA.m.data$ExonicFunc.refGene == "nonsynonymous SNV" | ADNA.m.data$ExonicFunc.refGene == "frameshift" | ADNA.m.data$ExonicFunc.refGene == "missense" | ADNA.m.data$ExonicFunc.refGene == "stopgain" | ADNA.m.data$ExonicFunc.refGene == "stoploss")
    
    #To exclude common variants:
    if (type =="uncommon"){
      ADNA.m.data <- subset(ADNA.m.data, ADNA.m.data$`1000g2015aug_all` == "." | ADNA.m.data$`1000g2015aug_all` <= 0.05)
    }
  }
  
  else {
    ADNA.m.data.temp <- fread(ADNA.m.file, sep="\t", header=F, stringsAsFactors=F, data.table=F, skip=1L)
    names(ADNA.m.data.temp) <- ADNA.header
    ADNA.m.data.temp <- subset(ADNA.m.data.temp, select = c(annovar.keep.cols, ADNA.sample.IDs))
    
    if (venn =="union"){
      ADNA.m.data.temp <- subset(ADNA.m.data.temp, ADNA.m.data.temp$SIFT_pred == "D" | ADNA.m.data.temp$Polyphen2_HDIV_pred == "D")
    }
    
    if (venn =="inter"){
      ADNA.m.data.temp <- subset(ADNA.m.data.temp, ADNA.m.data.temp$SIFT_pred == "D" & ADNA.m.data.temp$Polyphen2_HDIV_pred == "D")
    }
    
    ADNA.m.data.temp <- subset(ADNA.m.data.temp, ADNA.m.data.temp$Func.refGene == "exonic")
    ADNA.m.data.temp <- subset(ADNA.m.data.temp, ADNA.m.data.temp$ExonicFunc.refGene == "nonsynonymous SNV" | ADNA.m.data.temp$ExonicFunc.refGene == "frameshift" | ADNA.m.data.temp$ExonicFunc.refGene == "missense" | ADNA.m.data.temp$ExonicFunc.refGene == "stopgain" | ADNA.m.data.temp$ExonicFunc.refGene == "stoploss")
    
    if (type =="uncommon"){
      ADNA.m.data.temp <- subset(ADNA.m.data.temp, ADNA.m.data.temp$`1000g2015aug_all` == "." | ADNA.m.data.temp$`1000g2015aug_all` <= 0.05)
    }
    ADNA.m.data <- rbind(ADNA.m.data, ADNA.m.data.temp)
    rm(ADNA.m.data.temp)
  }
}

# Do not continue if annotation data.frames do not exist
if (!exists("ADNA.m.data")){
  q(save = "no")
}
if (!exists("EH.m.data")){
  q(save = "no")
}

# subset data for samples and variants passing QC ---------------------

# Read in list of IDs that passed QC for ADNA. This is necessary because the ADNA vcfs contain samples that did not pass QC.

AD.samples <- c(t(fread("/dcl01/mathias/data/ADRN_EH/common_analysis/annotation/AD_all_excl_failed.txt", data.table = F, header=F)))

NA.samples <- c(t(fread("/dcl01/mathias/data/ADRN_EH/common_analysis/annotation/NA_excl_failed.txt", data.table = F, header=F)))

EH.samples <- c(t(fread("/dcl01/mathias/data/ADRN_EH/common_analysis/annotation/lplist-usable.txt", data.table = F, header=F)))
#locally# EH.samples <- c(t(fread("/Users/claire/Documents/adrneh/annovar/ADNA_EH_PIPELINE/lplist-usable.txt", data.table =F, header=F)))
# AD.samples <- c(t(fread("/Users/claire/Documents/adrneh/annovar/ADNA_EH_PIPELINE/AD_all_excl_failed.txt", data.table =F, header=F)))
# NA.samples <- c(t(fread("/Users/claire/Documents/adrneh/annovar/ADNA_EH_PIPELINE/NA_excl_failed.txt", data.table =F, header=F)))


# the following joins the first nine columns and the samples that passed QC.
NA.cols <- c(annovar.keep.cols, NA.samples)
AD.cols <- c(annovar.keep.cols, AD.samples)
EH.cols <- c(annovar.keep.cols, EH.samples)
ADNA.cols <- c(annovar.keep.cols, AD.samples, NA.samples)

ADNA.m.data <- subset(ADNA.m.data, select=c(ADNA.cols))

  
# Duplicating ADNA into AD and NA data.frames in order to use the standardized 3 sample groups in the carrier loop later. Next, subsetting for those actual sample IDs.
  
AD.m.data <- ADNA.m.data
NA.m.data <- ADNA.m.data

# Subset accordingly ------

AD.m.data <- subset(ADNA.m.data, select=c(AD.cols))
NA.m.data <- subset(ADNA.m.data, select=c(NA.cols))
EH.m.data <- subset(EH.m.data, select=c(EH.cols))

# simplify genotype data ------------------------------
# Remove all values right of the genotype in each cell. Replace genotype with label of [het,hom,non] for heterozygous, homozygous, or non-carrier. We are interested in individuals that carry an alternative allele on either chromosome. We sum up carriers next.

simplifygeno <- function(n) {
  df <- n
  
  for(i in names(df[,-c(1:14)])){
    df[[i]] <- sub(':.*', '', df[[i]])
  }
  
  for(i in names(df[,c(15:length(df))])){
    df[[i]] <- sub('0/1', 'het', df[[i]])
    df[[i]] <- sub('0/0', 'non', df[[i]])
    df[[i]] <- sub('1/0', 'het', df[[i]])
    df[[i]] <- sub('1/1', 'hom', df[[i]])
    df[[i]] <- sub('./0', 'non', df[[i]])
    df[[i]] <- sub('0/.', 'non', df[[i]])
    df[[i]] <- sub('1/.', 'het', df[[i]])
    df[[i]] <- sub('./1', 'het', df[[i]])
    df[[i]] <- sub('\\./\\.', 'non', df[[i]])
    df[[i]] <- sub('\\.', 'non', df[[i]])
    df[[i]] <- sub('0', 'non', df[[i]])
    df[[i]] <- sub('1', 'het', df[[i]])
  }
  
  # sum for heterozygosity/homozygosity/noncarrier
  df$het <- rowSums(df == "het")
  df$hom <- rowSums(df == "hom")
  df$non <- rowSums(df == "non")
  
  x <- (length(df) -3)
  
  # replace labels with number
  for(i in names(df[,c(15:x)])){
    df[[i]] <- sub('het', '1', df[[i]])
    df[[i]] <- sub('hom', '1', df[[i]])
    df[[i]] <- sub('non', '0', df[[i]])
  }
  
  # regular variant level sum
  df$sum <- apply(df[,c(15:x)], 1, function(x) sum(as.numeric(x)))
  
  # remove monomorphic sites
  df <- subset(df, df$sum != 0)
  
  # make sure there are no duplicate rows
  df <- unique(df)

  # add key = chr-pos-alt ----------------
  df$KEY.1 <- paste(df$Chr, df$Start, sep = "-")
  df$KEY <- paste(df$KEY.1, df$Alt, sep="-")
  df <- subset(df, select= -c(KEY.1))
    
  # done
  return(df)
}


# EH.m.data$KEY.1 <- paste(EH.m.data$Chr, EH.m.data$Start, sep="-")
# EH.m.data$KEY <- paste(EH.m.data$KEY.1, EH.m.data$Alt, sep="-")
# EH.m.data <- subset(EH.m.data, select= -c(KEY.1))

ADNA.m.data$KEY.1 <- paste(ADNA.m.data$Chr, ADNA.m.data$Start, sep="-")
ADNA.m.data$KEY <- paste(ADNA.m.data$KEY.1, ADNA.m.data$Alt, sep="-")
ADNA.m.data <- subset(ADNA.m.data, select= -c(KEY.1))



EH.m.data <- simplifygeno(EH.m.data)
AD.m.data <- simplifygeno(AD.m.data)
NA.m.data <- simplifygeno(NA.m.data)

# carrier counting preparations -----------------------------
#setwd(snps.union.dir)
setwd(current.dir)

sample.names<-c("AD", "NA", "EH")

#testing# sample.names <- c("EH")
for (sample.name in sample.names){
  
  # add column of gene name for every variant-------------
  sample_multianno <- get(paste(sample.name, ".m.data", sep="")) # get multianno data for the sample group
  
  ## write out genelist per sample group --------
  genelist <- data.frame(subset(sample_multianno, select=c("KEY", "Chr", "Start", "Gene.refGene", "Ref", "Alt", "sum", "het", "hom", "non")))
  colnames(genelist)[6] <- paste(sample.name, "_alt", sep="")
  colnames(genelist)[7] <- paste(sample.name, "_variant_level_sum", sep="")
  colnames(genelist)[8] <- paste(sample.name, "_het", sep="") 
  colnames(genelist)[9] <- paste(sample.name, "_hom", sep="")
  colnames(genelist)[10] <- paste(sample.name, "_non", sep="")
  
  batch.name <- paste(current.batch[1], current.batch[length(current.batch)], sep="-")
  out.filename <- paste(sample.name, batch.name, sep=".")
  
  if (type =="all"){
    # for runs without filtering of common variants:
    out.filename <- paste(out.filename, ".genelist.csv", sep="")
  }
  
  if (type =="uncommon"){
    # for runs with filtering of common variants:
    out.filename <- paste(out.filename, ".genelist.uncommon.csv", sep="")
  }
  
  write.table(genelist, out.filename, sep="\t", col.names=T, row.names=F, quote=F)
  
  #get all gene names and make empty data frame -------------
  uniq <- unique(unlist(genelist$Gene.refGene))
  
  col2<-paste(sample.name, "_carriers", sep="")
  
  col3<-paste(sample.name, "_num_variants", sep="")
  
  if (exists("carrier.data")){rm(carrier.data)}
  
  carrier.data<-data.frame("gene"=numeric(0), col2=numeric(0), col3=numeric(0))
  names(carrier.data) <- c("gene", col2, col3)
  
  # carrier counting -----------
  
  for (i in 1:length(uniq)){
    
    # make temporary data.frame with all variants in one gene name ---------
    merge.1gene <- subset(sample_multianno, Gene.refGene == paste(as.character(uniq[i])))
    merge.1gene <- subset(merge.1gene, select=c(ncol(merge.1gene), 1:14, (ncol(merge.1gene)-1), (ncol(merge.1gene)-4), (ncol(merge.1gene)-3), (ncol(merge.1gene)-2), 15:(ncol(merge.1gene)-5)))
    # these are the columns reorganized above: move end columns up so KEY is the first, then Chr Start End Ref [...] sum het hom non [genotypes].
    
    # transpose merge.1gene to a new data.frame and count carriers per gene ------
    transposed <- data.frame(t(merge.1gene))
    carrier <- apply(transposed[-c(1:19),,drop=F],1, function(x) sum(as.numeric(x)))
    carrier <- c(rep(NA,19), carrier)
    transposed$carrier <- carrier
    transposed$carrier <- ifelse(transposed$carrier > 1, 1, transposed$carrier)
    
    # get just gene name and carrier columns from transposed data.frame ----------
    data<-c(as.character(transposed[,1][[8]]) , sum(as.numeric( as.character(transposed[-c(1:19),"carrier"] ))) , as.numeric(ncol(transposed)-1) )
    data.frame.temp <- data.frame(t(data.frame(data, stringsAsFactors=FALSE)))
    names(data.frame.temp) = c("gene", col2, col3)
    
    # add to the dataframe - sample-specific ------------
    carrier.data <- rbind(data.frame.temp,carrier.data)
    row.names(carrier.data) = NULL
    
    # make sure there are no duplicate rows or NA rows -----------
    carrier.data <- na.omit(unique(carrier.data))
    
    # print out carrier data - sample-specific ------------
    # batch.name variable recycled from section writing out genelist
    out.filename <- paste(sample.name, batch.name, sep=".")
    
    if (type =="all"){
      out.filename <- paste(out.filename, ".carriers.csv", sep="")  
    }
    
    if (type =="uncommon"){      
      out.filename <- paste(out.filename, ".carriers.uncommon.csv", sep="")
    }
    
    # Example filename produced from the above: EH.1-4.carriers.csv
    
    #setwd(current.dir)
    write.table(carrier.data, file=out.filename, sep="\t", row.names = F, col.names = T, quote=F)
    
    # remove temporary data.frames -------------
    rm(data.frame.temp, carrier, transposed, merge.1gene, data)
  }
  ##END CALCULATIONS ##
}
##END LOOP OVER SAMPLES ##

# merge gene-level carrier counts and variants into master file ---------------
if (type=="all"){
  batch.carriers <- paste(batch.name, ".carriers.csv", sep="")
  batch.genelist <- paste(batch.name, ".genelist.csv", sep="")
}

if (type =="uncommon"){
  batch.carriers <- paste(batch.name, ".carriers.uncommon.csv", sep="")
  batch.genelist <- paste(batch.name, ".genelist.uncommon.csv", sep="")
}

EH.carriers <- fread(paste("EH", batch.carriers, sep="."), sep="\t", header=T, stringsAsFactors=F, data.table=F)
EH.genelist <- fread(paste("EH", batch.genelist, sep="."), sep="\t", header=T, stringsAsFactors=F, data.table=F)
EH.master <- merge(EH.carriers, EH.genelist, by.y=c("Gene.refGene"), by.x=c("gene"), all=T)
colnames(EH.master)[1] <- "Gene.refGene"

AD.carriers <- fread(paste("AD", batch.carriers, sep="."), sep="\t", header=T, stringsAsFactors=F, data.table=F)
AD.genelist <- fread(paste("AD", batch.genelist, sep="."), sep="\t", header=T, stringsAsFactors=F, data.table=F)
AD.master <- merge(AD.carriers, AD.genelist, by.y=c("Gene.refGene"), by.x=c("gene"), all=T)
colnames(AD.master)[8] <- "ADNA_alt"
# Just in case the ADNA samples have a different alt allele than EH!

NA.carriers <- fread(paste("NA", batch.carriers, sep="."), sep="\t", header=T, stringsAsFactors=F, data.table=F)
NA.genelist <- fread(paste("NA", batch.genelist, sep="."), sep="\t", header=T, stringsAsFactors=F, data.table=F)
NA.master <- merge(NA.carriers, NA.genelist,  by.y=c("Gene.refGene"), by.x=c("gene"), all=T)
colnames(NA.master)[8] <- "ADNA_alt"

ADNA.master <- merge(AD.master, NA.master, by=c("KEY", "gene", "ADNA_alt", "Chr", "Start", "Ref"), all=T)
#change gene to Gene.refGene
colnames(ADNA.master)[2] <- "Gene.refGene"
EHADNA.master <- merge(EH.master, ADNA.master, by=c("KEY", "Gene.refGene", "Chr", "Start", "Ref"), all=T)

# add extra annotation information from annotation files ------
if (exists("EHADNA.master")){
  # KEY was added earlier.
  # These are the columns that I want to add to the master file for snps:
  subset.cols <- c("KEY", "Chr", "Start", "End", "Ref", "Alt", "Gene.refGene", "Func.refGene", "ExonicFunc.refGene", "AAChange.refGene", "snp147", "SIFT_pred", "Polyphen2_HDIV_pred", "1000g2015aug_all", "ExAC_ALL")

  EH.m.data.subset <- subset(EH.m.data, select=c(subset.cols))
  ADNA.m.data.subset <- subset(ADNA.m.data, select=c(subset.cols))
  M.data.subset <- unique(rbind(EH.m.data.subset, ADNA.m.data.subset))
  EHADNA.master.anno <- merge(EHADNA.master, M.data.subset, by=c("KEY", "Chr", "Start", "Ref", "Gene.refGene"), all=T)
  
  # reorder cols
  EHADNA.master.anno <- subset(EHADNA.master.anno, select=c("KEY", "Chr", "Start", "End", "Ref", "EH_alt", "ADNA_alt", "Gene.refGene", "Func.refGene", "ExonicFunc.refGene", "AAChange.refGene", "snp147", "1000g2015aug_all", "ExAC_ALL", "SIFT_pred", "Polyphen2_HDIV_pred", "EH_carriers", "EH_variant_level_sum", "EH_num_variants", "EH_het", "EH_hom", "EH_non", "AD_carriers", "AD_variant_level_sum", "AD_num_variants", "AD_het", "AD_hom", "AD_non", "NA_carriers", "NA_variant_level_sum", "NA_num_variants", "NA_het", "NA_hom", "NA_non"))
  


}

if (exists("EHADNA.master.anno")){
  if (type =="all"){
    if (venn =="union"){
      out.filename <- paste("Snps.union.all", batch.name, sep=".")
    }
    if (venn =="inter"){
      out.filename <- paste("Snps.inter.all", batch.name, sep=".")
    }
    if (venn =="indels"){
      out.filename <- paste("Indels.all", batch.name, sep=".")
    }
  }
  
  if (type =="uncommon"){
    if (venn =="union"){
      out.filename <- paste("Snps.union.uncommon", batch.name, sep=".")
    }
    if (venn =="inter"){
      out.filename <- paste("Snps.inter.uncommon", batch.name, sep=".")
    }
    if (venn =="indels"){
      out.filename <- paste("Indels.uncommon", batch.name, sep=".")
    }
  }
  
  out.filename <- paste(out.filename, ".csv", sep="")
  write.table(EHADNA.master.anno, file=out.filename, sep="\t", col.names=T, row.names=F, quote=F)
}

# End of current batch.
# After all batches are complete, EHADNA.master.anno.[batch].csv files are concatenated in a separate R script.

## Quit ----------
q(save = "no")

#For cluster submission:
# qsub_R_1_4.sh contains: Rscript ADNA_EH_PIPELINE_CLUSTER_v2.R inter all 1:4
# and so on for each qsub, Rscript command pair.
# Submit with:
# qsub -cwd -l mem_free=100G,h_vmem=101G,h_fsize=300G qsub-R.sh #Jan 10 note: may not be enough since genotypes are now added to the right.
#Jan 11 note: it's hopefully enough, with the more specific subsetting.
#Jan 13 note: 100/101G is good.
