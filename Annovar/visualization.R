## Program name: visualization.R
## Programmer: Claire E. Malley
## Created: November 29, 2016
## Purpose: This program takes concatenated output of ADNA_EH_PIPELINE_CLUSTER.R and creates ggplot scatterplots to compare carrier status between sample groups.
# To-do: also incorporate counts of basic Annovar annotation categories to make bar charts.

# Load required packages ----------
library(data.table)
library(ggplot2)
library(ggthemes) #optional
library(ggrepel)

# Working directories ---------
# On the cluster:
#snps.union.dir <- "/dcl01/mathias/data/ADRN_EH/common_analysis/annotation/Illumina-snps/union"
#snps.inter.dir <- "/dcl01/mathias/data/ADRN_EH/common_analysis/annotation/Illumina-snps/inter"

# Locally (my preference):

snps.union.dir <- "/Users/claire/Documents/adrneh/annovar/ADNA_EH_PIPELINE/visualization/union"
snps.inter.dir <- "/Users/claire/Documents/adrneh/annovar/ADNA_EH_PIPELINE/visualization/inter"


current.dir <- snps.union.dir

setwd(current.dir)


# Graph styling --------
colorpalette<- c('#2F2C62', '#42399B', '#4A52A7', '#59AFEA', '#7BCEB8', '#A7DA64', '#EFF121', '#F5952D', '#E93131', '#D70131', '#D70131')
tt <-theme(legend.text = element_text(size=14), legend.title=element_text(size=16), text=element_text(size=14), axis.text = element_text(size=14))


# Import data ------------

snps.union.all <- fread("Snps.union.all.csv", data.table=F, sep="\t", stringsAsFactors = F, header=T)

snps.union.uncommon <- fread("Snps.union.uncommon.csv", data.table=F, sep="\t", stringsAsFactors = F, header=T)

snps.union.all.carriers <- subset(snps.union.all, select=c("gene", "EH_carriers", "AD_carriers", "NA_carriers"))
snps.union.all.carriers <-  unique(snps.union.all.carriers)

snps.union.uncommon.carriers <- subset(snps.union.uncommon, select=c("gene", "EH_carriers", "AD_carriers", "NA_carriers"))
snps.union.uncommon.carriers <- unique(snps.union.uncommon.carriers)

snps.inter.all <- fread("Snps.inter.all.csv", data.table=F, sep="\t", stringsAsFactors = F, header=T)
snps.inter.uncommon <- fread("Snps.inter.uncommon.csv", data.table=F, sep="\t", stringsAsFactors = F, header=T)


snps.inter.all.carriers <- subset(snps.inter.all, select=c("gene", "EH_carriers", "AD_carriers", "NA_carriers"))
snps.inter.all.carriers <-  unique(snps.inter.all.carriers)

snps.inter.uncommon.carriers <- subset(snps.inter.uncommon, select=c("gene", "EH_carriers", "AD_carriers", "NA_carriers"))
snps.inter.uncommon.carriers <- unique(snps.inter.uncommon.carriers)



# Graphing -----------------
attach(snps.union.all.carriers)
a<- ggplot(snps.union.all.carriers) + geom_point(aes(x=as.numeric(EH_carriers)/48, y=as.numeric(AD_carriers)/491, col=densCols(x=as.numeric(EH_carriers)/48, y=as.numeric(AD_carriers)/491, colramp = colorRampPalette(colorpalette)), label=snps.union.all.carriers$gene), size=1.5, alpha=0.5) +scale_color_identity() + geom_abline(aes(intercept = 0, slope = 1, col="red"), linetype="dashed") + theme_hc() +tt +
  geom_text(aes(x=as.numeric(EH_carriers/48),y=as.numeric(AD_carriers/491),label=ifelse(as.numeric(EH_carriers/48)>0.5 & as.numeric(AD_carriers/491)<0.25, as.character(gene),"" ) ), hjust=0, vjust=-0.5) +
  geom_text_repel(aes(x=as.numeric(EH_carriers/48),y=as.numeric(AD_carriers/491),label=ifelse(as.numeric(EH_carriers/48)<0.5 & as.numeric(AD_carriers/491)>0.75, as.character(gene),"" ) )) +
  labs(title="Carriers of probably damaging SNPs in AD and EH samples \n as determined by SIFT and/or Polyphen 2 (pphdiv) in ANNOVAR\nAll chromosomes and variants", x="Proportion of carriers in EH sample", y="Proportion of carriers in AD sample")

b <- ggplot(snps.union.all.carriers) + geom_point(aes(x=as.numeric(EH_carriers)/48, y=as.numeric(NA_carriers)/241, col=densCols(x=as.numeric(EH_carriers)/48, y=as.numeric(NA_carriers)/241, colramp = colorRampPalette(colorpalette)), label=snps.union.all.carriers$gene), size=1.5, alpha=0.5) +scale_color_identity() + geom_abline(aes(intercept = 0, slope = 1, col="red"), linetype="dashed") + theme_hc() +tt +
  geom_text(aes(x=as.numeric(EH_carriers/48),y=as.numeric(NA_carriers/241),label=ifelse(as.numeric(EH_carriers/48)>0.5 & as.numeric(NA_carriers/241)<0.25, as.character(gene),"" ) ), hjust=0, vjust=-0.5) +
  geom_text(aes(x=as.numeric(EH_carriers/48),y=as.numeric(NA_carriers/241),label=ifelse(as.numeric(EH_carriers/48)<0.5 & as.numeric(NA_carriers/241)>0.75, as.character(gene),"" ) ), hjust=0, vjust=-0.5) +
  labs(title="Carriers of probably damaging SNPs in NA and EH samples \n as determined by SIFT and/or Polyphen 2 (pphdiv) in ANNOVAR\nAll chromosomes and variants", x="Proportion of carriers in EH sample", y="Proportion of carriers in NA sample")


c <- ggplot(snps.union.all.carriers) + geom_point(aes(x=as.numeric(AD_carriers/491),y=as.numeric(NA_carriers/241), col=densCols(x=as.numeric(AD_carriers/491), y=as.numeric(NA_carriers/241), colramp = colorRampPalette(colorpalette)) , label=gene), size=1.5, alpha=0.5) + scale_color_identity() + geom_abline(aes(intercept = 0, slope = 1, col="red"), linetype="dashed") + theme_hc() +tt + labs(title="Carriers of probably damaging SNPs in NA and AD samples \n as determined by SIFT and/or Polyphen 2 (pphdiv) in ANNOVAR\nAll chromosomes and variants", x="Proportion of carriers in AD sample", y="Proportion of carriers in NA sample")


attach(snps.union.uncommon.carriers)
d <- ggplot(snps.union.uncommon.carriers) + geom_point(aes(x=(as.numeric(EH_carriers)/48), y=(as.numeric(AD_carriers)/491), col=densCols(x=as.numeric(EH_carriers)/48, y=as.numeric(AD_carriers)/491, colramp = colorRampPalette(colorpalette)), label=gene), size=1.5, alpha=0.5) +scale_color_identity() + geom_abline(aes(intercept = 0, slope = 1, col="red"), linetype="dashed") + theme_hc() +tt +
  geom_text(aes(x=as.numeric(EH_carriers/48),y=as.numeric(AD_carriers/491),label=ifelse(as.numeric(EH_carriers/48)>0.5 & as.numeric(AD_carriers/491)<0.25, as.character(gene),"" ) ), hjust=0, vjust=-0.5) +
  geom_text_repel(aes(x=as.numeric(EH_carriers/48),y=as.numeric(AD_carriers/491),label=ifelse(as.numeric(EH_carriers/48)<0.5 & as.numeric(AD_carriers/491)>0.75, as.character(gene),"" ) )) +
  labs(title="Carriers of probably damaging SNPs in AD and EH samples \n as determined by SIFT and/or Polyphen 2 (pphdiv) in ANNOVAR\nAll chromosomes, uncommon variants only", x="Proportion of carriers in EH sample", y="Proportion of carriers in AD sample")


e <- ggplot(snps.union.uncommon.carriers) + geom_point(aes(x=as.numeric(EH_carriers)/48, y=as.numeric(NA_carriers)/241, col=densCols(x=as.numeric(EH_carriers)/48, y=as.numeric(NA_carriers)/241, colramp = colorRampPalette(colorpalette)), label=gene), size=1.5, alpha=0.5) +scale_color_identity() + geom_abline(aes(intercept = 0, slope = 1, col="red"), linetype="dashed") + theme_hc() +tt +
  geom_text(aes(x=as.numeric(EH_carriers/48),y=as.numeric(NA_carriers/241),label=ifelse(as.numeric(EH_carriers/48)>0.5 & as.numeric(NA_carriers/241)<0.25, as.character(gene),"" ) ), hjust=0, vjust=-0.5) +
  geom_text_repel(aes(x=as.numeric(EH_carriers/48),y=as.numeric(NA_carriers/241),label=ifelse(as.numeric(EH_carriers/48)<0.5 & as.numeric(NA_carriers/241)>0.75, as.character(gene),"" ) )) +
  labs(title="Carriers of probably damaging SNPs in NA and EH samples \n as determined by SIFT and/or Polyphen 2 (pphdiv) in ANNOVAR\nAll chromosomes, uncommon variants only", x="Proportion of carriers in EH sample", y="Proportion of carriers in NA sample")

f <- ggplot(snps.union.uncommon.carriers) + geom_point(aes(x=as.numeric(AD_carriers/491),y=as.numeric(NA_carriers/241), col=densCols(x=as.numeric(AD_carriers/491), y=as.numeric(NA_carriers/241), colramp = colorRampPalette(colorpalette)) , label=gene), size=1.5, alpha=0.5) + scale_color_identity() + geom_abline(aes(intercept = 0, slope = 1, col="red"), linetype="dashed") + theme_hc() +tt + labs(title="Carriers of probably damaging SNPs in NA and AD samples \n as determined by SIFT and/or Polyphen 2 (pphdiv) in ANNOVAR\nAll chromosomes, uncommon variants only", x="Proportion of carriers in AD sample", y="Proportion of carriers in NA sample")

print(a)
print(b)
print(c)
print(d)
print(e)
print(f)

attach(snps.inter.all.carriers)
g<- ggplot(snps.inter.all.carriers) + geom_point(aes(x=as.numeric(EH_carriers)/48, y=as.numeric(AD_carriers)/491, col=densCols(x=as.numeric(EH_carriers)/48, y=as.numeric(AD_carriers)/491, colramp = colorRampPalette(colorpalette)), label=snps.inter.all.carriers$gene), size=1.5, alpha=0.5) +scale_color_identity() + geom_abline(aes(intercept = 0, slope = 1, col="red"), linetype="dashed") + theme_hc() +tt +
  geom_text(aes(x=as.numeric(EH_carriers/48),y=as.numeric(AD_carriers/491),label=ifelse(as.numeric(EH_carriers/48)>0.5 & as.numeric(AD_carriers/491)<0.25, as.character(gene),"" ) ), hjust=0, vjust=-0.5) +
  geom_text(aes(x=as.numeric(EH_carriers/48),y=as.numeric(AD_carriers/491),label=ifelse(as.numeric(EH_carriers/48)<0.5 & as.numeric(AD_carriers/491)>0.75, as.character(gene),"" ) ), hjust=0, vjust=-0.5) +
  labs(title="Carriers of probably damaging SNPs in AD and EH samples \n as determined by SIFT and Polyphen 2 (pphdiv) in ANNOVAR\nAll chromosomes and variants", x="Proportion of carriers in EH sample", y="Proportion of carriers in AD sample")

h <- ggplot(snps.inter.all.carriers) + geom_point(aes(x=as.numeric(EH_carriers)/48, y=as.numeric(NA_carriers)/241, col=densCols(x=as.numeric(EH_carriers)/48, y=as.numeric(NA_carriers)/241, colramp = colorRampPalette(colorpalette)), label=snps.inter.all.carriers$gene), size=1.5, alpha=0.5) +scale_color_identity() + geom_abline(aes(intercept = 0, slope = 1, col="red"), linetype="dashed") + theme_hc() +tt +
  geom_text(aes(x=as.numeric(EH_carriers/48),y=as.numeric(NA_carriers/241),label=ifelse(as.numeric(EH_carriers/48)>0.5 & as.numeric(NA_carriers/241)<0.25, as.character(gene),"" ) ), hjust=0, vjust=-0.5) +
  geom_text(aes(x=as.numeric(EH_carriers/48),y=as.numeric(NA_carriers/241),label=ifelse(as.numeric(EH_carriers/48)<0.5 & as.numeric(NA_carriers/241)>0.75, as.character(gene),"" ) ), hjust=0, vjust=-0.5) +
  labs(title="Carriers of probably damaging SNPs in NA and EH samples \n as determined by SIFT and Polyphen 2 (pphdiv) in ANNOVAR\nAll chromosomes and variants", x="Proportion of carriers in EH sample", y="Proportion of carriers in NA sample")


i <- ggplot(snps.inter.all.carriers) + geom_point(aes(x=as.numeric(AD_carriers/491),y=as.numeric(NA_carriers/241), col=densCols(x=as.numeric(AD_carriers/491), y=as.numeric(NA_carriers/241), colramp = colorRampPalette(colorpalette)) , label=gene), size=1.5, alpha=0.5) + scale_color_identity() + geom_abline(aes(intercept = 0, slope = 1, col="red"), linetype="dashed") + theme_hc() +tt + labs(title="Carriers of probably damaging SNPs in NA and AD samples \n as determined by SIFT and Polyphen 2 (pphdiv) in ANNOVAR\nAll chromosomes and variants", x="Proportion of carriers in AD sample", y="Proportion of carriers in NA sample")


attach(snps.inter.uncommon.carriers)
j <- ggplot(snps.inter.uncommon.carriers) + geom_point(aes(x=(as.numeric(EH_carriers)/48), y=(as.numeric(AD_carriers)/491), col=densCols(x=as.numeric(EH_carriers)/48, y=as.numeric(AD_carriers)/491, colramp = colorRampPalette(colorpalette)), label=gene), size=1.5, alpha=0.5) +scale_color_identity() + geom_abline(aes(intercept = 0, slope = 1, col="red"), linetype="dashed") + theme_hc() +tt +
  geom_text(aes(x=as.numeric(EH_carriers/48),y=as.numeric(AD_carriers/491),label=ifelse(as.numeric(EH_carriers/48)>0.5 & as.numeric(AD_carriers/491)<0.25, as.character(gene),"" ) ), hjust=0, vjust=-0.5) +
  geom_text(aes(x=as.numeric(EH_carriers/48),y=as.numeric(AD_carriers/491),label=ifelse(as.numeric(EH_carriers/48)<0.5 & as.numeric(AD_carriers/491)>0.75, as.character(gene),"" ) ), hjust=0, vjust=-0.5) +
  labs(title="Carriers of probably damaging SNPs in AD and EH samples \n as determined by SIFT and Polyphen 2 (pphdiv) in ANNOVAR\nAll chromosomes, uncommon variants only", x="Proportion of carriers in EH sample", y="Proportion of carriers in AD sample")


k <- ggplot(snps.inter.uncommon.carriers) + geom_point(aes(x=as.numeric(EH_carriers)/48, y=as.numeric(NA_carriers)/241, col=densCols(x=as.numeric(EH_carriers)/48, y=as.numeric(NA_carriers)/241, colramp = colorRampPalette(colorpalette)), label=gene), size=1.5, alpha=0.5) +scale_color_identity() + geom_abline(aes(intercept = 0, slope = 1, col="red"), linetype="dashed") + theme_hc() +tt +
  geom_text(aes(x=as.numeric(EH_carriers/48),y=as.numeric(NA_carriers/241),label=ifelse(as.numeric(EH_carriers/48)>0.5 & as.numeric(NA_carriers/241)<0.25, as.character(gene),"" ) ), hjust=0, vjust=-0.5) +
  geom_text(aes(x=as.numeric(EH_carriers/48),y=as.numeric(NA_carriers/241),label=ifelse(as.numeric(EH_carriers/48)<0.5 & as.numeric(NA_carriers/241)>0.75, as.character(gene),"" ) ), hjust=0, vjust=-0.5) +
  labs(title="Carriers of probably damaging SNPs in NA and EH samples \n as determined by SIFT and/or Polyphen 2 (pphdiv) in ANNOVAR\nAll chromosomes, uncommon variants only", x="Proportion of carriers in EH sample", y="Proportion of carriers in NA sample")


l <- ggplot(snps.inter.uncommon.carriers) + geom_point(aes(x=as.numeric(AD_carriers/491),y=as.numeric(NA_carriers/241), col=densCols(x=as.numeric(AD_carriers/491), y=as.numeric(NA_carriers/241), colramp = colorRampPalette(colorpalette)) , label=gene), size=1.5, alpha=0.5) + scale_color_identity() + geom_abline(aes(intercept = 0, slope = 1, col="red"), linetype="dashed") + theme_hc() +tt + labs(title="Carriers of probably damaging SNPs in NA and AD samples \n as determined by SIFT and/or Polyphen 2 (pphdiv) in ANNOVAR\nAll chromosomes, uncommon variants only", x="Proportion of carriers in AD sample", y="Proportion of carriers in NA sample")

print(g)
print(h)
print(i)
print(j)
print(k)
print(l)


## Quit ----------
#q(save = "no")

# For cluster submission:
# qsub-vis-R.sh contains: R CMD BATCH visualization.R
# Submit with:
# qsub -cwd -l mem_free=50G,h_vmem=51G,h_fsize=300G qsub-vis-R.sh
