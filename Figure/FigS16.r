chr5_77029501 <- data.frame(
  category = c("A", "G"),
  value = c(0, 66)
)



pdf("chr5_77029501_NHLH2.pdf",height=3,width=3)
ggplot(chr5_77029501,aes(x=category,y=value,fill=category))+geom_bar(stat='identity',width=0.5)+theme_bw()+ 
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