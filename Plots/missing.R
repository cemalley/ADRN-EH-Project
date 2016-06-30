# This programming is to draw power plots

data <- read.table("ADRN_OMNI_missing.txt",header=TRUE)
pdf("OMNI_760_missing.pdf",width=6,height=7)
par(mfrow=c(2,1))
par(mar=c(5,4.5,0,2))
par(omi=c(.5,0,.5,0))
fig=c(3,9,1,4)/10

# Plot for GWA
plot(data$ORDER,data$F_MISS, xlim=c(0,760),ylim=c(0,0.1983),
     xlab="Sample",ylab="Missingness frequency",col="lightskyblue4",pch=20)
dev.off()

dat2 <- read.table("ADRN_OMNI_missing2.txt",header=TRUE)
pdf("OMNI_760_missing2.pdf",width=6,height=7)
par(mfrow=c(2,1))
par(mar=c(5,4.5,0,2))
par(omi=c(.5,0,.5,0))
fig=c(3,9,1,4)/10

# Plot for GWA
plot(dat2$ORDER,dat2$F_MISS, xlim=c(0,760),ylim=c(0,0.017),
     xlab="Sample",ylab="Missingness frequency",col="lightskyblue4",pch=20)
dev.off()
