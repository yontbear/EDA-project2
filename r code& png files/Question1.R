setwd("Desktop/coursera/EDA project/exdata-data-NEI_data/")

#read data NEI & SCC
NEI <- readRDS("summarySCC_PM25.rds")
str(NEI)
head(NEI)
SCC <- readRDS("Source_Classification_Code.rds")
head(SCC)

##################################QUESTION 1##########################
#subset NEI, leaving only emission and year
X <- NEI$Emissions
Y <- NEI$year
NEI1 <- data.frame(Emissions = X, year = Y)

#split by year, calculate sum emission
totalEmission = aggregate(Emissions~year,data=NEI1,FUN=sum)
totalEmission

# PLOT1 and Copy my plot to a PNG file
plot(totalEmission,type = "n", xlab = "year", ylab = "total emission", main = "PM2.5 Emissions")
lines(totalEmission)

dev.copy(png, file = "totalEmission by year.png")
dev.off()






