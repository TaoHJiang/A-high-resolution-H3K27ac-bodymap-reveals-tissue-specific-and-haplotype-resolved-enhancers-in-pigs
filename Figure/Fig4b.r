
library(reshape2)
library(ggplot2)

data=read.table("huatu.txt",head=T,sep="\t")
datt=melt(data)

pdf("tissue_specific_observed_in_this_study.pdf",width=10,height=6)
ggplot(datt, aes(tissue, value, fill = variable)) +
geom_bar(stat="identity", width = 0.7,position = position_stack(reverse = TRUE))+
scale_fill_manual(values = c('#E95D53', '#7488B5',"orange")) +
theme(panel.background = element_rect(fill = NA, color = 'black'),  
    axis.line = element_line(colour = 'black'), axis.text.x = element_text(angle = 45, hjust = 1)) +
labs(title = NULL, x = NULL, y = 'Number of peaks')+coord_flip()+scale_y_continuous(expand = c(0, 0)) + 
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