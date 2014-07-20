#Q5: How have emissions from motor vehicle sources 
#changed from 1999-2008 in Baltimore City?

#check if files are downloaded
if(length(dir(pattern=".*rds")) == 0){
  download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip", destfile="NEI_data.zip")
  unzip("NEI_data.zip", overwrite=TRUE)
}

#read data into NEI & SCC dataframes - may take a while!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

NEI$type <- as.factor(NEI$type)
NEI$year <- as.numeric(NEI$year)

library(ggplot2)

#Motor vehicle emissions: defined as either in the 'onroad' 
#category or contains 'veh' in the name 
vehicle.codes <- subset(SCC,
                        Data.Category=='Onroad' |                       
                          grepl("Veh",Short.Name,ignore.case=T),
                        select=SCC)$SCC
baltimore.vehicle.emissions <- subset(NEI, 
                                      fips=="24510" & SCC %in% vehicle.codes)

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