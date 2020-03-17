library(tidyverse)
bom_data <- read_csv("data/BOM_data.csv")
bom_stations <- read_csv("data/BOM_stations.csv")
bom_data
bom_stations
# question 1
temp_seperated <- separate(bom_data, Temp_min_max, into = c("t_min", "t_max"), sep="/")
view (temp_seperated)
temp_seperated_filtered <- filter(temp_seperated, Rainfall!="-",t_min!="-",t_max!="-")
view (temp_seperated_filtered)
temp_seperated_filtered %>% 
  group_by(Station_number)%>%
  summarise(num_rows = n ())

