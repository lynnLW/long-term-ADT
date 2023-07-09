path="H:/2022/project/microbiome/microbiome/ADT/duration/"
setwd(path)
#metainfo
meta<-read.table("../metainfo/duration-metainfo.txt",header=T,row.names = 1)
#alpha diversity
alpha<-read.table("alpha_diversity/alpha_diversity.csv",sep=",",header=T,row.names = 1)
alpha<-alpha[row.names(meta),]
library(ggpubr)
merge<-merge(alpha,meta,by="row.names")
var<-names(merge)[c(2:3,5,7:11)]
var
##multi-linear regression
for (i in var){
  print(i)
  fit<-lm(paste0(i,"~months_to_ADT+Age+ISUP_GG+BMI"),data=merge)
  static<-as.data.frame(summary(fit)$coefficients)
  write.table(static,file=paste0("alpha_diversity/",i,"_months_to_ADT_static.csv"),sep=",")
  p<-ggscatter(merge,x="months_to_ADT",y=i,color="blue",
               add="reg.line")+stat_cor(method = "spearman")
  print(p)
  ggsave(p,filename = paste0("alpha_diversity/",i,"_months_to_ADT.jpg"),units="cm",width=8,height=8,dpi=600)
}
## boxplot
for (i in var){
  comparisons=list(c("L","S"),c("L","M"),c("M","S"))
  p<-ggboxplot(merge,x="Duration",y=i,color="Duration",
               palette = "jco",
               xlab="",
               legend="none",order=c("S","M","L"))+
    stat_compare_means(comparisons = comparisons)
  p
  ggsave(p,filename = paste0("alpha_diversity/",i,"_duration.jpg"),units="cm",width=8,height=10,dpi=600)
}



