### BMI ma 3 wartości BMI = kg/m²
### Wartości BMI 
#### Niedowaga: BMI poniżej 18,5  
#### Norma (prawidłowa masa ciała): BMI 18,5 – 24,9
#### Nadwaga: BMI powyżej 25 w teorii zakres jest aż do 60 jednak zmniejszę go do 40 oznacza to
#### że te dane nie biorą pod uwagę otyłości 3 stopnia i z równym prawdopodobieństwem otyłości
#### podejrzewam że im większa otyłość tym mniej takich jednostek jednak na potrzeby zadania upraszczam to

### OBECNY DATAFRAME - rok,płeć,miasto,status wagi
generate_random_BMI_related_to_weight_status <- function(sex_obesity_data){
  BMI_relate_to_weight_status <- data.frame(sex_obesity_data)
  population <- nrow(BMI_relate_to_weight_status)
  BMI_relate_to_weight_status$BMI_value <- NA
  
  for(i in 1:population){
    # Dla osób z nadwagą - średnia BMI około 30, odchylenie standardowe 3
    if (BMI_relate_to_weight_status[i, "weight_status"] == "overweight") {
      BMI_value <- round(rnorm(1, mean = 30, sd = 3))
      BMI_value <- max(25, min(35, BMI_value))  # Ograniczenie do przedziału 25-30
      BMI_relate_to_weight_status[i, "BMI_value"] <- BMI_value
    }
    
    # Dla osób z prawidłową wagą - średnia BMI około 22, odchylenie standardowe 1.5
    if (BMI_relate_to_weight_status[i, "weight_status"] == "correct_weight") {
      BMI_value <- rnorm(1, mean = 21.5, sd = 1.8)
      BMI_value <- max(18.5, min(24.9, BMI_value))
      BMI_relate_to_weight_status[i, "BMI_value"] <- BMI_value
    }
    
    # Dla osób z niedowagą - średnia BMI około 17, odchylenie standardowe 1.5
    if (BMI_relate_to_weight_status[i, "weight_status"] == "underweight") {
      BMI_value <- round(rnorm(1, mean = 17, sd = 1.5))
      BMI_value <- max(15, min(18, BMI_value))  # Ograniczenie do przedziału 15-18
      BMI_relate_to_weight_status[i, "BMI_value"] <- BMI_value
    }
  }
  
  return(BMI_relate_to_weight_status)
}

# Przykład wywołania funkcji
# Załóżmy, że masz ramkę danych z kolumną "weight_status" w której są 3 możliwe wartości: "overweight", "correct_weight", "underweight"
# przykładowe dane wejściowe
sex_obesity_data <- data.frame(weight_status = c("overweight", "correct_weight", "underweight", "overweight", "correct_weight"))
result <- generate_random_BMI_related_to_weight_status(sex_obesity_data)
print(result)

