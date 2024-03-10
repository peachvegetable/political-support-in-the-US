#### Preamble ####
# Purpose: Downloads and saves the data from 2020 Cooperative Election Study (CES)
# Author: Yihang Cai
# Date: 10 March 2023
# Contact: yihang.cai@mail.utoronto.ca


#### Workspace setup ####
library(dataverse)
library(readr)
library(tidyverse)

#### Download data ####
# select the variables we want (i.e. race and family income)
# the code is adapted from Telling Stories with Data by Rohan Alxander
ces2020 <-
  get_dataframe_by_name(
    filename = "CES20_Common_OUTPUT_vv.csv",
    dataset = "10.7910/DVN/E9N6PH",
    server = "dataverse.harvard.edu",
    .f = read_csv
  )|>
  select(votereg, CC20_410, race, faminc_new)

#### Save data ####
# save the selected data to the data folder
write_csv(ces2020, "data/raw_data/raw_data.csv") 



         
