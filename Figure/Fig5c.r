files <- c("Liver_1", "Liver_2", "Liver_3", "Liver_4", "Liver_5", "Liver_6")
values <- c(13, 74, 186, 77, 251, 201)

df <- data.frame(File = files, Value = values)

library(ggplot2)

ggplot(df, aes(x = File, y = Value)) +
  geom_bar(stat = "identity", fill = "skyblue", color = "black") +
  theme_classic() +
  labs(title = "Values from Liver Files",
       x = "File Name",
       y = "Value") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))
