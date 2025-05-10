# Data Project
## Table of contents :
- [Project Overview](#project-overview)
- [Data Analysis](#data-analysis)


### Project Overview
--- 
From the raw input data, I proceeded to process, clean, and analyze the data using SQL Programming through the PostgreSQL database       management system (creating stored procedures to execute the steps sequentially in an automated manner). Finally, I used Tableau to      visualize dashboards and uncover insights as well as propose solutions for the business.

### Data Analysis
---
- **Excel** : Data Source
  - File *"fact_kpi_month_raw_data"*: Source data on credit card by customer at the end of each month.
  - File *"fact_txn_month_raw_data"*: Source data on monthly transactions posted to the General Ledger.
  - File *"kpi_asm_data"*: Monthly business performance data by each ASM (Area Sales Manager).
    
- **PostgreSQL** : Data Analysis
  - This section is divided into two parts:
    - **First**, I processed the data to create target tables (*core tables*), which are cumulative figures aggregated by month.
      - [PostgreSQL_modeling_data](#PostgreSQL_modeling_data.docx)
        
    - **Second**, based on these core tables with cumulative monthly data, I proceeded to remodel the data. From the cumulative monthly        data, I modeled the data into separate monthly figures, not based on cumulative data, to facilitate easy comparison of data across
      across months and to uncover insights more effectively.
      
  - The steps I took to implement these two parts are as follows:
    - **Step 1**: I identified the desired output, from which I determined the necessary entities to create, as well as the attributes         required for each entity.

        - Refer to Section 1 in this file :
          
    - **Step 2**: After defining the desired output, I proceeded to create tables and write stored procedures using SQL programming to         automatically populate data into the created tables. Additionally, I logged timestamps and errors (if any) into the log_tracking         table to ensure that the procedure would not halt in case of errors.

        - Refer to Section 2 in this file :
          
- **Tableau** : Create dashboards


### Exploratory Data Analysis 
- What is the top sale trend ?

### Result/Findings
- Revenue and profit in 01/2023 is higher than those in 02/2023

### Recommendations 
- Take actions


### References 
- Stackoverflow...


