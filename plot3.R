# File name: plot3.R
# This R file get a zip file from this URL
# https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip,
# unzip the file, and extract the data with dates 2007-02-01 and 2007-02-02.
# It combines the Date and Time column and put it in a new column Date_Time.
# It then examine how household energy usage varies over the above 2-day period
# and creates 3 line graphs: Sub_metering_1, Sub_metering_1, Sub_metering_3 in a single plot in PNG.

url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"

if (!file.exists("data")) dir.create("data") # creates a "data" directory

# Download and unzip the file, and record the data of the file downloaded
print("Downloading a 20MB File.")
print("This will take a couple of minutes depending on your internet connection speed")
download.file(url, destfile = "./data/household_power_consumption.zip", mode="wb")
datedownloaded <- date()
unzip ("./data/household_power_consumption.zip", exdir = "./data")


# Reading the text file
print("Reading downloaded file. This will take a couple of seconds")
data <- read.table("./data/household_power_consumption.txt", header = TRUE,
                      sep =";", na.strings = "?") # read in the entire txt file.
data[,1] <- as.Date(data[,1], format = "%d/%m/%Y") # convert date column to date format.
final_data <- subset(data, Date == "2007-02-01" | Date == "2007-02-02") # get data for the required date.

# Combine Data and Time column into a single column
final_data <- cbind(Date_Time = as.POSIXct(paste(final_data$Date, final_data$Time), 
                                           format="%Y-%m-%d %H:%M:%S"), final_data)

# Plotting Data to PNG
print("Plotting PNG Data")
png(filename = "plot3.png", width = 480, height = 480) # config graphic device for PNG
plot(final_data$Date_Time, final_data$Sub_metering_1, type = "n",
     xlab = "", ylab = "Energy sub metering")
lines(final_data$Date_Time, final_data$Sub_metering_1,col = "BLACK")
lines(final_data$Date_Time, final_data$Sub_metering_2,col = "RED")
lines(final_data$Date_Time, final_data$Sub_metering_3,col = "BLUE")
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       lty = c(1,1,1), col=c("BLACK", "RED", "BLUE"))
dev.off() # turn off graphics device
print("PNG Data Plotted to /Data/plot3.png")

# End of plot3.R