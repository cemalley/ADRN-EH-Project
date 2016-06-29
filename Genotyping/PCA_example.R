
rm(list=ls())

library(psy)

dat1=read.table("ADRN_499_plus_others_CAAPA_MDS_data_smartPCA_with_pop_04-15-14.txt", header=T, stringsAsFactors=F)
m11=mean(dat1$PC1)
s11=sd(dat1$PC1)
m12=mean(dat1$PC2)
s12=sd(dat1$PC2)

mycol1=c("blue","red","darkgreen","coral")

pdf("ADRN_plot_CAAPA_MDS_PCA.pdf",onefile=T)
par(mfrow=c(1,1))
par(mar=c(5,4.5,0,2))
par(omi=c(.5,0,.5,0))
fig=c(3,9,1,4)/10
plot(dat1$PC1, dat1$PC2, col="transparent",bg=mycol1[unclass(dat1$Pop)], 
pch=21, cex=1,xlab="Principal Component 1",ylab="Principal Component 2")
#abline(h =m12 ,v=m11, col = "gray", lty=1, lwd=2)
#abline(h =m12+s12 ,v=m11+s12, col = "gray", lty=2, lwd=1)
#abline(h =m12+(2*s12) ,v=m11+(2*s11), col = "gray", lty=2, lwd=1)
#abline(h =m12-s12 ,v=m11-s12, col = "gray", lty=2, lwd=1)
#abline(h =m12-(2*s12) ,v=m11-(2*s11), col = "gray", lty=2, lwd=1)
#abline(h =m12-(3*s12) ,v=m11-(3*s11), col = "gray", lty=2, lwd=1)
#abline(h =m12-(4*s12) ,v=m11-(4*s11), col = "gray", lty=2, lwd=1)
#abline(h =m12-(5*s12) ,v=m11-(5*s11), col = "gray", lty=2, lwd=1)
#abline(h =m12-(6*s12) ,v=m11-(6*s11), col = "gray", lty=2, lwd=1)
#abline(h =m12+(3*s12) ,v=m11+(3*s11), col = "gray", lty=2, lwd=1)
#abline(h =m12+(4*s12) ,v=m11+(4*s11), col = "gray", lty=2, lwd=1)
#abline(h =m12+(5*s12) ,v=m11+(5*s11), col = "gray", lty=2, lwd=1)
#abline(h =m12+(6*s12) ,v=m11+(6*s11), col = "gray", lty=2, lwd=1)
legend("topright", legend=c("ADRN","CEU","CHB","YRI"),pch=21,pt.cex=2,pt.bg=c("blue","red","darkgreen","coral"),cex=2)


dev.off()