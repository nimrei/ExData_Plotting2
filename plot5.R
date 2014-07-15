#Q5: How have emissions from motor vehicle sources 
#changed from 1999-2008 in Baltimore City?

#read data into NEI & SCC dataframes - may take a while!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

NEI$type <- as.factor(NEI$type)
NEI$year <- as.numeric(NEI$year)

library(ggplot2)

vehicle.codes <- SCC[grepl("Vehicle", SCC$Short.Name, ignore.case=T),]$SCC
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