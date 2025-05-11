# Data Project
## Table Of Contents :
---
- [Project Overview](#project-overview)
- [Data Analysis](#data-analysis)


### Background
--- 
The CFO wants to monitor the overall business performance of the entire company and its regions to assess operational efficiency and identify existing issues. Additionally, he wants to evaluate the performance of ASMs.
Understanding the CFO’s objectives and requirements, I initiated this project to address those needs.

### Data Source
- File *"fact_kpi_month_raw_data"*: Source data on credit card by customer at the end of each month.
- File *"fact_txn_month_raw_data"*: Source data on monthly transactions posted to the General Ledger.
- File *"kpi_asm_data"*: Monthly business performance data by each ASM (Area Sales Manager).
    
### Steps:
**1. Data Import**:
- I converted data from *xlsx* files to *csv* format and imported them into DBeaver using direct operations on DBeaver's interface.

**2. Creating Dim and Fact Tables**:
- First, I identified the desired output to determine the entities to be created and the necessary attributes for each entity.
  - *Creating Dim Tables*:
      - Dim tables are used to store basic information for easier data retrieval. I constructed these tables directly in Excel.
  - *Creating Fact Tables*:
      - Fact tables store quantitative values. I created these tables using SQL commands directly in DBeaver.

**3. Writing Stored Procedures**:
- I developed stored procedures to automatically load raw data into the existing dim and fact tables.  









  - This section is divided into two parts:
    - **First**, I processed the data to create target tables (*core tables*), which are cumulative figures aggregated by month.
      - Refer to file : ***"PostgreSQL_main.docx"***
    
    - **Second**, based on these core tables with cumulative monthly data, I proceeded to remodel the data. From the cumulative monthly        data, I modeled the data into separate monthly figures, not based on cumulative data, to facilitate easy comparison of data across
      across months and to uncover insights more effectively.
      - Refer to file : ***"PostgreSQL_modeling_data.docx"***
      
  - The steps I took to implement these two parts are as follows:
    - **Step 1**: I identified the desired output, from which I determined the necessary entities to create, as well as the attributes         required for each entity.
          
    - **Step 2**: After defining the desired output, I proceeded to create tables and write stored procedures using SQL programming to         automatically populate data into the created tables. Additionally, I logged timestamps and errors (if any) into the log_tracking         table to ensure that the procedure would not halt in case of errors.

    - **Step 3**: Connect the PostgreSQL database to Tableau and use direct query to format the data and extract the necessary data for        creating dashboards.

- **Tableau** : Create Dashboards
  - After successfully executing the direct query, I used Tableau to create individual charts and combined them to form the following    dashboards:

    - Dashboard ***“OBJECTIVE”***: Displays the inputs, outputs, and a flowchart of the data processing workflow.
    - Dashboard ***“Business Term Definition”***: Describes business terms (including abbreviations and explanations) to help the audience better understand the context.
    - Dashboard ***“Monthly Business Performance Report”***: A summary of the company’s business performance.
    - Dashboard ***“ASM’s Performance Evaluation Report”***: A report assessing the performance of ASMs in each region based on KPI metrics.
    - Dashboard ***“Business Performance Dashboard”***: A comprehensive dashboard that reports business performance across regions (costs, profits, metrics) through various charts, highlighting key insights.
    - Dashboard ***“Monthly Revenue Dashboard”***: A monthly revenue report for each region using charts to present data and extract insights.
    - Dashboard ***“Monthly Expense Dashboard”***: A monthly expense report for each region, including cost structure analysis through charts, with insights and proposed solutions.
    - Dashboard ***“ASM’s Performance Evaluation Dashboard”***: A dashboard evaluating ASMs, illustrating the distribution of ASMs by region each month through charts, with insights and recommended actions.
            

       - Refer to : [My Dashboards](https://public.tableau.com/shared/TCDPPZMWY?:display_count=n&:origin=viz_share_link)




