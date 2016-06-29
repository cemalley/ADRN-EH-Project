###### load the package  ##########
x <- "/dcl01/barnes/data/ADRN_WGS"
chromo <- commandArgs(TRUE)[1]
chromo <- as.numeric(chromo)
newchr <- paste("0",chromo,sep="")
chrom <- ifelse (chromo<10, newchr, chromo)
a <- paste(x, "/ADRN_chr",chrom,"/SKATO/", sep="")
library(SKAT)

vcf_out <- paste(a,"ADRN_chr",chrom,"_731_filled_filtered_missense_all",sep="")
bed_file <- paste(vcf_out,".bed",sep="")
bim_file <- paste(vcf_out,".bim",sep="")
fam_file <- paste(vcf_out,".fam",sep="")
ssd_file <- paste(vcf_out,".SSD",sep="")
info_file <- paste(vcf_out,".Info",sep="")
cov_file <- "/home/jhmi/mboorgu1/ADRN_EDC_731_skat_ADNA.Cov"

############ missense  all variants ###########

v1 <- paste(a,"chr",chrom,"_varset1_clean_new_qc.txt",sep="")
myvar <- read.table(v1, header=F)
len <- nrow(myvar)
res <- data.frame()
File.Bed <- bed_file
File.Bim <- bim_file
File.Fam <- fam_file
File.SetID <- v1
File.SSD <- ssd_file
File.Info <- info_file
File.Cov <- cov_file
Fam_Cov <- Read_Plink_FAM_Cov(File.Fam, File.Cov, Is.binary=FALSE)
Generate_SSD_SetID(File.Bed, File.Bim, File.Fam, File.SetID, File.SSD, File.Info)
SSD.INFO <- Open_SSD(File.SSD, File.Info)
X1 <- Fam_Cov$PC1
X2 <- Fam_Cov$PC2
y <- Fam_Cov$Phenotype.y
y <- replace(y, y==1, 0)
y <- replace(y, y==2, 1)
obj <- SKAT_Null_Model(y ~ X1 + X2, out_type="D")
out <- SKAT.SSD.All(SSD.INFO, obj, method="optimal.adj")
res <- rbind(res, out$results)
Close_SSD()

res_file1 <- paste(a,"chr",chrom,"_SkatO_ADNA_731samples_with_covar_missense_all_genes_clean_new_qc.txt",sep="")
write.table(res, file=res_file1,sep="\t", quote=F, row.names=F)

######## missense TGP rare or novel  #############

v2 <- paste(a,"chr",chrom,"_varset2_clean_new_qc.txt",sep="")
myvar2 <- read.table(v2, header=F)
len2 <- nrow(myvar2)
res2 <- data.frame()
File.Bed <- bed_file
File.Bim <- bim_file
File.Fam <- fam_file
File.SetID <- v2
File.SSD <- ssd_file
File.Info <- info_file
File.Cov <- cov_file
Fam_Cov <- Read_Plink_FAM_Cov(File.Fam, File.Cov, Is.binary=FALSE)
Generate_SSD_SetID(File.Bed, File.Bim, File.Fam, File.SetID, File.SSD, File.Info)
SSD.INFO <- Open_SSD(File.SSD, File.Info)
X1 <- Fam_Cov$PC1
X2 <- Fam_Cov$PC2
y <- Fam_Cov$Phenotype.y
y <- replace(y, y==1, 0)
y <- replace(y, y==2, 1)
obj2 <- SKAT_Null_Model(y ~ X1 + X2, out_type="D")
out2 <- SKAT.SSD.All(SSD.INFO, obj2, method="optimal.adj")
res2 <- rbind(res2, out2$results)
Close_SSD()

res_file2 <- paste(a,"chr",chrom,"_SkatO_ADNA_731samples_with_covar_missense_TGP_rare_novel_genes_clean_new_qc.txt",sep="")
write.table(res2, file=res_file2,sep="\t", quote=F, row.names=F)

######## missense damaging #############

v3 <- paste(a,"chr",chrom,"_varset3_clean_new_qc.txt",sep="")
myvar3 <- read.table(v3, header=F)
len3 <- nrow(myvar3)
res3 <- data.frame()
File.Bed <- bed_file
File.Bim <- bim_file
File.Fam <- fam_file
File.SetID <- v3
File.SSD <- ssd_file
File.Info <- info_file
File.Cov <- cov_file
Fam_Cov <- Read_Plink_FAM_Cov(File.Fam, File.Cov, Is.binary=FALSE)
Generate_SSD_SetID(File.Bed, File.Bim, File.Fam, File.SetID, File.SSD, File.Info)
SSD.INFO <- Open_SSD(File.SSD, File.Info)
X1 <- Fam_Cov$PC1
X2 <- Fam_Cov$PC2
y <- Fam_Cov$Phenotype.y
y <- replace(y, y==1, 0)
y <- replace(y, y==2, 1)
obj3 <- SKAT_Null_Model(y ~ X1 + X2, out_type="D")
out3 <- SKAT.SSD.All(SSD.INFO, obj3, method="optimal.adj")
res3 <- rbind(res3, out3$results)
Close_SSD()

res_file3 <- paste(a,"chr",chrom,"_SkatO_ADNA_731samples_with_covar_missense_damaging_genes_clean_new_qc.txt",sep="")
write.table(res3, file=res_file3,sep="\t", quote=F, row.names=F)

######## missense damaging TGP rare or novel #############

v4 <- paste(a,"chr",chrom,"_varset4_clean_new_qc.txt",sep="")
myvar4 <- read.table(v4, header=F)
len4 <- nrow(myvar4)
res4 <- data.frame()
File.Bed <- bed_file
File.Bim <- bim_file
File.Fam <- fam_file
File.SetID <- v4
File.SSD <- ssd_file
File.Info <- info_file
File.Cov <- cov_file
Fam_Cov <- Read_Plink_FAM_Cov(File.Fam, File.Cov, Is.binary=FALSE)
Generate_SSD_SetID(File.Bed, File.Bim, File.Fam, File.SetID, File.SSD, File.Info)
SSD.INFO <- Open_SSD(File.SSD, File.Info)
X1 <- Fam_Cov$PC1
X2 <- Fam_Cov$PC2
y <- Fam_Cov$Phenotype.y
y <- replace(y, y==1, 0)
y <- replace(y, y==2, 1)
obj4 <- SKAT_Null_Model(y ~ X1 + X2, out_type="D")
out4 <- SKAT.SSD.All(SSD.INFO, obj4, method="optimal.adj")
res4 <- rbind(res4, out4$results)
Close_SSD()

res_file4 <- paste(a,"chr",chrom,"_SkatO_ADNA_731samples_with_covar_missense_damaging_TGP_rare_novel_genes_clean_new_qc.txt",sep="")
write.table(res4, file=res_file4,sep="\t", quote=F, row.names=F)
