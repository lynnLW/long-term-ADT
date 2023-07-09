path="H:/2022/project/microbiome/microbiome/ADT/duration"
setwd(path)
load("dataset.Rdata")
dir.create("plot/taxa/",recursive = T)
dataset$sample_table$Duration<-factor(dataset$sample_table$Duration,levels = c("S","M","L"))
#Figure3A
# return a ggplot2 object
t2 <- trans_abund$new(dataset = dataset, taxrank = "Phylum",
                      ntaxa = 10, groupmean = variable)
t2$plot_bar(others_color = "grey70", legend_text_italic = FALSE)
ggsave(filename =paste0("plot/taxa/taxa_bar_mean_phylum_",variable,".jpg"),dpi=600,units="cm",
       width = 7,height = 8,scale=1.3)
#Figure3B
# show 40 taxa at Genus level
t4 <- trans_abund$new(dataset = dataset, taxrank = "Genus", ntaxa = 40)
p<-t4$plot_heatmap(facet = variable, xtext_keep = FALSE, withmargin = FALSE)
p
ggsave(filename =paste0("plot/taxa/taxa_heatmap_genus_",variable,".jpg"),dpi=600,units="cm",width = 16,height = 12,scale=1.8)