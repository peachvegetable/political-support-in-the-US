#### Preamble ####
# Purpose: Simulates a dataset that whether a person supports Biden or Trump depends on their family income level and race
# Author: Yihang Cai
# Date: 10 March 2023
# Contact: yihang.cai@mail.utoronto.ca


#### Workspace setup ####
library(tidyverse)


#### Simulate data ####
# set the seed for reproduction
set.seed(777)
# number of observations is 1000
num_obs <- 1000
# create a data set with 5 family income levels and 3 ethnicity for race
us_political_preferences <- tibble(
  family_income = sample(0:4, size = num_obs, replace = TRUE),
  race = sample(0:2, size = num_obs, replace = TRUE),
  support_prob = ((family_income + race) / 5),
) |>
  mutate(
    supports_biden = if_else(runif(n = num_obs) < support_prob, "yes", "no"),
    family_income = case_when(
      family_income == 0 ~ "< $10,000",
      family_income == 1 ~ "$10,000 - $99,999",
      family_income == 2 ~ "$100,000 - $199,999",
      family_income == 3 ~ "$200,000 - $299,999",
      family_income == 4 ~ "> $ $300,000"
    ),
    race = case_when(
      race == 0 ~ "White",
      race == 1 ~ "Black",
      race == 2 ~ "Other",
    )
  ) |>
  select(-support_prob, supports_biden, race, family_income) # remove support_prob from the dataset

us_political_preferences

