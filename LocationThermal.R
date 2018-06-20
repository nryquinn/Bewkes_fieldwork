#Create Table for Known Flight Information
RGBFlight <- read.table("//Users/Nick/Desktop/bewkes_flight_2.txt", sep = ",")

#Create a Column for TimeID
RGBFlight$V8 <- seq(1, dim(RGBFlight) [1])

#Rename Columns
colnames(RGBFlight) [colnames (RGBFlight) == "V8"] <- "TimeID"
colnames(RGBFlight) [colnames (RGBFlight) == "V1"] <- "PhotoID"
colnames(RGBFlight) [colnames (RGBFlight) == "V2"] <- "x/Longitude"
colnames(RGBFlight) [colnames (RGBFlight) == "V3"] <- "y/Lattitude"
colnames(RGBFlight) [colnames (RGBFlight) == "V4"] <- "z/Altitude"
colnames(RGBFlight) [colnames (RGBFlight) == "V5"] <- "Yaw"
colnames(RGBFlight) [colnames (RGBFlight) == "V6"] <- "Pitch"
colnames(RGBFlight) [colnames (RGBFlight) == "V7"] <- "Roll"

#Clean Up Extra Columns
RGBFlight$V9 <- NULL
RGBFlight$V10 <- NULL
RGBFlight$V11 <- NULL
RGBFlight$V12 <- NULL
RGBFlight$V13 <- NULL
RGBFlight$V14 <- NULL
RGBFlight$V15 <- NULL
RGBFlight$V16 <- NULL
RGBFlight$V17 <- NULL
RGBFlight$V18 <- NULL
RGBFlight$V19 <- NULL
RGBFlight$V20 <- NULL
RGBFlight$V21 <- NULL

#Create Table for Thermal Data
list.files("/Volumes/data/data_repo/field_data/bewkes/Drone/Thermal Imagery/Imagery/Subset_06_20")
ThermalFlight <-list.files("/Volumes/data/data_repo/field_data/bewkes/Drone/Thermal Imagery/Imagery/Subset_06_20")
ThermalData <- data.frame(ThermalFlight)

#Fix Thermal Data
ThermalData$Temp.name <- gsub("\\0620_Thermal _", "",ThermalData$ThermalFlight)
ThermalData$Temp.name2 <-gsub(".JPG", "", ThermalData$Temp.name)
ThermalData$Temp.name3 <- as.numeric(gsub("\\D", "", ThermalData$Temp.name2))
ThermalData <- ThermalData[order(ThermalData$Temp.name3), ]

#Create Time ID for Thermal Camera in increments of 0.5
ThermalData$TimeID <- seq(1,157 [1], by = 0.5)

#Delete Unneccessary RGB Images
RGBFlight <- RGBFlight[-c(158:267)]