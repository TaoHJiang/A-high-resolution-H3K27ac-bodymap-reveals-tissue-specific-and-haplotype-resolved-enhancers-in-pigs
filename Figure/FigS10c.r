library(ggplot2)
dat=read.table("phased_efficiency.txt",head=T)
pdf(file="/tmpdisk/phased_efficiency.pdf",width=6,height=3)
ggplot(dat, aes(x = group, y = mean, fill = group)) +
  geom_bar(stat = "identity", position = position_dodge(), width = 0.5) +
  geom_errorbar(aes(ymin = mean - se, ymax = mean + se), 
                position = position_dodge(0.7), width = 0.15) +#调整误差线长度
  scale_fill_manual(values = c("#f49128","#194a55")) +
  scale_y_continuous(expand = c(0, 0)) +
   theme_set(theme_bw())+theme(panel.grid = element_blank())+
 theme(panel.border = element_blank(),axis.line = element_line(colour="black",size=1))+
 theme(panel.grid = element_blank(),panel.background=element_blank())+
 theme(legend.text=element_text(size=15),legend.title=element_blank())+labs(x = "", y = "Read Counts")+
 theme(axis.title= element_text(size=16,color="black"))+
 theme(axis.text.x=element_text(color ="black",size=16),
 axis.text.y=element_text(size=16,color="black"))

dev.off()