
/opt/software/miniconda3/bin/R
rm(list=ls())
data=read.table("TF_signif.txt2")
name=sapply(as.character(data$V10),function(x) {unlist(strsplit(x,"/"))[2]})
name=as.data.frame(name)
name$name=gsub("_motif","",name$name)

dat=data.frame(data[,c(1,3,5)],name)
dat$V1=sapply(as.character(dat$V1),function(x) {unlist(strsplit(x,"/"))[1]})
dat$V1=sapply(as.character(dat$V1),function(x) {unlist(strsplit(x,")"))[1]})
dat$V1=paste0(dat$V1,")")

colnames(dat)[1:3]=c("Motif","Pvalue","qvalue")
dat$Pvalue2=-log10(dat$Pvalue)


for(i in 1:nrow(dat)){
if(dat$Pvalue[i]<=0.0001){
dat$Pvalue3[i]=0.0001
}
if(dat$Pvalue[i]>0.0001 & dat$Pvalue[i]<=0.001){
dat$Pvalue3[i]=0.001
}
if(dat$Pvalue[i]>0.001 & dat$Pvalue[i]<=0.01 ){
dat$Pvalue3[i]=0.01
}
if(dat$Pvalue[i]>0.01 & dat$Pvalue[i]<0.05){
dat$Pvalue3[i]=0.05
}
if(dat$Pvalue[i]>=0.05){
dat$Pvalue3[i]=1
}
}
dat$Pvalue4=-log10(dat$Pvalue3)

library(ggplot2)

pdf(file="enh_specific_enrich_TF.pdf",width=15,height=18)

ggplot(dat,aes(name,Motif))+
geom_point(aes(color=Pvalue4,size=Pvalue4))+
scale_color_gradient(low="white",high ="red")+
labs(color="-Log10(Pvalue)",size="-Log10(Pvalue)",x="",y="")+
 theme(legend.text=element_text(colour="black", size=12),
             axis.line=element_line(color="black"),
             axis.text.x = element_text(angle=90,vjust=0.5,colour="black",size=12),
             axis.title.x=element_text(colour="black", size=13),
             axis.text.y = element_text(vjust=0.5,colour="black",size=12),
             axis.title.y=element_text(colour="black", size=13))
dev.off()
