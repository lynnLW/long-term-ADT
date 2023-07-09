#Figure5C
##abundance table
expr<-read.csv("duration-genus-rel-table/duration-genus-rel-table-format.csv",row.names = 1)
##metainfo
meta<-read.table("../metainfo/duration-metainfo.txt",header=T,row.names = 1)
expr<-expr[,row.names(meta)]
##filter
data<-expr
data<-data[which(rowSums(data)>=0.01),]
data<-as.data.frame(t(data))
##features
list<-colnames(data)
merge<-merge(data,meta,by="row.names")
##correlation plot
for (i in 1:length(list)){
      p<-ggscatter(merge,"months_to_ADT",list[i],add=c("reg.line"),
                   conf.int = T,add.params = list(color = "darkblue", fill = "lightgray"),
                   conf.int.level = 0.95,xlab = paste0(var),
                   cor.method = "spearman",color = "darkblue",size=1)+
        stat_cor(method = "spearman")
      p
      ggexport(p,filename=paste0("Masslin2/ADT/",list[i],".jpg"),res=600,width =2100,
               height = 1900)
}
result<-data.frame()
r<-data.frame()
p<-data.frame()
for (i in 1:length(list)){
  f<-lm(merge[[list[i]]]~months_to_ADT+Age+BMI+ISUP_GG,data=merge)
  estimate<-summary(f)$coef[,c(1)]
  pvalue<-summary(f)$coef[,c(4)]
  r<-rbind(r,estimate)
  p<-rbind(p,pvalue)
}
colnames(r)<-names(estimate)
colnames(p)<-names(pvalue)
result<-cbind(r,p)
row.names(result)<-list
write.csv(result,file=paste0("Masslin2/lm/all_lm.csv"))
