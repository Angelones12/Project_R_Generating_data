
### Teraz mam przygotowane już ile jest kobiet w danym roku i ile w danym roku było osób z nadwagą itp itd
### Dla danego roku muszę ustalić niedowagę nadwagę itp itd

generate_sex_obesity_data <- function(y_research, sex_distribution, BMI_by_years) {
  rok <- y_research  # Przypisanie roku przed użyciem
  prob_values <- BMI_by_years[BMI_by_years$year == rok, c("overweight", "underweight", "correct_weight")]
  
  if (nrow(prob_values) == 0) {
    stop("Brak danych dla podanego roku")
  }
  
  populacja <- nrow(sex_distribution)  # Liczba osób w zbiorze danych
  
  # Wybór wagi dla każdej osoby
  weight_statuses <- sample(
    c("overweight", "underweight", "correct_weight"), 
    populacja, replace = TRUE, prob = as.numeric(prob_values)
  )
  
  # Dodanie nowej kolumny do oryginalnego dataframe
  sex_distribution$weight_status <- weight_statuses
  
  return(sex_distribution)
}

# Wywołanie funkcji
t_test <- generate_sex_obesity_data(1950, sex_distribution, df_BMI_byyears)

# Sprawdzenie wyników
t_test

count_weight_status_by_sex <- function(data) {
  # Zliczenie osób w każdej kategorii wagowej z podziałem na płeć
  num_overweight_men <- sum(data$sex == 0 & data$weight_status == "overweight")
  num_underweight_men <- sum(data$sex == 0 & data$weight_status == "underweight")
  num_correct_weight_men <- sum(data$sex == 0 & data$weight_status == "correct_weight")
  
  num_overweight_women <- sum(data$sex == 1 & data$weight_status == "overweight")
  num_underweight_women <- sum(data$sex == 1 & data$weight_status == "underweight")
  num_correct_weight_women <- sum(data$sex == 1 & data$weight_status == "correct_weight")
  
  # Wyświetlenie wyników
  cat("Mężczyźni - Nadwaga:", num_overweight_men, 
      "| Niedowaga:", num_underweight_men, 
      "| Prawidłowa waga:", num_correct_weight_men, "\n")
  
  cat("Kobiety - Nadwaga:", num_overweight_women, 
      "| Niedowaga:", num_underweight_women, 
      "| Prawidłowa waga:", num_correct_weight_women, "\n")
}

###count_weight_status_by_sex(t_test)