# This programming is to draw power plots

data <- read.table("ADRN_OMNI_het.txt",header=TRUE)
pdf("OMNI_760_het.pdf",width=6,height=7)
par(mfrow=c(2,1))
par(mar=c(5,4.5,0,2))
par(omi=c(.5,0,.5,0))
fig=c(3,9,1,4)/10

# Plot for GWA
plot(data$ORDER,data$F, xlim=c(0,760),ylim=c(-0.3865,0.1366),
     xlab="Sample",ylab="Inbreeding Coefficient",col="lightskyblue4",pch=20)
dev.off()

