## Load the required libraries
library(dplyr)

# Check if raw_data is loaded, else get the data.
if(!exists("raw_data", mode="function")) source("Assignment_1_Getting_Data.R")

# Arranging the data by date
by_date <- group_by(raw_data, date)

# Calculating total steps for each day
t_s <- summarize(by_date, Total_Steps = sum(steps, na.rm = TRUE))

Mean_TS <- mean(t_s$Total_Steps)
Median_TS <- median(t_s$Total_Steps)

#Create histogram
png("Hist_Total_Steps_Each_Day.png")
with(t_s, hist(Total_Steps, breaks = 10, col = "lightgreen", main = "Total Steps Each Day", xlab = "Total Steps"))
dev.off()

paste("The mean total number of steps taken per day is ", Mean_TS, "and the median of the total number of steps taken per day is ", Median_TS)
