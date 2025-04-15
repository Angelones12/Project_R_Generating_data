source("trend_masa_ciala.R")
source("rozklad_plci_dla_roku_x.R")
source("przypisanie_wag.R")
source("Wygenerowanie_BMI.R")
source("RozkladN_dla_wzrostu.R")
### NOTATKA
## OBECNIE JEST 5.5% kobiet w watykanie dlatgo uznam tą wartość dla całej populacji
## WSKAŹNIK OTYŁOŚCI W WATYKANIE OBECNIE WYNOSI 0% ale dla urozmaicenia zadania
## uznamy że będę go losował z przedziału 0-10%
## wskaźniki otyłości https://versus.com/en/malta-vs-vatican-city/adult-obesity

## ZAKŁADAJĄC ŻE WATYKAN NALEŻY DO GRUPY KRAJÓW ROZWINIĘTYCH - nie znalazłem dokładnych danych
## założę że % osób z niedowagą jest mniejszy i będzie losowany z przedziału 0-5%

## GENEROWANIE DANYCH
## Najpierw będę losował BMI potem będę losowo generował wzrost i obliczał na podstawie BMI wagę osoby

## Ciekawostka
## In 2013, Worldcrunch reported that there were around 30 women who were citizens of Vatican City, 
## including two South American women, two Poles, and three from Switzerland.

### KONIEC NOTATKI
set.seed(123)  # Ustalony seed dla powtarzalności

### TREND MASY CIAŁA
y_begin <- 1925 ### Rok startowy
y_end <- 2025 ### Rok końcowy
df_BMI_byyears <- generate_data_obesity(y_begin, y_end)
head(df_BMI_byyears)

### ROZKŁAD PŁCI
sex_distribution <- generate_BMI_data(1925, 7, 500) ### Rok, %Kobiet, ilość osób w populacji
newdata <- generate_BMI_data(2025, 5, 500) ### Rok, %Kobiet, ilość osób w populacji
sex_distribution <- rbind(sex_distribution,newdata)
sex_distribution

num_women <- sum(sex_distribution$sex == 1) ### Zliczenie ilości kobiet
num_women

### Przypisanie statusu wag

t_test <- generate_sex_obesity_data(1950, sex_distribution , df_BMI_byyears) ### rok, określenie % kobiet, rozkład otyłości na przestrzeni lat 
count_weight_status_by_sex(t_test)
head(t_test)

### Wygenerowanie BMI według ustaleń w pliku Wygenerowanie_BMI.R

BMI_data <- generate_random_BMI_related_to_weight_status(t_test)
head(BMI_data)

### Dodanie wzrostu
test <- height_weight_waga(BMI_data,170,30)
head(test)
plot_BMI_21(test)

