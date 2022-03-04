# Install the GOSemSim package
if (!require("BiocManager", quietly = TRUE))
  install.packages("BiocManager")
BiocManager::install("GOSemSim")

# Load GOSemSim package
require(GOSemSim)

# Load required functions for Homo Sapiens
source("~/gosemsimRun.R")

# Loading sample input file
library(readr)
input <- read_delim("gosemsim_input.txt", delim = "\t", 
                    escape_double = FALSE, trim_ws = TRUE)

# Prepare semantic data to measure GO similarity
hso = init.gosemsim()

# Calculating semantic similarity matrix for the input file
# By default, the semantic similarity between two GO terms are computed using the Wang method and semantic similarity between two sets of GO terms are combined with 'rcmax' method. 
simMat = data.frame()
for(i in 1:dim(input)[2]){
  for(j in 1:dim(input)[2]){
    simMat[i,j] = getResult(input[,i], input[,j], sem = hso)
  }}
