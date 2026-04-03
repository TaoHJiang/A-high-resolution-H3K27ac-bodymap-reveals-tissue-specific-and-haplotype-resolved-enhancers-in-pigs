c2=read.table("mrcam.txt")
pdf(file=paste0("./chr9_112109994_112110869_chr9_112103387_112106818_NRCAM",".pdf"),width=5,height=4)
ggplot(data = c2,aes(x = log(p1+1),y = log(p2+1)))+geom_point(size = 3)+ geom_smooth(method = 'lm',se=F,color='red')+
 theme_set(theme_bw())+theme(panel.grid = element_blank())+
 theme(panel.border = element_blank(),axis.line = element_line(colour="black",size=1))+
 theme(panel.grid = element_blank(),panel.background=element_blank())+
 theme(legend.text=element_text(size=15),legend.title=element_blank())+
 labs(x = "Enhancer log(TPM+1)", y = "Promoter log(TPM+1)")+
 theme(axis.title= element_text(size=16,color="black",vjust=0.5, hjust=0.5))+
 theme(axis.text.x=element_text(hjust = 1,vjust =0.5,color ="black",size=16),
 axis.text.y=element_text(size=16,color="black"))+stat_cor(data=c2, method = "spearman")
dev.off()