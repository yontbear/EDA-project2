setwd("Desktop/coursera/EDA project/exdata-data-NEI_data/")
library(ggplot2)
#read data NEI & SCC
NEI <- readRDS("summarySCC_PM25.rds")
str(NEI)
head(NEI)
SCC <- readRDS("Source_Classification_Code.rds")
head(SCC)

###############################QUESTION 4############################
#Across the United States, 
#how have emissions from coal combusction-related sources changed from 1999–2008?

str(SCC)
summary(SCC)
levels(SCC$EI.Sector)
levels(SCC$SCC.Level.Three)
#grepl key word "Coal" from SCC EI.Sector&SCC.Level.Two&SCC.Level.Three
coal1 <- SCC[grepl("Coal|Residential - Other",SCC$EI.Sector),]
nrow(coal1)
#103
grep("Coal",SCC$SCC.Level.Two)
#no result
coal2 <- SCC[grepl("Coal",SCC$SCC.Level.Three),]
nrow(coal2)
#172
#collect all scc number
coal <- rbind(coal1,coal2)
scc <- coal$SCC
#choose only unique scc number
good <- unique(scc)
length(good)
#197
NEI4 <- NEI[NEI$SCC %in% good, ]
head(NEI4)
nrow(NEI4)
tail(NEI4)
unique(NEI4$year)

nei4 <-  aggregate(Emissions~year,data=NEI4,FUN=sum)
nei4

#use base plot
plot(nei4, type = "n",  xlab = "year", ylab = "total emission",
     main = "Total PM2.5 Coal Combustion Emissions in the US")
lines(nei4)

#use ggplot
ggplot(nei4, aes(x = year, y = Emissions)) +
        geom_point(alpha=.3) +
        geom_smooth(alpha=.2, size=1) +
        ggtitle("Total PM2.5 Coal Combustion Emissions in the US")
dev.copy(png, file = "Coal Emission by year4.png")
dev.off()
