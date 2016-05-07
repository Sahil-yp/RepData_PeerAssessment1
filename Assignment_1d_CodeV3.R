## Load the required libraries
library(dplyr)
library(chron)
library(lattice)

# Check if raw_data is loaded, else get the data.
if(!exists("raw_data", mode="function")) source("Assignment_1_Getting_Data.R")

# Creating new data frame with raw_data + Weekday column
week_data <- mutate(raw_data,
       # day = weekdays(raw_data$date),
       weekend = factor(is.weekend(raw_data$date), labels = c("Weekday", "Weekend"))
       )

# Grouping by interval 
by_interval_w <- group_by(week_data, interval, weekend)

t_s_w <- summarize(by_interval_w, avg_steps = mean(steps, na.rm = TRUE))

# Creating the plot
png("Avg_Weekend_Weekday_Steps.png")
with(t_s_w, xyplot(avg_steps~interval|weekend, type = "l", layout=c(1,2)))
dev.off()
