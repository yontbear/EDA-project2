#read data NEI & SCC
NEI <- readRDS("summarySCC_PM25.rds")
str(NEI)
head(NEI)
SCC <- readRDS("Source_Classification_Code.rds")
head(SCC)

##################################QUESTION 6##########################
#Compare emissions from motor vehicle sources in Baltimore City with emissions 
#from motor vehicle sources in Los Angeles County, California (fips == "06037").
#Which city has seen greater changes over time in motor vehicle emissions?

#subset baltimore data and LA data
bal1 <- NEI[NEI$fips =="24510",]
head(bal1)
LA1 <- NEI[NEI$fips == "06037",]
head(LA1)

#choose scc number related to motor vehicle
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

#choose from bal1 and LA1 which scc in motor vehicle related scc
bal2 <- bal1[bal1$SCC %in% s,]
nrow(bal2)
LA2 <- LA1[LA1$SCC %in% s,]
nrow(LA2)

#aggregate by year
bal3 <- aggregate(Emissions~year,data = bal2, FUN = sum)
LA3 <- aggregate(Emissions~year, data = LA2, FUN = sum)
bal3
LA3
all <- rbind(bal3, LA3)
#create city name in order to distinguish baltimore and LA'S emission 
city <- c(rep("baltimore",4),rep("LA",4))
city
final <- data.frame(all, city =city)

#PLOT
plot(final$year,final$Emissions, type = "n", xlab = "year", ylab = "Emission" , main = "Motor Related Emission from Baltimore and Los Angles")
lines(bal3, col = "blue")
lines(LA3, col =  "orange")
legend("center",c("Baltimore", "Los Angeles"), lty = 1,col = c("blue", "orange"))

dev.copy(png, file = "Motor Vehicles Emissions  from two cities by year6.png")
dev.off()





