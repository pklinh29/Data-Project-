# Data Project
## Table Of Contents 
---
- [Background](#background)
- [Data Source](#data-source)
- [Flow Chart](#flow-chart)
- [Steps](#steps)
- [Achievements](#achievements)


### Background
--- 
The CFO wants to monitor the overall business performance of the entire company and its regions to assess operational efficiency and identify existing issues. Additionally, he wants to evaluate the performance of ASMs.
Understanding the CFO’s objectives and requirements, I initiated this project to address those needs.

### Flow Chart 
---
![image_alt](https://github.com/pklinh29/Data-Project-/blob/01d7d7a48f6567a7f8d475ea6fcde100c8d21487/A%CC%89nh%20ma%CC%80n%20hi%CC%80nh%202025-05-11%20lu%CC%81c%2011.06.45.png)
    
### Steps:
---
**1.Determine the Output**
- After understanding the tasks of the CFO, I proceeded to define the output as two tables:

    - “report_tong_hop” includes:
        + area_code (area code)
        + kpi_month (reporting month)
        + report_id (evaluation criterion ID)
        + total_value (total value)
    - “report_rank_asm” includes:
        + area_code (area code)
        + kpi_month (reporting month)
        + sale_name (ASM names)
        + email (ASM emails)
        + report_id (evaluation criterion ID)
        + total_value (total value)
          
**2.Data Collection**
- After defining the output, I proceeded to collect data to generate these outputs:

    + I met with the Operations team to obtain data on KPI indicators.
    + I met with the Accounting team to obtain GL data.
    + I met with the Business Development team to obtain metrics used to evaluate ASMs.
- Below are the data files I have collected:
    - File *"fact_kpi_month_raw_data"*: Source data on credit card by customer at the end of each month.
    - File *"fact_txn_month_raw_data"*: Source data on monthly transactions posted to the General Ledger.
    - File *"kpi_asm_data"*: Monthly business performance data by each ASM (Area Sales Manager).



**3. Data Import**
- I converted data from *xlsx* files to *csv* format and imported them into DBeaver using direct operations on DBeaver's interface.

**4. Creating Dim and Fact Tables**
- First, I identified the desired output to determine the entities to be created and the necessary attributes for each entity.
  - *Creating Dim Tables*:
      - Dim tables are used to store basic information for easier data retrieval. I constructed these tables directly in Excel.
        - Refer to: file *"dim_city_structure.xlsx"*: Information about provinces/cities and regions.
        - Refer to: file *"dim_rpt_criteria_structure.xlsx"*: Information about the structure of criteria for evaluating business performance.
        - Refer to: file *"dim_rpt_rank_asm.xlsx"*: Information about the criteria for evaluating the performance of each ASM.
          
  - *Creating Fact Tables*:
      - Fact tables store quantitative values. I created these tables using SQL commands directly in DBeaver.
        - Refer to : Section 1 in file *"PostgreSQL_main.docx"*
        - Refer to : Section 1 in file *"PostgreSQL_modeling_data.docx"*
              
**5. Writing Stored Procedures**
- I developed stored procedures to automatically load raw data into the existing dim and fact tables (data accumulated monthly). 
  - Refer to : Section 2 in file *"PostgreSQL_main.docx"*
 
- Additionally, I developed stored procedures to accurately extract monthly data from the tables populated by the previous procedures, making it easier to compare values.
  - Refer to : Section 2 in file *"PostgreSQL_modeling_data.docx"*
    
**6. Connect DBeaver and Tableau**
- After populating the data into the tables, I connected DBeaver and Tableau and wrote direct queries to extract the data in the desired format for visualization purposes in Tableau.
  - Refer to : Section 3 in file *"PostgreSQL_main.docx"*

**7.Create Dashboards**

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

### Achievements
---
- ***Enhanced Financial Business Understanding***:
    - Through this project, I gained a clearer understanding of financial business operations, including how to clearly define my responsibilities and align them with the CFO’s objectives in monitoring the overall business performance and individual regional performance.

- ***Improved Tech Skills***:
    - I successfully applied the following technical skills:

        + *SQL Programming*: Writing stored procedures and handling complex queries.
        + *Excel*: Creating dim tables and performing basic data processing.
        + *Tableau*: Visualizing data through charts and building dashboards.
        + *Prompt ChatGPT*: Effectively leveraging ChatGPT to learn both business concepts and technical skills.
- ***Enhanced Soft Skills***:

    - *English*: The entire project was conducted in English, improving my language proficiency.
    - *Logical Thinking*: I learned how to break down complex tasks into smaller, manageable steps to complete the project effectively.
    - *Communication Skills*: I consistently received and acted upon feedback from my mentor, Pham Long Van, who provided valuable guidance to help me address my shortcomings and improve the project.


