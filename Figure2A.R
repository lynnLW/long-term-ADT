#Figure2A
##rafa cruve
library(ggpubr)
##alpha
data<-read.table("rafa_cruves/observed_features.csv",sep=",",header=T)
data$Duration<-factor(data$Duration,levels = c("S","M","L"))
library(vegan)
library(tidyverse)
library("ggsci")
data2 <- data %>% gather("depth", "observed_features", -sampleid, -Duration) 
data2$depth<-gsub("_iter\\.\\d+","",data2$depth) 
data2$depth<-as.numeric(gsub("depth\\.", "", data2$depth))
p2 <- ggplot(data2, aes(depth, observed_features, color = Duration, 
                        group = Duration))+
  geom_smooth(se = F, method = "lm", formula = y~log(x))
p2<-p2+theme_classic()
p2<-p2+scale_color_jco()
p2
ggsave("rafa_cruves/observed_otus_rarefaction_groups.jpg", dpi=600,height = 4, width =5)