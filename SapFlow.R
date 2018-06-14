#Bewkes Project
os.flag <- 2
source("/Users/Nick/Documents/GitHub/bewkes_field/sapflux_process.r")
metA <- read.csv("/Volumes/data/data_repo/field_data/bewkes/sensor/decagon/met_air.csv")

#new column for time as a decimal
sapflowF$newcolumn <- NA
colnames(sapflowF) [colnames (sapflowF) == "newcolumn"] <- "time as decimal"
sapflowF$`time as decimal`= (sapflowF$hour / 24)

#new column for doy plus decimal of time
sapflowF$newcolumn <- NA
colnames(sapflowF) [colnames (sapflowF) == "newcolumn"] <- "doy by hour"
sapflowF$`doy by hour` = (sapflowF$doy + sapflowF$`time as decimal`)

#Creating a Plot of all Sensors
plot(sapflowF$`doy by hour`, sapflowF$sapflowF1, type = "l", xlab = "Day of Year", ylab = "Sap Flow in g/s", main = "Sap Flow Across All Shrubs", col = "red")
lines(sapflowF$`doy by hour`, sapflowF$sapflowF2, col = "blue")
lines(sapflowF$`doy by hour`, sapflowF$sapflowF3, col = "green")
lines(sapflowF$`doy by hour`, sapflowF$sapflowF4, col = "orange")
lines(sapflowF$`doy by hour`, sapflowF$sapflowF5, col = "black")

#Add a legend
legend("topleft", c("Sensor 1", "Sensor 2", "Sensor 3", "Sensor 4", "Sensor 5"), lty=1, col = c("red", "blue", "green", "orange", "black"), bty="n")
