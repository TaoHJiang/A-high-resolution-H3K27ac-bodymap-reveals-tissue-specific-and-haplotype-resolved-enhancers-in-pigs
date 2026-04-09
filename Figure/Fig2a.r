library(ggplot2)
library(ggbreak)
data=read.table("huatu2.txt")
data$percentage=(data$V4/data$V5)*100
total=data[c(1,2,5,6),]
tissue_specific=data[c(3,4,7,8),]

pdf("total_E-P_within_TAD_percentage.pdf",width=5.5,height=4)
ggplot(data,aes(x=V3,y=percentage,fill=V3))+
  geom_bar(stat="identity",position = "dodge",width=0.6)+
  scale_fill_manual(values = c("#00BFC4","#00BFC4","#F8766D","#F8766D","#00BFC4","#00BFC4","#F8766D","#F8766D"))+
   scale_y_continuous(expand=c(0,0),limits=c(0,100),breaks=c(0,2,4,6,20,40,60,80,100)) +
         scale_y_break(breaks = c(6,60),scales = 1)+
		   theme_classic()+
  theme(legend.position = NULL,
        axis.text.x = element_text(angle=90,hjust = 1,vjust = 1,color="black"),
        legend.title = element_blank())+
  labs(x=NULL,y="Percentage (%)")
dev.off()
