# Party ID Links for "German Bundestag Election Results at Constituency Level" data

This dataset provides party IDs to be able to link Resul Umit's "German Bundestag Election Results at Constituency Level" ([10.7910/DVN/S1M6SA](https://doi.org/10.7910/DVN/S1M6SA)) data to other datasets. Party IDs from PartyFacts (Döring and Regel 2019; [partyfacts.org](https://partyfacts.org)) and [Wikidata](https://www.wikidata.org) are provided.

If you find any errors in the assignment of party IDs please feel encouraged to reach out: `robert.stelzle[at]yahoo.com`.

In order to use the data, just place `alt_df_parties.rds` in the same directory as the files provided by Umit and add 

```
df_parties <- readRDS("alt_df_parties.rds")
```

in line 31 of Umit's `02_compile_code.R`. The code should subsequently look like this:

```
[...]
# import secondary data ---------------------------------------------------

load("03_compile_names.RData")
df_parties <- readRDS("alt_df_parties.rds")

# 1949 --------------------------------------------------------------------
[...]
```

Executing `02_compile_code.R` should now compile the constituency level data like previously, but adding two columns: `partyfacts_id` and `wikidata_id` providing the IDs.

## Coding Decisions

- The PartyFacts ID for "other" parties (1895) is only used for those parties explicitly marked as `"_other"` in Umit's data. For all further parties for which no PartyFacts ID is available `partyfacts_id` is set to missing.

- For the *Bündnis 90/Grüne – BürgerInnenbewegungen (B90/Gr)* -actually an electoral coalition of *Demokratie Jetzt*, the *East German Greens*, the *Initiative Frieden und Menschenrechte*, the *Vereinigte Linke*,  *Neues Forum* and the *Unabhängiger Frauenverband*- the Wikidata ID for *[Alliance 90](https://de.wikipedia.org/wiki/B%C3%BCndnis_90)* (Q446007) is used, as Wikidata does not have an ID specific to the electoral alliance. PartyFacts does provide an ID specific to this electoral alliance (865).
- For the West German Greens the Wikidata and PartyFacts ID for just *the Greens* (Wikidata: Q18761823; PartyFacts: 10) is used until the 1990 election. From the 1994 election onward following the merger of *the Greens* and *Alliance 90* the IDs specific to *Alliance 90/The Greens* (Wikidata: Q49766; PartyFacts: 1816) is used.
- For the various groups running under the "KPD" label over time different IDs are used:
    - The IDs of the original *KPD* (Wikidata: Q153401; PartyFacts: 1135) are used in the 1949 and 1953 elections, before the party was banned in 1956.
    - For 1976 and 1983 respectively the Wikidata IDs (1976: Q1752945. 1983: Q324107) of the party linked in the German Wikipedia entries of the respective election is used. Here, no PartyFacts ID is available.
    - For the 1990, 1994 and 2002 election, again the Wikidata ID (Q324107) of the party linked in the German Wikipedia entries of the elections  is assigned. Again, no PartyFacts ID is available.





## References

Döring, Holger and Sven Regel. 2019. "Party Facts: A Database of Political Parties Worldwide." Party Politics 25(2): 97–109. DOI: 
[10.1177/1354068818820671](https://doi.org/10.1177/1354068818820671).

Umit, Resul. 2022. "German Bundestag Election Results at Constituency Level." Harvard Dataverse, Version 1. DOI: [10.7910/DVN/S1M6SA](https://doi.org/10.7910/DVN/S1M6SA).



