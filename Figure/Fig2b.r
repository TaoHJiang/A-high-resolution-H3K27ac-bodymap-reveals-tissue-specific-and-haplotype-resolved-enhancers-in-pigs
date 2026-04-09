library(ggplot2)
setwd("/home/pencode/2024H3K27ac/co_activity/150kb")
df=read.table("muti_QTL_enrich.txt",head=T)
pdf("multi_QTL_enrich_barplot.pdf",height=3,width=3)
par(mai=c(0.7,0.7,0.3,0.3),mgp=c(2,0.6,0),font.lab=1,font.axis=1,font.main=1.5)
ggplot(df,aes(x=QTL,y=FC,fill=Enh))+
        geom_bar(stat="identity",position="dodge",width=0.7)+
        scale_fill_manual(values = c('#e54c3f','#009fda'))+
        geom_hline(yintercept = 1,linetype ="dashed")+ylim(0,4)+
        theme_bw()+xlab("")+ylab("Fold Change")+
        theme(legend.text=element_text(colour="black", size=12),
              panel.border=element_blank(),
              legend.position=c(0.8,0.95),
              legend.title = element_blank(),
              panel.grid.major.x = element_blank(),
              panel.grid.minor.x = element_blank(),
              panel.grid.minor.y = element_blank(),
              panel.grid.major.y = element_blank(),
              axis.line=element_line(color="black"),
              axis.text.x = element_text(face="italic",hjust=1,angle = 45,colour="black",size=12),
              axis.text.y = element_text(vjust=0.5,colour="black",size=12),
              axis.title.x=element_text(colour="black", size=13),
              axis.title.y=element_text(colour="black", size=13))

dev.off()