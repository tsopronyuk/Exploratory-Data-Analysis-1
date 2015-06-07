plot2 <- function() {
    fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
    download.file(fileUrl, destfile = "project1.zip", method = "curl")
    
    data <- read.table(unz("project1.zip", "household_power_consumption.txt"), header = TRUE,stringsAsFactors=FALSE,sep=';')
    data$Date <- as.Date(data$Date, format = "%d/%m/%Y")
    subnewFile <- data[data$Date >= "2007-02-01" & data$Date < "2007-02-03", ]
    newGlobal <- as.numeric(as.vector(subnewFile$Global_active_power))
    library(lubridate)
    
    # switch to US time
    backkup_locale <- Sys.getlocale('LC_TIME')
    Sys.setlocale('LC_TIME', 'C')
    
    dateTime   <- as.POSIXlt(paste(as.Date(subnewFile$Date, format="%d/%m/%Y"), subnewFile$Time, sep=" "),tz = "GMT")
    
    plot(y=newGlobal , x=dateTime, ylab="Global active power (kilowatts)", xlab=" ",type="l")
    dev.copy(png,"plot2.png", width=480, height=480)
    dev.off()
    
    #  restore changes time    
    Sys.setlocale('LC_TIME', backkup_locale)

}
