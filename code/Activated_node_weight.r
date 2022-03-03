####### Reading input file and storing the values into variables

data <- read.csv("/Users/agrawalp4/Downloads/covid_project/Norm_Expressn_LogFC_Lowess/code_github/test/input.csv") ### Input file should have 3 columns in the order gene,control data and case data. File should have a header in the same order.
gene <- data$gene			#### Saving gene information in the variable
control <- data$control			#### Saving control data information in the variable
case <- data$case			#### Saving case data information in the variable

####### Computing fold change ####
fc = (case/control)
actual_fc = (case/control)		#### storing original fold change without inverting
fc[fc < 1] <- 1/fc[fc < 1]		#### This command will inverse only those values which are < 1 and store the inverse value in the variable 'fc'
log_fc = log2(fc)			#### This command will take the log2 value of the values in the fc variable
log_fc = round(log_fc, digits=6)

######## Sorting the file is ascending order on Control Data Basis  #########

new = data.frame(data,actual_fc,log_fc)	#### Adding LogFC value to the main input_file as next step is to fit lowess regression in between control and log val.
new_file = as.matrix(new)		#### Converting data frame into matrix. This is required for ordering the file

ordered = new_file[order(new_file[,2]),]	#### Ordering the file in ascending order based on column "control". Lowess function provides output in ascending fashion, that's why this is required to prevent loss of gene order information.

aa = data.frame(ordered)		#### Converting matrix back to data frame

######## Fitting Lowess Regression and computing Expected logFC #########

fitting <- lowess(control,log_fc)	#### Loess fitting
bb = data.frame(aa$gene,fitting)	#### Combining the sorted gene and the loess fitting output
new_datafile = data.frame(ordered,bb)	#### Making new data frame with absolute and expected log fc value
colnames(new_datafile) [6] <- "sorted_gene"	### Renaming the columns for analysis purpose
colnames(new_datafile) [7] <- "sorted_control"	### Renaming the columns for analysis purpose
colnames(new_datafile) [8] <- "expected_logfc"	### Renaming the columns for analysis purpose

###### Node weight computation and output writing ########

antilog=abs(2^new_datafile$expected_logfc)			### Computing antilog of the expected log fc output
node_weight=as.numeric(new_datafile$actual_fc)/antilog		### Node weight computation
final_file = data.frame(new_datafile,antilog,node_weight)	### Writing the gene and its corresponding node wieght value
write.csv(final_file, file="output.csv")			### Writing output in a file


