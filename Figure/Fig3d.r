library(dplyr)
library(ggplot2)

result <- read.table("X12_LINE_enrich.txt")

top10 <- result %>% 
  arrange(proportion) %>% 
  tail(10)

pdf("X12_LINE_binding_TF_in_enh_perct.pdf",width=3,height=3)
ggplot(df, aes(x = V1, y = min_p_value, label = V2)) +
  geom_point(color = "blue", size = 3) +  # 绘制散点
  geom_text(data = top10, aes(label = V2),  color = "red") +  # 标注top10字符
  labs(x = "Percentage (%)", y = "-Log10(p-value)") +
 theme_set(theme_bw())+theme(panel.grid = element_blank())+
 theme(panel.border = element_blank(),axis.line = element_line(colour="black",size=1))+
 theme(panel.grid = element_blank(),panel.background=element_blank())+
 theme(legend.text=element_text(size=15),legend.title=element_blank())+
 theme(axis.title= element_text(size=16,color="black",vjust=0.5, hjust=0.5))+
 theme(axis.text.x=element_text(hjust = 1,vjust =0.5,color ="black",size=16),
 axis.text.y=element_text(size=16,color="black"))
dev.off()
