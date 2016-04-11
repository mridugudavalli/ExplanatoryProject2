install.packages("ggplot2")
require(ggplot2)
NEI <- readRDS("~/project2/summarySCC_PM25.rds")
SCC <- readRDS("~/project2/Source_Classification_Code.rds")

NEI_sampling <- NEI[sample(nrow(NEI), size=5000, replace=F), ]

MD <- subset(NEI, fips == 24510)
MD$year <- factor(MD$year, levels=c('1999', '2002', '2005', '2008'))

png(filename='~/project2/plot3.png', width=800, height=500, units='px')


ggplot(data=MD, aes(x=year, y=log(Emissions))) + facet_grid(. ~ type) + guides(fill=F) +
  geom_boxplot(aes(fill=type)) + stat_boxplot(geom ='errorbar') +
  ylab(expression(paste('Log', ' of PM'[2.5], ' Emissions'))) + xlab('Year') + 
  ggtitle('Emissions per Type in Baltimore City, Maryland') +
  geom_jitter(alpha=0.10)

dev.off()