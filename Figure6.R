library(forestploter)
library(forestplot)
data<-read.csv(file="mr_pca.csv")
tabletext<-data[,c(1:5,9:12)]
pdf("mr_pca.pdf",width = 14,height = 6)
forestplot(data,mean,lower,upper,tabletext,
           graph.pos=5,
           xlab="",is.summary=c(T,rep(F,8)),
           col=fpColors(box="darkblue", lines="red", zero = "black"),
           boxsize=0.2,clip =c(-.1, Inf),xticks=c(-0.01,0,0.01),
           zero=0,hrzl_lines=T,
           cex=2, line.margin=0.01,
           colgap=unit(5,"mm"),
           txt_gp=fpTxtGp(label=gpar(cex=1.2),
                          ticks=gpar(cex=0.8),
                          xlab=gpar(cex = 1),
                          title=gpar(cex = 1)))
dev.off()
##
data<-read.csv(file="mr_test.csv")
tabletext<-data[,c(1:5,9:12)]
pdf("mr_test.pdf",width = 10,height=4)
forestplot(data,mean,lower,upper,tabletext,
           graph.pos=5,
           xlab="",is.summary=c(T,rep(F,5)),
           col=fpColors(box="darkblue", lines="red", zero = "black"),
           boxsize=0.2,
           zero=0,hrzl_lines=T,
           cex=2, line.margin=0.01,
           colgap=unit(5,"mm"),
           txt_gp=fpTxtGp(label=gpar(cex=1.2),
                          ticks=gpar(cex=1),
                          xlab=gpar(cex = 1),
                          title=gpar(cex = 1)))
dev.off()
