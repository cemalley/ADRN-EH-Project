data=read.table("ADRN_eigen_values_smartPCA_484_samples.txt", header=T,na.string="NA")

pdf("ADRN_eigen_values_smartPCA_484_samples_screeplot.pdf",onefile=T)
par(mfrow=c(1,1))
par(mar=c(5,4.5,0,2))
par(omi=c(.5,0,.5,0))
fig=c(3,9,1,4)/10

plot(data$Factor, data$Eigenvalue, col="black", pch=20, cex=1,xlab="Factor Number",ylab="Eigenvalue")
lines(data$Factor,data$Eigenvalue)
dev.off()