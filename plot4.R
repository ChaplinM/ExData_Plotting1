hpc <- read.table("household_power_consumption.txt", header=T, sep=";")

hpc_sub <- subset(hpc, hpc$Date=="1/2/2007" | hpc$Date=="2/2/2007")

# replace ? symbols in various columns with NA, convert to numeric 
hpc_sub$Global_active_power <- as.numeric(sub(x=hpc_sub$Global_active_power, 
                                              pattern="[?]", replacement="NA"))
hpc_sub$Global_reactive_power <- as.numeric(sub(x=hpc_sub$Global_reactive_power, 
                                                pattern="[?]", replacement="NA"))
hpc_sub$Voltage <- as.numeric(sub(x=hpc_sub$Voltage, 
                                  pattern="[?]", replacement="NA"))
hpc_sub$Sub_metering_1 <- as.numeric(sub(x=hpc_sub$Sub_metering_1, 
                                         pattern="[?]", replacement="NA"))
hpc_sub$Sub_metering_2 <- as.numeric(sub(x=hpc_sub$Sub_metering_2, 
                                         pattern="[?]", replacement="NA"))

# derive new FullTime column of type POSIXct from Date, Time columns
hpc_sub$FullTime <- as.POSIXct(paste(hpc_sub$Date,hpc_sub$Time), 
                               "%d/%m/%Y %H:%M:%S", tz="GMT")

# open a png graphics device
png(filename="./figure/plot4.png", width=480, height=480, bg="transparent")

par(mfrow = c(2, 2))

# see plot2.R
plot(hpc_sub$Global_active_power ~ hpc_sub$FullTime, type="l", xlab="", 
     ylab="Global Active Power")

# line chart of Voltage vs datetime
plot(hpc_sub$Voltage ~ hpc_sub$FullTime, type="l", xlab="datetime", 
     ylab="Voltage")

# see plot3.R
plot(hpc_sub$Sub_metering_1 ~ hpc_sub$FullTime, type="l", xlab="", 
     ylab="Energy sub metering")
points(hpc_sub$Sub_metering_2 ~ hpc_sub$FullTime, type="l", col="red")
points(hpc_sub$Sub_metering_3 ~ hpc_sub$FullTime, type="l", col="blue")
legend("topright", bty="n", lty=1, col=c("black","blue","red"), 
       legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))

# reactive power is non-zero when voltage and current are out-of-phase 
with(hpc_sub, plot(Global_reactive_power ~ FullTime, type="l", xlab="datetime")) 

dev.off()

