chr15_154269004 <- data.frame(
  category = c("C", "T"),
  value = c(31, 10.5)
)
chr15_154269004$category <- factor(chr15_154269004$category, levels = c('C','T'))

pdf("chr15_154269004_ZIC1.pdf",height=3,width=3)
ggplot(chr15_154269004,aes(x=category,y=value,fill=category))+geom_bar(stat='identity',width=0.5)+theme_bw()+ 
scale_y_continuous(expand=c(0,0))+scale_fill_manual(values=c("#DC143C","#00008B"))+
theme(legend.text=element_text(colour="black", size=12),
panel.border=element_blank(),legend.position=c(0.95,0.95),legend.title = element_blank(),
  panel.grid.major.x = element_blank(),
         panel.grid.minor.x = element_blank(),
        panel.grid.minor.y = element_blank(),
 panel.grid.major.y = element_blank(),
 axis.line=element_line(color="black"),
 axis.text.x = element_text(colour="black",size=12),
         axis.title.x=element_text(colour="black", size=13),
         axis.text.y = element_text(colour="black",size=12),
         axis.title.y=element_text(colour="black", size=13))+
  ylab('Read Counts')+
  xlab('')

dev.off() 
