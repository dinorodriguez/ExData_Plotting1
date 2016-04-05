library(sqldf)
data <- read.csv.sql("../Documents/household_power_consumption.txt", sql = "select Date, Time, Global_active_power, Global_reactive_power, Voltage, Sub_metering_1, Sub_metering_2, Sub_metering_3 from file where Date = '1/2/2007' or Date = '2/2/2007'", header = TRUE, sep = ";")
datetime <- with(data, strptime(paste(as.Date(Date,"%d/%m/%Y"),Time),"%Y-%m-%d %H:%M:%S"))
png("plot4.png", width = 480, height = 480)
par(mfrow = c(2,2))

# 1,1
plot(datetime, data$Global_active_power, type = "l", ylab = "Global Active Power", xlab = "")

# 1,2
with(data, plot(datetime, Voltage, type = "l"))

# 2,1
plot(datetime, data$Sub_metering_1, type = "l", ylab = "Energy sub metering", xlab = "", col = "black")
lines(datetime, data$Sub_metering_2, col = "red")
lines(datetime, data$Sub_metering_3, col = "blue")
legend("topright", c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), lty = 1, col=c("black","red","blue"), bty = "n")

# 2,2
with(data, plot(datetime, Global_reactive_power, type = "l"))

dev.off()