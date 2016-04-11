install.packages("ggplot2")
require(ggplot2)

NEI <- readRDS("~/project2/summarySCC_PM25.rds")
SCC <- readRDS("~/project2/Source_Classification_Code.rds")


NEI$year <- factor(NEI$year, levels=c('1999', '2002', '2005', '2008'))

MD.onroad <- subset(NEI, fips == '24510' & type == 'ON-ROAD')
CA.onroad <- subset(NEI, fips == '06037' & type == 'ON-ROAD')

MD.DF <- aggregate(MD.onroad[, 'Emissions'], by=list(MD.onroad$year), sum)
colnames(MD.DF) <- c('year', 'Emissions')
MD.DF$City <- paste(rep('MD', 4))

CA.DF <- aggregate(CA.onroad[, 'Emissions'], by=list(CA.onroad$year), sum)
colnames(CA.DF) <- c('year', 'Emissions')
CA.DF$City <- paste(rep('CA', 4))

DF <- as.data.frame(rbind(MD.DF, CA.DF))


png("plot6.png", width=1040, height=480)
g <- ggplot(DF, aes(factor(year), Emissions))
g <- g + facet_grid(. ~ City) + geom_bar(stat="identity")  +
  xlab("year") +
  ylab(expression('Total PM'[2.5]*" Emissions")) +
  ggtitle('Total Emissions from motor vehicle (type=ON-ROAD) in Baltimore City, MD (fips = "24510") vs Los Angeles, CA (fips = "06037")  1999-2008')
print(g)
dev.off()