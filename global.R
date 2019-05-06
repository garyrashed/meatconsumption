
library(RSQLite)

MeatInfo = "./Meats.sqlite"
db = dbConnect(SQLite(), MeatInfo)

countryCodes = dbGetQuery(db, "Select * from CC")
meatData = dbGetQuery(db, "Select * from MeatConsumption")

fullData = left_join(meatData, countryCodes, by = c("Country" = "ThreeCharCode")) %>% arrange(., CountryName)

# countryCodes <- read.csv("CountryCodes.csv", fileEncoding = "UTF-8-BOM", stringsAsFactors=FALSE)
# meatData <- read.csv("Meats2.csv", fileEncoding = "UTF-8-BOM", stringsAsFactors=FALSE)
# 
# fullData = left_join(meatData, countryCodes, by = c("LOCATION" = "ThreeDigitCode"))

