#Q3: Of the four types of sources indicated by the type 
#(point, nonpoint, onroad, nonroad) variable, 
#which of these four sources have seen decreases in emissions 
#from 1999-2008 for Baltimore City? 
#Which have seen increases in emissions from 1999-2008?

#read data into NEI & SCC dataframes - may take a while!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
library(ggplot2)

NEI$type <- as.factor(NEI$type)
NEI$year <- as.numeric(NEI$year)

baltimore.emissions.per.year <- aggregate(Emissions ~ year+type,
                                          subset(NEI, fips=="24510"), 
                                          sum)

png(filename="plot3.png", width=480, height=480)

ggplot(data=baltimore.emissions.per.year, 
       aes(x=year, y=Emissions, group=type, colour=type)) +
  geom_line() +
  xlab("Year") +
  ylab("PM2.5 (tons)") +
  ggtitle("PM2.5 vs. Year by Source Type")

dev.off()