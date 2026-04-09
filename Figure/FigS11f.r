rm(list = ls())
data=read.table("chr1_7425858_7429917_chr1_7389527_7391606_logH1_H2_IGF2R.txt")

pdf(file=paste0("chr1_7425858_7429917_chr1_7389527_7391606_logH1_H2_IGF2R",".pdf"),width=5,height=4)
ggplot(data = df2,aes(x = prolog,y = enhlog))+geom_point(size = 3)+ geom_smooth(method = 'lm',se=F,color='red')+
 theme_set(theme_bw())+theme(panel.grid = element_blank())+
 theme(panel.border = element_blank(),axis.line = element_line(colour="black",size=1))+
 theme(panel.grid = element_blank(),panel.background=element_blank())+
 theme(legend.text=element_text(size=15),legend.title=element_blank())+
 labs(x = "H1/H2 for enhancer", y = "H1/H2 for promoter")+
 theme(axis.title= element_text(size=16,color="black",vjust=0.5, hjust=0.5))+
 theme(axis.text.x=element_text(hjust = 1,vjust =0.5,color ="black",size=16),
 axis.text.y=element_text(size=16,color="black"))+stat_cor(data=df2, method = "spearman")
dev.off()
