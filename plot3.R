hpc <- read.table("household_power_consumption.txt", header=T, sep=";")

hpc_sub <- subset(hpc, hpc$Date=="1/2/2007" | hpc$Date=="2/2/2007")

# replace ? symbols in Global_active_power column with NA, convert to numeric 
hpc_sub$Global_active_power <- as.numeric(sub(x=hpc_sub$Global_active_power, 
                                              pattern="[?]", replacement="NA"))
# replace ? symbols in Sub_metering_1 column with NA, convert to numeric 
hpc_sub$Sub_metering_1 <- as.numeric(sub(x=hpc_sub$Sub_metering_1, 
                                         pattern="[?]", replacement="NA"))
# replace ? symbols in Sub_metering_2 column with NA, convert to numeric 
hpc_sub$Sub_metering_2 <- as.numeric(sub(x=hpc_sub$Sub_metering_2, 
                                         pattern="[?]", replacement="NA"))

# derive new FullTime column of type POSIXct from Date, Time columns
hpc_sub$FullTime <- as.POSIXct(paste(hpc_sub$Date,hpc_sub$Time), 
                               "%d/%m/%Y %H:%M:%S", tz="GMT")

# open a png graphics device
png(filename="./figure/plot3.png", width=480, height=480, bg="transparent")

# open plotting with Sub_metering_1 as this uses the full scale on the y-axis
plot(hpc_sub$Sub_metering_1 ~ hpc_sub$FullTime, type="l", xlab="", 
     ylab="Energy sub metering")

# "overlay" other data series for sub metering 2 and 3 as points
points(hpc_sub$Sub_metering_2 ~ hpc_sub$FullTime, type="l", col="red")
points(hpc_sub$Sub_metering_3 ~ hpc_sub$FullTime, type="l", col="blue")

# add a legend at the top right
legend("topright", lty=1, col=c("black","blue","red"), 
       legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))

dev.off()
