# File name: plot1.R
# This R file get a zip file from this URL
# https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip,
# unzip the file, and extract the data with dates 2007-02-01 and 2007-02-02.
# It then examine how household energy usage varies over the above 2-day period
# and creates a Histogram of Global Active Power and print to PNG.

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

# Plotting Data
print("Plotting PNG Data")
png(filename = "plot1.png", width = 480, height = 480) # config graphic device for PNG
hist(final_data$Global_active_power, xlab = "Global Active Power (kilowatts)",
     main = "Global Active Power", col = "RED") # plot histogram to PNG
dev.off() # turn off graphics device
print("PNG Data Plotted to /Data/plot1.png")

# End of plot1.R