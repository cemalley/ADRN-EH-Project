rm(list=ls())

dat1=read.table("ADRN_PCA_fin2.txt", header=T, stringsAsFactors=F)
m11=mean(dat1$PC1)
s11=sd(dat1$PC1)
m12=mean(dat1$PC2)
s12=sd(dat1$PC2)

library(psy)

mycol=c("blue","darkgreen","yellow","red")
mycol1=c("blue","darkgreen","yellow","red")

mycol2=c("blue","red")
mycol3=c("blue","darkgreen","yellow","grey","red")

pdf("plot.MDS.PCA.outlier2.pdf",onefile=T)
par(mfrow=c(1,1))
par(mar=c(5,4.5,0,2))
par(omi=c(.5,0,.5,0))
fig=c(3,9,1,4)/10
plot(dat1$PC1, dat1$PC2, col="transparent", bg=mycol3[unclass(dat1$GROUP)],
     pch=21, cex=1,xlab="Principal Component 1",ylab="Principal Component 2")
legend("bottomleft", legend=c("ADRN","CEU","YRI","CHB"),pch=21,pt.cex=1,
       pt.bg=c("blue","darkgreen","yellow","grey"),cex=1)

plot(dat1$PC1, dat1$PC3, col="transparent", bg=mycol3[unclass(dat1$GROUP)],
     pch=21, cex=1,xlab="Principal Component 1",ylab="Principal Component 3")
legend("topleft", legend=c("ADRN","CEU","YRI","CHB"),pch=21,pt.cex=1,
       pt.bg=c("blue","darkgreen","yellow","grey"),cex=1)

plot(dat1$PC2, dat1$PC3, col="transparent", bg=mycol3[unclass(dat1$GROUP)],
     pch=21, cex=1,xlab="Principal Component 2",ylab="Principal Component 3")
legend("topleft", legend=c("ADRN","CEU","YRI","CHB"),pch=21,pt.cex=1,
       pt.bg=c("blue","darkgreen","yellow","grey"),cex=1)

dev.off()

dat2=read.table("ADRN_PCA_fin2.txt", header=T, stringsAsFactors=F)
m11=mean(dat2$PC1)
s11=sd(dat2$PC1)
m12=mean(dat2$PC2)
s12=sd(dat2$PC2)

pdf("plot.MDS.PCA.fin2.pdf",onefile=T)
par(mfrow=c(1,1))
par(mar=c(5,4.5,0,2))
par(omi=c(.5,0,.5,0))
fig=c(3,9,1,4)/10
plot(dat2$PC1, dat2$PC2, col="transparent", bg=mycol1[unclass(dat2$GROUP)],
pch=21, cex=1,xlab="Principal Component 1",ylab="Principal Component 2")
legend("bottomleft", legend=c("ADRN","CEU","YRI","CHB"),pch=21,pt.cex=1,
pt.bg=c("blue","darkgreen","yellow","red"),cex=1)

plot(dat2$PC1, dat2$PC3, col="transparent", bg=mycol1[unclass(dat2$GROUP)],
     pch=21, cex=1,xlab="Principal Component 1",ylab="Principal Component 3")
legend("topleft", legend=c("ADRN","CEU","YRI","CHB"),pch=21,pt.cex=1,
       pt.bg=c("blue","darkgreen","yellow","red"),cex=1)

plot(dat2$PC2, dat2$PC3, col="transparent", bg=mycol1[unclass(dat2$GROUP)],
     pch=21, cex=1,xlab="Principal Component 2",ylab="Principal Component 3")
legend("topleft", legend=c("ADRN","CEU","YRI","CHB"),pch=21,pt.cex=1,
       pt.bg=c("blue","darkgreen","yellow","red"),cex=1)

dev.off()

dat3=read.table("ADRN_OMNI_PCA3.txt", header=T, stringsAsFactors=F)
m11=mean(dat3$PC1)
s11=sd(dat3$PC1)
m12=mean(dat3$PC2)
s12=sd(dat3$PC2)

pdf("plot.MDS.PCA3.pdf",onefile=T)
par(mfrow=c(1,1))
par(mar=c(5,4.5,0,2))
par(omi=c(.5,0,.5,0))
fig=c(3,9,1,4)/10
plot(dat3$PC1, dat3$PC2, col="transparent", bg=mycol1[unclass(dat3$GROUP)],
     pch=21, cex=1,xlab="Principal Component 1",ylab="Principal Component 2")
legend("bottomleft", legend=c("CEU","YRI","CHB","ADRN"),pch=21,pt.cex=1,
       pt.bg=c("red","darkgreen","yellow","blue"),cex=1)

plot(dat3$PC1, dat3$PC3, col="transparent", bg=mycol1[unclass(dat3$GROUP)],
     pch=21, cex=1,xlab="Principal Component 1",ylab="Principal Component 3")
legend("topleft", legend=c("CEU","YRI","CHB","ADRN"),pch=21,pt.cex=1,
       pt.bg=c("red","darkgreen","yellow","blue"),cex=1)

plot(dat3$PC2, dat3$PC3, col="transparent", bg=mycol1[unclass(dat3$GROUP)],
     pch=21, cex=1,xlab="Principal Component 2",ylab="Principal Component 3")
legend("topleft", legend=c("CEU","YRI","CHB","ADRN"),pch=21,pt.cex=1,
       pt.bg=c("red","darkgreen","yellow","blue"),cex=1)

dev.off()
