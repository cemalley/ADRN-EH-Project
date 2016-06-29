x <- "/amber2/scratch/schavan/ADRN"
z <- "/nexsan2/disk2/ctsa/barnes/ADRN/ADRN_chr"
k <- "/nexsan2/disk2/1K_hg19_vcf/20120628/20120628_SNPs/"
chromo <- commandArgs(TRUE)[1]
chromo <- as.numeric(chromo)
newchr <- paste("0",chromo,sep="")
chrom <- ifelse (chromo<10, newchr, chromo)
y<- paste(z,chrom,"/761MultiVCF/", sep="")
path <- paste(x,"/ADRN_chr",chrom,"/Annovar_fromTim_17_12_14/", sep="")
d <- paste(x,"/ADRN_chr",chrom,"/761MultiVCF/", sep="")

a <- paste(x, "/ADRN_chr",chrom,"/SKATO/", sep="")


####### Extract EUR_AF from vcf file and TGP phase1 data file #############

file1 <- paste(d, "ADRN_chr",chrom,"_761_SNPs_filled_GQ30_DP7_segdup.recode.vcf.bgzf.gz", sep="")
file2 <- paste(k, "ALL.chr",chrom, ".phase1.SNPS.segdup.vcf.bgzf.gz", sep="")

out1 <- paste(a, "bcftools_extracted_chr", chrom, "_EUR_AF.txt", sep="")
out2 <- paste(a, "bcftools_extracted_chr", chrom, "_EUR_AF_TGP.txt", sep="")

command1 <- paste("./bcftools-1.2/bcftools query -f '%CHROM\t%POS\t%REF\t%ALT\t%ID\t%INFO/EUR_AF\n' ",file1, " > ",out1, sep="")
command2 <- paste("./bcftools-1.2/bcftools query -f '%CHROM\t%POS\t%REF\t%ALT\t%ID\t%INFO/EUR_AF\n' ",file2, " > ",out2, sep="")

system(command1)
system(command2)

######## Read the AF files and extract rare and novel info for the variants ########
  
EUR_AF_vcf <- read.delim(out1, header=F)
EUR_AF_tgp <- read.delim(out2, header=F)
merge_all <- merge(EUR_AF_vcf, EUR_AF_tgp, by=c("V1","V2"))
data <- merge_all[c(1,2,3,4,5,10)]
colnames(data)[1] <- "Chr"
colnames(data)[2] <- "Pos"
colnames(data)[3] <- "Ref"
colnames(data)[4] <- "Alt"
colnames(data)[5] <- "SNP"
colnames(data)[6] <- "EUR_AF_TGP"
data$MAF <- ifelse(data$EUR_AF_TGP == ".", 10.5,as.numeric(paste(data$EUR_AF_TGP)))
data$MAF <- ifelse(data$MAF > 0.5, (1-data$MAF), data$MAF)
data$category <- data$MAF
data$category[data$category == -9.5] <- "Novel"
data$category[data$category < 0.05] <- "Rare"
data_sub <- data[which((data$category == "Rare") | (data$category == "Novel")),]
tgp_rare_novel_var <- paste(a,"chr",chrom,"_TGP_common_variants_Rare_Novel_only.txt",sep="")
write.table(data_sub, file=tgp_rare_novel_var, sep="\t", quote=F, row.names=F)

######### Annotation information to create variant sets #################

anno_file <- paste(path,"anno_input_chr",chrom,".txt.hg19_multianno.txt.gz", sep="")
anno <- read.delim(gzfile(anno_file),header=T)
anno_missense <- anno[which((anno$ExonicFunc.refGene == "nonsynonymous SNV") | (anno$ExonicFunc.refGene == "stopgain") | (anno$ExonicFunc.refGene == "stoploss")),]
anno_missense$Chr <- paste("chr", anno_missense$Chr, sep="")
colnames(anno_missense)[2] <- "Pos"
rm(anno)
anno_varset3 <- anno_missense[which(((anno_missense$ExonicFunc.refGene == "stopgain") | (anno_missense$ExonicFunc.refGene == "stoploss")) | (anno_missense$LJB23_Polyphen2_HVAR_pred == "D") & (anno_missense$LJB23_SIFT_pred == "D")),]
TGP_rare_novel <- read.delim(tgp_rare_novel_var)
anno_missense_tgp_rare_novel <- merge(anno_missense, TGP_rare_novel, by=c("Chr","Pos"))
anno_varset3_tgp_rare_novel <- merge(anno_varset3, TGP_rare_novel, by=c("Chr","Pos"))

######## add additional rows for variants falling in multiple gene regions #########

varset1 <- anno_missense[c(1,2,7)]
varset1_final <- data.frame(varset1$Chr, varset1$Pos, do.call(rbind, strsplit(as.character(varset1$Gene.refGene), split = ",")))
for(i in 3:length(varset1_final)) {colnames(varset1_final)[i] <- "gene"}
varset1_list <- data.frame()
for(i in 1:(length(varset1_final)-2)) { 
  varset1_append <- varset1_final[,c(1,2,(i+2))]
  varset1_list <- rbind(varset1_list, varset1_append)
  }
varset1_list <- unique(varset1_list)

varset2 <- anno_missense_tgp_rare_novel[c(1,2,7)]
varset2_final <- data.frame(varset2$Chr, varset2$Pos, do.call(rbind, strsplit(as.character(varset2$Gene.refGene), split = ",")))
for(i in 3:length(varset2_final)) {colnames(varset2_final)[i] <- "gene"}
varset2_list <- data.frame()
for(i in 1:(length(varset2_final)-2)) { 
  varset2_append <- varset2_final[,c(1,2,(i+2))]
  varset2_list <- rbind(varset2_list, varset2_append)
}
varset2_list <- unique(varset2_list)

varset3 <- anno_varset3[c(1,2,7)]
varset3_final <- data.frame(varset3$Chr, varset3$Pos, do.call(rbind, strsplit(as.character(varset3$Gene.refGene), split = ",")))
for(i in 3:length(varset3_final)) {colnames(varset3_final)[i] <- "gene"}
varset3_list <- data.frame()
for(i in 1:(length(varset3_final)-2)) { 
  varset3_append <- varset3_final[,c(1,2,(i+2))]
  varset3_list <- rbind(varset3_list, varset3_append)
}
varset3_list <- unique(varset3_list)

varset4 <- anno_varset3_tgp_rare_novel[c(1,2,7)]
varset4_final <- data.frame(varset4$Chr, varset4$Pos, do.call(rbind, strsplit(as.character(varset4$Gene.refGene), split = ",")))
for(i in 3:length(varset4_final)) {colnames(varset4_final)[i] <- "gene"}
varset4_list <- data.frame()
for(i in 1:(length(varset4_final)-2)) { 
  varset4_append <- varset4_final[,c(1,2,(i+2))]
  varset4_list <- rbind(varset4_list, varset4_append)
}
varset4_list <- unique(varset4_list)

varset1_chr_pos <- varset1_list[c(1,2)]
v1_file <- paste(a,"chr",chrom,"_varset1_chr_pos_for_vcf_subset.txt", sep="")
write.table(varset1_chr_pos, file=v1_file, sep="\t", quote=F, row.names=F)


######### Generate plink files from original vcf for AD & NA individuals and all missense variants ###########
vcf_out <- paste(a,"ADRN_chr",chrom,"_731_filled_filtered_missense_all",sep="")
vcftools_command <- paste("/nexsan2/disk2/ctsa/mathias/Software/vcftools/vcftools --gzvcf ", file1," --keep /home/jhmi/mboorgu1/ADRN_all_excl_failed_and_EH.txt --positions ",v1_file," --recode --plink --out ",vcf_out,sep="")
system(vcftools_command)
plink_command <- paste("/nexsan2/disk2/ctsa/mathias/Software/plink --file ",vcf_out," --make-bed --out ",vcf_out,sep="")
system(plink_command)

########## Obtain ID (vcf file) by merging chr pos from varsets with map file ##################

map_file_name <- paste(vcf_out,".map",sep="")
map_file <- read.delim(map_file_name, header=F)
map_file$V1 <- paste("chr",map_file$V1,sep="")
varset1 <- merge(varset1_list, map_file, by.x=c("varset1.Chr","varset1.Pos"),by.y=c("V1","V4"))
names(varset1) <- NULL
varset1.sub <- varset1[c(3,4)]
varset1_file <- paste(a,"chr",chrom,"_varset1.txt",sep="")
write.table(varset1.sub, file=varset1_file, sep="\t", quote=F, row.names=F)

varset2 <- merge(varset2_list, map_file, by.x=c("varset2.Chr","varset2.Pos"),by.y=c("V1","V4"))
names(varset2) <- NULL
varset2.sub <- varset2[c(3,4)]
varset2_file <- paste(a,"chr",chrom,"_varset2.txt",sep="")
write.table(varset2.sub, file=varset2_file, sep="\t", quote=F, row.names=F)

varset3 <- merge(varset3_list, map_file, by.x=c("varset3.Chr","varset3.Pos"),by.y=c("V1","V4"))
names(varset3) <- NULL
varset3.sub <- varset3[c(3,4)]
varset3_file <- paste(a,"chr",chrom,"_varset3.txt",sep="")
write.table(varset3.sub, file=varset3_file, sep="\t", quote=F, row.names=F)

varset4 <- merge(varset4_list, map_file, by.x=c("varset4.Chr","varset4.Pos"),by.y=c("V1","V4"))
names(varset4) <- NULL
varset4.sub <- varset4[c(3,4)]
varset4_file <- paste(a,"chr",chrom,"_varset4.txt",sep="")
write.table(varset4.sub, file=varset4_file, sep="\t", quote=F, row.names=F)
