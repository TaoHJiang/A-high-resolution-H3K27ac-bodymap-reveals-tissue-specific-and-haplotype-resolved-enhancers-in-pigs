values <- c(802, 108, 76, 22, 4)
labels <- c("1", "2", "3", "4", "5")

pct <- round(values / sum(values) * 100, 1)
lbls <- paste0(labels, " (", pct, "%)")

colors <- c("#8B0000", "#d95f02", "#7570b3", "#e7298a", "#008B8B")

pie(values, labels = lbls, col = colors, main = "")

