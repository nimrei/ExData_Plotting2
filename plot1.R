#Q1: Have total emissions from PM2.5 decreased in the 
#United States from 1999 to 2008?

#read data into NEI & SCC dataframes - may take a while!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

NEI$type <- as.factor(NEI$type)
NEI$year <- as.numeric(NEI$year)

#1
total.emissions.per.year <- aggregate(Emissions ~ year, 
                                      NEI, 
                                      sum)

png(filename="plot1.png", width=480, height=480)

with(total.emissions.per.year,
     plot(year, Emissions/1e6, 
          type="l", 
          xlab="Year", ylab="PM2.5 (millions of tons)", 
          main="Tons of PM2.5 Generated Per Year")
     )

dev.off()