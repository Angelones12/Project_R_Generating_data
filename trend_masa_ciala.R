library(ggplot2)
library(dplyr)
library(tidyr) 
generate_data_obesity <- function(y_begin, y_end) {
  years <- c(y_begin:y_end)
  df_BMI_byyears <- data.frame(year = integer(), overweight = numeric(), underweight = numeric(), correct_weight = numeric())
  
  # Parametry rozkładów normalnych dla nadwagi i niedowagi
  mean_o_weight <- 20  # Średnia procentowa osób z nadwagą
  sd_o_weight <- 2     # Odchylenie standardowe
  mean_u_weight <- 10   # Średnia procentowa osób z niedowagą
  sd_u_weight <- 1.5   # Odchylenie standardowe
  
  for(i in years){
    # Generowanie danych z rozkładu normalnego
    o_weight <- round(rnorm(1, mean_o_weight, sd_o_weight))  # Nadwaga
    u_weight <- round(rnorm(1, mean_u_weight, sd_u_weight))  # Niedowaga
    # Zapewniamy, że wartości są w granicach 0-100
    o_weight <- max(0, min(100, o_weight))
    u_weight <- max(0, min(100, u_weight))
    # Waga prawidłowa to 100% - (nadwaga + niedowaga)
    c_weight <- 100 - (o_weight + u_weight)
    c_weight <- max(0, min(100, c_weight))  # Zapewniamy, że nie przekroczy 100%
    
    # Dodanie danych do ramki
    df_BMI_byyears <- rbind(df_BMI_byyears, data.frame(year = i, overweight = o_weight, underweight = u_weight, correct_weight = c_weight))
  }
  
  return(df_BMI_byyears)
}

df_BMI_byyears <- generate_data_obesity(y_begin, y_end)
print(df_BMI_byyears)

### SPRAWDZENIE OUTLAYERÓW POPRZEZ SPRAWDZENIE WYKRESU
ggplot(df_BMI_byyears, aes(x = year)) +
  geom_line(aes(y = overweight, color = "Overweight")) +  # Line for overweight
  geom_line(aes(y = underweight, color = "Underweight")) +  # Line for underweight
  geom_line(aes(y = correct_weight, color = "Correct Weight")) +  # Line for correct weight
  labs(
    title = "Weight Categories Over Time",  # Title of the plot
    x = "Year",                           # X-axis label
    y = "Percentage (%)"                  # Y-axis label
  ) +
  scale_color_manual(values = c("red", "blue", "green"))  # Simple color scheme
