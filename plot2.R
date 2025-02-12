#loading the data
install.packages("readr")
library(readr)
household_data <- read_delim("C:/Users/Elite/Downloads/exdata_data_household_power_consumption/household_power_consumption.txt", delim = ";")
View(household_data)
#changing the time and date formats
household_data$Date <- as.Date(household_data$Date, format = "%d/%m/%Y")
household_data$Time <- strptime(household_data$Time, format = "%H:%M:%S")
#subsetting the data for the first two days in february 2007
Real_data <- subset(household_data, Date >= as.Date("2007-02-01") & Date <= as.Date("2007-02-02"))
View(Real_data)
#extracting days of the week
Real_data$Day <- weekdays(Real_data$Date)
#filtering for thursday,friday and saturday
filtered_weekdays <- subset(Real_data, Day %in% c("Thursday", "Friday", "Saturday"))
View(filtered_weekdays)
#combining the time and date columns
filtered_weekdays$Time <- sub(".* ", "", filtered_weekdays$Time)
filtered_weekdays$Datetime <- as.POSIXct(paste(filtered_weekdays$Date, filtered_weekdays$Time), format="%Y-%m-%d %H:%M:%S")
#creating the plot
day_positions <- tapply(filtered_weekdays$Datetime, format(filtered_weekdays$Datetime, "%A"), min)
if ("Friday" %in% names(day_positions)) {saturday_position <- max(filtered_weekdays$Datetime) + 86400} else {saturday_position <- NA}
day_positions <- c(day_positions, Saturday = saturday_position)
day_positions <- day_positions[!is.na(day_positions)]
unique_days <- names(day_positions)
plot(filtered_weekdays$Datetime, filtered_weekdays$Global_active_power, type="l", xaxt="n",xlab=" ", ylab="Global Active Power (kilowatts)")
axis(1, at=day_positions, labels=unique_days)
dev.copy(png, "plot2.png", width= 480, height= 480)
dev.off()