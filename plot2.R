#Q2: Have total emissions from PM2.5 decreased in
#Baltimore City, Maryland from 1999 to 2008? 

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

baltimore.emissions.per.year <- aggregate(Emissions ~ year, 
                                          subset(NEI, fips=="24510"), 
                                          sum)

png(filename="plot2.png", width=480, height=480)

with(baltimore.emissions.per.year,
     plot(year, Emissions, 
          type="l", 
          xlab="Year", ylab="PM2.5 (tons)", 
          main="Tons of PM2.5 Generated Per Year in Baltimore City, MD")
)

dev.off()