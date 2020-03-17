library(tidyverse)
bom_data <- read_csv("data/BOM_data.csv")
bom_stations <- read_csv("data/BOM_stations.csv")
bom_data
bom_stations
temp_seperated <- separate(bom_data, Temp_min_max, into = c("t_min", "t_max"), sep="/")
view (temp_seperated)
temp_rainfall <- select(temp_seperated,Station_number,t_min, t_max, Rainfall)
view(temp_rainfall)
