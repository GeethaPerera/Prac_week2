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

# question 2

temp_seperated_filtered_numeric <- temp_seperated_filtered %>%   
mutate(t_min = as.numeric(t_min))%>%  
mutate(t_max = as.numeric(t_max))
temp_difference <- mutate(temp_seperated_filtered_numeric, temp_difference = t_max-t_min)
view (temp_difference)
temp_difference_by_month <- group_by(temp_difference, Month)
view(temp_difference_by_month)

summary <- summarise (temp_difference_by_month, mean_temp_diff = mean(temp_difference))
