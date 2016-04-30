## Load the required libraries
library(dplyr)
# Check if raw_data is loaded, else get the data.
if(!exists("raw_data", mode="function")) source("Assignment_1_Getting_Data.R")

# Number of rows with NAs. You could also just call the summary function on the raw data
NA_sum <- sum(is.na(raw_data))

# Create new dataset to replace NA values
new_data <- raw_data

# Aranging by interval
by_interval <- group_by(new_data, interval)
interval_steps <- summarise(by_interval, avg_steps = mean(steps, na.rm = TRUE))

#Imputing Missing Values with the average step for a given interval
for (i in 1:nrow(new_data)) {
        if(is.na(new_data[i,1])) {
           id_val <- new_data[i,3]
           rep_val <- filter(interval_steps, interval == id_val)
           new_data[i,1] <- rep_val[1,2]
        }
}

# Arranging new data by date
by_date <- group_by(new_data, date)
t_s <- summarize(by_date, Total_Steps = sum(steps))

Mean_TS <- mean(t_s$Total_Steps)
Median_TS <- median(t_s$Total_Steps)

#Creating the histogram
png("Hist_Total_Steps_Each_Day_with_Imputed_Data.png")
with(t_s, hist(Total_Steps, breaks = 10, col = "lightgreen", main = "Total Steps Each Day", xlab = "Total Steps"))
dev.off()

paste("The total number of NA values in the raw dataset is", NA_sum)
paste("The mean total number of steps taken per day, after imputing missing values is", round(Mean_TS, digits=2))
paste("The the median of the total number of steps taken per day, after imputing missing values is",round(Median_TS, digits = 2))