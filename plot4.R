#Q4: Across the United States, how have emissions 
#from coal combustion-related sources changed from 1999-2008?

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

coal.emissions.codes <- SCC[grepl("coal", SCC$Short.Name, ignore.case=T), ]

coal.emissions.per.year <- aggregate(Emissions ~ year, 
                                     subset(NEI, SCC %in% coal.emissions.codes$SCC), 
                                     sum)

png(filename="plot4.png", width=480, height=480)

ggplot(data=coal.emissions.per.year, 
       aes(x=year, y=Emissions)) +
  geom_line() +
  xlab("Year") +
  ylab("PM2.5 (tons)") +
  ggtitle("PM2.5 from Coal-Related Sources vs. Year")

dev.off()