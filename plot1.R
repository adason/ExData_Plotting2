# Have total emissions from PM2.5 decreased in the United States from 1999 to 2008?
# Using the base plotting system, make a plot showing the total PM2.5 emission 
# from all sources for each of the years 1999, 2002, 2005, and 2008.

# First, read the dataset given by the assignment
NEI <- readRDS("data/summarySCC_PM25.rds")
SCC <- readRDS("data/Source_Classification_Code.rds")

# Convert to data.table
library(data.table)
NEI <- data.table(NEI)
SCC <- data.table(SCC)

# Take sum of total emission, group by year
emission_year <- NEI[, sum(Emissions), by = year]
setnames(emission_year, "V1", "totalem")
with(emission_year, 
     plot(year, totalem, type = "b", col = "blue",
          main = "Emissions", xlab = "Year", 
          ylab = "Totla Emission in 3 Years (ton)")
     )

# Should try to make the plot preetier...