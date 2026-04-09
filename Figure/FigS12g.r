data <- data.frame(
  Tissue = c("Liver_1", "Liver_2", "Liver_3", "Liver_4", "Liver_5", "Liver_6"),
  site_specific = c(1, 6, 21, 12, 16, 26)  
)


pdf("tissue_specifci_phased_liver.pdf", width =5, height = 4)
ggplot(data, aes(x = Tissue, y = site_specific, fill = Tissue)) +
  geom_bar(stat = "identity",width=0.6) +
   theme_classic() +
  theme(axis.text.x = element_text(hjust = 1)) +
  labs(title = "",
       x = "Tissue",
       y = "Number of Enhancers"
   )
dev.off()