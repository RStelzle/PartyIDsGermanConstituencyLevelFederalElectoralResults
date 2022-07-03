library(tidyverse)

## Place Parlgov's "view_cabinet.csv" dataset,
## the Partyfacts External Parties dataset and
## 01_bundestag_elections.tab -obtained from running Umit's code
## with my modifications- in the same directory as this script.
## Then run:

pf_ext <- read_csv("partyfacts-external-parties.csv")
pg_cabinets <- read_csv("view_cabinet.csv")
ger_const_mod <- read_delim("01_bundestag_elections.tab")



ger_const_mod <- 
ger_const_mod %>% 
  mutate(partyfacts_id = case_when(
    # Comined partyfacts ID for CDU & CSU.
    partyfacts_id == 1375 ~ 211,
    partyfacts_id == 1731 ~ 211,
    TRUE ~ partyfacts_id
  ))


pf_parlgov <- 
pf_ext %>% 
  filter(country == "DEU", dataset_key == "parlgov") %>% 
  select(name_short, dataset_party_id, partyfacts_id)





pg_electiondates <- 
pg_cabinets %>% 
  filter(country_name_short == "DEU") %>% 
  select(election_date) %>% 
  filter(lubridate::year(election_date) >= 1949) %>% 
  distinct() %>% 
  mutate(next_election = lead(election_date))


pg_cab_link <- 
pg_cabinets %>% 
  filter(country_name_short == "DEU", lubridate::year(election_date) >= 1949) %>% 
  select(election_date, start_date, cabinet_name, cabinet_party, party_name, party_id) %>% 
  filter(cabinet_party == 1) %>% 
  select(-cabinet_party) %>%
  group_by(election_date) %>% 
  filter(start_date == max(start_date)) %>%  # last cabinet in election term
  ungroup() %>% 
  left_join(
    pg_electiondates,
    by = "election_date"
  ) %>% 
  mutate(party_id = as.character(party_id)) %>%
  left_join(
    pf_parlgov,
    by = c("party_id" = "dataset_party_id")
  ) %>% 
  select(
    next_election, partyfacts_id 
  ) %>% 
  mutate(incumbent = TRUE) %>% 
  mutate(next_election = lubridate::year(next_election))
  
 

# Final linked up dataset:
ger_const_mod %>% 
  left_join(
    pg_cab_link,
    by = c("election" = "next_election", "partyfacts_id")
  ) %>% 
  mutate(incumbent = case_when(
    is.na(incumbent) ~ FALSE,
    TRUE ~ TRUE
  ))

