library(ggplot2)
df=read.table("total_Liver__Go_enrich_new.txt",sep="\t")
dat=df[,c(2:5,14)]

# 
pdf("Liver_GO_result.pdf", width = 10, height = 9)

ggplot(dat, aes(V2, V4)) +
  geom_point(aes(size = V3, color = V5)) +
  scale_size(range = c(2, 6)) +
  scale_color_gradient(high = 'blue', low = 'red') +
  theme(
    panel.background = element_rect(color = 'black', fill = 'transparent'),
    panel.grid = element_blank(),
    legend.key = element_blank()
  ) +
  coord_flip() +
  labs(x = '', y = 'Enrichment Score') +
  facet_grid(V14 ~ ., scale = 'free_y', space = 'free_y')

dev.off()
