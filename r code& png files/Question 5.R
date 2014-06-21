setwd("Desktop/coursera/EDA project/exdata-data-NEI_data/")

#read data NEI & SCC
NEI <- readRDS("summarySCC_PM25.rds")
str(NEI)
head(NEI)
SCC <- readRDS("Source_Classification_Code.rds")
head(SCC)

##################################QUESTION 5##########################
str(SCC)
summary(SCC)
levels(SCC$EI.Sector)
levels(SCC$SCC.Level.Two)
#search scc number related to motor vehicle
vehicle1 <- SCC[grepl("Vehicles",SCC$EI.Sector),]
nrow(vehicle1)
vehicle2 <- SCC[grepl("Vehicles",SCC$SCC.Level.Two),]
nrow(vehicle2)
vehicle3 <- SCC[grepl("Vehicles",SCC$SCC.Level.Three),]
nrow(vehicle3)
#put all together , extract only unique scc number
v <-rbind(vehicle1,vehicle2,vehicle3)
scc <- v$SCC
head(scc)
s <- unique(scc)
length(s)
#choose from NEI which scc in motor vehicle related scc
NEI5 <- NEI[NEI$SCC %in% s, ]
head(NEI5)
nrow(NEI5)
unique(NEI4$year)
#aggregate data by year, calculate sum emissions
nei5 <-  aggregate(Emissions~year,data=NEI5,FUN=sum)
nei5
#plot and save
ggplot(nei5, aes(x = year, y = Emissions)) +
        geom_point(alpha=.3) +
        geom_smooth(alpha=.2, size=1) +
        ggtitle("Total PM2.5 Motor Vehicles Emissions in the US")
dev.copy(png, file = "Motor Vehicles Emissions by year5.png")
dev.off()
