# This programming is to draw power plots

data <- read.table("ADRN_OMNI_gender.txt",header=TRUE,na.string="NA")
pdf("ADRN_OMNI_gender.pdf",width=6,height=7)
par(mfrow=c(2,1))
#par(mar=c(5,4.5,0,2))
#par(omi=c(.5,0,.5,0))
#fig=c(3,9,1,4)/10

# Plot for correlation
attach(data)
plot(ORDER,F,type="n",xlab="Sample",ylab="inbreeding estimate on X chrom",pch=19,cex=0.5,cex.lab=0.8)
points(MALE,F,col="blue",pch=19,cex=0.5)
points(FEMALE,F,col="red",pch=19,cex=0.5)
abline(h=0.8,lty=3,col="blue")
abline(h=0.2,lty=3,col="red")
legend("bottomright",legend=c("Male","Female"),pch=19,col=c("blue","red"))

dev.off()


