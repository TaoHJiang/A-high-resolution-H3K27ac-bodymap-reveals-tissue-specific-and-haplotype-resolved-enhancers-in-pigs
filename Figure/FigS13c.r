setwd("/work/jiangtao/2024_H3K27ac_phase/ASB/depth/")
data=read.table("TF_score_ASB_score.txt",head=T)
dat=data.frame(data$name,data$TF)
dat2=unique(dat)

TF_per_loci=as.data.frame(table(dat2[,1]))

library(ggplot2)
pdf("TF_per_loci.pdf",height=3,width=5)
ggplot(TF_per_loci,aes(x=Freq))+geom_histogram(binwidth=0.5)+theme_bw()+ scale_y_continuous(expand=c(0,0))+
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
  ylab('Count')+
  xlab('Number of allelic TFs per ASB')

dev.off()  