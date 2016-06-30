ADRN <- read.table("ADRN_test.txt",header=T,na.string="NA")
Exclude <- read.table("OMNI_toexclude.txt",header=T,na.string="NA")
Exclude$EXTRACOL <- 1
ADRN2 <- merge(ADRN,Exclude,all=T)
ADRNfin <- ADRN2[is.na(ADRN2$EXTRACOL),]
ADRNfin$EXTRACOL <- NULL
attach(ADRNfin)
ADRNfin$RC.AFFSTAT[DIAGRP!="ADEH+"] <- 1
ADRNfin$RC.AFFSTAT[DIAGRP=="ADEH+" & Recurrent>0 & !is.na(DISK)] <- 2
ADRNfin$AD.AFFSTAT[DIAGRP=="Non-Atopic"] <- 1
ADRNfin$AD.AFFSTAT[DIAGRP=="Staph+" | DIAGRP=="Staph-"] <- 2
ADRNfin$Staph.AFFSTAT[DIAGRP=="Staph-"] <- 1
ADRNfin$Staph.AFFSTAT[DIAGRP=="Staph+"] <- 2
ADRNfin$EH.AFFSTAT[DIAGRP=="Staph+" | DIAGRP=="Staph-"] <- 1
ADRNfin$EH.AFFSTAT[DIAGRP=="ADEH+"] <- 2
ADRNfin$EHNA.AFFSTAT[DIAGRP=="Non-Atopic"] <- 1
ADRNfin$EHNA.AFFSTAT[DIAGRP=="ADEH+"] <- 2
detach(ADRNfin)
ADRNfin$LOGIGE <- log10(ADRNfin$TOTIGE)
ADRNfin$LOGEOS <- log10(ADRNfin$EOSIN+10)
ADRNfin$LOGEASI <- log10(ADRNfin$EASI+1)
ADRNfin$LOGPHAD <- log10(ADRNfin$APHADN+1)
ADRNfin$RLADJ <- (((ADRNfin$RLTOT)^(1.5)-1)/(1.5))

ADRNfinal=subset(ADRNfin,select=c(PATIENT,ID,GENDER,Recurrent,RC.AFFSTAT,AD.AFFSTAT,Staph.AFFSTAT,EH.AFFSTAT,
                                  EHNA.AFFSTAT,LOGIGE,LOGEOS,LOGEASI,LOGPHAD,RLADJ))

#Final file
write.table(ADRNfinal,"ADRN_phenotype_master2.txt",sep="\t",row.names=F,quote=F)

#Summary stats
Staph=subset(ADRNfin,DIAGRP=="Staph+" | DIAGRP=="Staph-")
Nonatopic=subset(ADRNfin,DIAGRP=="Non-Atopic")
attach(ADRNfin)
ADRNfin$AD.AFFSTAT[DIAGRP=="Non-Atopic"] <- 1
ADRNfin$AD.AFFSTAT[DIAGRP=="Staph+" | DIAGRP=="Staph-"] <- 2
detach(ADRNfin)
ADNA=subset(ADRNfin,DIAGRP=="Non-Atopic" | DIAGRP=="Staph+" | DIAGRP=="Staph-")
library(psych)
library(doBy)
summaryBy(AGE ~ AD.AFFSTAT, data = ADNA, 
          FUN = function(x) { c(m = mean(x), s = sd(x), n = length(x))} )
ADNA_IGE=subset(ADNA,!is.na(LOGIGE))
IGE_results <-summaryBy(LOGIGE ~ AD.AFFSTAT, data = ADNA_IGE,  
                        FUN = function(x) { c(m = mean(x), s = sd(x), n = length(x), 
                                              lci = mean(x) - qt(0.975, df=length(x)-1)*(sd(x)/sqrt(length(x))),
                                              uci = mean(x) + qt(0.975, df=length(x)-1)*(sd(x)/sqrt(length(x))))} )
IGE_results$geo_mean <- 10^(IGE_results$LOGIGE.m)
IGE_results$geo_lci <- 10^(IGE_results$LOGIGE.lci)
IGE_results$geo_uci <- 10^(IGE_results$LOGIGE.uci)
ADNA_EOS=subset(ADNA,!is.na(LOGEOS))
EOS_results <-summaryBy(LOGEOS ~ AD.AFFSTAT, data = ADNA_EOS,  
                        FUN = function(x) { c(m = mean(x), s = sd(x), n = length(x), 
                                              lci = mean(x) - qt(0.975, df=length(x)-1)*(sd(x)/sqrt(length(x))),
                                              uci = mean(x) + qt(0.975, df=length(x)-1)*(sd(x)/sqrt(length(x))))} )
EOS_results$geo_mean <- 10^(EOS_results$LOGEOS.m)
EOS_results$geo_lci <- 10^(EOS_results$LOGEOS.lci)
EOS_results$geo_uci <- 10^(EOS_results$LOGEOS.uci)
ADNA_PHAD=subset(ADNA,!is.na(LOGPHAD))
PHAD_results <-summaryBy(LOGPHAD ~ AD.AFFSTAT, data = ADNA_PHAD,  
                         FUN = function(x) { c(m = mean(x), s = sd(x), n = length(x), 
                                               lci = mean(x) - qt(0.975, df=length(x)-1)*(sd(x)/sqrt(length(x))),
                                               uci = mean(x) + qt(0.975, df=length(x)-1)*(sd(x)/sqrt(length(x))))} )
PHAD_results$geo_mean <- 10^(PHAD_results$LOGPHAD.m)
PHAD_results$geo_lci <- 10^(PHAD_results$LOGPHAD.lci)
PHAD_results$geo_uci <- 10^(PHAD_results$LOGPHAD.uci)
ADNA_EASI=subset(ADNA,!is.na(EASI))
summaryBy(EASI ~ AD.AFFSTAT, data = ADNA_EASI ,
          FUN = function(x) { c(m = mean(x), s = sd(x), n = length(x), min = min(x), max = max(x))} )
ADNA_RL=subset(ADNA,!is.na(RLTOT))
summaryBy(RLTOT ~ AD.AFFSTAT, data = ADNA_RL ,
          FUN = function(x) { c(m = mean(x), s = sd(x), n = length(x))} )

chisq.test(ADNA$AD.AFFSTAT,ADNA$Gender)
t.test(ADNA$AGE~ADNA$AD.AFFSTAT)
t.test(ADNA$LOGIGE~ADNA$AD.AFFSTAT)
t.test(ADNA$LOGEOS~ADNA$AD.AFFSTAT)