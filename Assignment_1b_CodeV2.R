## Load the required libraries
library(dplyr)
# Check if raw_data is loaded, else get the data.
if(!exists("raw_data", mode="function")) source("Assignment_1_Getting_Data.R")

#Arrange the data by interval id
by_interval <- group_by(raw_data, interval)

#Calculating the average number of steps over total period for each interval
interval_steps <- summarise(by_interval, avg_steps = mean(steps, na.rm = TRUE))

#Time series plot for the average steps per interval
png("Average_Steps_per_Interval.png")
plot(interval_steps, type = "l", col = "blue", main = "Average Steps Per Interval", xlab = "Interval", ylab = "Average Steps") 
dev.off()

max_steps <- interval_steps[which.max(interval_steps$avg_steps),]
paste("The maximum number of steps, i.e.,", round(max_steps[1,2], digits = 2), "occur during interval", max_steps[1,1])