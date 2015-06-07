plot4 <- function() {
    fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
    download.file(fileUrl, destfile = "project1.zip", method = "curl")
    
    data <- read.table(unz("project1.zip", "household_power_consumption.txt"), header = TRUE,stringsAsFactors=FALSE,sep=';')
    data$Date <- as.Date(data$Date, format = "%d/%m/%Y")
    subnewFile <- data[data$Date >= "2007-02-01" & data$Date < "2007-02-03",]
    
    newGlobal <- as.numeric(as.vector(subnewFile$Global_active_power))
    newGlobalRe <- as.numeric(as.vector(subnewFile$Global_reactive_power))
    newVoltage <- as.numeric(as.vector(subnewFile$Voltage))
    newSub_metering_1 <- as.numeric(as.vector(subnewFile$Sub_metering_1))
    newSub_metering_2 <- as.numeric(as.vector(subnewFile$Sub_metering_2))
    newSub_metering_3 <- as.numeric(as.vector(subnewFile$Sub_metering_3))
    library(lubridate)
    
    # switch to US time
    backkup_locale <- Sys.getlocale('LC_TIME')
    Sys.setlocale('LC_TIME', 'C')
    
    dateTime   <- as.POSIXlt(paste(as.Date(subnewFile$Date, format="%d/%m/%Y"), subnewFile$Time, sep=" "),tz = "GMT")
    dev.off()
    png("plot4.png", width=480, height=480)
    par(mar=c(2, 2, 2, 2))
    
    par( mfrow = c( 2, 2 ) )
    plot(y=newGlobal , x=dateTime, ylab="Global active power", xlab=" ",type="l")
    plot(y=newVoltage , x=dateTime, ylab="Voltage", xlab="datetime",type="l")
    
    plot(y=newSub_metering_1 , x=dateTime, xlab=" ",ylab="Energy sub metering",type="l",col="black")
    #legend("topright", legend = "Sub_metering_1",col=par("col"))
    
    lines(y=newSub_metering_2 , x=dateTime, xlab=" ",type="l",col="red")
     
    lines(y=newSub_metering_3 , x=dateTime, xlab=" ",type="l",col="blue")
    legend("topright",col=c("black","red","blue" ),
           pch="-",lty=1, lwd=2,bty="o",  
           legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
    plot(y=newGlobalRe , x=dateTime, ylab="Global_reactive_power",xlab="datetime", type="l")
    dev.copy(png,"plot4.png", width=480, height=480)
    dev.off()
    
    #  restore changes time    
    Sys.setlocale('LC_TIME', backkup_locale)

}

