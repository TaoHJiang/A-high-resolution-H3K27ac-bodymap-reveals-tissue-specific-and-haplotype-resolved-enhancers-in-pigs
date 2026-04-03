
/opt/software/miniconda3/bin/R
rm(list=ls())
library(reshape2)

data=read.table("TF_signif.txt2")
data=unique(unique(data))
name=sapply(as.character(data$V10),function(x) {unlist(strsplit(x,"/"))[2]})
name=as.data.frame(name)
name$name=gsub("_motif","",name$name)

dat=data.frame(data[,c(1,3,5)],name)
dat$V1=sapply(as.character(dat$V1),function(x) {unlist(strsplit(x,"/"))[1]})
dat$V1=sapply(as.character(dat$V1),function(x) {unlist(strsplit(x,")"))[1]})
dat$V1=paste0(dat$V1,")")

colnames(dat)[1:3]=c("Motif","Pvalue","qvalue")
dat$Pvalue2=-log10(dat$Pvalue)
dat2=dat[,c(1,4,5)]
dat3=dcast(dat2, Motif ~ name, value.var = "Pvalue2")
rownames(dat3)=dat3$Motif
dat4=dat3[,2:ncol(dat3)]
colnames(dat4)=c("Temporal_lobe_L","Temporal_lobe_R","Parietal_lobe_R","Frontal_lobes_R","Callosum_L","Callosum_R",
"Olfactory_bulb_L","Olfactory_bulb_R","Pineal_body","Corpus_striatum_L","Corpus_striatum_R","Hippocampus_L","Hippocampus_R",
"Gyrus_cinguli_L","Gyrus_cinguli_R")

dat4=dat4[,c(9,7,8,10,12,11,15,5,13,14,1,6,2,3,4)]
#dat5=dat4
#dat5[dat5>5]<-5


library(pheatmap)


qq=colnames(dat4)
qqq=as.data.frame(qq)
colnames(qqq)="tissue"
rownames(qqq)=qqq$tissue
annotation_col=qqq


ann_colors=list(tissue=c(
Pineal_body="#A05837",
Olfactory_bulb_L="#404E55",
Olfactory_bulb_R="#0089A3",
Corpus_striatum_L="#CB7E98",
Hippocampus_L="#6B002C",
Corpus_striatum_R="#A4E804",
Gyrus_cinguli_R = "#9B9700",
Callosum_L="#5B4534",
Hippocampus_R = "#772600", 
Gyrus_cinguli_L  = "#D790FF",
Temporal_lobe_L="#201625",
Callosum_R="#FDE8DC",
Temporal_lobe_R="#72418F",
Parietal_lobe_R="#99ADC0",
Frontal_lobes_R="#922329"
))



N=NULL
for(i in 1:ncol(dat4)){
tissue=dat4[,i]
other=dat4[,-i]
other$max=apply(other,1,max)
tmp=data.frame(tissue,other$max)
rownames(tmp)=rownames(dat4)
tmp$FC=tmp[,1]/(tmp[,2]+0.0000001)
tmp2=tmp[(tmp$FC>=1 & tmp[,1]>2 ),]
if(nrow(tmp2)>0){
tmp2=tmp2[order(tmp2$tissue,decreasing=T),]
N=c(N,rownames(tmp2))
}
}

common=intersect(N,rownames(dat4))
result5=dat4[common,]

diff=setdiff(rownames(dat4),N)
result6=dat4[diff,]

result9=rbind(result5,result6)
result10=result9[,1:15]
result10[result10>10]<-10

pdf("Brain_TF_result_heatmap.pdf", width=10, height=19)
pheatmap(result10,border=NA,fontsize=8, fontsize_col = 8,
         annotation_col = annotation_col,annotation_colors = ann_colors,
		 annotation_legend = T,cluster_cols=F,scale="row",
		 cluster_rows=F,show_rownames=T,show_colnames=T)
dev.off()

 