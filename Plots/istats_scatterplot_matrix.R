setwd("/Users/meherpreethi/Desktop/ADNA_Final")
dat<-read.delim("ADRN_chr17_731_filled_filtered_istats_and_doub_for_plot.txt")
pheno <- read.delim("ADRN_phenotype_731_for_istats_plot.txt")
colnames(pheno)[1] <- "ID"
dat.pheno<-merge(dat,pheno,by="ID")
attach(dat.pheno)
pairs(~NALT+NHET+SING+DOUB+TITV,data=dat.pheno,col=dat.pheno$AD.AFFSTAT, main="Simple Scatterplot Matrix",font.axis=2,pch=19)
