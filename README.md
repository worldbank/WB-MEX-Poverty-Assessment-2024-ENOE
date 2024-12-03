# World Bank Mexico Poverty Assessment 2024

This repository contains the reproducibility package for the analysis conducted as part of the **World Bank Mexico Poverty Assessment 2024**. The focus is on data from the **National Survey of Occupation and Employment (ENOE)** by INEGI.

## Data Sources

- **Raw Data**: The ENOE survey data can be downloaded from INEGI's website:  
  [https://en.www.inegi.org.mx/programas/enoe/15ymas/](https://en.www.inegi.org.mx/programas/enoe/15ymas/)

- **Harmonization Methodology**: The harmonization of ENOE data is based on the methodology used in the **World Bank Global Labor Database (GLD)**. More details are available here:  
  [https://worldbank.github.io/gld/README.html](https://worldbank.github.io/gld/README.html)

## Purpose

The code in this repository:

1. Harmonizes the raw ENOE data to ensure consistency across surveys.
2. Constructs a longitudinal panel of workers using harmonized survey data.
3. Reproduces key summary statistics and analyzes transitions in and out of poverty.

## How to Use

1. **Download Raw Data**: Start by downloading the ENOE survey data from INEGI.
2. **Run the Code**: Use the scripts provided in this repository to harmonize the data and generate the desired outputs.

### Prerequisites

- StataMP
- Data processing libraries (e.g., wbopendata)

## Outputs

- Harmonized datasets
- Summary statistics
- Transition matrices analyzing poverty dynamics

## Authors and Contributions

- **Corresponding Author**:  
  Israel Osorio Rodarte  
  Email: [iosoriorodarte@worldbank.org](mailto:iosoriorodarte@worldbank.org)

- **Contributors**:  
  - Eugenia Suarez Moran  
  - Brenda Samaniego

## Disclaimer

All errors and omissions are the sole responsibility of the main author. Feedback and suggestions are welcome.
