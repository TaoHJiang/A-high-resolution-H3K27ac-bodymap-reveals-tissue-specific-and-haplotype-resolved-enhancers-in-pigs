result=read.table("Brain_GO_result.txt",head=T)
rownames(result)=result[,1]
result2=result[,2:ncol(result)]
result2=-log10(result2)
result2$max=apply(result2,1,max)
result3=result2[result2$max>2,1:11]


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



library(pheatmap)

result4=result3[,c(10,8,9,2,6,3,5,1,7,4,11)]
result4$Callosum_R=0
result4$Temporal_lobe_R=0
result4$Parietal_lobe_R=0
result4$Frontal_lobes_R=0

N=NULL
for(i in 1:ncol(result4)){
tissue=result4[,i]
other=result4[,-i]
other$max=apply(other,1,max)
tmp=data.frame(tissue,other$max)
rownames(tmp)=rownames(result4)
tmp$FC=tmp[,1]/(tmp[,2]+0.0000001)
tmp2=tmp[(tmp$FC>=1 & tmp[,1]>2 ),]
if(nrow(tmp2)>0){
tmp2=tmp2[order(tmp2$tissue,decreasing=T),]
N=c(N,rownames(tmp2))
}
}

result5=result4[N,]


qq=colnames(result5)
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


pdf("Brain_GO_result_heatmap.pdf", width=10, height=9)
pheatmap(result5,border=NA,fontsize=8, fontsize_col = 8,
         annotation_col = annotation_col,annotation_colors = ann_colors,
		 annotation_legend = T,cluster_cols=F,scale="row",
		 cluster_rows=F,show_rownames=F,show_colnames=F)
dev.off()
