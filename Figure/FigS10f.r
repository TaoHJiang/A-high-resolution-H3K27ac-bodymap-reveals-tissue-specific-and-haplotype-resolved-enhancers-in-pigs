library(ggplot2)
dat=read.table("AS_enh_enrich_imprinting_regions.txt",head=T)
pdf(file="AS_enh_enrich_imprinting_regions.pdf",width=4,height=3)
ggplot(data = dat,aes(x = log10(dat$M+1),y = -log10(N)))+geom_point(size = 1)+
 theme_set(theme_bw())+theme(panel.grid = element_blank())+
 theme(panel.border = element_blank(),axis.line = element_line(colour="black",size=1))+
 theme(panel.grid = element_blank(),panel.background=element_blank())+
 theme(legend.text=element_text(size=15),legend.title=element_blank())+
 labs(x = "Log10 (odds ratio)", y = "-Log10 (pvalue)")+
 theme(axis.title= element_text(size=16,color="black",vjust=0.5, hjust=0.5))+
 theme(axis.text.x=element_text(hjust = 1,vjust =0.5,color ="black",size=16),
 axis.text.y=element_text(size=16,color="black"))+scale_y_continuous(expand=c(0,0),limits=c(0,10))+
 scale_x_continuous(limits=c(-5,5))+ geom_vline(xintercept=0.05,lty=3,col="black",lwd=0.5) +#添加横线|FoldChange|>2
  geom_hline(yintercept = 0,lty=3,col="black",lwd=0.5)
dev.off()
