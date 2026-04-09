
library(VennDiagram)

area1 <- 98656   
area2 <- 42006   
cross_area <- 3364 

pdf("tissue_specifci_overlap_haplotype_specific.pdf", width =4, height = 4)
venn.plot <- draw.pairwise.venn(
  area1 = area1,
  area2 = area2,
  cross.area = cross_area,
  category = c("Set A", "Set B"),
  fill = c("skyblue", "lightpink"),
  lty = "blank",
  cex = 2,
  cat.cex = 2,
  cat.pos = c(-20, 20),
  cat.dist = 0.05
)
dev.off()

