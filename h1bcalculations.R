library(dplyr)
library(readr)
library(stringr)

##create df

# frequency of each wage level at all higher education institutions --------
main_df <- read.csv("LCA_Disclosure_Data_FY2025_Q2.csv")
taxid_df <- read.csv("Data_8-13-2025.csv")

# main_df <- main_df |>
#   filter(VISA_CLASS == "H-1B")
# 
# final_df <- taxid_df |>
#   inner_join(main_df, by = c("ein" = "EMPLOYER_FEIN")) |>
#   filter(VISA_CLASS == "H-1B")
# 
# final_df <- final_df |>
#   distinct(CASE_NUMBER, .keep_all = TRUE)
# 
# head(final_df)
# 
# write_csv(final_df, "taxid_with_main_data.csv")

matched_df <- read.csv("taxid_with_main_data.csv")

matched_df |> 
  count(PW_WAGE_LEVEL, name = "n") |>
  arrange(desc(n))       

matched_df |> 
  filter(!is.na(PW_OTHER_SOURCE) & trimws(PW_OTHER_SOURCE) != "") |> 
  mutate(source_group = case_when(
    str_to_lower(PW_OTHER_SOURCE) == "cba" ~ "CBA",
    str_to_lower(PW_OTHER_SOURCE) == "survey" ~ "Survey",
    TRUE ~ "Other"
  )) |> 
  count(source_group, name = "count") |> 
  arrange(desc(count))

# FREQUENCY OF EACH WAGE LEVEL AT AAU INSTITUTIONS ------------------------


# aauid_df <- read.csv("einaauinstitutions.csv")

# aaufinal_df <- aauid_df |>
#   inner_join(main_df, by = c("ein" = "EMPLOYER_FEIN")) |>
# 
#   #data cleaning
#   filter(
#      !grepl(
#        paste(
#          c(
#            "Indiana University Indianapolis",
#            "Indiana University Purdue University Indianapolis",
#            "State University of New York At Binghamton",
#            "University at Albany, State University of New York",
#            "State University of New York - Polytechnic Institute",
#            "State University of New York at Oneonta",
#            "SUNY Plattsburgh",
#            "State University of New York at Oswego",
#           "State University of New York at Fredonia",
#           "State University of New York Downstate Health Sciences University",
#           "SUNY College of Environmental Science & Forestry",
#           "State University of New York at Potsdam",
#           "State University of New York at Cobleskill",
#           "State University of New York - Purchase College",
#           "New York State Office of Mental Health",
#           "State University of New York - College of Optometry",
#           "State University of New York - Empire State University",
#           "State University of New York at Canton",
#           "State University of New York at Cortland",
#           "State University of New York at Brockport",
#           "NYS Office of Information Technology Services",
#           "South Carolina Sea Grant Consortium",
#           "State University of New York - Maritime College",
#           "State University of New York - Buffalo State University",
#           "New York State",
#           "SUNY Maritime College",
#           "University of Colorado Denver",
#           "University of Colorado, Denver",
#           "University of Colorado System Administration",
#           "Board of Trustees, University of Illinois, on behalf of University of Illinois Springfield",
#           "University of Illinois Chicago",
#           "University of Illinois at Chicago",
#           "University of Maryland Baltimore",
#           "University of Maryland, Baltimore County",
#           "Towson University",
#           "Bowie State University",
#           "Morgan State University",
#           "Frostburg State University",
#           "St. Mary's College of Maryland",
#           "University of Maryland Center for Environmental Science",
#           "University of Maryland Eastern Shore",
#           "State of Maryland, Office of the Public Defender",
#           "DEPARTMENT OF LEGISLATIVE SERVICES",
#           "Salisbury University",
#           "The Curators of the University of Missouri/University of Missouri-Kansas City",
#           "The Curators of the University of Missouri/Missouri University of Science and Technology",
#           "University of Wisconsin-Whitewater"
#         ),
#         collapse = "|"
#       ),
#       EMPLOYER_NAME,
#       ignore.case = TRUE
#     )
#   ) |>
# 
#   #remove duplicates
#   distinct(CASE_NUMBER, .keep_all = TRUE)
# 
# head(aaufinal_df)
# 
## write_csv(aaufinal_df, "aauinstitutions_data.csv")

aauwagelevel <- read.csv("aauinstitutions_data.csv")

aauwagelevel |> 
  count(PW_WAGE_LEVEL, name = "n") |>
  arrange(desc(n))       

aauwagelevel |> 
  filter(!is.na(PW_OTHER_SOURCE) & trimws(PW_OTHER_SOURCE) != "") |> 
  mutate(source_group = case_when(
    str_to_lower(PW_OTHER_SOURCE) == "cba" ~ "CBA",
    str_to_lower(PW_OTHER_SOURCE) == "survey" ~ "Survey",
    TRUE ~ "Other"
  )) |> 
  count(source_group, name = "count") |> 
  arrange(desc(count))


# WAGE LEVEL, ALL COMPANIES -----------------------------------------------------------

main_df |>
  filter(VISA_CLASS == "H-1B") |>
  count(PW_WAGE_LEVEL, name = "n") |>
  arrange(desc(n))       

main_df |> 
  filter(VISA_CLASS == "H-1B") |>
  filter(!is.na(PW_OTHER_SOURCE) & trimws(PW_OTHER_SOURCE) != "") |> 
  mutate(source_group = case_when(
    str_to_lower(PW_OTHER_SOURCE) == "cba" ~ "CBA",
    str_to_lower(PW_OTHER_SOURCE) == "survey" ~ "Survey",
    TRUE ~ "Other"
  )) |> 
  count(source_group, name = "count") |> 
  arrange(desc(count))

