## Program name: concatenate_batches.R
## Programmer: Claire E. Malley
## Created: November 29, 2016
## Updated to more carefully handle missing data based on gene name: November 30, 2016
## Updated for new pipeline Jan 12, 2017. lookin' good folks
## Purpose: Concatenate output of batches of ADNA_EH_PIPELINE_CLUSTER.R. The program was run for 6 separate batches of genotype data and output 12 files total, for all variants and for uncommon variants only.

# Load required packages ----------
library(data.table)
library(stringr)
library(zoo)
library(plyr)

# Working directories ---------
snps.union.dir <- "/dcl01/barnes/data/adrneh/anno/snps-union"
snps.inter.dir <- "/dcl01/barnes/data/adrneh/anno/snps-inter"
#locally: snps.union.dir <- "/Users/claire/Documents/adrneh/annovar/ADNA_EH_PIPELINE/Illumina-snps/union"

current.dir <- snps.union.dir

setwd(current.dir)

all <- Sys.glob("Snps*\\all*\\.csv")
uncommon <- Sys.glob("Snps*\\uncommon*\\.csv")

#all <- Sys.glob("Snps.inter.all*\\.csv")
#uncommon <- Sys.glob("Snps.inter.uncommon*\\.csv")



# Remove data.frames if they exist (i.e. program was run recently in session)  ----------
if(exists("all.data")){rm(all.data)}
if(exists("uncommon.data")){rm(uncommon.data)}

# Concatenate all-variants files ----------
for (file in all){
  if (!exists("all.data")){
    all.data<- fread(file, sep="\t", header=T, stringsAsFactors=F, data.table=F)
  }
  
  else {
    all.data.temp <- fread(file, sep="\t", header=T, stringsAsFactors=F, data.table=F)
    all.data <- rbind(all.data, all.data.temp)
    rm(all.data.temp)
  }
}

all.data <- unique(all.data)

# Concatenate uncommon-variants-only files  ----------
for (file in uncommon){
  if (!exists("uncommon.data")){
    uncommon.data<- fread(file, sep="\t", header=T, stringsAsFactors=F, data.table=F)
  }
  
  else {
    uncommon.data.temp <- fread(file, sep="\t", header=T, stringsAsFactors=F, data.table=F)
    uncommon.data <- rbind(uncommon.data, uncommon.data.temp)
    rm(uncommon.data.temp)
  }
}

uncommon.data <- unique(uncommon.data)

# Replace all in-value commas with semicolons -----------
# Necessary for opening the file in Excel, which interprets commas as delimiters even if tab delimiting is specified in the data "split to columns" process

for(i in names(uncommon.data)){
  uncommon.data[[i]] <- str_replace(uncommon.data[[i]], ",", ";")
}
for(i in names(all.data)){
  all.data[[i]] <- str_replace(all.data[[i]], ",", ";")
}

# Handle missing data carefully by column -----------------

natozero <- function(n) {
  
  df <- n
  
  df$EH_variant_level_sum[is.na(df$EH_variant_level_sum)] <- 0
  df$EH_num_variants[is.na(df$EH_num_variants)] <- 0
  
  df$AD_variant_level_sum[is.na(df$AD_variant_level_sum)] <- 0
  df$AD_num_variants[is.na(df$AD_num_variants)] <- 0
  
  df$NA_variant_level_sum[is.na(df$NA_variant_level_sum)] <- 0
  df$NA_num_variants[is.na(df$NA_num_variants)] <- 0
  
  df$EH_alt[is.na(df$EH_alt)] <- 0
  df$ADNA_alt[is.na(df$ADNA_alt)] <- 0

  df$NA_het[is.na(df$NA_het)] <- 0
  df$NA_het[is.na(df$NA_het)] <- 0
  df$NA_non[is.na(df$NA_non)] <- 0
  
  df$AD_het[is.na(df$AD_het)] <- 0
  df$AD_hom[is.na(df$AD_hom)] <- 0
  df$AD_non[is.na(df$AD_non)] <- 0
  
  df$EH_het[is.na(df$EH_het)] <- 0
  df$EH_hom[is.na(df$EH_hom)] <- 0
  df$EH_non[is.na(df$EH_non)] <- 0
  
  df <- df[order(df$EH_carriers),]
  df <- ddply(df, .(Gene.refGene), na.locf)
  
  df <- df[order(df$AD_carriers),]
  df <- ddply(df, .(Gene.refGene), na.locf)
  
  df <- df[order(df$NA_carriers),]
  df <- ddply(df, .(Gene.refGene), na.locf)
  
  return(df)
}

carryover.all <- natozero(all.data)
carryover.all[is.na(carryover.all)] <- 0

carryover.uncommon <- natozero(uncommon.data)
carryover.uncommon[is.na(carryover.uncommon)] <- 0


# Write out concatenated files -----------
write.table(carryover.uncommon, "Snps.uncommon.csv", sep="\t", col.names = T, row.names = F, quote=F)

write.table(carryover.all, "Snps.all.csv", sep="\t", col.names = T, row.names = F, quote=F)

## Quit ----------
q(save = "no")

#For cluster submission:
# qsub-concat-R.sh contains: R CMD BATCH concatenate.R
# Submit with:
# qsub -cwd -l mem_free=100G,h_vmem=101G,h_fsize=300G qsub-concat-R.sh
