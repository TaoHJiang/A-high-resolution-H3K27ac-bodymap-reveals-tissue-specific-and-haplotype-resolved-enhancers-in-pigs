library(pheatmap)
dat=read.table("sample_pair_result_01file.txt")

name=read.table("/home/pencode/promoter/tissue_id.txt2")
rownames(name)=name$V2 
name2=name[colnames(dat),]
cor_matrix <- cor(dat, method = 'spearman')

qq=name2$V2
qqq=as.data.frame(qq)
colnames(qqq)="tissue"
rownames(qqq)=qqq$tissue
annotation_col=qqq






ann_colors=list(tissue=c(
Adipose_1="#FFFF00",Adipose_2="#FFFF00",Adipose_3="#FFFF00",Adipose_4="#FFFF00",Adipose_5="#FFFF00",
Adrenal_Gland="#1CE6FF",
Anus_1 = "#FF34FF", 
Bladder  = "#FF4A46",
Blood_Vessel_1 = "#008941",Blood_Vessel_2 = "#008941",Blood_Vessel_3 = "#008941",Blood_Vessel_4= "#008941",Blood_Vessel_5 = "#008941",Blood_Vessel_6 = "#008941",Blood_Vessel_7 = "#008941",Blood_Vessel_8 = "#008941",Blood_Vessel_9 = "#008941",
Bone_marrow_1="#006FA6",Bone_marrow_2="#006FA6",
  Brain_10="#A30059",Brain_11="#A30059",Brain_12="#A30059",Brain_13="#A30059",Brain_14="#A30059",Brain_15="#A30059",Brain_16="#A30059",Brain_17="#A30059",Brain_20="#A30059",Brain_21="#A30059",Brain_23="#A30059",Brain_24="#A30059",Brain_25="#A30059",Brain_26="#A30059",Brain_27="#A30059",Brain_40="#A30059",Brain_4="#A30059",Brain_5="#A30059",Brain_6="#A30059",Brain_7="#A30059",
 Brain_stem_18="#FFDBE5",Brain_stem_19="#FFDBE5",
  Bronchi="#7A4900",
  Bulbourethral_gland="#0000A6",
  Cartilage_1="#63FFAC",Cartilage_2="#63FFAC",
  Cerebellum_8="#B79762",Cerebellum_9="#B79762",
  Choroidal_plexus="#004D43",
  Diaphragm = "#8FB0FF",
  Endocardium_1 = "#997D87", 
  Endocardium_2 = "#5A0007",
  Esophagus_membrane_1="#809693",
  Fallopian_tube="#6A3A4C",
  Gallbladder = "#1B4400",
  Heart_1="#4FC601",Heart_2="#4FC601",Heart_3="#4FC601",Heart_4="#4FC601",Heart_5="#4FC601",Heart_6="#4FC601",
  Heart_valve="#3B5DFF",
  Kidney3="#4A3B53",Kidney_1="#4A3B53",Kidney_2="#4A3B53",
  Large_intestine_10="#FF2F80",Large_intestine_11="#FF2F80",Large_intestine_12="#FF2F80",Large_intestine_16="#FF2F80",Large_intestine_8="#FF2F80",Large_intestine_9="#FF2F80",
  Ligament="#61615A",
  Liver_1="#BA0900",Liver_2="#BA0900",Liver_3="#BA0900",Liver_4="#BA0900",Liver_5="#BA0900",Liver_6="#BA0900",
  Lung_1="#6B7900",Lung_2="#6B7900",Lung_3="#6B7900",Lung_4="#6B7900",Lung_5="#6B7900",Lung_6="#6B7900",Lung_7="#6B7900",Lung_1="#6B7900",
Lymph_node_0 = "#00C2A0",Lymph_node_1 = "#00C2A0", Lymph_node_2 = "#00C2A0", Lymph_node_3 = "#00C2A0", Lymph_node_4 = "#00C2A0", Lymph_node_5 = "#00C2A0", Lymph_node_6 = "#00C2A0", Lymph_node_7 = "#00C2A0", Lymph_node_8 = "#00C2A0", Lymph_node_9 = "#00C2A0",  
Mammary_gland = "#FFAA92", 
Mesentery = "#FF90C9",
Oralcavity_membrane_2="#D16100",
Ovary="#DDEFFF",
Palate="#000035",
Pancreas_3="#7B4F4B",
Parathyroid_gland = "#A1C299", 
Parotid_gland = "#300018", 
Penis="#0AA6D8",
Pituitary_22="#013349",
Respiratory_mucosa_3="#00846F",Respiratory_mucosa_4="#00846F",Respiratory_mucosa_5="#00846F",Respiratory_mucosa_6="#00846F",Respiratory_mucosa_7="#00846F",
Retina="#372101",
Sciatic_nerve="#FFB500",
Seminal_vesicles="#C2FFED",
Skeletal_muscle_1="#A079BF",Skeletal_muscle_2="#A079BF",Skeletal_muscle_3="#A079BF",
Skin_1="#CC0744",Skin_2="#CC0744",
Small_intestine_13="#C2FF99",Small_intestine_14="#C2FF99",Small_intestine_15="#C2FF99",Small_intestine_2="#C2FF99",Small_intestine_3="#C2FF99",Small_intestine_4="#C2FF99",Small_intestine_5="#C2FF99",Small_intestine_6="#C2FF99",Small_intestine_7="#C2FF99",
Spinal_cord_28="#001E09",Spinal_cord_29="#001E09",Spinal_cord_30="#001E09",Spinal_cord_31="#001E09",
Spleen = "#00489C", 
Stomach_1 = "#6F0062", Stomach_2 = "#6F0062",Stomach_3 = "#6F0062",
Sublingual_gland = "#0CBD66",
Submandibular_gland="#EEC3FF",
Thalamus_1="#456D75",Thalamus_2="#456D75",Thalamus_3="#456D75",
Thymus="#B77B68",
Thyroid_gland="#7A87A1",
Tongue_1="#788D66",Tongue_2="#788D66",
Ureter = "#FAD09F", 
Urethra_1 = "#FF913F", Urethra_2 = "#FF913F",Urethra_3 = "#FF913F",
Uterus_1 = "#D790FF",Uterus_2= "#D790FF",
Vagina="#922329",
Vocal_cords="#A4E804")
  )		  



pdf("sample_pair_result_01file_heatmap.pdf", width=10, height=7)
pheatmap(cor_matrix,border=NA,fontsize=8, fontsize_col = 8,
         annotation_col = annotation_col,annotation_colors = ann_colors,
		 annotation_legend = T,cluster_cols=T,
		 cluster_rows=T,show_rownames=F,show_colnames=F,color = colorRampPalette(c("white", "red"))(50))
dev.off()
