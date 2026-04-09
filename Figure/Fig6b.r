
pdf("chr2_hap_gene.pdf",width=3.5,height=1.5)

ggplot(dat4)+geom_bar(aes(x=group,y=Ratio,group=variable,
               fill=variable),stat = 'identity',width = 0.7,position = position_dodge(width = 0.7))+
  labs( y = 'Percent(%)') +coord_flip()+
  scale_fill_manual(values = c("#CC0000","#006633"))+
   scale_y_continuous(breaks = seq(-1.0, 1, 0.4), labels = as.character(abs(seq(-1.0, 1.0, 0.4))), limits = c(-1, 1)) +
  guides(fill="none",alpha="none")+
theme(panel.grid = element_blank(), panel.background = element_rect(color = 'black', fill = 'transparent'),
 legend.title = element_blank(),axis.text = element_text(color="black",size=12),
 axis.title = element_text(color = "black",size=15)) +geom_hline(yintercept = 0, size = 0.4)
dev.off()
