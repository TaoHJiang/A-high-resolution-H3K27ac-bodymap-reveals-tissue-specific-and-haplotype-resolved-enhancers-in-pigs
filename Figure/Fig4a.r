library(ggplot2)
library(reshape2)
setwd("/home/pencode/2024H3K27ac/specific_conbine/tissue")
data=read.table("total_tissue_specific_tissue_site.txt",head=T,sep="\t")
data$Tissue_specific2=data[,2]-data[,3]
data2=data[,-2]
datt=melt(data2)

#library(forcats)
#datt$variable <- forcats::fct_rev(datt$variable)

pdf("tissue_specific_tissue_site_peak_number.pdf",width=14,height=6)
ggplot(datt, aes(name, value, fill = variable)) +
geom_bar(stat="identity", width = 0.7,position = position_stack(reverse = TRUE))+
scale_fill_manual(values = c('#E95D53', '#7488B5'), breaks = c( "Tissue_specific2","Tissue_site_specific")) +
theme(panel.background = element_rect(fill = NA, color = 'black'),  
    axis.line = element_line(colour = 'black'), axis.text.x = element_text(angle = 45, hjust = 1)) +
labs(title = NULL, x = NULL, y = 'Number of peaks')+
 theme(legend.text=element_text(colour="black", size=12),panel.border=element_blank(),
       legend.position=c(0.75,0.9),legend.title = element_blank(),
         panel.grid.major.x = element_blank(),
         panel.grid.minor.x = element_blank(),
        panel.grid.minor.y = element_blank(),
 panel.grid.major.y = element_blank(),
 axis.line=element_line(color="black"),
 axis.text.x = element_text(angle = 90,vjust=0.5,colour="black",size=12),
         axis.title.x=element_text(colour="black", size=13),
         axis.text.y = element_text(vjust=0.5,colour="black",size=12),
         axis.title.y=element_text(colour="black", size=13))
 dev.off()
