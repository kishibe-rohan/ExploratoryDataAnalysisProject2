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

# Across the United States, how have emissions from coal combustion-related sources changed from 1999-2008?

coalEmissions <- grepl("coal",NEISSC$Short.Name,ignore.case = TRUE)
coalNEISSC <- NEISSC[coalEmissions,]

totalByYear <- aggregate(Emissions ~ year,coalNEISSC,sum)

png("plot4.png",width=640,height=480)

g <- ggplot(totalByYear,aes(factor(year),Emissions))
g <- g + geom_bar(stat="identity")+ xlab("year") +
  ylab(expression('Total PM'[2.5]*" Emissions")) +
  ggtitle('Total Emissions from coal sources from 1999 to 2008')

print(g)
dev.off()
