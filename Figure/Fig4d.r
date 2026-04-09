library(ggpubr)
library(ggplot2)


shared_num <- c(322, 518) 
total_num  <- c(847, 518)  
group <- c("E-P_pair_with_tissue_specific_enh_and_pro",
           "E-P_pair_with_tissue_conserved_enh_and_pro")

data <- data.frame(shared_num, total_num, group)
data$percentage <- data$shared_num / data$total_num


mat <- matrix(c(
  322, 847 - 322,
  518, 518 - 518
), nrow = 2, byrow = TRUE)

test_res <- fisher.test(mat)
p_value <- test_res$p.value

p_label <- ifelse(p_value < 0.001, "***",
           ifelse(p_value < 0.01, "**",
           ifelse(p_value < 0.05, "*", "ns")))

p <- ggbarplot(
  data,
  x = "group",
  y = "percentage",
  fill = "group",
  color = "white",
  width = 0.6,
  orientation = "horiz",
  palette = c("#BC3C29", "#E18727"),
  legend = "none",
  sort.val = "asc",
  sort.by.groups = TRUE
) +
  scale_y_continuous(
    expand = c(0, 0),
    limits = c(0, 1.15),
    labels = scales::percent_format(accuracy = 1)
  ) +
  scale_x_discrete(expand = c(0, 0)) +
  
  annotate("segment", x = 1, xend = 2, y = 1.05, yend = 1.05, size = 0.8) +
  annotate("segment", x = 1, xend = 1, y = 1.01, yend = 1.05, size = 0.8) +
  annotate("segment", x = 2, xend = 2, y = 1.01, yend = 1.05, size = 0.8) +
  
  annotate("text", x = 1.5, y = 1.08, label = p_label, size = 6) +
  
  annotate("text", x = 1.5, y = 1.13, 
           label = paste0("Fisher's exact test, p = ", signif(p_value, 3)),
           size = 4) +
  
  theme_pubr() +
  theme(
    axis.title = element_blank(),
    axis.text.y = element_text(size = 11),
    axis.text.x = element_text(size = 11),
    legend.position = "none"
  )

pdf(file = "share_the_same_TF_motif.pdf", width = 12, height = 3)
print(p)
dev.off()