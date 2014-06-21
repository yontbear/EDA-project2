setwd("Desktop/coursera/EDA project/exdata-data-NEI_data/")

#read data NEI & SCC
NEI <- readRDS("summarySCC_PM25.rds")
str(NEI)
head(NEI)
SCC <- readRDS("Source_Classification_Code.rds")
head(SCC)

#################################QUESTION 2############################
#subset only baltimore data, leaving emission and year
baltimore <- NEI[NEI$fips =="24510",]
head(baltimore)

X2 <- baltimore$Emissions
Y2 <- baltimore$year
NEI2 <- data.frame(Emissions = X2, year = Y2)

totalEmission2 = aggregate(Emissions~year,data=NEI2,FUN=sum)
totalEmission2


#PLOT2 and Copy my plot to a PNG file
plot(totalEmission2, type = "n",  xlab = "year", ylab = "total emission",
     main = "Baltimore PM2.5 Emissions")
lines(totalEmission2)
dev.copy(png, file = "totalEmission by year2.png")
dev.off()