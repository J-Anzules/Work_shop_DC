surveys <- read.csv("/home/jon/my.work/Workshop/data/portal_data_joined.csv")

install.packages('tidyverse')
library("tidyverse")

select(surveys, plot_id, species_id, weight)

filter(surveys, year == 1995)

#Pipes => %>%
  
surveys_sml <- surveys %>% 
   filter(year == 1995) %>%
   select(plot_id, species_id, weight)
