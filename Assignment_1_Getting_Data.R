
initial_dir <- getwd()

## Check if .csv dataset exists, else download and unzip the file
if(file.exists("activity.csv"))
        raw_data <- read.csv("activity.csv") else {
                fileURL <- "https://d396qusza40orc.cloudfront.net/repdata%2Fdata%2Factivity.zip"
                download.file(fileURL, destfile = 'activity.zip', method = "libcurl")
                data_date <- date()
                write(data_date, file = "Data_Download_Date.txt")
                unzip("activity.zip")
                raw_data <- read.csv("activity.csv")
        }

raw_data$date <- as.Date(raw_data$date,"%Y-%m-%d")