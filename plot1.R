#Loading the dataset
install.packages("readr")
library(readr)
household_data <- read_delim("C:/Users/Elite/Downloads/exdata_data_household_power_consumption/household_power_consumption.txt", delim = ";")
View(household_data)
#changing the date format
household_data$Date <- as.Date(household_data$Date, format="%d/%m/%Y")
household_data$Time <- strptime(household_data$Time, format="%H:%M:%S")
#Subsetting the data
start_date <- as.Date("2007-02-01")
end_date <- as.Date("2007-02-02")
Real_data <- subset(household_data, Date >= start_date & Date <= end_date)
View(Real_data)
# A histogram of global active power
Real_data$Global_active_power <- as.numeric(Real_data$Global_active_power)
hist(Real_data$Global_active_power, main = "Global Active Power", xlab = "Global Active Power (kilowatts)", ylab = "Frequency", col = "red")
dev.copy(png, "plot1.png", width= 480, height= 480)
dev.off()