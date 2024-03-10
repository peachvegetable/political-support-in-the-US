#### Preamble ####
# Purpose: Cleans the data that downloaded from 2020 Cooperative Election Study (CES)
# Author: Yihang Cai
# Date: 10 March 2023
# Contact: yihang.cai@mail.utoronto.ca

#### Workspace setup ####
library(tidyverse)
library(dplyr)

#### Clean data ####
# to make sure the column types are the correct types
ces2020 <-
  read_csv(
    "ces2020.csv",
    col_types =
      cols(
        "votereg" = col_integer(),
        "CC20_410" = col_integer(),
        "race" = col_integer(),
        "faminc_new" = col_integer()
      )
  )

# create new variables based on conditions, rather than numeric values the dataset is modified to better describe the information for better view
ces2020 <-
  ces2020 |>
  filter(votereg == 1,
         CC20_410 %in% c(1, 2)) |>
  mutate(
    voted_for = if_else(CC20_410 == 1, "Biden", "Trump"),
    voted_for = as_factor(voted_for),
    race = case_when(
      race == 1 ~ "White",
      race == 2 ~ "Black",
      race == 3 ~ "Hispanic",
      race == 4 ~ "Asian",
      race == 5 ~ "Native American",
      race == 6 ~ "Middle Eastern",
      race == 7 ~ "Two or more races",
      race == 8 ~ "Other"
    ),
    faminc_new = case_when(
      faminc_new == 1 ~ "Less than $10,000",
      faminc_new == 2 ~ "$10,000 - $19,999",
      faminc_new == 3 ~ "$20,000 - $29,999",
      faminc_new == 4 ~ "$30,000 - $39,999",
      faminc_new == 5 ~ "$40,000 - $49,999",
      faminc_new == 6 ~ "$50,000 - $59,999",
      faminc_new == 7 ~ "$60,000 - $69,999",
      faminc_new == 8 ~ "$70,000 - $79,999",
      faminc_new == 9 ~ "$80,000 - $89,999",
      faminc_new == 10 ~ "$100,000 - $119,999",
      faminc_new == 11 ~ "$120,000 - $149,999",
      faminc_new == 12 ~ "$150,000 - $199,999",
      faminc_new == 13 ~ "$200,000 - $249,999d",
      faminc_new == 14 ~ "$250,000 - $349,999",
      faminc_new == 15 ~ "$350,000 - $499,999",
      faminc_new == 16 ~ "$500,000 or more",
      faminc_new == 17 ~ "Prefer not to say"
    ),
    faminc_new = factor(
      faminc_new,
      levels = c(
        "Less than $10,000",
        "$10,000 - $19,999",
        "$20,000 - $29,999",
        "$30,000 - $39,999",
        "$40,000 - $49,999",
        "$50,000 - $59,999",
        "$60,000 - $69,999",
        "$70,000 - $79,999",
        "$80,000 - $89,999",
        "$100,000 - $119,999",
        "$120,000 - $149,999",
        "$150,000 - $199,999",
        "$200,000 - $249,999",
        "$250,000 - $349,999",
        "$350,000 - $499,999",
        "$500,000 or more",
        "Prefer not to say"
      )
    )
  ) |>
  rename(
    family_income = faminc_new
    )|>
  select(voted_for, race, family_income)

#### Save data ####
write_csv(ces2020, "data/analysis_data/analysis_data.csv")
