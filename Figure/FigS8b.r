df <- data.frame(
value=c(529,17,923,5552,24,1434,2231,748,1675,82,802,217,56,23,522,10,103,161,619,367,33,149,215),
site=c(5,9,2,20,2,2,2,6,3,6,6,7,10,5,3,2,9,4,3,3,2,3,2),
group=c("Adipose","Blood_Vessel","Bone_marrow","Brain","Brain_stem",
        "Cartilage","Cerebellum","Heart","Kidney","Large_intestine",
		"Liver","Lung","Lymph_node","Respiratory_mucosa","Skeletal_muscle","Skin","Small_intestine","Spinal_cord","Stomach","Thalamus","Tongue","Urethra","Uterus"))

df$value=log10(df$value)

#
pdf("tissue_site.pdf", width =5, height = 6)
ggplot(df, aes(x = group, y = site)) +
  geom_point(aes(size = value, color = value)) +
  scale_size_continuous(name = "log10(Counts)") +
  scale_color_viridis_c(option = "D", name = "log10(Counts)") +
  theme_classic() +
  theme(
    axis.text.x = element_text(angle = 45, hjust = 1),
    axis.text.y = element_text(size = 8)
  ) +
  labs(title = "", x = "", y = "")
dev.off()