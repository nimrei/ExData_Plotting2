#Assignment 2

#read data into NEI & SCC dataframes - may take a while!
source("readdata.R")



#1
emissions <- subset(NEI, year %in% c("1999","2002","2005","2008"))
total.per.year <- aggregate(Emissions ~ year, emissions, sum)
png(filename="plot1.png", width=480, height=480)

with(total.per.year,
     plot(year, Emissions/1e6, 
          type="l", 
          xlab="Year", ylab="PM2.5 (millions of tons)", 
          main="Tons of PM2.5 Generated Per Year")
     )

dev.off()


#2
baltimore.emissions <- subset(NEI, 
                              fips=="24510" 
                              & year %in% c("1999","2008")
                              )
baltimore.emissions.per.year <- aggregate(Emissions ~ year, baltimore.emissions, sum)

png(filename="plot2.png", width=480, height=480)

with(baltimore.emissions.per.year,
     plot(year, Emissions/1e6, 
          type="l", 
          xlab="Year", ylab="PM2.5 (millions of tons)", 
          main="Tons of PM2.5 Generated Per Year in Baltimore City, MD")
)

dev.off()

#3
library(ggplot2)

baltimore.emissions <- subset(NEI, fips=="24510")
baltimore.emissions.per.year <- aggregate(Emissions ~ year+type, baltimore.emissions, sum)

png(filename="plot3.png", width=480, height=480)

ggplot(data=baltimore.emissions.per.year, 
       aes(x=year, y=Emissions, group=type, colour=type)) +
  geom_line() +
  xlab("Year") +
  ylab("PM2.5 (tons)") +
  ggtitle("PM2.5 vs. Year by Source Type")

dev.off()

#4
library(ggplot2)

coal.emissions.codes <- SCC[grepl("coal", SCC$Short.Name, ignore.case=TRUE) |
                         grepl("coal", SCC$SCC.Level.Three, ignore.case=TRUE), ]
coal.emissions <- subset(NEI, SCC %in% coal.emissions.codes$SCC)
coal.emissions.per.year <- aggregate(Emissions ~ year, 
                                     coal.emissions, sum)

png(filename="plot4.png", width=480, height=480)
ggplot(data=coal.emissions.per.year, 
       aes(x=year, y=Emissions)) +
       geom_line() +
       xlab("Year") +
       ylab("PM2.5 (tons)") +
       ggtitle("PM2.5 from Coal-Related Sources vs. Year")
dev.off()

#5

library(ggplot2)

vehicles <- SCC[grepl("Vehicle", SCC$Short.Name, ignore.case=T),]$SCC
baltimore.vehicle.emissions <- subset(NEI, 
                                      fips=="24510" &
                                      SCC %in% vehicles
                                      )
baltimore.vehicle.emissions.per.year <- aggregate(Emissions ~ year, 
                                                  baltimore.vehicle.emissions,
                                                  sum)

png(filename="plot5.png", width=480, height=480)
ggplot(data=baltimore.vehicle.emissions.per.year, 
       aes(x=year, y=Emissions)) +
       geom_line() +
       xlab("Year") +
       ylab("PM2.5 (tons)") +
       ggtitle("PM2.5 from Motor Vehicles vs. Year in the Baltimore City, MD area")
dev.off()



#6

library(ggplot2)

vehicles <- SCC[grepl("Vehicle", SCC$Short.Name, ignore.case=T),]$SCC
vehicle.emissions <- subset(NEI,             
                            fips %in% c("24510","06037") &
                            SCC %in% vehicles
                            )
vehicle.emissions$region <- as.factor(vehicle.emissions$fips)
levels(vehicle.emissions$region) <- c("Los Angeles","Baltimore")
vehicle.emissions.per.year <- aggregate(Emissions ~ year + region, 
                                        vehicle.emissions,
                                        sum)
png(filename="plot6.png", width=480, height=480)

ggplot(data=vehicle.emissions.per.year, 
       aes(x=year, y=Emissions, group=region, colour=region)) +
       geom_line() +
       xlab("Year") +
       ylab("PM2.5 (tons)") +
       ggtitle("PM2.5 from Motor Vehicles vs. Year in Baltimore and Los Angeles")
dev.off()







# #location on the web of our zip file
# source.web <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
# source.local <- tail(unlist(strsplit(source.web,split="/")),n=1)
# 
# #new datafile name based on our filtering criteria
# NEI.file <- "summarySCC_PM25.rds"
# SCC.file <- "Source_Classification_Code.rds"
# 
# #download our file if we don't have it
# if (!file.exists(source.local)) {
#   download.file(source.web, source.local)
# }
# #unzip the files
# unzip(source.local)
# 
# ## This first line will likely take a few seconds. Be patient!
# NEI <- readRDS(NEI.file)
# SCC <- readRDS(SCC.file)
# 



# 
# # Now read the full file
# df <- read.table(data.file, header=T, sep=";", na.strings="?")
# 
# # Combine date and time into 1 column
# df$Date <- as.POSIXct(paste(df$Date,df$Time),format="%d/%m/%Y %H:%M:%S")
# df$Time <- NULL
# # df$Date <- as.POSIXct(df$Date,format="%d/%m/%Y")
# # df$Time <- as.POSIXct(df$Time,format="%H:%M:%S")
# df$Weekday <- factor(format(df$Date,'%a'),levels=c("Mon","Tue","Wed","Thu","Fri","Sat","Sun"))
# 
# 
# # plot data into "plot1.png" file
# png("plot1.png")
# 
# 
# 
# #1
# hist(df$Global_active_power, col="red", main="Global Active Power",
#      xlab="Global Acitve Power (kilowatts)", ylab="Frequency")
# 
# #2
# plot(as.POSIXct(df$Date), df$Global_active_power, 
#      xlab="", type="l", ylab="Global Active Power (kilowatts)")
# 
# #3
# plot(as.POSIXct(df$Date),df$Sub_metering_1, 
#      xlab="", type="l", ylab="Energy sub metering")
# # add more lines to the same plot
# lines(as.POSIXct(df$Date),df$Sub_metering_2,col="red")
# lines(as.POSIXct(df$Date),df$Sub_metering_3,col="blue") 
# # add a legend 
# legend("topright", cex=1, col=c("black", "red", "blue"), 
#        lwd=1,y.intersp=1,xjust=1,text.width = strwidth("Sub_metering_1"),
#        legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
# 
# #4
# par(mfrow=c(2,2))
# # plot topleft
# with(df, plot(Date, Global_active_power, 
#                  xlab="", type="l", ylab="Global Active Power"))
# # plot topright
# with(df, plot(Date,Voltage, type="l"))    
# # plot bottomleft 
# with(df, plot(Date,Sub_metering_1, xlab="", type="l", ylab="Energy sub metering"))
# with(df, lines(Date,Sub_metering_2,col="red"))
# with(df, lines(Date,Sub_metering_3,col="blue"))
# legend("topright", cex=1, col=c("black", "red", "blue"),lwd=2,bty="n",
#                  y.intersp=0.8,legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
# # plot bottomright
# with(df, plot(Date, Global_reactive_power, type="l"))
# 
# 
# 
# dev.off()


# required.vars <- list(Date="character",
#                       Time="character",
#                       Global_active_power="numeric",
#                       Global_reactive_power="numeric",
#                       Voltage="numeric",
#                       Global_intensity="numeric",
#                       Sub_metering_1="numeric",
#                       Sub_metering_2="numeric",
#                       Sub_metering_3="numeric")

