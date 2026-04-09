
library(ggpubr)
pdf(file=paste0("./chr5_77027768_77029785_chr5_77073841_77076162_TUBA8",".pdf"),width=4.5,height=3)
ggplot(data = c2,aes(x = log2(p1+1),y = log2(p2+1)))+geom_point(aes(color=name2),size = 3)+ geom_smooth(method = 'lm',se=F,color='red')+
 theme_set(theme_bw())+theme(panel.grid = element_blank())+
 theme(panel.border = element_blank(),axis.line = element_line(colour="black",size=1))+
 theme(panel.grid = element_blank(),panel.background=element_blank())+
 theme(legend.text=element_text(size=15),legend.title=element_blank())+scale_color_manual(values=c(
  rep("dark blue",2),rep("black",149)),breaks=c("Uterus_1","Uterus_2",rep("Other_tissues",149)),labels=c("Uterus_1","Uterus_2",rep("Other_tissues",149)))+
 labs(x = "Enhancer log2(TPM+1)", y = "Promoter log2(TPM+1)")+
 theme(axis.title= element_text(size=16,color="black",vjust=0.5, hjust=0.5))+
 theme(axis.text.x=element_text(hjust = 1,vjust =0.5,color ="black",size=16),
 axis.text.y=element_text(size=16,color="black"))+stat_cor(data=c2, method = "spearman")
dev.off()