source("Main.R")
library(truncnorm)
BMI_data
### OBECNY DATAFRAME to year sex country weight_status BMI_value
library(truncnorm)

height_weight_waga <- function(BMI_data_with_weight, m, sd) {
  n <- nrow(BMI_data_with_weight)
  
  # Losowanie wzrostów z zakresu 145–205
  base_height <- rtruncnorm(n, a = 145, b = 205, mean = m, sd = sd)
  
  # Dodanie różnicy dla kobiet/mężczyzn z delikatną korektą
  eps <- rnorm(n, mean = 0, sd = 3)
  height <- ifelse(BMI_data_with_weight$sex == 0, base_height - 3 + eps, base_height + eps)
  
  # Płynne przelosowywanie: Im niższy wzrost, tym większa szansa na przelosowanie
  too_short <- height < 150
  prob_reroll <- pmin(1, (150 - height[too_short]) / 2.5)  # Wyższa szansa na przelosowanie przy niższych wzrostach
  reroll <- runif(sum(too_short)) < prob_reroll
  
  # Przelosowywanie osób poniżej 150 cm
  height[too_short & reroll] <- rtruncnorm(sum(too_short & reroll), a = 150, b = 205, mean = m, sd = sd)
  
  # Ostateczne ograniczenie
  height <- pmin(pmax(height, 145), 210)
  
  # Zapisanie do ramki
  BMI_data_with_weight$height <- height
  BMI_data_with_weight$weight <- BMI_data_with_weight$BMI_value * (height / 100)^2
  
  return(BMI_data_with_weight)
}


test <- height_weight_waga(BMI_data,170,30)

plot_BMI_21 <- function(BMI_data) {
  # Założenie: Idealne BMI = 21
  ideal_BMI <- 21
  heights_range <- seq(min(BMI_data$height), max(BMI_data$height), length.out = 100) / 100  # Zamiana cm na metry
  ideal_weight_range <- ideal_BMI * (heights_range^2)
  plot(BMI_data$weight, BMI_data$height, col='grey', pch=16, cex=0.7,
       xlab="Waga", ylab="Wysokość")
  lines(ideal_weight_range, heights_range * 100, col='red', lwd=2)  # Przeliczamy metry na cm na osi Y
}

plot_BMI_21(test)

