install.packages("ggplot2")
require(ggplot2)

NEI <- readRDS("~/project2/summarySCC_PM25.rds")
SCC <- readRDS("~/project2/Source_Classification_Code.rds")
NEI$year <- factor(NEI$year, levels=c('1999', '2002', '2005', '2008'))

MD.onroad <- subset(NEI, fips == 24510 & type == 'ON-ROAD')

MD.df <- aggregate(MD.onroad[, 'Emissions'], by=list(MD.onroad$year), sum)
colnames(MD.df) <- c('year', 'Emissions')

png("plot5.png", width=840, height=480)
g <- ggplot(MD.df, aes(factor(year), Emissions))
g <- g + geom_bar(stat="identity") +
  xlab("year") +
  ylab(expression('Total PM'[2.5]*" Emissions")) +
  ggtitle('Total Emissions from motor vehicle (type = ON-ROAD) in Baltimore City, Maryland (fips = "24510") from 1999 to 2008')
print(g)
dev.off()