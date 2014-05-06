## Code for generating plots in fulfillment of requirements
## for Course Project 1 of Exploratory Data Analysis course
## 

# Download data
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileUrl, "powerconsumption.zip")
# record date file was downloaded and store for reference
datedownloaded <- date()
data <- read.table(unz("powerconsumption.zip", "household_power_consumption.txt"), header=T, sep=";",
                   na.strings="?",colClasses=c("character","character","numeric","numeric",
                                "numeric","numeric","numeric","numeric","numeric"))
                                
# Set date range for data subsetting
startDate <- as.Date("2007-2-1")
endDate <- as.Date("2007-2-2")

# Convert Date
data$Date <- as.Date(data$Date, format='%d/%m/%Y')

# Subset data
projectdata <- subset(data, data$Date %in% c(startDate, endDate))

# Generate Plot 1
png(file = "plot1.png")
par(mfrow = c(1, 1))
hist(projectdata$Global_active_power, col="red",
     xlab="Global Active Power (kilowatts)",main="Global Active Power")
dev.off()