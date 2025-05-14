# Data Project
## Table Of Contents 
---
- [Context](#context)
- [Preparation](#preparation)
- [Implementation](#implementation)
- [ Business Value Achievements](#business-value-achievements)
- [Individual Achievements](#individual-achievements)



### Context
--- 
The CFO wants to monitor the overall business performance of the entire company and its regions to assess operational efficiency and identify existing issues. Additionally, he wants to evaluate the performance of ASMs.
Understanding the CFO’s objectives and requirements, I initiated this project to address those needs.
    
### Preparation:
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
    - File *"fact_kpi_month_raw_data.xlsx"*: Source data on credit card by customer at the end of each month.
    - File *"fact_txn_month_raw_data.xlsx"*: Source data on monthly transactions posted to the General Ledger.
    - File *"kpi_asm_data.xlsx"*: Monthly business performance data by each ASM (Area Sales Manager).


### Implementation 
---

**Flow Chart**

- After collecting the data, I proceeded with the following steps as described in the flowchart below:
![image_alt](https://github.com/pklinh29/Data-Project-/blob/01d7d7a48f6567a7f8d475ea6fcde100c8d21487/A%CC%89nh%20ma%CC%80n%20hi%CC%80nh%202025-05-11%20lu%CC%81c%2011.06.45.png)

**1.Data Import**
- I converted data from *"xlsx"* files to *"csv"* format and imported them into DBeaver using direct operations on DBeaver's interface.
- 3 files I used to import into DBeaver are:
  + File *"fact_kpi_month_raw_data.csv"*
  + File *"fact_txn_month_raw_data.csv"*
  + File *"kpi_asm_data.csv"*
    
**2.Creating Dim and Fact Tables**
- First, I identified the desired output to determine the entities to be created and the necessary attributes for each entity.
  
  - *Creating Dim Tables*:
      - First, I created the tables "dim_city_structure", "dim_rpt_criteria_structure", and "dim_rpt_rank_asm" to insert data. The syntax is as follows:
     + Create "dim_city_structure" :
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
    
              
      + Create "dim_rpt_criteria_structure" :
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
            + report_level: The level of significance or hierarchy for each evaluation criterion.
            + *sortorder*: A sequence of numbers used to arrange the criteria in the correct order to prevent disorganization.

          
     + Create "dim_rpt_rank_asm" :
        ```sql
        create table finalproject.dim_rpt_rank_asm(
        report_id int8,
        report_code varchar(1024),
        name varchar(1024),
        report_level int8,
        sortorder int8
        )
        ```
        + In this tables:
            + report_id: The sequential identifier for each ASM performance evaluation criterion, arranged in ascending order.
            + report_code: The code representing each ASM performance evaluation criterion.
            + name: The full name of each ASM performance evaluation criterion.
            + report_level: The level of significance or hierarchy for each evaluation criterion.
            + sortorder: A sequence of numbers used to ensure that the criteria are ordered correctly without being mixed up.
         
              
    - I wrote the following SQL statements to insert data into DBeaver. The syntax is as follows:
         + Insert into table "dim_city_structure" :
           
         ```sql
         INSERT INTO finalproject.dim_city_structure
         (ma_tinh_thanh,danh_sach_vung,parent_id)
         VALUES
    	 ('A','Hội Sở ','-1'),
    	 ('21','Hà Giang','B'),
    	 ('59','Tuyên Quang','B'),
    	 ('43','Phú Thọ','B'),
    	 ('54','Thái Nguyên','B'),
    	 ('13','Cao Bằng','B'),
    	 ('36','Lạng Sơn','B'),
    	 ('48','Quảng Ninh','B'),
    	 ('37','Lào Cai','C'),
    	 ('63','Yên Bái','C'),
    	 ('17','Điện Biên','C'),
    	 ('51','Sơn La','C'),
    	 ('29','Hòa Bình','C'),
    	 ('23','Hà Nội','D'),
    	 ('26','Hải Phòng','D'),
    	 ('61','Vĩnh Phúc','D'),
    	 ('30','Hưng Yên','D'),
    	 ('25','Hải Dương','D'),
    	 ('53','Thái Bình','D'),
    	 ('39','Nam Định','D'),
         ('41','Ninh Bình','D'),
    	 ('22','Hà Nam','D'),
    	 ('40','Nghệ An','E'),
    	 ('24','Hà Tĩnh','E'),
    	 ('45','Quảng Bình','E'),
    	 ('49','Quảng Trị','E'),
    	 ('14','Đà Nẵng','F'),
    	 ('46','Quảng Nam','F'),
    	 ('47','Quảng Ngãi','F'),
    	 ('44','Phú Yên','F'),
    	 ('42','Ninh Thuận','F'),
    	 ('10','Bình Thuận','F'),
    	 ('33','Kon Tum','F'),
    	 ('20','Gia Lai','F'),
    	 ('35','Lâm Đồng','F'),
    	 ('12','Cần Thơ','G'),
    	 ('38','Long An','G'),
    	 ('19','Đồng Tháp','G'),
    	 ('57','Tiền Giang','G'),
    	 ('60','Vĩnh Long','G'),
    	 ('58','Trà Vinh','G'),
    	 ('27','Hậu Giang','G'),
    	 ('32','Kiên Giang','G'),
    	 ('50','Sóc Trăng','G'),
    	 ('11','Cà Mau','G'),
    	 ('18','Đồng Nai','H'),
    	 ('52','Tây Ninh','H'),
    	 ('03','Bắc Kạn','B'),
    	 ('02','Bắc Giang','B'),
    	 ('05','Bắc Ninh','D'),
    	 ('07','Bình Định','F'),
    	 ('01','An Giang','G'),
    	 ('06','Bến Tre','G'),
    	 ('04','Bạc Liêu','G'),
    	 ('08','Bình Dương','H'),
    	 ('09','Bình Phước','H'),
    	 ('G','Tây Nam Bộ','A'),
    	 ('H','Đông Nam Bộ','A'),
    	 ('C','Tây Bắc Bộ','A'),
    	 ('E','Bắc Trung Bộ','A'),
    	 ('D','Đồng Bằng Sông Hồng','A'),
    	 ('B','Đông Bắc Bộ','A'),
    	 ('F','Nam Trung Bộ','A'),
    	 ('56','Huế','E'),
    	 ('55','Thanh Hóa','E'),
    	 ('31','Khánh Hòa','F'),
    	 ('15','Đắk Lắk','F'),
    	 ('16','Đắk Nông','F'),
    	 ('28','Hồ Chí Minh','H'),
    	 ('62','Bà Rịa - Vũng Tàu','H')
         ;
         ```
        + Insert into table "dim_rpt_criteria_structure" :
          
        ```sql
         INSERT INTO finalproject.dim_rpt_criteria_structure
        (report_id,report_code,"name",report_parent_id,report_level,sortorder)
        VALUES
    	 (1,'P01','I/ Lợi nhuận trước thuế',-1,0,1000000),
    	 (2,'I00','1.Thu nhập từ hoạt động thẻ ',1,1,1100000),
    	 (3,'I01','1.1.Lãi trong hạn ',2,2,1100100),
    	 (4,'I02','1.2.Lãi quá hạn ',2,2,1100200),
    	 (5,'I03','1.3.Phí Bảo hiểm ',2,2,1100300),
    	 (6,'I04','1.4.Phí tăng hạn mức ',2,2,1100400),
    	 (7,'I05','1.5.Phí thanh toán chậm, thu từ ngoại bảng, khác',2,2,1100500),
    	 (8,'E00','2.Chi phí thuần KDV ',1,1,1200000),
    	 (9,'E01','2.1.DT Nguồn vốn ',8,2,1200100),
    	 (10,'E02','2.2.CP vốn TT 2 ',8,2,1200200),
    	 (11,'E03','2.3.CP vốn TT 1 ',8,2,1200300),
    	 (12,'E04','2.4. vốn CCTG ',8,2,1200400),
    	 (13,'N00','3.Chi phí thuần hoạt động khác ',1,1,1300000),
    	 (14,'N01','3.1.DT Fintech ',13,2,1300100),
    	 (15,'N02','3.2.DT tiểu thương, cá nhân ',13,2,1300200),
    	 (16,'N03','3.3.DT Kinh doanh ',13,2,1300300),
    	 (17,'N04','3.4.CP hoa hồng ',13,2,1300400),
    	 (18,'N05','3.5.CP thuần KD khác ',13,2,1300500),
    	 (19,'N06','3.6.CP hợp tác kd tàu (net) ',13,2,1300600),
    	 (20,'I000','4.Tổng thu nhập hoạt động',1,1,1400000),
    	 (21,'T00','5.Tổng chi phí hoạt động',1,1,1500000),
    	 (22,'T01','5.1.CP thuế, phí',21,2,1500100),
    	 (23,'T02','5.2.CP nhân viên',21,2,1500200),
    	 (24,'T03','5.3.CP quản lý',21,2,1500300),
    	 (25,'T04','5.4.CP tài sản',21,2,1500400),
    	 (26,'C00','6.Chi phí dự phòng',1,1,1600000)
            ;
        ```
	    + Insert into table "dim_rpt_rank_asm" :
   
        ```sql
          INSERT INTO finalproject.dim_rpt_rank_asm
          (report_id,report_code,"name",report_level,sortorder)
          VALUES
         (1,'LTN01','ltn_avg',1,1100000),
         (2,'OS01','psdn_avg',1,1200000),
         (3,'ARA01','approval_rate_avg',1,1300000),
         (4,'NPL01','npl_truoc_wo_luy_ke',1,1400000),
         (5,'C01','cir',1,1500000),
         (6,'M01','margin',1,1600000),
         (7,'HS01','hs_von',1,1700000),
         (8,'HNS01','hsbq_nhan_su',1,1800000)
          ;
        ```

  - *Creating Fact Tables*:
      - Fact tables store quantitative values. I created these tables using SQL commands directly in DBeaver.
        - Refer to : Section 1 in file *"PostgreSQL_main.docx"*
        - Refer to : Section 1 in file *"PostgreSQL_modeling_data.docx"*
              
**3.Writing Stored Procedures**
- I developed stored procedures to automatically load raw data into the existing dim and fact tables (data accumulated monthly). 
  - Refer to : Section 2 in file *"PostgreSQL_main.docx"*
 
- Additionally, I developed stored procedures to accurately extract monthly data from the tables populated by the previous procedures, making it easier to compare values.
  - Refer to : Section 2 in file *"PostgreSQL_modeling_data.docx"*
    
**4.Connect DBeaver and Tableau**
- After populating the data into the tables, I connected DBeaver and Tableau and wrote direct queries to extract the data in the desired format for visualization purposes in Tableau.
  - Refer to : Section 3 in file *"PostgreSQL_main.docx"*

**5.Create Dashboards**

  - After successfully executing the direct query, I used Tableau to create individual charts and combined them to form the following    dashboards:

    - Dashboard ***“OBJECTIVE”***: Displays the inputs, outputs, and a flowchart of the data processing workflow.
	![image_alt](https://github.com/pklinh29/Data-Project-/blob/ea67545713759ac0c4ce1a9855232ec92ad5dce2/objective.png)


    - Dashboard ***“Business Term Definition”***: Describes business terms (including abbreviations and explanations) to help the audience better understand the context.
	![image_alt](https://github.com/pklinh29/Data-Project-/blob/ea67545713759ac0c4ce1a9855232ec92ad5dce2/description.png)

    - Dashboard ***“Monthly Business Performance Report”***: A summary of the company’s business performance.
	![image_alt](https://github.com/pklinh29/Data-Project-/blob/ea67545713759ac0c4ce1a9855232ec92ad5dce2/table%20business.png)

    - Dashboard ***“ASM’s Performance Evaluation Report”***: A report assessing the performance of ASMs in each region based on KPI metrics.
      	![image_alt](https://github.com/pklinh29/Data-Project-/blob/ea67545713759ac0c4ce1a9855232ec92ad5dce2/table%20asm.png)
      
    - Dashboard ***“Business Performance Dashboard”***: A comprehensive dashboard that reports business performance across regions (costs, profits, metrics) through various charts, highlighting key insights.
   	![image_alt](https://github.com/pklinh29/Data-Project-/blob/ea67545713759ac0c4ce1a9855232ec92ad5dce2/bao%20cao%20kq%20hd%20kd.png)
      
    - Dashboard ***“Monthly Revenue Dashboard”***: A monthly revenue report for each region using charts to present data and extract insights.
	![image_alt](https://github.com/pklinh29/Data-Project-/blob/ea67545713759ac0c4ce1a9855232ec92ad5dce2/revenue.png)

    - Dashboard ***“Monthly Expense Dashboard”***: A monthly expense report for each region, including cost structure analysis through charts, with insights and proposed solutions.
	![image_alt](https://github.com/pklinh29/Data-Project-/blob/ea67545713759ac0c4ce1a9855232ec92ad5dce2/expense.png)

    - Dashboard ***“ASM’s Performance Evaluation Dashboard”***: A dashboard evaluating ASMs, illustrating the distribution of ASMs by region each month through charts, with insights and recommended actions.
      	![image_alt](https://github.com/pklinh29/Data-Project-/blob/ea67545713759ac0c4ce1a9855232ec92ad5dce2/asm%20dashboard.png)

       - Refer to : [Demo Online](https://public.tableau.com/views/DataProject_17471311261490/BocoKD?:language=en-US&:sid=&:redirect=auth&:display_count=n&:origin=viz_share_link)
         
         
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


