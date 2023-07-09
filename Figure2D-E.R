path="H:/2022/project/microbiome/microbiome/ADT/duration"
setwd(path)
library("microeco")
load("dataset.Rdata")
theme_set(theme_bw())
#Figure2D-E and Beta-diversity significance
#plot beta diversity
b<-c("bray","jaccard","unwei_unifrac")
for (i in b){
  variable="Duration"
  t1 <- trans_beta$new(dataset = dataset, group = "Duration", measure = i)
  t1$cal_ordination(ordination="PCoA")
  p<-t1$plot_ordination(plot_color = "Duration", plot_shape = "Duration", 
                        plot_type = c("point","ellipse"))
  p<-p+theme(panel.grid=element_blank())
  p
  ggsave(paste0("plot/beta diversity/pcoa_",variable,"_",i,".tiff"),dpi=600,units="cm",width = 10,height =8,scale=1.5)
  t1$cal_manova(manova_set="Age+Duration+ISUP_GG+BMI")
  res2<-t1$res_manova
  write.table(as.data.frame(res2),file=paste0("beta_diversity/",variable,"_",i,"_manova.csv"),sep=",")
}
