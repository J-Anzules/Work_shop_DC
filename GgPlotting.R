library(tidyverse)

common <- read.csv("dataOutPut/surveys_complete.csv")

ggplot(common, aes(x = weight, y = hindfoot_length)) + 
  geom_point(alpha = 0.2, aes(color = species_id)) #transparancy
ggplot(common, aes(y = weight, x = species_id)) + 
  geom_point(alpha = 0.2, aes(color = plot_type))

ggplot(common, aes(y = weight, x = species_id)) + 
  facet_grid(sex ~ .)+
  geom_boxplot(alpha = 0.2, aes(color = plot_type))

## Challenge

## Use what you just learned to create a scatter plot of weight over species_id
## with the plot types showing in different colors. Is this a good way to show
## this type of data?

yearly.counts <- common %>%
  group_by(year, species_id) %>%
  tally()
ggplot(data = yearly.counts, aes(x = year, y = n, group = species_id,
                                 color = species_id))+
  geom_line()+
  facet_wrap(~ species_id )

yearly_sex_counts <- common %>%
  group_by(year, species_id, sex) %>%
  tally()

ggplot(data = yearly_sex_counts, aes(x = year, y = n, color = sex))+
  geom_line()+
  facet_wrap(~ species_id)

##Challenge

## Use what you just learned to create a plot that
## depicts how the average weight of each species
## changes through the years.

average <- common%>% 
  group_by(species_id, year) %>%
  mutate(avg = mean(weight))

ggplot(data = average, aes(x=year, y = avg, color = species_id))+
  geom_line()+
  facet_wrap(~ species_id)+
  theme(axis.text.x = element_text(angle = 70), legend.position = 'none')

ggsave("my_plot.png", )
