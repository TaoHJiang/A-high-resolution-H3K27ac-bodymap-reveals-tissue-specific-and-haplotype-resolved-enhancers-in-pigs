library(ggplot2)
library(tidyr)
library(dplyr)

df <- data.frame(
  tissue = c("Adipose","Blood_Vessel","Bone_marrow","Brain","Brain_stem","Cartilage","Cerebellum","Heart",
             "Kidney","Large_intestine","Liver","Lung","Lymph_node","Respiratory_mucosa","Skeletal_muscle",
             "Skin","Small_intestine","Spinal_cord","Stomach","Thalamus","Tongue","Urethra","Uterus"),
  site_specific = c(529,17,923,5552,24,1434,2231,748,1675,82,802,217,56,23,522,10,103,161,619,367,33,149,215),
  site_conserved = c(19,0,162,0,2,126,1,0,162,0,0,9,0,0,409,0,3,14,21,7,9,0,1),
  other = c(152,22,0,117,0,0,0,212,1,81,210,74,2,21,325,0,206,66,378,53,0,1,0)
)

df_long <- df %>%
  pivot_longer(cols = c("site_specific", "site_conserved", "other"),
               names_to = "category", values_to = "count")

pdf("tissue_specifci_site.pdf", width =6, height = 4)
ggplot(df_long, aes(x = reorder(tissue, -count), y = count, fill = category)) +
  geom_bar(stat = "identity") +
  theme_classic()+
  labs(x = "Tissue", y = "Count", title = "Enhancer Categories by Tissue") +
  scale_fill_manual(values = c("site_specific" = "#1f77b4", "site_conserved" = "#2ca02c", "other" = "#ff7f0e")) 
dev.off()
