library(VennDiagram)
pdf("phase_peak_convince.pdf",width=4,height=4)
draw.quad.venn(
  area1 = 6134,    # rep1
  area2 = 5756,    # rep2
  area3 = 5843,    # rep3
  area4 = 6443,   # rep4
  n12 = 2377,
  n13 = 2370,
  n14 = 1576,
  n23 = 2317,
  n24 = 1488,
  n34 = 1455,
  n123 = 1231,
  n124 = 737,
  n134 = 698,
  n234 = 690,
  n1234 = 408,
  category = c("rep1", "rep2", "rep3", "rep4"),
  fill = c("red", "blue", "green", "yellow"),
  alpha = 0.5,
  cat.cex = 0.8,
  margin = 0.05
)

dev.off()
