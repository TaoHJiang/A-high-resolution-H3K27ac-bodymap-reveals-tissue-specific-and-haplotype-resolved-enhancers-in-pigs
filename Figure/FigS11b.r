rm(list = ls())
data=read.table("/work/jiangtao/2024_H3K27ac_phase/ref_peak/EPI_huatu.txt")

pdf("/work/jiangtao/2024_H3K27ac_phase/ref_peak/phased_EPI.pdf",width=6,height=3.5)
ggplot(data, aes(x = V1, y = V2, fill = V1)) +
  geom_bar(stat = "identity", position = position_dodge(), width = 0.7) +
  scale_color_brewer(palette = "Set1") +
   scale_y_continuous(expand =  c(0, 0)) +
  labs(x = "", y = "Number") +
  theme(panel.background = element_blank(),
        panel.grid = element_blank(),
        axis.line = element_line(size=0.8,colour = "black"))  
dev.off()