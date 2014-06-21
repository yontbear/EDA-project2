setwd("Desktop/coursera/EDA project/exdata-data-NEI_data/")

#read data NEI & SCC
NEI <- readRDS("summarySCC_PM25.rds")
str(NEI)
head(NEI)
SCC <- readRDS("Source_Classification_Code.rds")
head(SCC)

#################################QUESTION 3############################

baltimore <- NEI[NEI$fips =="24510",]
head(baltimore)

#subset data leaving baltimore's emission, type and year
X3 <- baltimore$Emissions
Y3 <- as.factor(baltimore$type)
Z3 <- baltimore$year
NEI3 <- data.frame(Emissions = X3, type = Y3, year = Z3)
# 
nei3 <- aggregate(NEI3$Emissions,list(type = NEI3$type, year = NEI3$year), sum)
head(nei3)
names(nei3) <- c("type", "year", "Emissions")

#Plot3 and copy it to a PNG file
library(ggplot2)
ggplot(nei3, aes(x=year, y=Emissions, colour=type)) +
        geom_point(alpha=.3) +
        geom_smooth(alpha=.2, size=1, method="loess") +
        ggtitle("Total Emissions by Type in Baltimore City")
dev.copy(png, file = "totalEmission by year3.png")
dev.off()