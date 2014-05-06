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

# Generate Plot 3
png(file = "plot3.png", width = 480, height = 480, units = "px")
par(mfrow = c(1, 1))
with(projectdata, plot(datetime, Sub_metering_1, type="l", col="black",
                       xlab="", ylab="Energy sub metering"))
with(projectdata, lines(datetime, Sub_metering_2, type="l", col="red"))
with(projectdata, lines(datetime, Sub_metering_3, type="l", col="blue"))
legend("topright", c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
       lty=c(1,1,1), col=c("black","red","blue"), cex=0.8)
dev.off()