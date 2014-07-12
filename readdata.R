#Assignment 2

#convenience file to read in data to 
#avoid repeating file reading code

#Result: reads NEI & SCC files into global space

#location on the web of our zip file
source.web <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
source.local <- tail(unlist(strsplit(source.web,split="/")),n=1)

#new datafile name based on our filtering criteria
NEI.file <- "summarySCC_PM25.rds"
SCC.file <- "Source_Classification_Code.rds"

#download our file if we don't have it
if (!file.exists(source.local)) {
  download.file(source.web, source.local)
}
#unzip the files
unzip(source.local)

## This first line will likely take a few seconds. Be patient!
NEI <- readRDS(NEI.file)
SCC <- readRDS(SCC.file)

#Commmon variable setup code...
NEI$type <- as.factor(NEI$type)
NEI$year <- as.numeric(NEI$year)