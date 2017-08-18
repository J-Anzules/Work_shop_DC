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

#Challenge 2;

## Challenge

## 1. How many individuals were caught in each plot_type surveyed?
colnames(surveys)
surveys %>%
  group_by(plot_id) %>%
  tally

## 2. Use group_by() and summarize() to find the mean, min, and 
## max hindfoot length for each species (using species_id).

mmm <- surveys %>%
  group_by(species) %>%
  filter(!is.na(hindfoot_length))%>%
  summarize(mean = mean(hindfoot_length),
            mininum = min(hindfoot_length),
            max = max(hindfoot_length))
## 3. What was the heaviest animal measured in each year? Return
## the columns year, genus, species_id, and weight.

surveys %>%
  group_by(year) %>%
  filter(!is.na(weight)) %>%
  filter(weight == max(weight))%>%
  select(year, genus, species_id, weight)
  

try <- surveys %>%
  group_by(year) %>%
  filter(weight == max(weight, na.rm = TRUE))%>%
  select(year, genus, species_id, weight) 

filter(surveys, !is.na(weight), weight == max(weight))

## 4. You saw above how to count the number of individuals of each sex using a
## combination of group_by() and tally(). How could you get the same result using
## group_by() and summarize()? Hint: see ?n.

surveys_complete <- surveys%>%
  filter(species_id != "") %>%
  filter(!is.na(weight))%>%
  filter(!is.na(hindfoot_length))%>%
  filter(sex != "")

surveys_complete <- surveys %>%
  filter(species_id != "",
         !is.na(weight),
         !is.na(hindfoot_length),
         sex != "")

species_count <- surveys_complete %>%
  group_by(species_id) %>%
  tally %>%
  filter(n>=50)

surveys_common_species <- surveys_complete%>%
  filter(species_id %in% species_count$species_id)

write.csv(surveys_common_species, file = "dataOutPut/surveys_complete.csv")

##### END PART SOMETHING 
##### PLOTTING

