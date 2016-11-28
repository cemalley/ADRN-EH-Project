## Program name: ADNA_EH_PIPELINE.R
## Programmer: Claire Malley
## Creater: September 21-26, 2016.
## Updated: November 21, 2016.
## Adapted for running entirely on the cluster: November 22-28, 2016.
## Purpose: This program takes annotation output from ANNOVAR plus the variant call files and counts carriers per variant and per gene. For SNPs, the program goes a step further to take only sites that are annotated as damaging in SIFT and PolyPhen 2, for both the union and intersection of these sets. Common SNPs in 1000 Genomes Project are also filtered out for SNPs (phase 1 release). For indels, the program only counts carriers, since SIFT and PolyPhen do not cover indels. It also does not factor in variant rarity for indels (yet).
## Jargon: multianno = annotation output file from ANNOVAR. vcf = variant call file. EH = individuals with eczema herpeticum. ADNA = two groups, AD being individuals with atopic dermatitis, and NA being non-atopic individuals.
## Sample sizes: EH = 48, AD = 491, NA = 238.

# load required packages ---------------------
# install.packages("data.table")
# install.packages("stringr")
# install.packages("ggplot2")
# install.packages("ggthemes")
# install.packages("plyr")
# install.packages("ggrepel")
library(data.table)
library(stringr)
library(ggplot2)
library(ggthemes)
library(plyr)
library(ggrepel)

# Working directory locations

# SNPs directory:
#snps.dir="/Users/claire/Documents/adrneh/annovar/ADNA_EH_PIPELINE/nov17/snps"
snps.dir="/dcl01/mathias/data/ADRN_EH/common_analysis/annotation/Illumina-snps"
#for ADNA:
ADNA.vcf.dir="/dcl01/mathias/data/ADRN_EH/ADRN"

snps.union.dir="/dcl01/mathias/data/ADRN_EH/common_analysis/annotation/Illumina-snps/union"

#Local paths
# Indels directory
#indels.dir="/Users/claire/Documents/adrneh/annovar/ADNA_EH_PIPELINE/nov17/indels"
# SNPs union directory
#snps.union.dir="/Users/claire/Documents/adrneh/annovar/ADNA_EH_PIPELINE/nov17/snps/union"
# SNPs intersection directory
#snps.intersection.dir="/Users/claire/Documents/adrneh/annovar/ADNA_EH_PIPELINE/nov17/snps/intersection"

# Change the following working directory variable for each run of the pipeline.
current.dir = snps.dir

setwd(current.dir)

# Run the pipeline with a portion of the files.

batch <- c(1:22) # ADNA will only have chromosomes 1-22 analyzed. I subset the list of EH multianno files to chr1-22.
current.batch <- batch[1:4]
#current.batch <- batch[5:8]
#current.batch <- batch[9:12]
#current.batch <- batch[13:16]
#current.batch <- batch[17:20]
#current.batch <- batch[21:22]

# select damaging variants in multianno ----------------------------

EH.m.files <- Sys.glob("EH.*.table.hg19_multianno.csv")
EH.m.files <- EH.m.files[1:22]
ADNA.m.files <- Sys.glob("ADNA*.table.hg19_multianno.csv")

# Note: indel pipeline runs will have no SIFT or PolyPhen scores.
if(exists("EH.m.data")){rm(EH.m.data)}
if(exists("ADNA.m.data")){rm(ADNA.m.data)}

for (EH.m.file in EH.m.files[c(current.batch)]){
  if (!exists("EH.m.data")){
    EH.m.data <- fread(EH.m.file, sep=",", header=TRUE, stringsAsFactors=FALSE, data.table=FALSE)
    #for indels:
    #EH.m.data <- subset(EH.m.data, select = c("Chr", "Start", "Ref", "Alt", "Func.refGene", "Gene.refGene", "snp147", "1000g2015aug_all"))
    #for snps#
    EH.m.data <- subset(EH.m.data, EH.m.data$SIFT_pred == 'D' & EH.m.data$Polyphen2_HDIV_pred == 'D', select = c("Chr", "Start", "Ref", "Alt", "Func.refGene", "Gene.refGene", "snp147", "SIFT_pred", "Polyphen2_HDIV_pred", "1000g2015aug_all"))
  }

  else {
    EH.m.data.temp <- fread(EH.m.file, sep=",", header=TRUE, stringsAsFactors=FALSE, data.table=FALSE)
    #for indels:
    #EH.m.data.temp <- subset(EH.m.data.temp, select = c("Chr", "Start", "Ref", "Alt", "Func.refGene", "Gene.refGene", "snp147", "1000g2015aug_all"))
    #for snps#
    EH.m.data.temp <- subset(EH.m.data.temp, EH.m.data.temp$SIFT_pred == 'D' & EH.m.data.temp$Polyphen2_HDIV_pred == 'D', select = c("Chr", "Start", "Ref", "Alt", "Func.refGene", "Gene.refGene", "snp147", "SIFT_pred", "Polyphen2_HDIV_pred", "1000g2015aug_all"))
    EH.m.data <- rbind(EH.m.data, EH.m.data.temp)
    rm(EH.m.data.temp)
  }
}

EH.m.data <- unique(EH.m.data)

for (ADNA.m.file in ADNA.m.files[current.batch]){
  if(!exists("ADNA.m.data")){
    ADNA.m.data <- fread(ADNA.m.file, sep=",", header=TRUE, stringsAsFactors=FALSE, data.table=FALSE)
    ADNA.m.data <- subset(ADNA.m.data, ADNA.m.data$SIFT_pred == 'D' & ADNA.m.data$Polyphen2_HDIV_pred == 'D', select = c("Chr", "Start", "Ref", "Alt", "Func.refGene", "Gene.refGene", "snp147", "SIFT_pred", "Polyphen2_HDIV_pred", "1000g2015aug_all"))
  }

  else {
    ADNA.m.data.temp <- fread(ADNA.m.file, sep=",", header=TRUE, stringsAsFactors=FALSE, data.table=FALSE)
    ADNA.m.data.temp <- subset(ADNA.m.data.temp, ADNA.m.data.temp$SIFT_pred == 'D' & ADNA.m.data.temp$Polyphen2_HDIV_pred == 'D', select = c("Chr", "Start", "Ref", "Alt", "Func.refGene", "Gene.refGene", "snp147", "SIFT_pred", "Polyphen2_HDIV_pred", "1000g2015aug_all"))
    ADNA.m.data <- rbind(ADNA.m.data, ADNA.m.data.temp)
    rm(ADNA.m.data.temp)
  }
}

ADNA.m.data <- unique(ADNA.m.data)

# Duplicating ADNA into AD and NA data.frames in order to use the standardized sample group in the carrier loop later.

AD.m.data <- ADNA.m.data

NA.m.data <- ADNA.m.data

rm(ADNA.m.data)

# Do not continue if annotation data.frames do not exist
if (!exists("AD.m.data")){
  q(save = "no")
}
if (!exists("EH.m.data")){
  q(save = "no")
}

# subset vcf for samples and variants passing QC ---------------------

# Read in list of IDs that passed QC for ADNA. This is necessary because the ADNA vcfs contain samples that did not pass QC.

AD.samples <- unlist(fread("/dcl01/mathias/data/ADRN_EH/common_analysis/annotation/AD_all_excl_failed.txt", data.table = F))

NA.samples <- unlist(fread("/dcl01/mathias/data/ADRN_EH/common_analysis/annotation/NA_excl_failed.txt", data.table = F))

EH.samples <- unlist(fread("/dcl01/mathias/data/ADRN_EH/common_analysis/annotation/lplist-usable.txt", data.table = F))

# the following are the first nine columns present in the VCF files
cols <- c("CHROM", "POS", "ID", "REF", "ALT", "QUAL", "FILTER", "INFO", "FORMAT")

# the following joins the first nine columns and the samples that passed QC.
NA.cols <- c(cols, NA.samples)
AD.cols <- c(cols, AD.samples)
EH.cols <- c(cols, EH.samples)

# I made subset VCF files for damaging sites in a new directory on the cluster.
setwd(snps.union.dir)

EH.vcf.files <- Sys.glob("EH*\\damaging.union.vcf")

if(exists("EH.vcf.data")){rm(EH.vcf.data)}
if(exists("ADNA.vcf.data")){rm(ADNA.vcf.data)}


for (EH.vcf.file in EH.vcf.files[current.batch]){
  if (!exists("EH.vcf.data")){
    EH.vcf.data <- fread(EH.vcf.file, header=F, sep="\t", stringsAsFactors = F, data.table = F, skip=1413L)
    #EH snps: skip 1413L
    #EH indels: skip 1449L
    colnames(EH.vcf.data) <- EH.vcf.data[1, ]
    colnames(EH.vcf.data)[1] <- "CHROM"
    EH.vcf.data = EH.vcf.data[-1, ]
    EH.vcf.data <- subset(EH.vcf.data, EH.vcf.data$FILTER=="PASS", select=(EH.cols))
  }

  else {
    EH.vcf.data.temp <- fread(EH.vcf.file, header=F, sep="\t", stringsAsFactors = F, data.table = F, skip=1413L)
    colnames(EH.vcf.data.temp) <- EH.vcf.data.temp[1, ]
    colnames(EH.vcf.data.temp)[1] <- "CHROM"
    EH.vcf.data.temp = EH.vcf.data.temp[-1, ]

    EH.vcf.data.temp <- subset(EH.vcf.data.temp,  EH.vcf.data$FILTER=="PASS", select=(EH.cols))
    EH.vcf.data <- rbind(EH.vcf.data, EH.vcf.data.temp)
    rm(EH.vcf.data.temp)
  }
}

EH.vcf.data <- unique(EH.vcf.data)

#setwd(ADNA.vcf.dir)
ADNA.vcf.files<-Sys.glob("ADNA*\\.damaging.union.vcf")

for (ADNA.vcf.file in ADNA.vcf.files[current.batch]){
  if(!exists("ADNA.vcf.data")){
    ADNA.vcf.data <- fread(ADNA.vcf.file, header=F, sep="\t", stringsAsFactors = F, data.table = F, skip=52L)
    # ADNA snps: skip 52L
    #ADNA indels: skip 15892L
    colnames(ADNA.vcf.data) <- ADNA.vcf.data[1, ]
    colnames(ADNA.vcf.data)[1] <- "CHROM"
    ADNA.vcf.data = ADNA.vcf.data[-1, ]
  }

  else {
    ADNA.vcf.data.temp <- fread(ADNA.vcf.file, header=F, sep="\t", stringsAsFactors = F, data.table = F, skip=52L)
    # ADNA snps: skip 52L
    #ADNA indels: skip 15892L
    colnames(ADNA.vcf.data.temp) <- ADNA.vcf.data.temp[1, ]
    colnames(ADNA.vcf.data.temp)[1] <- "CHROM"
    ADNA.vcf.data.temp = ADNA.vcf.data.temp[-1, ]
    ADNA.vcf.data <- rbind(ADNA.vcf.data, ADNA.vcf.data.temp)
    rm(ADNA.vcf.data.temp)
  }
}

NA.vcf.data<-unique(subset(ADNA.vcf.data, ADNA.vcf.data$FILTER=="PASS", select=(NA.cols)))

AD.vcf.data<-unique(subset(ADNA.vcf.data, ADNA.vcf.data$FILTER=="PASS", select=(AD.cols)))

# Do not continue if VCF data.frames do not exist
if (!exists("ADNA.vcf.data")){
  q(save = "no")
}
if (!exists("EH.vcf.data")){
  q(save = "no")
}

#setwd(current.dir)
# simplify genotype data ------------------------------
# Remove all values right of the genotype in each cell, then replace cell with '1' if the individual carries an alternative allele on either chromosome. This is done in order to sum up carriers next.

for(i in names(NA.vcf.data[,-c(1:9)])){
  NA.vcf.data[[i]] <- (1*grepl("1|2|3|4", sub(':.*', '', NA.vcf.data[[i]]), perl= TRUE))
}
# note: some VCF data have multiple alternative alleles per row. I consider 1-4 alt alleles here.

for(i in names(AD.vcf.data[,-c(1:9)])){
  AD.vcf.data[[i]] <- (1*grepl("1|2|3|4", sub(':.*', '', AD.vcf.data[[i]]), perl= TRUE))
}

for(i in names(EH.vcf.data[,-c(1:9)])){
  EH.vcf.data[[i]] <- (1*grepl("1|2|3|4", sub(':.*', '', EH.vcf.data[[i]]), perl= TRUE))
}

# remove monomorphic sites -------------------

# monomorphic sites = variant positions with no genotype information for anyone, i.e. the calculated sum of carriers at a variant is 0

NA.vcf.data$sum <- apply(NA.vcf.data[,-c(1:9)], 1, function(x) sum(x))
AD.vcf.data$sum <- apply(AD.vcf.data[,-c(1:9)], 1, function(x) sum(x))
EH.vcf.data$sum <- apply(EH.vcf.data[,-c(1:9)], 1, function(x) sum(x))

NA.vcf.data <- subset(NA.vcf.data, NA.vcf.data$sum != 0)
AD.vcf.data <- subset(AD.vcf.data, AD.vcf.data$sum != 0)
EH.vcf.data <- subset(EH.vcf.data, EH.vcf.data$sum != 0)

NA.vcf.data <- unique(NA.vcf.data)
AD.vcf.data <- unique(AD.vcf.data)
EH.vcf.data <- unique(EH.vcf.data)

# subset multianno file for positions in the subset vcf data

EH.m.data <- EH.m.data[(EH.m.data$Start %in% EH.vcf.data$POS),]
AD.m.data <- AD.m.data[(AD.m.data$Start %in% AD.vcf.data$POS),]
NA.m.data <- NA.m.data[(NA.m.data$Start %in% NA.vcf.data$POS),]

# now do the inverse so that the vcf data positions and number of variants matches what was output by annovar

EH.vcf.data <- EH.vcf.data[(EH.vcf.data$POS %in% EH.m.data$Start),]
AD.vcf.data <- AD.vcf.data[(AD.vcf.data$POS %in% AD.m.data$Start),]
NA.vcf.data <- NA.vcf.data[(NA.vcf.data$POS %in% NA.m.data$Start),]

# carrier counting preparations -----------------------------
setwd(current.dir)
sample.names<-c("AD", "NA", "EH")

for (sample.name in sample.names){

  # add column of gene name for every variant (chr: pos) --------------

  sample_multianno <- get(paste(sample.name, ".m.data", sep="")) # get multianno data for the sample group

  gene.def <- data.frame(subset(sample_multianno, select=c("Chr","Start","Gene.refGene"))) # reorganize multianno data

  colnames(gene.def)[3] <- "gene"

  gene.def$Chr.Start<- paste(gene.def$Chr, gene.def$Start, sep = "-")

  merge <- get(paste(sample.name, ".vcf.data", sep="")) # get vcf data for the sample group

  merge$CHROM.POS <- paste(merge$CHROM, merge$POS, sep = "-")

  # remove common variants --------------
  # optional step depending on whether this run is all variants or uncommon variants only #

  # legacy # merge <- merge[(!(merge$CHROM.POS %in% data.TGP$CHROM.POS)),]

  # subset merge for positions that are < 0.05 or = 0 in 1000g2015aug frequencies (rare)

  merge$gene <- gene.def$gene[match(merge$CHROM.POS,gene.def$Chr.Start)]

  merge <- merge[!(is.na(merge$gene) | merge$gene==""), ]

  ## write out genelist per sample group --------
  genelist<-subset(merge, select=c("gene", "CHROM.POS", "REF", "ALT", "sum"))
  colnames(genelist)[2] = "chr-pos"
  colnames(genelist)[3] = "ref"
  colnames(genelist)[4] = paste(sample.name, "_alt", sep="")
  colnames(genelist)[5] = paste(sample.name, "_variant_level_sum", sep="")

  batch.name <- paste(current.batch[1], current.batch[length(current.batch)], sep="-")
  out.filename <- paste(sample.name, batch.name, sep=".")
  out.filename <- paste(out.filename, ".genelist.csv", sep="")
  write.table(genelist, out.filename, sep="\t", col.names=T, row.names=F)

  #get all gene names and make empty data frame -------------
  uniq <- unique(unlist(gene.def$gene))

  col2<-paste(sample.name, "_carriers", sep="")

  col3<-paste(sample.name, "_num_variants", sep="")

  if (exists("carrier.data")){rm(carrier.data)}

  carrier.data<-data.frame("gene"=numeric(0), col2=numeric(0), col3=numeric(0))
  names(carrier.data) <- c("gene", col2, col3)

  # carrier counting -----------

  for (i in 1:length(uniq)){

    # make temporary data.frame with all variants in one gene name ---------
    merge.1gene <- subset(merge, gene == paste(as.character(uniq[i])))
    merge.1gene <- subset(merge.1gene, select=c(1,2,4,5,ncol(merge.1gene), (ncol(merge.1gene)-2),(ncol(merge.1gene)-1), 10:(ncol(merge.1gene)-3)))

    # transpose merge.1gene to a new data.frame and count carriers per gene ------
    transposed <-  data.frame(t(merge.1gene))
    carrier <- apply(transposed[-c(1:7),,drop=F],1, function(x) sum(as.numeric(x)))
    carrier <- c(rep(NA,7), carrier)
    transposed$carrier <- carrier
    transposed$carrier <- ifelse(transposed$carrier > 1, 1, transposed$carrier)

    # get just gene name and carrier columns from transposed data.frame ----------
    data<-c(as.character(transposed[,1][[5]]) , sum(as.numeric( as.character(transposed[-c(1:7),"carrier"] ))) , as.numeric(ncol(transposed)-1) )
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
    out.filename <- paste(out.filename, ".carriers.csv", sep="")

    # Example filename produced from the above: EH.1-4.carriers.csv

    setwd(current.dir)
    write.table(carrier.data, file=out.filename, sep="\t", row.names = F, col.names = T, quote=F)

    # remove temporary data.frames -------------
    rm(data.frame.temp, carrier, transposed, merge.1gene, data, genelist)
  }
  ##END CALCULATIONS ##
}
##END LOOP OVER SAMPLES ##
q(save = "no")

