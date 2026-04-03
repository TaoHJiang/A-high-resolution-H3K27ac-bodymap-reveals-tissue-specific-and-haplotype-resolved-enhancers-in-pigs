singularity exec -B /home/pencode/raw_data/2025_Liver/phase:/tmpdisk /home/Singusoft/scdior_vim_SCopeLoomR_AUCell_remotes_SCENIC_ggdendro_chromVAR_ggpubr_corrplot.sif  R
library(ggpubr)
h1=read.table("/tmpdisk/total_H1_reads.txt2")
h2=read.table("/tmpdisk/total_H2_reads.txt2")
dat=data.frame(h1,h2)
colnames(dat)=c("H1_reads","H2_reads")
dat$group=paste0("Rep",rep(c(1,2,3),each = 6))

pdf(file="/tmpdisk/phased_bias.pdf",width=5,height=3)
ggplot(data = dat,aes(x = H1_reads,y = H2_reads,color = group))+geom_point(size = 1)+
 theme_set(theme_bw())+theme(panel.grid = element_blank())+
 theme(panel.border = element_blank(),axis.line = element_line(colour="black",size=1))+
 theme(panel.grid = element_blank(),panel.background=element_blank())+
 theme(legend.text=element_text(size=15),legend.title=element_blank())+
 labs(x = "H1_reads", y = "H2_reads")+
 theme(axis.title= element_text(size=16,color="black",vjust=0.5, hjust=0.5))+
 theme(axis.text.x=element_text(hjust = 1,vjust =0.5,color ="black",size=16),
 axis.text.y=element_text(size=16,color="black"))
dev.off()