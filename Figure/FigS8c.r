

library(UpSetR)

data=read.table("/home/pencode/2024H3K27ac/H3K27AC_151sample_01file_ID.txt",head=T)
tissue_name=read.table("/home/pencode/promoter/tissue_id.txt2")
rownames(tissue_name) =tissue_name$V3
tissue_name2=tissue_name[colnames(data),]
colnames(data)=tissue_name2$V4


Brain2=data[,grep(pattern="Brain",colnames(data))]
Brain3=Brain2[,-c(2:4,9:10,19:24,27)]
Brain4=data.frame(Brain3,data["Meninges"])

colnames(Brain4)=c("Pineal_body",
                   "Hippocampus_L","Hippocampus_R",
                   "Gyrus_cinguli_L","Gyrus_cinguli_R",
                   "Occipital_lobe_L","Occipital_lobe_R",
                   "Temporal_lobe_L","Temporal_lobe_R",
                   "Parietal_lobe_L","Parietal_lobe_R",
                   "Frontal_lobes_L","Frontal_lobes_R",
                   "Callosum_L","Callosum_R",
                   "Olfactory_bulb_L","Olfactory_bulb_R",
                   "Corpus_striatum_L","Corpus_striatum_R",
                   "Meninges"
)



pdf(file="Brain_enh_specific_upset.pdf",width=8,height=4.5)
par(mar=c(6,5,4,3) + 0.1) 
upset(Brain4, nsets=1, 
      sets = c("Pineal_body",
                   "Hippocampus_L","Hippocampus_R",
                   "Gyrus_cinguli_L","Gyrus_cinguli_R",
                   "Occipital_lobe_L","Occipital_lobe_R",
                   "Temporal_lobe_L","Temporal_lobe_R",
                   "Parietal_lobe_L","Parietal_lobe_R",
                   "Frontal_lobes_L","Frontal_lobes_R",
                   "Callosum_L","Callosum_R",
                   "Olfactory_bulb_L","Olfactory_bulb_R",
                   "Corpus_striatum_L","Corpus_striatum_R",
                   "Meninges"),
     
      order.by = "freq", 
      decreasing = T,
      keep.order = T,  
      matrix.color = "blue", 
      main.bar.color = "#BC3C29", 
      sets.bar.color = rainbow(20),
      shade.alpha = 0.4, 
      matrix.dot.alpha = 1, 
      mainbar.y.label = "Shared tissue-specific Enh numbers", 
      sets.x.label = "Total tissue-specific Enh numbers",
      point.size = 2.2, 
      line.size = 0.7, 
      mb.ratio = c(0.4, 0.6), 
      number.angles = 0, 
      att.pos = "bottom",  
      group.by = "degree", 
      scale.intersections = "identity",  
      scale.sets = "identity", 
      text.scale = 1, 
      set_size.show = TRUE, 
      set_size.numbers_size = 6.5

)
dev.off()