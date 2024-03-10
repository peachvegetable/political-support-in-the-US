#### Preamble ####
# Purpose: Models... [...UPDATE THIS...]
# Author: Rohan Alexander [...UPDATE THIS...]
# Date: 11 February 2023 [...UPDATE THIS...]
# Contact: rohan.alexander@utoronto.ca [...UPDATE THIS...]
# License: MIT
# Pre-requisites: [...UPDATE THIS...]
# Any other information needed? [...UPDATE THIS...]


#### Workspace setup ####
library(tidyverse)
library(rstanarm)
library(modelsummary)

#### Read data ####
analysis_data <- read_csv("data/analysis_data/analysis_data.csv")

### Model data ####
analysis_data$voted_for <- factor(analysis_data$voted_for, levels = c("Biden", "Trump"))

ces2020_reduced <- 
  analysis_data |> 
  slice_sample(n = 1000)

first_model <-
  stan_glm(
    formula = voted_for ~ race + family_income,
    data = ces2020_reduced,
    family = binomial(link = 'logit'),
    prior = normal(location = 0, scale = 2.5, autoscale = TRUE),
    prior_intercept = normal(location = 0, scale = 2.5, autoscale = TRUE),
    seed = 853
  )


#### Save model ####
saveRDS(
  first_model,
  file = "models/first_model.rds"
)