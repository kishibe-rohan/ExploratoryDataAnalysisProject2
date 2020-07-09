#loading required data
library(ggplot2)

if(!exists("NEI"))
{
  NEI <- readRDS("summarySCC_PM25.rds")     #assumed to be in same dir
}

if(!exists("SCC"))
{
  SCC <- readRDS("Source_Classification_Code.rds")     #assumed to be in same dir
}

if(!exists("NEISSC"))
{
  NEISSC <- merge(NEI,SCC,by="SCC")
}

# How have emissions from motor vehicle sources changed from 1999-2008 in Baltimore City?

bltMotorNEI <- NEI[NEI$fips=="24510" & NEI$type=="ON-ROAD",]

totalByYear <- aggregate(Emissions~year,bltMotorNEI,sum)

png("plot5.png",width = 840,height = 640)


g <- ggplot(totalByYear,aes(factor(year),Emissions))
g <- g + geom_bar(stat="identity") + xlab("year") +  ylab(expression('Total PM'[2.5]*" Emissions")) +
  ggtitle('Total Emissions from motor vehicle (type = ON-ROAD) in Baltimore City, Maryland (fips = "24510") from 1999 to 2008')

print(g)

dev.off()


