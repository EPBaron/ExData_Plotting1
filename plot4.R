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

# Set up plot grid
png(file = "plot4.png", width = 480, height = 480, units = "px")
par(mfrow = c(2, 2))
# Set plot margins
par(mar=c(5,5,3,1))
# Set text size
par(cex=0.8)

# Generate Plot 4
with(projectdata, plot(datetime, Global_active_power, type="l",
                       xlab="", ylab="Global Active Power"))
with(projectdata, plot(datetime, Voltage, type="l"))
with(projectdata, plot(datetime, Sub_metering_1, type="l", col="black",
                       xlab="", ylab="Energy sub metering"))
with(projectdata, lines(datetime, Sub_metering_2, type="l", col="red"))
with(projectdata, lines(datetime, Sub_metering_3, type="l", col="blue"))
legend("topright", c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
       lty=c(1,1,1), col=c("black","red","blue"), bty="n")
with(projectdata, plot(datetime, Global_reactive_power, type="l"))
dev.off()