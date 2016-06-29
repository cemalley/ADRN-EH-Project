#ADvsNA Go enrichment analysis(P < 0.001) 
getwd()
######
library(plyr)

dat<-read.delim("~/Downloads/AD_NA_10^-3_eQTL_genestrtstop/UCSC_Genes_knownGenes")
colnames(dat)
gtf<-dat

colnames(gtf)
#keep chrom, strand, genestart, gene end(txstart and end), and Gene Symbol
gtf<-gtf[c(2,3,4,5,11)]

gtf.pos<-gtf[which(gtf$hg19.knownGene.strand=="+"),]
gtf.neg<-gtf[which(gtf$hg19.knownGene.strand=="-"),]


#cis regions as defined in PrixFixe 100kbp upstream and 10kbp downstream
gtf.pos$GeneStart_cis<-gtf.pos$hg19.knownGene.txStart-100000
gtf.pos$GeneEnd_cis<-gtf.pos$hg19.knownGene.txEnd+10000
colnames(gtf.pos)
#keep chrom, strand, gene symbol and new GENE start and end(cis)
gtf.pos<-gtf.pos[c(1,2,5,6,7)]
gtf.pos$chr_Gene<-paste(gtf.pos$hg19.knownGene.chrom,gtf.pos$hg19.kgXref.geneSymbol,sep=":")
gtf.pos<-ddply(gtf.pos,.variables = c('hg19.knownGene.chrom','hg19.knownGene.strand','hg19.kgXref.geneSymbol','chr_Gene'),summarise,min=min(GeneStart_cis),max=max(GeneEnd_cis))
write.table(gtf.pos,"~/Desktop/adna_02_22_2016/UCSC_Genes_KnownGenes_alltrans_encompass_pos.txt",sep="\t",row.names=F,quote=F)


#cis regions as defined in PrixFixe 100kbp upstream and 10kbp downstream
gtf.neg$GeneStart_cis<-gtf.neg$hg19.knownGene.txStart-10000
gtf.neg$GeneEnd_cis<-gtf.neg$hg19.knownGene.txEnd+100000
colnames(gtf.neg)
#keep chrom, strand, gene symbol and new GENE start and end(cis)
gtf.neg<-gtf.neg[c(1,2,5,6,7)]
gtf.neg$chr_Gene<-paste(gtf.neg$hg19.knownGene.chrom,gtf.neg$hg19.kgXref.geneSymbol,sep=":")
gtf.neg<-ddply(gtf.neg,.variables = c('hg19.knownGene.chrom','hg19.knownGene.strand','hg19.kgXref.geneSymbol','chr_Gene'),summarise,min=min(GeneStart_cis),max=max(GeneEnd_cis))
write.table(gtf.neg,"~/Desktop/adna_02_22_2016/UCSC_Genes_KnownGenes_alltrans_encompass_neg.txt",sep="\t",row.names=F,quote=F)

##156  chr1  -	1227763	1244989	ACAP3
#1217763  1344989 ACAP3
#



colnames(gtf.pos)
colnames(gtf.neg)
gtf.posneg<-rbind(gtf.pos,gtf.neg)
write.table(gtf.posneg,"~/Desktop/adna_02_22_2016/UCSC_Genes_KnownGenes_alltrans_encompass_posneg.txt",sep="\t",row.names=F,quote=F)



gtf<-read.delim("UCSC_Genes_KnownGenes_alltrans_encompass_posneg.txt")

adna.topvars.eQTLinfo<-read.delim("ADRN_allchrs_adna_sig_qc_anno_excl_failed_EH_NAs_removed_clean_newQC_p_lt_0.001_2_22_2016.txt")
adna.topvars.eQTLinfo$Chrom<-paste("chr",adna.topvars.eQTLinfo$Chr,sep="")
adna.topvars.eQTLinfo.UCSCGene<-adna.topvars.eQTLinfo

rm(dat)


####trial

test<-adna.topvars.eQTLinfo.UCSCGene #493482 pval 0.05 qcied SNPs
ucsc<-gtf

dat.trail <- merge(test,ucsc,by.x='Chrom',by.y='hg19.knownGene.chrom') # merge by chromosome
dat.trail <- dat.trail[which(dat.trail$POS >= dat.trail$min & dat.trail$POS <= dat.trail$max),] # filter those that are out of range
length(unique(dat.trail$hg19.kgXref.geneSymbol))

panthergenes<-read.delim("pantherGeneList_nick.txt")
length(unique(panthergenes$hg19.kgXref.geneSymbol))

dat.trail.panther<-merge(dat.trail,panthergenes,by="hg19.kgXref.geneSymbol")


#write out
dat.trail.alltopvars<-merge(adna.topvars.eQTLinfo.UCSCGene,dat.trail.panther,by="chrpos",all.x=T)
colnames(dat.trail.alltopvars)
dat.trail.alltopvars<-dat.trail.alltopvars[c(1:29,31,61:64)]
write.table(dat.trail.alltopvars,"adna_topvars_UCSCGenes_posneg.txt",sep="\t",row.names=F,quote=F)

write.table((unique(dat.trail.alltopvars[which(dat.trail.alltopvars$P_Final_adna.x < 0.001),]$hg19.kgXref.geneSymbol)),"ucsc_genelist_plt0.001.txt",sep="\t",row.names = F,quote = F)
write.table((unique(dat.trail.alltopvars[which(dat.trail.alltopvars$P_Final_adna.x < 0.0001),]$hg19.kgXref.geneSymbol)),"ucsc_genelist_plt0.0001.txt",sep="\t",row.names = F,quote = F)
write.table((unique(dat.trail.alltopvars[which(dat.trail.alltopvars$P_Final_adna.x < 0.00001),]$hg19.kgXref.geneSymbol)),"ucsc_genelist_plt0.00001.txt",sep="\t",row.names = F,quote = F)
write.table((unique(dat.trail.alltopvars[which(dat.trail.alltopvars$P_Final_adna.x < 0.000001),]$hg19.kgXref.geneSymbol)),"ucsc_genelist_plt0.000001.txt",sep="\t",row.names = F,quote = F)
write.table((unique(dat.trail.alltopvars[which(dat.trail.alltopvars$P_Final_adna.x < 0.0000001),]$hg19.kgXref.geneSymbol)),"ucsc_genelist_plt0.0000001.txt",sep="\t",row.names = F,quote = F)
#
library(plyr)

#AD vs NA P <0.001 SNPs with UCSC start and End_ cleaned data set ()
dat2 <- dat.trail.alltopvars
dat2 <- plyr::ddply(dat2, .variables='chrpos', plyr::colwise(paste), collapse = ";")

colnames(dat2)
dat3<-dat2[c(1,30,31,33,34)]

dat.out<-merge(dat3,dat.trail.alltopvars,by="chrpos")

dat.out<-dat.out[which(!duplicated(dat.out$chrpos)),]

colnames(dat.out)
write.table(dat.out,"adna_p_10-3_ucsc_clean_7033_SNPs.txt",sep="\t",row.names=F,quote=F)



#adna topvars merge with eQTL info

adna.topvars<-read.delim("ADRN_allchrs_adna_sig_qc_anno_excl_failed_EH_NAs_removed_clean_newQC_p_lt_0.001_2_22_2016.txt")

eQTL.info<-read.delim("~/Downloads/AD_NA_10^-3_eQTL_genestrtstop/GTEx_sig_eQTLs_061015_release.txt")

colnames(adna.topvars)
colnames(eQTL.info)
adna.topvars$chrpos<-paste(adna.topvars$Chr,adna.topvars$POS,sep=":")
eQTL.info$chrpos<-paste(eQTL.info$snp_chrom,eQTL.info$snp_pos,sep=":")

adna.topvars.eQTLinfo<-merge(adna.topvars,eQTL.info,by="chrpos")

write.table(adna.topvars.eQTLinfo,"adna_topvars_eQTLinfo.txt",sep="\t",row.names=F,quote=F)

adna.topvars.eQTLinfo<-merge(adna.topvars,eQTL.info,by="chrpos",all.x=T)
write.table(adna.topvars.eQTLinfo,"adna_topvars_eQTLinfo_7033SNPs.txt",sep="\t",row.names=F,quote=F)

#skin eQTL 
skin.eQTL.info<-eQTL.info[c(1:5,40,41,50)]
colnames(skin.eQTL.info)[1]<-"Gene_eQTL"
skin.eQTL.info<-skin.eQTL.info[which(skin.eQTL.info$Skin_Not_Sun_Exposed_Suprapubic==1 | skin.eQTL.info$Skin_Sun_Exposed_Lower_leg ==1),]

adna.topvars.skin.eQTLinfo<-merge(adna.topvars,skin.eQTL.info,by="chrpos")

write.table(adna.topvars.skin.eQTLinfo,"adna_topvars_skin_eQTLinfo.txt",sep="\t",row.names=F,quote=F)

write.table((unique(adna.topvars.skin.eQTLinfo[which(adna.topvars.skin.eQTLinfo$P_Final_adna < 0.001),]$Gene_eQTL)),"skineQTL_genelist_plt0.001.txt",sep="\t",row.names = F,quote = F)
write.table((unique(adna.topvars.skin.eQTLinfo[which(adna.topvars.skin.eQTLinfo$P_Final_adna < 0.0001),]$Gene_eQTL)),"skineQTL_genelist_plt0.0001.txt",sep="\t",row.names = F,quote = F)
write.table((unique(adna.topvars.skin.eQTLinfo[which(adna.topvars.skin.eQTLinfo$P_Final_adna < 0.00001),]$Gene_eQTL)),"skineQTL_genelist_plt0.00001.txt",sep="\t",row.names = F,quote = F)
write.table((unique(adna.topvars.skin.eQTLinfo[which(adna.topvars.skin.eQTLinfo$P_Final_adna < 0.000001),]$Gene_eQTL)),"skineQTL_genelist_plt0.000001.txt",sep="\t",row.names = F,quote = F)
write.table((unique(adna.topvars.skin.eQTLinfo[which(adna.topvars.skin.eQTLinfo$P_Final_adna < 0.0000001),]$Gene_eQTL)),"skineQTL_genelist_plt0.0000001.txt",sep="\t",row.names = F,quote = F)








#493482 pval 0.05 qcied SNPs
##482371 mappable SNPs
#genes#26339...> 17963 mapped Genes/20814

#374022 mappable pval 0.04 qcied SNPs
#genes#26131..> 17835 mapped Genes/20814 

#252346 pval 0.03
#genes# 24798..> 17011

#175184 pval 0.02
#genes#23553..>16194

#79791 pval 0.01
#genes#17062..>11764

