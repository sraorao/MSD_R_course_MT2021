# Q1. Packages can be installed in R from various repositories. The most common ones
#     are CRAN and Bioconductor. Install the beeswarm package from CRAN.
install.packages("beeswarm")
# Q2. The beeswarm package comes with a preloaded dataset of breast tumours. Load 
#     this dataset into your global R environment.
#     hint: You first need to load the package into R and then load the breast data.frame
#     into memory; try ??breast at your R console and follow the help pages if needed.
library(beeswarm)
data(breast)
# Q3. How many ER positive and ER negative tumours are in the dataset?
summary(breast) # or

table(breast$ER) # or

cat(paste("The number of ER positive tumours is: ", sum(breast$ER == "pos"), 
            "\nand the number of ER negative tumours is: ", sum(breast$ER == "neg"))) # or

library(dplyr)
breast %>%
  group_by(ER) %>%
  count()

# Q4. Plot ESR1 on the X axis and ERBB2 on the y axis, colour the dots by ER status
plot(breast$ESR1, breast$ERBB2, col = breast$ER) # or

library(ggplot2)
breast %>%
  ggplot(mapping = aes(x = ESR1, y = ERBB2, colour = ER)) + # sets up the x, y and colour but does not draw anything yet
    geom_point() + # draws the points
    theme_bw() + # Black and White theme
    theme(panel.grid = element_blank()) # remove panel grid

# Q5. Filter the dataset to include only those patients who have metastasis as the outcome,
#     and assign this filtered dataset to a new variable
?breast # help pages say that event_survival == 1 is metastasis
breast_mets = breast[breast$event_survival == 1, ] # or

breast_mets <- filter(breast, event_survival == 1) # or

breast %>%
  filter(event_survival == 1) -> breast_mets

