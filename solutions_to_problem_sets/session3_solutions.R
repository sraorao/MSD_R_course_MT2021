##Breakout tasks - MSD COVID dataset
#1) Import the corresponding sheet from Excel file provided (use readxl)
#Group 1 - IFNy; Group 2 - IL-1; Group 3 - IL-2; Group 4 - IL-10
library(readxl)
mydata <- read_excel("Session3/data/MSD_data.xlsx", sheet = 'IL-1')
mydata$Randomised_to <- as.factor(mydata$Randomised_to)
levels(mydata$Randomised_to)

#2) Add a new column "Subtraction" (col4) by subtracting the background unstimulated value (col3) from the stimulated one (col2)
library(dplyr)
mydata$Subtraction <- mydata$Calc.Conc.Mean_S1S2-mydata$Calc.Conc.Mean_Unst
#or with dplyr
mydata %>% mutate(Subtraction=Calc.Conc.Mean_S1S2-Calc.Conc.Mean_Unst) -> mydata

#3) Group the "Subtraction" values by the randomisation group and find mean, median, standard deviation
mydata %>% group_by(Randomised_to) -> mydata1
summarise(mydata, median(Subtraction))
summarise(mydata1, median(Subtraction))
#Note the difference?

#4) Find the maximum and minimum values of Subtract in each group (group by randomisation)
#combining 3 and 4 tasks together and writing the output in the data.frame
mydata %>%
group_by(Randomised_to) %>%
summarise(mean_IL1 = mean(Subtraction), median_IL1 = median(Subtraction), sd_IL1 = sd(Subtraction), max_IL1 = max(Subtraction), min_IL1 = min(Subtraction)) -> IL1_summary

#5) Remove the rows, which have negative values in Subtract
mydata %>%
filter(Subtraction >= 0) -> IL1_positive

#6) Save the table as csv comma-separated file containing columns 1, 5 and 6 only (without negative values - see #5)
#Hint: try to find 2 solutions - base R and dplyr option
IL1_positive %>%
select(c("Assay", "Randomised_to", "Subtraction")) -> IL1_selected
#or with base R
IL1_selected <- IL1_positive[,c(1,5,6)]
#save as csv (comma-separated by default)
write_csv(IL1_selected, "IL1_analysed.csv")
