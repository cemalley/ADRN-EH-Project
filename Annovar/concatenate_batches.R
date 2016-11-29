## Program name: concatenate_batches.R
## Programmer: Claire E. Malley
## Created: November 29, 2016
## Purpose: Concatenate output of batches of ADNA_EH_PIPELINE_CLUSTER.R. The program was run for 6 separate batches of genotype data and output 12 files total, for all variants and for uncommon variants only.

# Load required packages ----------
library(data.table)
library(stringr)

# Working directories ---------
snps.union.dir <- "/dcl01/mathias/data/ADRN_EH/common_analysis/annotation/Illumina-snps/union"
snps.inter.dir <- "/dcl01/mathias/data/ADRN_EH/common_analysis/annotation/Illumina-snps/inter"

current.dir <- snps.union.dir

setwd(current.dir)

union.all <- Sys.glob("Snps.union.all*\\.csv")
union.uncommon <- Sys.glob("Snps.union.uncommon*\\.csv")

# Remove data.frames if they exist (i.e. program was run recently in session)  ----------
if(exists("union.all.data")){rm(union.all.data)}
if(exists("union.uncommon.data")){rm(union.uncommon.data)}

# Concatenate all-variants files ----------
for (file in union.all){
  if (!exists("union.all.data")){
    union.all.data<- fread(file, sep="\t", header=T, stringsAsFactors=F, data.table=F)
  }
  
  else {
    union.all.data.temp <- fread(file, sep="\t", header=T, stringsAsFactors=F, data.table=F)
    union.all.data <- rbind(union.all.data, union.all.data.temp)
    rm(union.all.data.temp)
  }
}

union.all.data <- unique(union.all.data)


# Concatenate uncommon-variants-only files  ----------
for (file in union.uncommon){
  if (!exists("union.uncommon.data")){
    union.uncommon.data<- fread(file, sep="\t", header=T, stringsAsFactors=F, data.table=F)
  }
  
  else {
    union.uncommon.data.temp <- fread(file, sep="\t", header=T, stringsAsFactors=F, data.table=F)
    union.uncommon.data <- rbind(union.uncommon.data, union.uncommon.data.temp)
    rm(union.uncommon.data.temp)
  }
}

union.uncommon.data <- unique(union.uncommon.data)

# Replace all in-value commas with semicolons -----------
# Necessary for opening the file in Excel, which interprets commas as delimiters even if tab delimiting is specified in the data "split to columns" process

for(i in names(union.uncommon.data)){
  union.uncommon.data[[i]] <- str_replace(union.uncommon.data[[i]], ",", ";")
}
for(i in names(union.all.data)){
  union.all.data[[i]] <- str_replace(union.all.data[[i]], ",", ";")
}

# Write out concatenated files -----------
out.filename.all <- "Snps.all.union.csv"
out.filename.uncommon <- "Snps.uncommon.union.csv"

write.table(union.all.data, file=out.filename.all, sep="\t", col.names = T, row.names = F, quote = F)
write.table(union.uncommon.data, file=out.filename.uncommon, sep="\t", col.names = T, row.names = F, quote =F)


## Quit ----------
q(save = "no")

#For cluster submission:
# qsub-concat-R.sh contains: R CMD BATCH concatenate_batches.R
# Submit with:
# qsub -cwd -l mem_free=50G,h_vmem=51G,h_fsize=300G qsub-concat-R.sh
