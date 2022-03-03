##### Important Link "https://www.biostars.org/p/456294/" ####

library(ggplot2)
df = read.csv("dotplot_input.csv")
df$Dataset <- as.factor(df$Dataset)

ggTheme <- theme(axis.text.x = element_text(size = 10, angle = 25, vjust = 1, hjust = 1), axis.text.y = element_text(size = 10),
+                  axis.title = element_text(size = 20, face ="bold"), panel.border = element_rect(color = "grey", fill = NA, size = 2),
+                  panel.grid.major = element_blank(), #panel.grid.minor.x = element_line(colour="black", size=1),
+                  strip.text.x = element_text(size = 10, colour = "brown")
+ )

ggplot(df, aes(x = Dataset, y = Samples)) + geom_point(aes(size = OR, shape = significance)) + scale_shape_manual(values=c(21, 16)) + scale_size_continuous(range = c(1,5), breaks = c(1, 2, 3, 5, 10, 20)) + geom_hline(aes(yintercept = yLines), color = "grey") + geom_vline(aes(xintercept = xLines), color = "grey") + theme_bw() + ggTheme

ggsave(file="Dotplot_output.pdf", width=10, height=10, dpi=300)
