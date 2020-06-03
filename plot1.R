setwd("IdeaProjects/r_project/course4/week1/")

zip_file_name <- "household_power_consumption.zip"

if (!file.exists(zip_file_name)) {
    download.file(
        "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",
        zip_file_name,
        method = "curl"
    )
    dateDownloaded <- date()
}
unzip(zip_file_name)

# Data frame preperation
# Because of '?' in the data, can't specify colClasses = column_classes
# column_classes <- c("factor", "factor", rep("numeric", 7))
power_consumption <- read.csv("household_power_consumption.txt", sep = ";")
power_consumption$Date <- as.Date(power_consumption$Date, "%d/%m/%Y")
power_consumption$Global_active_power <- as.numeric(as.character(power_consumption$Global_active_power))
power_consumption$Global_reactive_power <- as.numeric(as.character(power_consumption$Global_reactive_power))
power_consumption$Voltage <- as.numeric(as.character(power_consumption$Voltage))
power_consumption$Sub_metering_1 <- as.numeric(as.character(power_consumption$Sub_metering_1))
power_consumption$Sub_metering_2 <- as.numeric(as.character(power_consumption$Sub_metering_2))
power_consumption$Sub_metering_3 <- as.numeric(as.character(power_consumption$Sub_metering_3))

dates <- c(as.Date("2007-02-01"), as.Date("2007-02-02"))
selected <- power_consumption[power_consumption$Date %in% dates, ]
full_datetime <- strptime(paste(format(selected$Date), selected$Time), "%Y-%m-%d %H:%M:%S")

# Plot 1
plot1 <- function() {
    hist(selected$Global_active_power,
         main = "Global Active Power",
         xlab = "Global Active Power (kilowatts)",
         xaxt = "n",
         col = "red"
    )
    axis(1, at = seq(0, 6, by = 2))
}

plot1()
dev.copy(png, file = "plot1.png")
dev.off()
