result=read.table("Total_GO_result.txt",head=T)
rownames(result)=result[,1]
result2=result[,2:ncol(result)]
result2=-log10(result2)

library(pheatmap)


qq=colnames(result2)
qqq=as.data.frame(qq)
colnames(qqq)="tissue"
rownames(qqq)=qqq$tissue
annotation_col=qqq


ann_colors=list(tissue=c(
Adipose="#FFFF00",
Adrenal_Gland="#1CE6FF",
Anus = "#FF34FF", 
Bladder  = "#FF4A46",
Blood_Vessel = "#008941",
Bone_marrow="#006FA6",
  Brain="#A30059",
 Brain_stem="#FFDBE5",
  Bronchi="#7A4900",
  Bulbourethral_gland="#0000A6",
  Cartilage="#63FFAC",
  Cerebellum="#B79762",
  Choroidal_plexus="#004D43",
  Diaphragm = "#8FB0FF",
  Endocardium_2 = "#5A0007",
  Esophagus="#809693",
  Fallopian_tube="#6A3A4C",
  Gallbladder = "#1B4400",
  Heart="#4FC601",
  Heart_valve="#3B5DFF",
  Kidney="#4A3B53",
  Large_intestine="#FF2F80",
  Ligament="#61615A",
  Liver="#BA0900",
  Lung="#6B7900",
Lymph_node = "#00C2A0",  
Mammary_gland = "#FFAA92", 
Oralcavity="#D16100",
Ovary="#DDEFFF",
Palate="#000035",
Pancreas="#7B4F4B",
Parathyroid_gland = "#A1C299", 
Parotid_gland = "#300018", 
Penis="#0AA6D8",
Pituitary="#013349",
Respiratory_mucosa="#00846F",
Retina="#372101",
Sciatic_nerve="#FFB500",
Seminal_vesicles="#C2FFED",
Skeletal_muscle="#A079BF",
Small_intestine="#C2FF99",
Spinal_cord="#001E09",
Spleen = "#00489C", 
Stomach= "#6F0062",
Sublingual_gland = "#0CBD66",
Submandibular_gland="#EEC3FF",
Thalamus="#456D75",
Thymus="#B77B68",
Thyroid_gland="#7A87A1",
Tongue="#788D66",Tongue_2="#788D66",
Ureter = "#FAD09F", 
Urethra = "#FF913F",
Uterus = "#D790FF",
Vagina="#922329",
Vocal_cords="#A4E804")
  )		  


result2[result2>10] <- 10

result3=result2[grep(pattern='^GO',rownames(result2)),]
rownames(result3)=sapply(rownames(result3),function(x) {unlist(strsplit(x,"~"))[1]})
result4=result2[grep(pattern='^ssc',rownames(result2)),]
rownames(result4)=sapply(rownames(result4),function(x) {unlist(strsplit(x,":"))[1]})
result5=rbind(result3,result4)
result5$max=apply(result5,1,max)
result6=result5[result5$max>2,]


N=NULL
for(i in 1:ncol(result6)){
tissue=result6[,i]
other=result6[,-i]
other$max=apply(other,1,max)
tmp=data.frame(tissue,other$max)
rownames(tmp)=rownames(result6)
tmp$FC=tmp[,1]/(tmp[,2]+0.0000001)
tmp2=tmp[(tmp$FC>=1 & tmp[,1]>2 ),]
if(nrow(tmp2)>0){
N=c(N,rownames(tmp2))
}
}

common=intersect(N,rownames(result6))
result7=result6[common,]

diff=setdiff(rownames(result6),N)
result8=result6[diff,]

result9=rbind(result7,result8)
result10=result9[,1:55]
pdf("Total_GO_result_heatmap.pdf", width=10, height=9)
pheatmap(result10,border=NA,fontsize=8, fontsize_col = 8,
         annotation_col = annotation_col,annotation_colors = ann_colors,
		 annotation_legend = T,cluster_cols=F,
		 cluster_rows=F,show_rownames=F,show_colnames=F,color = colorRampPalette(c("white", "red"))(10))
dev.off()
