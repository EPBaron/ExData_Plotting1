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

# Paste Date and Time fields into new column
projectdata$datetime <- paste(projectdata$Date, projectdata$Time)
# Convert to Posix formatted date-time
projectdata$datetime <- strptime(projectdata$datetime, format="%Y-%m-%d %H:%M:%S")
# Generate Plot 2
png(file = "plot2.png", width = 480, height = 480, units = "px")
par(mfrow = c(1, 1))
with(projectdata, plot(datetime, Global_active_power, type="l",
                       xlab="", ylab="Global Active Power (kilowatts)"))
dev.off()                
                     