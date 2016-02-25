# Plot 1

# calculate approx memory required
reqmem <- 2075259 * 9 * 8 / 2^20 # MB (8 bytes per numeric)
reqmem

# Read data
#-----------
fname = "household_power_consumption.txt"
# read only first column (date) and figure out which rows correspond to 
# 2007-02-01 and 2007-02-02
date.val <- read.table(fname, comment.char = ";", header=T)
reqind <- which(date.val$Date == "1/2/2007")
s1 <- min(reqind)-1
n1 <- length(reqind)
reqind <- which(date.val$Date == "2/2/2007")
s2 <- min(reqind)-1
n2 <- length(reqind)

# read colnames by reading just the first row
colnames <- names(read.table(fname, sep=";", nrow=1, header=T))
# read all columns for these two dates
d1 <- read.table(fname, sep=";", skip = s1, nrow = n1, col.names = colnames,
                   stringsAsFactors = FALSE, header = TRUE, na.strings = "?")

d2 <- read.table(fname, sep=";", skip = s2, nrow = n2, col.names = colnames,
                 stringsAsFactors = FALSE, header = TRUE, na.strings = "?")

powerdata <- rbind(d1,d2)

# Plot the data
#--------------
png(filename="plot1.png")
hist(powerdata$Global_active_power, col="red", 
     xlab="Global Active Power(kilowatts)", main = "Global Active Power")
dev.off()
