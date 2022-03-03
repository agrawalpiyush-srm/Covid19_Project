########## Code for generating Heatmaps #######

library(pheatmap)
df = read.csv("/Users/agrawalp4/Downloads/upset_plots/Gene_enrichment_plots/Pathext_all_virus/pathext_act.csv")
data <- as.matrix(df)
pheatmap(data, color = c("red", "yellow", "green","brown"),breaks = c(0, 3, 5, 10, 100), main = 'Example Heatmap', filename = "Image.jpg")
