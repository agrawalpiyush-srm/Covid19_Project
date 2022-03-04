# covid19_project
This project is about identifying in silico novel anti SARS-CoV-2 drug targets based on network approach

**##################### Instructions for the Users ###################**
  
In this study, we implemented netwrok based approach to identify differentially regulated paths (also referred as TopNets). These TopNets are of two types; (i) Activated; and (ii) Repressed. Further, from these TopNets, we identify top central genes.

PathExt requires node weights as an input for each gene in the corresponding sample. For more details, refer PathExt paper at "https://academic.oup.com/bioinformatics/article/37/9/1254/5952670?login=true"

**#################### Node Weight Computation ######################**

For computing node weights, user need to provide the input data in the csv file format. The input data should consist of 3 columns. First column should be gene list. Second column should be the value of those genes in control sample and Third column should be the value of those genes in the case. Order of the column is very important for the code.

It's recommended that user should provide the gene values in the quantile normalize form.

Next, run code **"Activated_node_weight.r"** to compute node weight for the Activated Network and **"Repressed_node_weight.r"** to compute node weight for the Repressed Network. The codes are provided in the **"code"** folder

The provided code compute value for one sample. User can run the code in loop for multiple samples.

**Code Usage:**

**/usr/local/bin/Rscript Activated_node_weight.r**      ##### For computing Activated Node Weight

**/usr/local/bin/Rscript Repressed_node_weight.r**      ##### For computing Repressed Node Weight


**########################### Running PathExt for Generating the TopNets ##########**

1. Compute the percentile threshold and q-score at which you user want minimum nubmer of nodes in the topnet. Run the following commands inside the folder where all the python codes are present.

**mkdir test_data/results/temp**

**python3 node_weight_matrix_colname_Pijs.py test_data/input_data Sample1 test_data/human_PPIN.txt 0.1 2 1000 test_data/results/Activated_response test_data/results/temp/Pij**

**python3 fdr_rand_pijs_boxcox.py test_data/results/temp test_data/results/Pij_zscores.txt**

**rm -rf test_data/results/temp**

**python3 try_different_thresholds_node_weight_matrix.py test_data/input_data Sample1 test_data/human_PPIN.txt 2 test_data/results/Pij_zscores.txt test_data/results/thresh_TopNet_sizes.txt**

2. After running the following commands, select the best values from the output file **"thresh_TopNet_sizes.txt"**. For example, user selected 0.01 as percentile and 0.05 as q-score. Now run the following commands for generating the topnets with user selected pecentile and q-score.

**mkdir test_data/results/temp**

**python node_weight_matrix_colname_Pijs.py test_data/input_data Sample1 test_data/human_PPIN.txt 0.01 2 1000 test_data/results/Activated_response test_data/results/temp/Pij**

**python fdr_rand_pijs_boxcox.py test_data/results/temp test_data/results/Pij_zscores.txt**

**rm -rf test_data/results/temp**

**python benjamini_hochberg_boxcox.py test_data/results/Pij_zscores.txt 0.05 test_data/results/Pij_zscores_fdr.txt**

**python extract_fdr_network.py test_data/results/Activated_response test_data/results/Pij_zscores_fdr.txt 0.05 test_data/results/Activated_Response_TopNet.txt**

Here,

a) "input_data" is a tab seprated microarray data file with all the samples to be studied;

b) "human_PPIN.txt" is the unweighted network file

c) "Sample1" is the name of perturbation sample to study

d) "0.01" is the percentile threshold

e) "2" is the path length threshold

f) "0.05" is the q-score cutoff

g) "1000" is the number of randomizations

h) "results" is the output directory

i) "thresh_TopNet_sizes.txt" is the output file with all the percentile and q-score threshold.

j) "Activated_Response" is the file name for base response network (we'll put it in the output directory)

k) "Activated_Response_TopNet.txt" is the file name for TopNet (we'll put it in the output directory)

**########################## Computing centrality score and top central genes ###########**

After generating the topnet file, compute the centrality score of each gene by running the following command

**python calc_ripple_centrality.py test_data/results/Activated_Response_TopNet.txt test_data/results/Activated_epicenter**

Next step is sorting the output file on the basis of "ripple_centrality" score and selecting the top required genes.

We have provided the example ouput file in the **"test_data/results/"** folder for the reader.

**############################ Creating Heatmap #######################################**

Create a comma separated file to generate heatmap. Sample input file is provided "heatmap_input.csv" and the generated output is a jpg image "Heatmap.jpg"

Code is present in the **"code"** folder

**Code usage:**

**/usr/local/bin/Rscript heatmap.r**

**############################ Creating DotPlot #######################################**

Create a comma separated file to generate Dotplot. Sample input file is provided "dotplot_input.csv" and the generated output is a jpg image "Dotplot.jpg"

Code is present in the **"code"** folder

**Code usage:**

**/usr/local/bin/Rscript dotplot.r**

**############################## Creating Circular Images using CirGO #####################**

First download the CirGo software from the https://github.com/IrinaVKuznetsova/CirGO and install it.

Once the software is installed, you have to run the following command using the sample input file.

**python CirGO.py -inputFile cirgo_input_file.csv -outputFile out.svg -fontSize 7 -numCat 40 -legend Test_Data**

User can modify the parameters as per their usage.

Here, we have provided the code, the sample input file and the output image in the **"code"** folder

#######################################################################################################

**Tools and packages used:**

Python 3.6.9
Pandas 0.25.3
Networkx 1.11
Numpy 1.17.4
Random
Sys
Math

