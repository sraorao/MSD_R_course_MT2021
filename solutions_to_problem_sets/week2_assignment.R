# Q1. Install the stemHypoxia data package from Bioconductor by following the 
#     instructions here: https://bioconductor.org/packages/devel/data/experiment/html/stemHypoxia.html
if (!requireNamespace("BiocManager", quietly = TRUE))
  install.packages("BiocManager") # this and the above line are not needed if BiocManager is already installed

BiocManager::install("stemHypoxia")
 

# Q2. Load the stemHypoxia gene expression data.frame and draw a boxplot of gene expressions for all samples
#     hint: find the help page for the dataset to get you started. BUT, there is an error 
#           in the example code, how can you fix it?

library(stemHypoxia)
?stemHypoxia
data(stemHypoxia) # notice the 'design' and 'M' objects appearing in your global environment on the right
# data.frame M contains the gene expression data, as described in the help pages
?M
# the help page for 'M' has the following code at the end of the page as an example
boxplot(M[,-(1,2)])
# but it has an error, which can be fixed in the following way
boxplot(M[,-c(1,2)]) # or
boxplot(M[, c(-1, -2)])

# Q3. Make a new column in the gene expression data.frame for the mean expression of each gene across
#     all the samples. Sort the data.frame from highest to lowest mean expression and subset the top
#     10 genes (with the highest mean expression).
#     hint: Useful functions for this task are rowMeans(), base::order()/dplyr::arrange()

# BASE R SOLUTION
M$mean_exp <- rowMeans(M[, -c(1,2)]) # create a new column for mean expression
M_sorted <- M[order(M$mean_exp, decreasing = TRUE), ] # sort by decreasing mean_exp
M_sorted_top10 <- M_sorted[1:10, ] # top 10 genes by mean expression

# DPLYR SOLUTION
M %>%
  mutate(mean_exp = rowMeans(.[, -c(1,2)])) %>%
  arrange(-mean_exp) %>%
  slice(1:10) -> M_sorted_top10_dplyr

identical(M_sorted_top10$Gene_ID, M_sorted_top10_dplyr$Gene_ID) # we can see that the top 10 genes are identical whichever method we use

