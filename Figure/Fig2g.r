pdf(file=paste0("./number_enh_regulate_per_pro_cor_conserved",".pdf"),width=4,height=3)
ggplot(data=c2,aes(Freq,sum)) + geom_bin2d(bins = 70) +
scale_fill_continuous(type = "viridis") +
geom_smooth(method=lm,linetype=2,colour="red",se=F) +
  guides(alpha="none") +  
 theme_set(theme_bw())+theme(panel.grid = element_blank())+
 theme(panel.border = element_blank(),axis.line = element_line(colour="black",size=1))+
 theme(panel.grid = element_blank(),panel.background=element_blank())+
 theme(legend.text=element_text(size=15),legend.title=element_blank())+
 labs(x = "Number of enhancers regulated each promoter", y = "Number of biosamples promoter sharing among")+
 theme(axis.title= element_text(size=16,color="black",vjust=0.5, hjust=0.5))+
 theme(axis.text.x=element_text(hjust = 1,vjust =0.5,color ="black",size=16),
 axis.text.y=element_text(size=16,color="black"))+stat_cor(data=c2, method = "spearman")
dev.off()