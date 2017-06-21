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
png("plot1.png")

## Making Plot 1
hist(y$Global_active_power, xlab="Global Active Power (kilowatts)", main="Global Active Power", col="red")

## Close the device
dev.off()