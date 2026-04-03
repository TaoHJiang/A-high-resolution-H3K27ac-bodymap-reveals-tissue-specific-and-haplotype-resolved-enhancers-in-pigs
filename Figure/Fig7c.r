library(ggplot2)
pdf("chr5_77027768_77029785.pdf",width=4.5,height=3)
ggplot(data = df,aes(x = ratio,y = logq))+geom_point(aes(color=V9),size = 3)+ 
 theme_set(theme_bw())+theme(panel.grid = element_blank())+
 theme(panel.border = element_blank(),axis.line = element_line(colour="black",size=1))+
 theme(panel.grid = element_blank(),panel.background=element_blank())+
 theme(legend.text=element_text(size=15),legend.title=element_blank())+scale_color_manual(values=c(
  rep("dark blue",2),rep("black",146)),breaks=c("HS3F14a1R_H3K27AC_deeptools_tmp","HS3F15a1W_H3K27AC_deeptools_tmp",rep("Other_tissues",146)),labels=c("Uterus_1","Uterus_2",rep("Other_tissues",146)))+
 labs(x = "Ratio", y = "-Log10(q-value)")+
 theme(axis.title= element_text(size=16,color="black",vjust=0.5, hjust=0.5))+
 theme(axis.text.x=element_text(hjust = 1,vjust =0.5,color ="black",size=16),
 axis.text.y=element_text(size=16,color="black"))
dev.off()
