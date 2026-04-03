data <- data.frame(
   Value = c(12, 13, 18, 20, 9, 10, 8),
   Sample = c("Lung_1", "Lung_2", "Lung_3", "Lung_4", "Lung_5", "Lung_6", "Lung_7")
 )
 
#heart 
data <- data.frame(
  Value = c(38, 43, 27, 14, 1, 35, 46),
  Sample = c("Endocardium_1", "Heart_1", "Heart_2", "Heart_3", "Heart_4", "Heart_5", "Heart_6")
)
 #liver
 data <- data.frame(
  Value = c(6, 7, 1, 31, 73, 72),
  Sample = c("Liver_1", "Liver_2", "Liver_3", "Liver_4", "Liver_5", "Liver_6")
)
 #muscle
 data <- data.frame(
  Value = c(44, 44, 39),
  Sample = c("Muscle_1", "Muscle_2", "Muscle_3")
)
 #kidney
  data <- data.frame(
  Value = c(42, 42,0),
  Sample = c("Kidney_1", "Kidney_2", "Kidney_3")
)

 
 
 
 
 
rownames(data)=data$Sample
  
# 排序
col_order <- order(data$Value, decreasing = TRUE)
sorted_data <- data[ col_order,]

sorted_data2=as.data.frame(sorted_data[,-2])
rownames(sorted_data2)=rownames(sorted_data)
  
   library(pheatmap)
 pheatmap(sorted_data2, 
          scale="column",
          cluster_rows = F,    # 不对行进行聚类
          cluster_cols = FALSE,    # 不对列进行聚类
          color = colorRampPalette(c("white", "red"))(10), # 自定义颜色梯度
          main = "Heatmap of Lung Samples") # 图标题
		  
		  
  

 
 