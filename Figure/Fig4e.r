df=merge(conserved[1:15,],specific,by="Var1")
df=read.table()
df_plot <- df %>%
  arrange(percentage.x) %>%
  mutate(
    Var1 = factor(Var1, levels = Var1),
    left = -percentage_conserved,
    right = percentage_specific
  )

 pdf("tetst.pdf",height=4,width=9)
ggplot(df_plot) +
  geom_col(aes(x = Var1, y = left), fill = "#3C8DBC", width = 0.65) +
  geom_col(aes(x = Var1, y = right), fill = "#D95F02", width = 0.65) +
  
  geom_text(aes(x = Var1, y = left, label = percent(percentage_conserved, accuracy = 0.1)),
            hjust = 1.1, size = 4) +
  geom_text(aes(x = Var1, y = right, label = percent(percentage_specific, accuracy = 0.1)),
            hjust = -0.2, size = 4) +
  
  coord_flip() +
  geom_hline(yintercept = 0, linewidth = 0.6) +
  
  scale_y_continuous(
    labels = function(x) percent(abs(x), accuracy = 1),
    limits = c(-0.8, 0.08)
  ) +
  
  labs(
    x = "",
    y = "Percentage (%)"
  ) +
  
  theme_bw() +
  theme(
    panel.grid = element_blank(),
    axis.text.y = element_text(size = 12, face = "bold"),
    axis.title = element_text(size = 13, face = "bold")
  )
  dev.off()
