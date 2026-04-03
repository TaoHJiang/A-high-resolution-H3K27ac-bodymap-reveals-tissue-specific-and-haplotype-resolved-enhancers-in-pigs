
pdf(file=paste0("./chr5_88499376_88499825_chr5_88495793_88496138",".pdf"), width=5, height=4)

ggplot(data = c2, aes(x = log(p1 + 1), y = log(p2 + 1))) +
  geom_point(aes(color = group_liver), size = 3) +
  geom_smooth(method = 'lm', se = FALSE, color = 'black', inherit.aes = FALSE,
              aes(x = log(p1 + 1), y = log(p2 + 1))) +
  stat_cor(method = "spearman") +
  scale_color_manual(values = c("Kidney" = "blue", "no" = "grey70")) +  # 自定义颜色
  theme_bw() +
  theme(panel.grid = element_blank(),
        panel.border = element_blank(),
        axis.line = element_line(colour = "black", size = 1),
        panel.background = element_blank(),
        legend.text = element_text(size = 15),
        legend.title = element_blank(),
        axis.title = element_text(size = 16, color = "black", vjust = 0.5, hjust = 0.5),
        axis.text.x = element_text(hjust = 1, vjust = 0.5, color = "black", size = 16),
        axis.text.y = element_text(size = 16, color = "black"))

dev.off()
