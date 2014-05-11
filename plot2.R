hpc <- read.table("household_power_consumption.txt", header=T, sep=";")

hpc_sub <- subset(hpc, hpc$Date=="1/2/2007" | hpc$Date=="2/2/2007")

# replace ? symbols in Global_active_power column with NA, convert to numeric 
hpc_sub <- cbind(hpc_sub, GAP=as.numeric(sub(x=hpc_sub$Global_active_power, 
                                             pattern="[?]", replacement="NA")))

# derive new FullTime column of type POSIXct from Date, Time columns
hpc_sub$FullTime <- as.POSIXct(paste(hpc_sub$Date,hpc_sub$Time),
                               "%d/%m/%Y %H:%M:%S", tz="GMT")

png(filename="./figure/plot2.png", width=480, height=480, bg="transparent")

# TODO ensure plot is line chart with day of week on x-axis
plot(hpc_sub$GAP ~ hpc_sub$FullTime, type="l", xlab="", 
     ylab="Global Active Power (kilowatts)")

dev.off()
