# R Data Simulation and Visualization Project

## Overview

This project was developed as part of an elective course focused on learning the R programming language. The main objective is to simulate synthetic data for selected countries between the years 1925 and 2025, and then analyze and visualize that data in a way that is clear and accessible for everyone.

## Features

- Synthetic data generation for different countries across 100 years
- Body mass trend simulation
- Gender distribution modeling
- BMI category assignment (Underweight, Normal, Overweight)
- Detailed BMI values generated based on category
- Height and weight estimation based on BMI
- Data visualization using `ggplot2`

## Methodology

The dataset was created using the following steps:

1. **Body Mass Trend Generation:** A trend of average body mass over time was simulated for each country.
2. **Gender Distribution:** The male/female percentage was generated for each year.
3. **BMI Categories:** Individuals were classified into BMI status groups: underweight, normal, and overweight.
4. **Exact BMI Values:** For each group, a specific BMI value was randomly selected within a realistic range (e.g., <19 for underweight).
5. **Height Simulation:** Random but plausible height values were generated.
6. **Weight Calculation:** Based on height and BMI, the weight was calculated.

## Note

This is not an optimized approach. Many variables could be adjusted to refine the realism of the simulation. However, this complexity was intentionally introduced to make the task more challenging and provide more opportunities to learn and explore the R language.

## Technologies

- R
- dplyr
- ggplot2

## License

This project is for educational purposes only.
