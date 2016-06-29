ibs=read.table("filename.txt", header=T, stringsAsFactors=F)
colnames(ibs2)=c("fid1","id1","fid2","id2","rt","ez","z0","z1","z2","phat","phe","dst",
                 "ppc","ratio")
#ibs2=subset(ibs, ibs$PI_HAT>0.05)#originally commented out
dim(ibs2)
mycol=matrix(ncol=1,nrow=nrow(ibs2))

#write.csv(ibs2,"ibs.phat.outliers2.csv", row.names=F, quote=F)

for (i in 1:nrow(ibs2)){
  if (ibs2[i,9]>.97){mycol[i]="green3"} ##dups
  if (ibs2[i,7]<0.05 & ibs2[i,8]>0.97 & ibs2[i,9]<0.05){mycol[i]="blue"} ## p-o
  if (ibs2[i,7]<0.4 & ibs2[i,8]>0.4 & ibs2[i,9]>0.16){mycol[i]="red"}## full sibs2
  if (ibs2[i,7]<0.6 & ibs2[i,8]<0.58 & ibs2[i,9]<0.05){mycol[i]="magenta"} ## 1/2 sibs2
  if (ibs2[i,7]>0.6 & ibs2[i,8]<0.4 & ibs2[i,9]<0.02){mycol[i]="grey"} ## cousins
  if (ibs2[i,7]>0.78){mycol[i]="black"}
}

#write.csv(cbind(ibs2,mycol),"ibs.phat.outliers2.csv", row.names=F, quote=F)

png("ibsplot_ADRN_IBS_total.png")
plot.new()
plot(ibs2$z0, ibs2$z1, cex=1.4, xlim=c(0,1), ylim=c(0,1), main="" )
abline(h = 1:0, v = 1:0, col = "gray", lty=3)
abline(h = 0.75, v=0.75, col = "gray", lty=3)
abline(h = 0.5:0,v=0.5, col = "gray", lty=3)
abline(h = 0.25:0,v=0.25, col = "gray", lty=3)
legend("topright", legend=c("Duplicates/MZ tiwns", "Parent=Offspring", "Full Sibs", "Half Sibs", "Cousins", 
                            "Unrelated"),pch=19, col=c("green3","blue","red","magenta","grey","black"))
points(ibs2$z0,ibs2$z1, pch=19, col=mycol, cex=1.4)
dev.off()