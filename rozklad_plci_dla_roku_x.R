###year_of_research <- 1950
###f_procentage <- 5 ### procent kobiet
###population <- 1000
#### Potrzebujesz teraz dla konkretnego roku określić ile jest kobiet i mężczyzn oraz określić czy mają nadwagę czy nie

generate_BMI_data <- function(year_of_research, f_percentage, population) {
  BMI_data <- data.frame(year = integer(), sex = integer(), country = character())
  
  for(i in 1:population) {
    sex <- sample(c(0, 1), 1, replace = TRUE, prob = c(1 - f_percentage * 0.01, f_percentage * 0.01)) 
    country <- "VA"
    BMI_data <- rbind(BMI_data, data.frame(year = year_of_research, sex = sex, country = country))
  }
  
  return(BMI_data)
}
