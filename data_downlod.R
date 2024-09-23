# Install necessary packages
if (!requireNamespace("httr", quietly = TRUE)) {
  install.packages("httr")  # For API requests
}
if (!requireNamespace("readr", quietly = TRUE)) {
  install.packages("readr")  # For reading CSV files
}
if (!requireNamespace("WDI", quietly = TRUE)) {
  install.packages("WDI")  # For downloading World Bank data
}

# Load necessary libraries
library(httr)
library(readr)
library(WDI)

# ===============================
# Download WHO Life Expectancy Data from Kaggle
# ===============================

# Set Kaggle API endpoint and dataset name
dataset_name <- "kumarajarshi/life-expectancy-who"

# Download the dataset using Kaggle API
GET(paste0("https://www.kaggle.com/api/v1/datasets/download/", dataset_name),
    write_disk("life_expectancy_data.zip", overwrite = TRUE))

# Unzip the downloaded file
unzip("life_expectancy_data.zip", exdir = "life_expectancy_data")

# Read the life expectancy data (assuming the file is named 'life_expectancy.csv')
life_expectancy_data <- read_csv("life_expectancy_data/life_expectancy.csv")

# ===============================
# Download COVID-19 Data from Our World in Data
# ===============================

# URL for Our World in Data COVID-19 dataset
covid_url <- "https://covid.ourworldindata.org/data/owid-covid-data.csv"

# Download the dataset
covid_data <- read_csv(covid_url)

# Save the COVID-19 dataset to a CSV file
write_csv(covid_data, "owid_covid_data.csv")

# ===============================
# Download GDP Per Capita Data from World Bank
# ===============================

# Download GDP per capita data
gdp_data <- WDI(country = "all", indicator = "NY.GDP.PCAP.CD", start = 2000, end = 2023)

# Save the GDP data to a CSV file
write.csv(gdp_data, "gdp_per_capita_data.csv", row.names = FALSE)

# ===============================
# Check the structure of the downloaded datasets
# ===============================

# Check the structure of the datasets
str(life_expectancy_data)
str(covid_data)
str(gdp_data)

# Optionally, preview the first few rows of the datasets
head(covid_data)
head(gdp_data)
head(life_expectancy_data)
