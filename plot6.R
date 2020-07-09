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

# Compare emissions from motor vehicle sources in Baltimore City with emissions from motor 
# vehicle sources in Los Angeles County, California (fips == "06037"). 
# Which city has seen greater changes over time in motor vehicle emissions?



subsetNEI <- NEI[(NEI$fips=="24510"|NEI$fips=="06037") & NEI$type=="ON-ROAD",  ]

totalByYearAndFips <- aggregate(Emissions ~ year + fips, subsetNEI, sum)
totalByYearAndFips$fips[totalByYearAndFips$fips=="24510"] <- "Baltimore, MD"
totalByYearAndFips$fips[totalByYearAndFips$fips=="06037"] <- "Los Angeles, CA"

png("plot6.png", width=1040, height=480)
g <- ggplot(totalByYearAndFips, aes(factor(year), Emissions))
g <- g + facet_grid(. ~ fips)
g <- g + geom_bar(aes(fill=year),stat="identity")  +
  xlab("year") +
  ylab(expression('Total PM'[2.5]*" Emissions")) +
  ggtitle('Total Emissions from motor vehicle (type=ON-ROAD) in Baltimore City, MD (fips = "24510") vs Los Angeles, CA (fips = "06037")  1999-2008')

print(g)
dev.off()

