# Plot 3

# Read data
#-----------
fname = "household_power_consumption.txt"
# read only first column (date) and figure out which rows correspond to 
# 2007-02-01 and 2007-02-02

#date.val <- read.table(fname, comment.char = ";", header=T)
#reqind <- which(date.val$Date == "1/2/2007")
#s1 <- min(reqind)-1
#n1 <- length(reqind)
#reqind <- which(date.val$Date == "2/2/2007")
#s2 <- min(reqind)-1
#n2 <- length(reqind)

s1 <- 66636
n1 <- 1440
s2 <- 68076
n2 <- 1440

# read colnames by reading just the first row
colnames <- names(read.table(fname, sep=";", nrow=1, header=T))
# read all columns for these two dates
d1 <- read.table(fname, sep=";", skip = s1, nrow = n1, col.names = colnames,
                 stringsAsFactors = FALSE, header = TRUE, na.strings = "?")

d2 <- read.table(fname, sep=";", skip = s2, nrow = n2, col.names = colnames,
                 stringsAsFactors = FALSE, header = TRUE, na.strings = "?")

powerdata <- rbind(d1,d2)

# convert date into posixlt format
powerdata$Date <- paste(powerdata$Date, powerdata$Time)
powerdata <- select(powerdata, -contains("Time"))
powerdata$Date <- strptime(powerdata$Date, "%d/%m/%Y %H:%M:%S")

# Plot the data
#--------------
png(filename="plot3.png")

with(powerdata, plot(Date, Sub_metering_1, xlab="", ylab ="Energy Sub Metering", type="n"))
with(powerdata, lines(Date, Sub_metering_1, col="black"))
with(powerdata, lines(Date, Sub_metering_2, col="red"))
with(powerdata, lines(Date, Sub_metering_3, col="blue"))
legend("topright",col = c("black","red","blue"), lwd = 1,
       legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))

dev.off()
