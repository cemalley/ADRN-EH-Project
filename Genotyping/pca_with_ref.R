
rm(list=ls())

library(psy)

dat1=read.table("ADRN_499_plus_ref_CAAPA_MDS_data_smartPCA_clean_markers_04-16-14.txt", header=T, stringsAsFactors=F)
m11=mean(dat1$PC2)
s11=sd(dat1$PC2)
m12=mean(dat1$PC3)
s12=sd(dat1$PC3)

mycol1=c("blue","red","green","coral")

pdf("ADRN_plot_CAAPA_MDS_PCA_with_ref_clean_markers_PC2vsPC3.pdf",onefile=T)
par(mfrow=c(1,1))
par(mar=c(5,4.5,0,2))
par(omi=c(.5,0,.5,0))
fig=c(3,9,1,4)/10
plot(dat1$PC2, dat1$PC3, col="transparent",bg=mycol1[unclass(dat1$Pop)], 
pch=21, cex=1,xlab="Principal Component 2",ylab="Principal Component 3")
abline(h =m12 ,v=m11, col = "gray", lty=1, lwd=2)
abline(h =m12+s12 ,v=m11+s12, col = "gray", lty=2, lwd=1)
abline(h =m12+(2*s12) ,v=m11+(2*s11), col = "gray", lty=2, lwd=1)
abline(h =m12-s12 ,v=m11-s12, col = "gray", lty=2, lwd=1)
abline(h =m12-(2*s12) ,v=m11-(2*s11), col = "gray", lty=2, lwd=1)
abline(h =m12-(3*s12) ,v=m11-(3*s11), col = "gray", lty=2, lwd=1)
abline(h =m12-(4*s12) ,v=m11-(4*s11), col = "gray", lty=2, lwd=1)
abline(h =m12-(5*s12) ,v=m11-(5*s11), col = "gray", lty=2, lwd=1)
abline(h =m12-(6*s12) ,v=m11-(6*s11), col = "gray", lty=2, lwd=1)
abline(h =m12+(3*s12) ,v=m11+(3*s11), col = "gray", lty=2, lwd=1)
abline(h =m12+(4*s12) ,v=m11+(4*s11), col = "gray", lty=2, lwd=1)
abline(h =m12+(5*s12) ,v=m11+(5*s11), col = "gray", lty=2, lwd=1)
abline(h =m12+(6*s12) ,v=m11+(6*s11), col = "gray", lty=2, lwd=1)
legend("topleft", legend=c("ADRN","CEU","CHB","YRI"),pch=21,pt.cex=2,pt.bg=c("blue","red","green","coral"),cex=2)


dev.off()
