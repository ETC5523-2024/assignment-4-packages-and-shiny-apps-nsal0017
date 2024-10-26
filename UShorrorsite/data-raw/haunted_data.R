library(janitor)
library(tidyverse)


url <- 'https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2023/2023-10-10/haunted_places.csv'

haunted_data <- read_csv(url)

# Saving the prepared data set
usethis::use_data(haunted_data, overwrite=TRUE)




