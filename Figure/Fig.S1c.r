
library(VennDiagram)

pdf("phase1_84ac_vs_151me3_venn.pdf",width=6,height=6)
draw.pairwise.venn(
area1=271376, 
area2=480238, 
cross.area=185371,
cat.cex = 2,
cex = 1.8,
category = c('Jiang et al','Current study'),
col=c('#003366','#99CC33'),
fill=c('#003366','#99CC33'),
cat.pos = c(5, 0),
reverse = FALSE)
dev.off()