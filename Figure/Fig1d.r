library(ggplot2)
library(dplyr)
library(ggpubr)


df <- data.frame(
  value = c(
    3.543470993, 3.552374157, 3.745456536,
    27.16179165, 28.80562682, 27.52047892,
    19.75822228, 19.20216544, 20.06397886,
    2.246162392, 2.106990792, 2.207375517,
    7.92329823, 7.459500573, 7.797238736,
    2.835126879, 2.794073129, 2.707294943,
    2.96074468, 2.903911141, 2.9501576,
    3.238330042, 3.179016763, 3.238745006,
    2.78554531, 2.91453374, 2.897699238,
    5.666384677, 5.746338343, 5.978139099,
    1.28106055, 1.154585655, 1.19102414
  ),
  group = rep(c(
    "Enhancer1", "Enhancer2", "Enhancer3", "Enhancer4", "Enhancer5",
    "Enhancer6", "Enhancer7", "Enhancer8", "Enhancer9", "Enhancer10",
    "PGL3_promoter"
  ), each = 3)
)


df$group <- factor(df$group, levels = c(
  "PGL3_promoter",
  paste0("Enhancer", 1:10)
))


comparisons <- lapply(paste0("Enhancer", 1:10), function(x) c("PGL3_promoter", x))


pdf("convince_10enhacner.pdf",width=4,height=4)
 ggplot(df, aes(x = group, y = value)) +
  geom_bar(stat = "summary", fun = "mean", width = 0.7, fill = "gray") +
  geom_errorbar(stat = "summary", fun.data = mean_se, width = 0.2) +theme_classic()+
 theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
  ylab("Relative luciferase activity") + xlab("") +
  stat_compare_means(comparisons = comparisons, method = "t.test", label = "p.signif")

dev.off()