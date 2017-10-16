## Note: The week days are in my language.
## It is assumed our working directory coincides the read file directory.
## Reading data. As long as we need data for 2007/02/01 and 2007/02/02
## only we don't need to read the whole file. The file contains observations
## for every minute since 2006/12/16 17:24:00. Which means we can skip
## 66637 rows and read 2880 rows which are the amount of minutes from
## 2006/12/16 17:24:00 to 2007/02/01 00:00:00 and in two days we need
## respectively.

data <- read.table("household_power_consumption.txt",
                   skip = 66637, nrows = 2880, na.strings = "?", sep = ";")

## Setting names to our data frame by reading the first row in the file.

names(data) <- names(read.table("household_power_consumption.txt",
                                nrows = 1, sep = ";", header = TRUE))

## Transforming date and time variables to appropriate type.

data$General_Date <- strptime(paste(as.character(data$Date),
                                    as.character(data$Time)),
                              format = "%d/%m/%Y %H:%M:%S")

## Opening png graphics device and creating new file if doesn't exist.
## Size 480 x 480 by default. Plotting in png file and closing device.

png("plot2.png")
with(data, plot(General_Date, Global_active_power, type = "l",
                ylab = "Global Active Power (kilowatts)", xlab = ""))
dev.off()