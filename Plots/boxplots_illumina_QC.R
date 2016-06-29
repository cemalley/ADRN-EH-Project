data <- read.delim("ADRN_761_illumina_qc.txt")
data$case_control <- data$Phenotype
data$case_control <- ifelse(is.na(data$case_control == "TRUE"),0,1)

attach(data)

color= c("black", "red")
palette(color)
beeswarm(Percent_Callable ~ case_control, data=data,col=1:2,pch=16,cex=0.5,ylim=c(min(Percent_Callable),max(Percent_Callable)), labels=c("NA", "AD"),las=0,xlab="",ylab="% Callable")
bxplot(Percent_Callable ~ case_control, data=data,add=T)


color= c("black", "red")
palette(color)
beeswarm(Percent_Callable_5x ~ case_control, data=data,col=1:2,pch=16,cex=0.5,ylim=c(min(Percent_Callable_5x),max(Percent_Callable_5x)), labels=c("NA", "AD"),las=0,xlab="",ylab="% Callable >= 5x")
bxplot(Percent_Callable_5x ~ case_control, data=data,add=T)

color= c("black", "red")
palette(color)
beeswarm(Percent_Callable_10x ~ case_control, data=data,col=1:2,pch=16,cex=0.5,ylim=c(min(Percent_Callable_10x),max(Percent_Callable_10x)), labels=c("NA", "AD"),las=0,xlab="",ylab="% Callable >= 10x")
bxplot(Percent_Callable_10x ~ case_control, data=data,add=T)

color= c("black", "red")
palette(color)
beeswarm(Percent_Callable_20x ~ case_control, data=data,col=1:2,pch=16,cex=0.5,ylim=c(min(Percent_Callable_20x),max(Percent_Callable_20x)), labels=c("NA", "AD"),las=0,xlab="",ylab="% Callable >= 20x")
bxplot(Percent_Callable_20x ~ case_control, data=data,add=T)

color= c("black", "red")
palette(color)
beeswarm(Average_Coverage ~ case_control, data=data,col=1:2,pch=16,cex=0.5,ylim=c(min(Average_Coverage),max(Average_Coverage)), labels=c("NA", "AD"),las=0,xlab="",ylab="Average Coverage")
bxplot(Average_Coverage ~ case_control, data=data,add=T)

detach(data)
