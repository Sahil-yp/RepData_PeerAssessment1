## Load the required libraries
library(dplyr)
# Check if raw_data is loaded, else get the data.
if(!exists("raw_data", mode="function")) source("Assignment_1_Getting_Data.R")

# Number of rows with NAs. You could also just call the summary function on the raw data
NA_sum <- sum(is.na(raw_data))

# Create new dataset to replace NA values
new_data <- raw_data

# Aranging by interval
by_interval_n <- group_by(new_data, interval)
interval_steps_n <- summarise(by_interval_n, avg_steps_n = mean(steps, na.rm = TRUE))

#Imputing Missing Values with the average step for a given interval
for (i in 1:nrow(new_data)) {
        if(is.na(new_data[i,1])) {
                id_val <- new_data[i,3]
                rep_val <- filter(interval_steps_n, interval == id_val)
                new_data[i,1] <- rep_val[1,2]
        }
}

# Arranging new data by date
by_date_n <- group_by(new_data, date)
t_s_n <- summarize(by_date_n, Total_Steps_n = sum(steps))

Mean_TSN <- mean(t_s_n$Total_Steps_n)
Median_TSN <- median(t_s_n$Total_Steps_n)

#Creating the histogram
png("Hist_Total_Steps_Each_Day_with_Imputed_Data.png")
with(t_s_n, hist(Total_Steps_n, breaks = 10, col = "lightgreen", main = "Total Steps Each Day", xlab = "Total Steps"))
dev.off()

paste("The total number of NA values in the raw dataset is", NA_sum)
paste("The mean total number of steps taken per day, after imputing missing values is", round(Mean_TSN, digits=2))
paste("The median of the total number of steps taken per day, after imputing missing values is",round(Median_TSN, digits = 2))