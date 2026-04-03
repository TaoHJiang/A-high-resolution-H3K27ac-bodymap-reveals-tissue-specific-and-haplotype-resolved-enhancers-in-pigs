N2=read.table("/home/pencode/jiangtao/2024_H3K27ac_phase/ASB/depth/tissue/tissue_ASB_peak_enrich/tissue_enrich_GWAS.txt",head=T)
pdf("tissue_enrich_GWAS2.pdf",width=16,height=12)
ggplot(N2, aes(x = tissue, y = trait)) +
  geom_point(aes(size = OR, color = logP)) +
  scale_size(range = c(2, 12)) + 
  scale_color_gradient(low = "blue", high = "red") +
  theme_bw(base_size = 14) +
  theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
  labs(x = "", y = "-log10(P value)", 
       size = "Odd Ratio", color = "-log10(P value)")
dev.off()
