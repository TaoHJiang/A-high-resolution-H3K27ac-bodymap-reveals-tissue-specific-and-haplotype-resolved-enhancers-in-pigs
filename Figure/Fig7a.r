pdf("Uterus_enrich_GWAS.pdf",width=8,height=6)
ggplot(Uterus, aes(x = OR, y = logP)) +
  geom_point(aes(size = OR, color = logP)) +
#  scale_size(range = c(2, 12)) +  
  scale_color_gradient(low = "blue", high = "red") +
  theme_classic(base_size = 14) +scale_y_continuous(expand=c(0,0))+scale_x_continuous(expand=c(0,0))+
  theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
  labs(x = "", y = "-log10(P value)", 
       size = "Odd Ratio", color = "-log10(P value)")+
	   geom_text(
    data = subset(Uterus, OR > 1 & logP > 2), 
    aes(label = trait),
    vjust = -0.5,
    size = 4
  )
dev.off()
