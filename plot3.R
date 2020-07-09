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

bltNEI <- NEI[NEI$fips=="24510",]

totalByYearAndType <- aggregate(Emissions~year+type,bltNEI,sum)

png("plot3.png", width=640, height=480)

g <- ggplot(totalByYearAndType, aes(factor(year), Emissions, fill = type))
g <- g + geom_bar(stat="identity") + facet_grid(.~type,scales="free",space="free")+ labs(x="year", y=expression("Total PM"[2.5]*" Emission (Tons)")) + 
  labs(title=expression("PM"[2.5]*" Emissions, Baltimore City 1999-2008 by Source Type"))+
  ggtitle('Total Emissions in Baltimore City, Maryland (fips == "24510") from 1999 to 2008')

print(g)

dev.off()