## Download and unzip the dataset
if(!file.exists("./proj")){dir.create("./proj")}
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileUrl,destfile="./proj/data.zip")
unzip(zipfile="./proj/data.zip",exdir="./proj")

## Extract Data from file
l<-list.files("./proj")
l<-c("./proj/", l[2])
z<-read.table(paste(l, collapse = ""), header=TRUE, sep=";", as.is=TRUE)
head(z)

## Convert Data Types to numeric and character
for(i in 3:9)  z[,i]<-as.numeric(z[,i])
z[,1] <- as.Date(z[,1], "%d/%m/%Y")

## Subset data as required
y<-subset(z, z$Date=="2007-02-01" | z$Date=="2007-02-02")

## Change Current device
png("plot4.png")

## Making Slots for plots
par(mfrow=c(2,2))

## Plot 1
plot(y$Global_active_power, type="l", ylab="Global Active Power (kilowatts)", xlab="", xaxt="n")
lab<-c("Thu", "Fri", "Sat")
find<-table(y$Date)
find<-find[1] + 1
count<-nrow(y)
axis(1, at=c(0, find, count), label=lab)

## Plot 2
plot(y$Voltage, type="l", ylab="Voltage", xlab="datetime", xaxt="n")
axis(1, at=c(0, find, count), label=lab)

## Plot 3
plot(y$Sub_metering_1, type="l", ylab="Energy sub metering", xaxt="n", xlab="", ylim=c(0,38))
par(new=TRUE)
plot(y$Sub_metering_2, type="l", xlab="", ylab="", xaxt="n", ylim=c(0,38), col="red")
par(new=TRUE)
plot(y$Sub_metering_3, type="l", xlab="", ylab="", xaxt="n", ylim=c(0,38), col="blue")
axis(1, at=c(0, find, count), label=lab)
legend("topright", lty=1, col=c("black", "blue", "red"), legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), bty="n", cex=0.9)

## Plot 4
plot(y$Global_reactive_power, type="l", ylab="Global_reactive_power", xlab="datetime", xaxt="n")
axis(1, at=c(0, find, count), label=lab)

## Close the device
dev.off()