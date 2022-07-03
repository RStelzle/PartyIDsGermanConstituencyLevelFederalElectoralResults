library(tidyverse)

## Place the Manifesto Project Dataset (version 2021a),
## the Partyfacts External Parties dataset and
## 01_bundestag_elections.tab -obtained from running Umit's code
## with my modifications- in the same directory as this script.
## Then run:


pf_ext <- read_csv("partyfacts-external-parties.csv")
mp_raw <- read_csv("MPDataset_MPDS2021a.csv")
ger_const_mod <- read_delim("01_bundestag_elections.tab")


pf_mp_link <- 
pf_ext %>% 
  filter(
    country == "DEU",
    dataset_key == "manifesto"
  ) %>% 
  select(mp_party_id = dataset_party_id, partyfacts_id)



mp_germany <- 
mp_raw %>% 
  filter(countryname == "Germany") %>% 
  select(edate, mp_party_id = party, rile) %>% 
  mutate(edate = lubridate::year(lubridate::dmy(edate))) %>% 
  mutate(mp_party_id = as.character(mp_party_id)) %>% 
  left_join(
    pf_mp_link,
    by = c("mp_party_id" = "mp_party_id")
  )


# Final linked up dataset:
ger_const_mod %>% 
  mutate(partyfacts_id = case_when(
    # Comined partyfacts ID for CDU & CSU.
    partyfacts_id == 1375 ~ 211,
    partyfacts_id == 1731 ~ 211,
    # Manifesto Project curiously has a combined Manifesto for Greens & Greens/Alliance 90 in 1990
    partyfacts_id == 10 & election == 1990 ~ 865,
    TRUE ~ partyfacts_id
  )) %>% 
  left_join(
    mp_germany,
    by = c("partyfacts_id" = "partyfacts_id", "election" = "edate")
  )



