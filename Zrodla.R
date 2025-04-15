source("Main.R")
library(googlesheets4)
library(dplyr)
library(ggplot2)

gsheet_key <- "1AV3jgvWzZTFmrKexH0WhkmlYqMcWeZay3b9fTvTtgdU"


sheet_write(test,gsheet_key,sheet="source")

# Google Sheet key jako ciąg znaków (string)
g_sheet <- "17lKNBZYUmPJJoNtaMX_tj17JhzdLlZvSmdch3wNwW3c"


### OBECNY DATAFRAME test to     $year$ $sex$ $country$ weight_status BMI_value $height$ $weight$
### Obecny dataframe dta  to age $height$ $weight$   $sex$ education  $year$ $country$
head(dta)
plot_BMI_21(test)



# Wczytanie danych z arkusza Google Sheet
dta <- read_sheet(g_sheet, sheet = "source")
summary(dta)


test <- rbind(test,dta)
test

plot_BMI_21(dta)

calosc <- left_join(test, dta, by = c("age" = "age"))