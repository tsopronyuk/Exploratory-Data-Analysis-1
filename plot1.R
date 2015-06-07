plot1 <- function() {
    fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
    download.file(fileUrl, destfile = "project1.zip", method = "curl")
    
    data <- read.table(unz("project1.zip", "household_power_consumption.txt"), header = TRUE,stringsAsFactors=FALSE,sep=';')
    data$Date <- as.Date(data$Date, format = "%d/%m/%Y")
    subnewFile <- data[data$Date >= "2007-02-01" & data$Date <= "2007-02-02", ]
    head(subnewFile)
    newGlobal <- as.numeric(as.vector(subnewFile$Global_active_power))
    hist(x=newGlobal,main="Global active power",xlab="Global active power (kilowatts)",col=2)
    

    dev.copy(png,"plot1.png", width=480, height=480)
    dev.off()

}
