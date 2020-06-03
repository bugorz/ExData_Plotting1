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

# Plot 3
plot3 <- function() {
    plot(x = full_datetime,
         y = selected$Sub_metering_1,
         xlab = "",
         ylab = "Energy sub metering",
         yaxt = "n",
         type = "l"
    )
    
    lines(x = full_datetime,
          y = selected$Sub_metering_2,
          lty = 1,
          col = "red"
    )
    
    lines(x = full_datetime,
          y = selected$Sub_metering_3,
          lty = 1,
          col = "blue"
    )
    
    ori <- legend(
        "topright",
        legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
        col = c("black", "red", "blue"),
        lty = 1,
        plot = FALSE,
        y.intersp = 1.5, # For correct PNG output
        inset = c(0.04, 0), # For correct PNG output
        cex = 0.75 # For correct PNG output
    )
    legend(x = c(ori$rect$left, ori$rect$left + ori$rect$w * 1.2),
           y = c(ori$rect$top, ori$rect$top - ori$rect$h),
           col = c("black", "red", "blue"),
           lty = 1,
           legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
           y.intersp = 1.5, # For correct PNG output
           cex = 0.75 # For correct PNG output
    )
    axis(2, at = seq(0, 40, by = 10))
}

plot3()
dev.copy(png, file = "plot3.png")
dev.off()
