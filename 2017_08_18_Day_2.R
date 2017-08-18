surveys <- read.csv("/home/jon/my.work/Workshop/data/portal_data_joined.csv")

install.packages('tidyverse')
library("tidyverse")

select(surveys, plot_id, species_id, weight)

filter(surveys, year == 1995)

#Pipes => %>%
  
surveys_sml <- surveys %>% 
   filter(year == 1995) %>%
   select(plot_id, species_id, weight)
## Adding a column

surveys %>%
  mutate(weight_kg = weight / 1000, 
         weight_kg2 = weight_kg * 2) %>%
  tail

## Contain ony the species_id, column and a row column called 
#hind(foot_half containing values are are half the hindfoot length values. 
#In this hindfoot_half column, there are no NAs and all values are less than 30)

newdf <- surveys %>%
  filter(!is.na(hindfoot_length)) %>%
  mutate(hindfoot_half = hindfoot_length /2) %>% 
  filter(hindfoot_half < 30) %>%
  select(species_id, hindfoot_half)

nrow(newdf)

surveys %>%
  filter(!is.na(weight), sex == 'F' | sex == 'M')%>%
  group_by(sex, species_id)%>%
  summarize(mean_weight = mean(weight, na.rm = TRUE), 
            min_weight = min(weight))
#tally counts the total number of observations for the 
surveys %>% 
  group_by(sex) %>%
  tally
