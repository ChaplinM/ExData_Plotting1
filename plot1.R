hpc <- read.table("household_power_consumption.txt", header=T, sep=";")

hpc_sub <- subset(hpc, hpc$Date=="1/2/2007" | hpc$Date=="2/2/2007")

hpc_sub$Global_active_power <- as.numeric(sub(x=hpc_sub$Global_active_power, 
                                              pattern="[?]", replacement="NA"))

png(filename="./figure/plot1.png", width=480, height=480, bg="transparent")

hist(hpc_sub$Global_active_power, main="Global Active Power",
     xlab="Global Active Power (kilowatts)", col="red", ylim=c(0,1200))

dev.off()
