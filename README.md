# Data Project
## Table Of Contents 
---
- [Background](#background)
- [Steps](#steps)
- [ Business Value Achievements](#business-value-achievements)
- [Individual Achievements](#individual-achievements)



### Background
--- 
The CFO wants to monitor the overall business performance of the entire company and its regions to assess operational efficiency and identify existing issues. Additionally, he wants to evaluate the performance of ASMs.
Understanding the CFO’s objectives and requirements, I initiated this project to address those needs.
    
### Steps:
---
**1.Determine the Output**
- After understanding the tasks of the CFO, I proceeded to define the output as two tables:

    - “report_tong_hop” includes:
        + area_code (area code)
        + kpi_month (reporting month)
        + report_id (evaluation criterion ID)
        + total_value (total value)
     - For example:
        ![image_alt](https://github.com/pklinh29/Data-Project-/blob/1c4aece5d5beac0c52dd8e8484e06806af5a4136/A%CC%89nh%20ma%CC%80n%20hi%CC%80nh%202025-05-13%20lu%CC%81c%2017.44.31.png)

    - “report_rank_asm” includes:
        + area_code (area code)
        + kpi_month (reporting month)
        + sale_name (ASM names)
        + email (ASM emails)
        + report_id (evaluation criterion ID)
        + total_value (total value)
    - For example:
        ![image_alt](https://github.com/pklinh29/Data-Project-/blob/1c4aece5d5beac0c52dd8e8484e06806af5a4136/A%CC%89nh%20ma%CC%80n%20hi%CC%80nh%202025-05-13%20lu%CC%81c%2017.44.57.png)
          
**2.Data Collection**
- After defining the output, I proceeded to collect data to generate these outputs:

    + I met with the Operations team to obtain data on KPI indicators.
    + I met with the Accounting team to obtain GL data.
    + I met with the Business Development team to obtain metrics used to evaluate ASMs.
- Below are the data files I have collected:
    - File *"fact_kpi_month_raw_data"*: Source data on credit card by customer at the end of each month.
    - File *"fact_txn_month_raw_data"*: Source data on monthly transactions posted to the General Ledger.
    - File *"kpi_asm_data"*: Monthly business performance data by each ASM (Area Sales Manager).

**Flow Chart**

- After collecting the data, I proceeded with the following steps as described in the flowchart below:
![image_alt](https://github.com/pklinh29/Data-Project-/blob/01d7d7a48f6567a7f8d475ea6fcde100c8d21487/A%CC%89nh%20ma%CC%80n%20hi%CC%80nh%202025-05-11%20lu%CC%81c%2011.06.45.png)

**3. Data Import**
- I converted data from *"xlsx"* files to *"csv"* format and imported them into DBeaver using direct operations on DBeaver's interface.
- First, I created the tables "dim_city_structure", "dim_rpt_criteria_structure", and "dim_rpt_rank_asm" to insert data. The syntax is as follows:
  - Create "dim_city_structure" :
    ```sql
    create table finalproject.dim_city_structure(
    ma_tinh_thanh varchar(1024),
    danh_sach_vung varchar(1024),
    parent_id varchar(1024)
    )
    ```
    + In this table:
        + *ma_tinh_thanh*: The unique identifier for each province/city and the code representing each region.
        + *danh_sach_vung*: The full name of each province/city and region.
        + *parent_id*: The region code to which each province/city belongs.
          
  - Create "dim_rpt_criteria_structure" :
    ```sql
    create table finalproject.dim_rpt_criteria_structure(
    report_id int8,
    report_code varchar(1024),
    name varchar(1024),
    report_parent_id int8,
    report_level int8,
    sortorder int8
    )
    ```
    + In this table:
        + *report_id*: The sequential identifier for each business performance evaluation criterion, arranged in ascending order.
        + *report_code*: The code representing each business performance evaluation criterion.
        + *name*: The full name of each business performance evaluation criterion.
        + *report_parent_id*: The code of the main criteria group to which the sub-criteria belong.
        + *sortorder*: A sequence of numbers used to arrange the criteria in the correct order to prevent disorganization.
      
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
            

       - Refer to : [My Dashboards](https://public.tableau.com/views/DataProject_17471311261490/BocoKD?:language=en-US&:sid=&:redirect=auth&:display_count=n&:origin=viz_share_link)
         
         
### Business Value Achievements 
---
- This project provides the management team with a comprehensive overview of the company’s operations through reports on business performance, revenue, expenses, and ASM performance evaluation, enabling them to devise appropriate business strategies.


### Individual Achievements
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


