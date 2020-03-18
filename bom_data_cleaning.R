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

summary_temp_difference_by_month <- summarise (temp_difference_by_month, mean_temp_diff = mean(temp_difference))
view (summary_temp_difference_by_month)

arrange(summary_temp_difference_by_month, mean_temp_diff)

# The month that showed the lowest average temperature difference is June. 

# Question 3

bom_data
bom_stations

# the station data is not in a tidy format 
# as stations are listed in columns and the information on each station
# are listed in rows


bom_stations_long <-gather(bom_stations,key=Station_number,value="value",2:21)
bom_stations_long

# this data is tidy

bom_stations_long_spread <- spread(bom_stations_long, key = info, value = "value")
bom_stations_long_spread 
bom_stations_new <- mutate(bom_stations_long_spread,Station_number=as.numeric(Station_number))
bom_stations_new

bom_final <- full_join(temp_seperated,bom_stations_new)
bom_final
bom_final_filtered <- filter(bom_final, Rainfall!="-",t_min!="-",t_max!="-")
bom_final_filtered
bom_final_filtered_numeric <- bom_final_filtered %>%   
  mutate(t_min = as.numeric(t_min))%>%  
  mutate(t_max = as.numeric(t_max))
bom_final_filtered_numeric
bom_final_temp_difference <- mutate(bom_final_filtered_numeric, temp_difference = t_max-t_min)
bom_final_temp_difference
view(bom_final_temp_difference)
temp_difference_by_state <- group_by(bom_final_temp_difference, state)
view(temp_difference_by_state)

summary_temp_difference_by_state <- summarise (temp_difference_by_state, mean_temp_diff = mean(temp_difference))
summary_temp_difference_by_state

arrange(summary_temp_difference_by_state, mean_temp_diff)

# The state that showed the lowest average temperature difference is Queensland.

# Question 4

view(bom_final_filtered_numeric)
bom_final_numeric <-mutate (bom_final_filtered_numeric,Solar_exposure = as.numeric(Solar_exposure),lon=as.numeric(lon))
bom_final_numeric
bom_final_numeric_filtered <- filter(bom_final_numeric, Solar_exposure!="NA")
bom_final_numeric_filtered
bom_final_numeric_filtered_by_longitude <- group_by(bom_final_numeric_filtered, lon)
bom_final_numeric_filtered_by_longitude
summary_solar_exposure_by_longitude <- summarise (bom_final_numeric_filtered_by_longitude, mean_solar_exposure = mean(Solar_exposure))
summary_solar_exposure_by_longitude
arrange(summary_solar_exposure_by_longitude, lon)

# the eastmost (highest longitude) weather station have a higher average solar exposure

#another way to find the same answer

head(summary_solar_exposure_by_longitude,1)
tail(summary_solar_exposure_by_longitude,1)



