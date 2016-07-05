## A useful set of aesthetic and theme adjustments for ggplot 2.

install.packages('wesanderson')
library(wesanderson)
library(ggplot2)

tt <-theme(legend.text = element_text(size=14), legend.title=element_text(size=16), text=element_text(size=14), axis.text = element_text(size=14))


## C Malley Jul 2 2016
