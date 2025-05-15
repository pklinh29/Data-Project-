--- 1.Tạo các bảng cần thiết 
-- bang hach toan chinh xac card income
create table finalproject.tmp_accurate_accounting_card_income(
kpi_month int8,
report_id int8,
area_code varchar(1024),
total_value decimal
);
-- bang dnck binh quan sau wo nhom 1
create table finalproject.tmp_total_os_db_grp_1_after_wo(
kpi_month int8,
area_code varchar(1024),
avg_total_os_area decimal,
avg_total_os_all decimal
);
-- bang dnck binh quan sau wo nhom 2
create table finalproject.tmp_total_os_db_grp_2_after_wo(
kpi_month int8,
area_code varchar(1024),
avg_total_os_area decimal,
avg_total_os_all decimal
);
--bang dnck binh quan sau wo nhom 2 -> 5
create table finalproject.tmp_total_os_db_grp_2_to_5_after_wo(
kpi_month int8,
area_code varchar(1024),
avg_total_os_area decimal,
avg_total_os_all decimal
);
-- bang so luong the psdn
create table finalproject.the_psdn(
area_code varchar(1024),
kpi_month int8,
so_the_psdn int8,
so_the_psdn_toan_hang int8
);
-- report 1
create table finalproject.report_tong_hop(
area_code varchar(1024) ,
kpi_month int8,
report_id int8,
total_value decimal
) ;
--bảng hạch toán chính xác các tiêu chí về chi phí kinh doanh vốn các khu vực
	create table finalproject.tmp_accurate_accounting_captial_business(
	kpi_month int8,
	report_id int8,
	area_code varchar(1024),
	total_value decimal
	);
--bảng tỷ lệ phân bổ tiêu chí trong chi phí kinh doanh vốn các khu vực
create table finalproject.tmp_allocate_capital_business(
kpi_month int8,
area_code varchar(1024),
card_income decimal,
interest_credit_card decimal
);
--bảng hạch toán chính xác tiêu chí trong chi phí thuần hoạt động khác
create table finalproject.tmp_accurate_accounting_net_other_operating_expenses(
kpi_month int8,
report_id int8,
area_code varchar(1024),
total_value decimal
);
--bảng tỷ lệ phân bổ tiêu chí trong chi phí thuần hoạt động khác
create table finalproject.tmp_total_os_db_after_wo(
kpi_month int8,
area_code varchar(1024),
avg_total_os_area decimal,
avg_total_os_all decimal
);
-- bảng so_nhan_vien
create table finalproject.number_of_employees(
area_code varchar(1024),
kpi_month int8,
no_of_employees_area int8,
no_of_employees_all int8
);		
--bảng hạch toán chính xác trong tổng chi phí hoạt động
create table finalproject.tmp_accurate_accounting_operating_expenses(
kpi_month int8,
report_id int8,
area_code varchar(1024),
total_value decimal
);
---- chi phi du phong
--bảng hạch toán chính xác trong chi phí dự phòng
create table finalproject.tmp_accurate_accounting_provision_expenses(
kpi_month int8,
report_id int8,
area_code varchar(1024),
total_value decimal
);
-- bang wo luy ke
create table finalproject.wo_by_month(
area_code varchar(1024),
kpi_month int8,
write_off_month int8,
wo_by_month decimal,
wo_luyke decimal
);
-- bang dnck truoc wo
create table finalproject.os_bef_wo(
area_code varchar(1024),
kpi_month int8,
os_bef_wo decimal,
avg_total_os_all decimal
);
-- bang dnck truoc wo binh quan
create table finalproject.total_os_bef_wo(
area_code varchar(1024),
kpi_month int8,
total_os_area_bef_wo decimal,
total_os_all decimal
);
--bang cac chi so tai chinh
create table finalproject.index_finance(
area_code varchar(1024),
kpi_month int8,
cir decimal,
change_cir float8,
margin decimal,
change_margin float8,
return_of_capital decimal,
change_roc float8,
avg_profit_per_employee decimal,
change_appe float8
);
-- bang SDCK sau wo
create table finalproject.os_after_wo
(
area_code varchar(1024),
kpi_month int8,
total_os_area decimal,
total_os_all decimal
);
-- insert vao bang npl_truoc_wo_luy_ke
create table finalproject.npl_truoc_wo_luy_ke
(
area_code varchar(1024),
kpi_month int8, 
npl_bef_wo float8
);
-- bang target report 2
create table finalproject.report_rank_asm(
kpi_month int8,
area_code varchar(1024),
sale_name varchar(1024),
email varchar(1024),
report_id int8,
total_value decimal
);


--- 2.Tạo Stored Procedure 

create or replace procedure finalproject.report_tong_hop_T2_prc(in_date date )
as
$$
declare
v_begining_year date; -- bien luu ngay dau nam dang YYYY-MM-DD
v_in_date_month int8; --  bien luu namthang dang YYYYMM
v_begining_month_of_year int8; -- bien luu namthang dau nam : YYYY01
v_start_time timestamp ; -- bien luu thoi gian bat dau chay procedure
begin
-- ---------------------
   -- THÔNG TIN NGƯỜI TẠO
   -- ---------------------
   -- Tên người tạo: Phung Khanh Linh
   -- Ngày tạo: 21/01/2025
   -- ---------------------
   -- THÔNG TIN NGƯỜI CẬP NHẬT
   -- ---------------------
   -- Tên người cập nhật: Phung Khanh Linh
   -- Ngày cập nhật: 26/02/2025
   -- Mục đích cập nhật: Thêm cột sale_name vào bảng report_rank_asm


   -- ---------------------
   -- SUMMARY LUỒNG XỬ LÝ
   -- ---------------------
   -- Bước 1: khởi tạo thời gian bắt đầu , thêm thời giam bắt đầu chạy procedure vao bảng log tracking
   -- Bước 2: gán giá trị cho các biến
   -- Bước 3: xoá dữ liệu các bảng cũ
   -- Bước 4: thu nhập từ hoạt động thẻ
		-- 4.1. insert vào bảng hạch toán chính xác các tiêu chí trong thu nhập từ hoạt động thẻ các khu vực
   	-- 4.2. insert vào bảng tỷ lệ phân bổ tiêu chí trong thu nhập từ hoạt động thẻ các khu vực
   	-- 4.3. insert vào bảng report 1 cac tieu chi cua thu nhập từ hoạt động thẻ
	-- bước 5: chi phí kinh doanh vốn
		-- 5.1. insert vào bảng hạch toán chính xác các tiêu chí về chi phí kinh doanh vốn các khu vực
		-- 5.2. insert vào bảng tỷ lệ phân bổ tiêu chí trong chi phí kinh doanh vốn các khu vực
		-- 5.3. insert vào bảng report 1 cac tieu chi cua chi phí kinh doanh vốn
	-- bước 6: chi phí thuần hoạt động khác
		-- 6.1. insert vào bảng hạch toán chính xác tiêu chí trong chi phí thuần hoạt động khác
		-- 6.2. insert vào bảng tỷ lệ phân bổ tiêu chí trong chi phí thuần hoạt động khác
		-- 6.3. insert vào bảng report 1 cac tieu chi cua chi phí thuần hoạt động khác
	-- bước 7: tổng chi phí hoạt động
		-- 7.1. insert vào bảng so_nhan_vien ( đây cũng là bảng sử dụng để phân bổ )
		-- 7.2. insert vào bảng hạch toán chính xác trong tổng chi phí hoạt động
		-- 7.3. insert vào bảng report 1 cac tieu chi cua tổng chi phí hoạt động
	-- bước 8: chi phí dự phòng
		-- 8.1. insert vào bảng hạch toán chính xác trong chi phí dự phòng
		-- 8.2. insert vào bảng tỷ lệ phân bổ tiêu chí trong chi phí dự phòng
		-- 8.3. insert vào bảng report 1 cac tieu chi cua chi phí dự phòng
	-- bước 9: insert vào report level 1 va 0
	-- Buoc 10. insert vao report tieu chi hoi so 'A'
	-- bước 11 : insert vao bang cac chi so tai chinh
	-- B12. REPORT 2 : insert vao report 2
	 -- 12.1. insert vao bang report 2
		-- id ve quy mo
		-- id ve tai chinh
	-- B13. ghi thoi gian bat dau va ket thuc chay procedure , xu ly ngoai le va ghi loi
		
   -- ---------------------
   -- CHI TIẾT CÁC BƯỚC
   -- ---------------------
	-- B1. ghi nhan tg bat dau chay procedure
	v_start_time := clock_timestamp() ; -- khoi tao tg bat dau chay procedure
	
	-- Ghi nhận thời gian bắt đầu chạy procedure
   INSERT INTO finalproject.log_tracking
   (procedure_name, start_time, is_successful, rec_created_dt)
   VALUES ( 'report_tong_hop_T2_prc', clock_timestamp() , NULL, now() );
 
	--B2.định nghĩa các biến
	v_begining_year := date_trunc('year',in_date);
	v_begining_month_of_year := cast(substring(to_char(v_begining_year,'YYYYMM') from 1 for 6) as int8);
	v_in_date_month := cast(substring(to_char(in_date,'YYYYMMDD') from 1 for 6) as int8);
	
	-- B3. xoa du lieu ngay cu di
		-- xoa cac bang lq den report 1
	truncate table finalproject.tmp_accurate_accounting_card_income;
	truncate table finalproject.tmp_total_os_db_grp_1_after_wo;
	truncate table finalproject.tmp_total_os_db_grp_2_after_wo;
	truncate table finalproject.tmp_total_os_db_grp_2_to_5_after_wo;
	truncate table  finalproject.the_psdn ;
	truncate table finalproject.tmp_accurate_accounting_captial_business;
	truncate table finalproject.tmp_allocate_capital_business;
	truncate table finalproject.tmp_accurate_accounting_net_other_operating_expenses;
	truncate table finalproject.tmp_total_os_db_after_wo;
	delete from finalproject.number_of_employees where kpi_month = v_in_date_month ;
	truncate table finalproject.tmp_accurate_accounting_operating_expenses;
	truncate table finalproject.tmp_accurate_accounting_provision_expenses;
	truncate table finalproject.wo_by_month;
	truncate table finalproject.os_bef_wo;
	truncate table finalproject.total_os_bef_wo;
	delete from finalproject.index_finance where kpi_month = v_in_date_month;
	delete from finalproject.report_tong_hop where kpi_month = v_in_date_month;
		-- xoa cac bang lq den report 2
	truncate table finalproject.os_after_wo ;
	truncate table finalproject.npl_truoc_wo_luy_ke;
	delete from finalproject.report_rank_asm where kpi_month = v_in_date_month;
-- Bước 4: thu nhập từ hoạt động thẻ
	-- 4.1. insert vào bảng hạch toán chính xác các tiêu chí trong thu nhập từ hoạt động thẻ các khu vực
	insert into finalproject.tmp_accurate_accounting_card_income
	(kpi_month,report_id, area_code, total_value)
	-- hach toan chinh xac lai trong han cac khu vuc
	select  v_in_date_month as kpi_month,
			3 as report_id,
			substring(f.analysis_code,9,1) as area_code,
			sum(f.amount) as total_value
	from finalproject.fact_txn_month_raw_data f
	where (f.transaction_date between v_begining_year and in_date) and f.analysis_code like 'DVML%'
			  and f.account_code in ('702000030002','702000030001','702000030102')
	group by  substring(f.analysis_code,9,1)
	union
	-- hach toan chinh xac lai trong han cua head
	select  v_in_date_month as kpi_month,
			3 as report_id,
			'A' as area_code,
			sum(f.amount) as total_value
	from finalproject.fact_txn_month_raw_data f
	where (f.transaction_date between v_begining_year and in_date) and analysis_code like 'HEAD%'
			  and f.account_code in ('702000030002','702000030001','702000030102')
	union
	-- hach toan chinh xac lai qua han cac khu vuc
	select  v_in_date_month as kpi_month,
			4 as report_id,
			substring(f.analysis_code,9,1) as area_code,
			sum(f.amount) as total_value
	from finalproject.fact_txn_month_raw_data f
	where (f.transaction_date between v_begining_year and in_date) and analysis_code like 'DVML%'
			  and f.account_code in ('702000030012','702000030112')
	group by  substring(f.analysis_code,9,1)
	union
	-- hach toan chinh xac lai qua han cua head
	select  v_in_date_month as kpi_month,
			4 as report_id,
			'A' as area_code,
			sum(f.amount) as total_value
	from finalproject.fact_txn_month_raw_data f
	where (f.transaction_date between v_begining_year and in_date) and analysis_code like 'HEAD%'
			  and f.account_code in ('702000030012','702000030112')
	union
	-- hach toan chinh xac phi bao hiem cac khu vuc
	select  v_in_date_month as kpi_month,
			5 as report_id,
			substring(f.analysis_code,9,1) as area_code,
			sum(f.amount) as total_value
	from finalproject.fact_txn_month_raw_data f
	where (f.transaction_date between v_begining_year and in_date) and analysis_code like 'DVML%'
			  and f.account_code in ('716000000001')
	group by  substring(f.analysis_code,9,1)
	union
	-- hach toan chinh xac phi bao hiem cua head
	select  v_in_date_month as kpi_month,
			5 as report_id,
			'A' as area_code,
			sum(f.amount) as total_value
	from finalproject.fact_txn_month_raw_data f
	where (f.transaction_date between v_begining_year and in_date) and analysis_code like 'HEAD%'
			  and f.account_code in ('716000000001')
	union
	-- hach toan chinh xac phi tang han muc cac khu vuc
	select  v_in_date_month as kpi_month,
			6 as report_id,
			substring(f.analysis_code,9,1) as area_code,
			sum(f.amount) as total_value
	from finalproject.fact_txn_month_raw_data f
	where (f.transaction_date between v_begining_year and in_date) and analysis_code like 'DVML%'
			  and f.account_code in ('719000030002')
	group by  substring(f.analysis_code,9,1)
	union
	-- hach toan chinh xac phi tang han muc cua head
	select  v_in_date_month as kpi_month,
			6 as report_id,
			'A' as area_code,
			sum(f.amount) as total_value
	from finalproject.fact_txn_month_raw_data f
	where (f.transaction_date between v_begining_year and in_date) and analysis_code like 'HEAD%'
			  and f.account_code in ('719000030002')
	union
	-- hach toan chinh xac phi thanh toan cham khac cua khu vuc
	select  v_in_date_month as kpi_month,
			7 as report_id,
			substring(f.analysis_code,9,1) as area_code,
			sum(f.amount) as total_value
	from finalproject.fact_txn_month_raw_data f
	where (f.transaction_date between v_begining_year and in_date) and analysis_code like 'DVML%'
			  and f.account_code in ('719000030003','719000030103','790000030003','790000030103','790000030004','790000030104')
	group by  substring(f.analysis_code,9,1)
	union
	-- hach toan chinh xac phi thanh toan cham khac cua head
	select  v_in_date_month as kpi_month,
			7 as report_id,
			'A' as area_code,
			sum(f.amount) as total_value
	from finalproject.fact_txn_month_raw_data f
	where (f.transaction_date between v_begining_year and in_date) and analysis_code like 'HEAD%'
			  and f.account_code in ('719000030003','719000030103','790000030003','790000030103','790000030004','790000030104')
	;
   	-- 4.2. insert vào bảng tỷ lệ phân bổ tiêu chí trong thu nhập từ hoạt động thẻ các khu vực
	--4.2.1. insert vao bang dnck binh quan sau wo nhom 1
	insert into finalproject.tmp_total_os_db_grp_1_after_wo
	(kpi_month, area_code, avg_total_os_area, avg_total_os_all)
	select  v_in_date_month as kpi_month,
			x1.parent_id as area_code,
			x1.avg_total_os_area,
			x2.avg_total_os_all	
	from 	
	(	-- tinh trung binh du no cuoi ki trung binh theo tung khu vuc sau khi wo nhom 1 ( t2= avg(t1,t2) )
		select 	parent_id, v_in_date_month as kpi_month, avg(dnck_kv) as avg_total_os_area
		from
		(	-- tinh du no cuoi ki tu dau nam den thang hien tai theo tung nhom, tung khu vuc
			select d.parent_id,f2.kpi_month, sum(f2.outstanding_principal) as dnck_kv
			from finalproject.fact_kpi_month_raw_data f2
			join finalproject.dim_city_structure d on  d.danh_sach_vung = f2.pos_city
			where (f2.kpi_month between  v_begining_month_of_year and v_in_date_month ) and max_bucket = 1
			group by d.parent_id,f2.kpi_month
		)
		group by parent_id
	)x1
	join
	(		-- dnck trung binh toan hang ( t2= avg(t1,t2) )
		select v_in_date_month as kpi_month, avg(avg_dnck_toan_hang ) as avg_total_os_all
		from
		(
			select f2.kpi_month,sum(f2.outstanding_principal) as avg_dnck_toan_hang
			from finalproject.fact_kpi_month_raw_data f2
			where (f2.kpi_month between v_begining_month_of_year and v_in_date_month) and max_bucket = 1
			group by f2.kpi_month
		)
	)x2 on 1=1
	;
	--4.2.2. insert vao bang dnck binh quan sau wo nhom 2
	insert into finalproject.tmp_total_os_db_grp_2_after_wo
	(kpi_month, area_code, avg_total_os_area, avg_total_os_all)
	-- dnck sau wo nhom 2
	select  v_in_date_month as kpi_month,
			x3.parent_id as area_code,
			x3.avg_total_os_area,
			x4.avg_total_os_all	
	from 	
	(	-- tinh trung binh du no cuoi ki trung binh theo tung khu vuc sau khi wo nhom 2 ( t2= avg(t1,t2) )
		select 	parent_id, v_in_date_month as kpi_month, avg(dnck_kv) as avg_total_os_area
		from
		(	-- tinh du no cuoi ki tu dau nam den thang hien tai theo tung nhom, tung khu vuc
			select d.parent_id,f2.kpi_month, sum(f2.outstanding_principal) as dnck_kv
			from finalproject.fact_kpi_month_raw_data f2
			join finalproject.dim_city_structure d on  d.danh_sach_vung = f2.pos_city
			where (f2.kpi_month between  v_begining_month_of_year and v_in_date_month ) and max_bucket = 2
			group by d.parent_id,f2.kpi_month
		)
		group by parent_id
	)x3  
	join
	(		-- dnck trung binh toan hang ( t2= avg(t1,t2) )
		select v_in_date_month as kpi_month, avg(avg_dnck_toan_hang ) as avg_total_os_all
		from
		(
			select f2.kpi_month,sum(f2.outstanding_principal) as avg_dnck_toan_hang
			from finalproject.fact_kpi_month_raw_data f2
			where (f2.kpi_month between v_begining_month_of_year and v_in_date_month) and max_bucket = 2
			group by f2.kpi_month
		)
	)x4 on 1=1
	;
	--4.2.3. insert vao bang dnck binh quan sau wo nhom 2 -> 5
	insert into finalproject.tmp_total_os_db_grp_2_to_5_after_wo
	(kpi_month, area_code, avg_total_os_area, avg_total_os_all)
	-- dnck sau wo nhom 2-> 5
	select  v_in_date_month as kpi_month,
			x5.parent_id as area_code,
			x5.avg_total_os_area,
			x6.avg_total_os_all	
	from 	
	(	-- tinh trung binh du no cuoi ki trung binh theo tung khu vuc sau khi wo nhom 2-5 ( t2= avg(t1,t2) )
		select 	parent_id, v_in_date_month as kpi_month, avg(dnck_kv) as avg_total_os_area
		from
		(	-- tinh du no cuoi ki tu dau nam den thang hien tai theo tung nhom, tung khu vuc
			select d.parent_id,f2.kpi_month, sum(f2.outstanding_principal) as dnck_kv
			from finalproject.fact_kpi_month_raw_data f2
			join finalproject.dim_city_structure d on  d.danh_sach_vung = f2.pos_city
			where (f2.kpi_month between  v_begining_month_of_year and v_in_date_month ) and (max_bucket between 2 and 5)
			group by d.parent_id,f2.kpi_month
		)
		group by parent_id
	)x5 
	join
	(		-- dnck trung binh toan hang ( t2= avg(t1,t2) )
		select v_in_date_month as kpi_month, avg(avg_dnck_toan_hang ) as avg_total_os_all
		from
		(
			select f2.kpi_month,sum(f2.outstanding_principal) as avg_dnck_toan_hang
			from finalproject.fact_kpi_month_raw_data f2
			where (f2.kpi_month between v_begining_month_of_year and v_in_date_month) and  (max_bucket between 2 and 5)
			group by f2.kpi_month
		)
	)x6 on 1=1
	;
	--4.2.4. insert vao bang so luong the psdn
	-- the psdn
	insert into finalproject.the_psdn
	(area_code, kpi_month, so_the_psdn, so_the_psdn_toan_hang)
	select z.parent_id as area_code,
			z.kpi_month,
			z.so_the_psdn,
			d.so_the_psdn_toan_hang
	from
	(	
		 -- the psdn theo kv
			select parent_id,v_in_date_month as kpi_month, count(f2.psdn) as so_the_psdn
			from finalproject.fact_kpi_month_raw_data f2
			join finalproject.dim_city_structure d on f2.pos_city = d.danh_sach_vung
			where (f2.kpi_month between  v_begining_month_of_year and v_in_date_month ) and f2.psdn =1
			group by parent_id
	
	)z
	join
	(	
			-- the psdn toan hang
			select  count(f2.psdn) as so_the_psdn_toan_hang
			from finalproject.fact_kpi_month_raw_data f2
			where (f2.kpi_month between v_begining_month_of_year and v_in_date_month) and f2.psdn =1
	)d on 1=1
	;
	-- 4.3. insert vào bảng report 1 tong thu nhap tu hoat dong the
	--4.3.1. insert vao bang report tieu chi lai trong han
	insert into finalproject.report_tong_hop
	(area_code, kpi_month, report_id, total_value)
	select t1.area_code,
			t1.kpi_month,
			t1.report_id,
			t1.total_value + (x7.total_value*x8.rate_allocate) as total_value
	from finalproject.tmp_accurate_accounting_card_income t1
	join
	(
		-- lay ra gia tri hach toan chinh xac
		select total_value
		from finalproject.tmp_accurate_accounting_card_income
		where report_id = 3 and area_code = 'A'
	)x7 on 1=1
	join
	(		
		-- lay ra ty le phan bo
		select kpi_month,
				 area_code,
				avg_total_os_area/avg_total_os_all as rate_allocate
		from finalproject.tmp_total_os_db_grp_1_after_wo
	)x8 on t1.area_code = x8.area_code and t1.report_id = 3
	where t1.report_id = 3
	;
	
	--4.3.2. insert vao bang report tieu chi lai qua han
	insert into finalproject.report_tong_hop
	(area_code, kpi_month, report_id, total_value)
	select t1.area_code,
			t1.kpi_month,
			t1.report_id,
			t1.total_value + (x9.total_value*x10.rate_allocate) as total_value
	from finalproject.tmp_accurate_accounting_card_income t1
	join
	(
		-- lay ra gia tri hach toan chinh xac
		select total_value
		from finalproject.tmp_accurate_accounting_card_income
		where report_id = 4 and area_code = 'A'
	)x9 on 1=1
	join
	(		
		-- lay ra ty le phan bo
		select kpi_month,
				 area_code,
				avg_total_os_area/avg_total_os_all as rate_allocate
		from finalproject.tmp_total_os_db_grp_2_after_wo
	)x10 on t1.area_code = x10.area_code and t1.report_id = 4
	where t1.report_id = 4
	;
	--4.3.3. insert vao bang report tieu chi phi bao hiem
	insert into finalproject.report_tong_hop
	(area_code, kpi_month, report_id, total_value)
	 select t1.area_code,
			t1.kpi_month,
			t1.report_id,
			t1.total_value + (x11.total_value*x12.rate_allocate) as total_value
	from finalproject.tmp_accurate_accounting_card_income t1
	join
	(
		-- lay ra gia tri hach toan chinh xac
		select total_value
		from finalproject.tmp_accurate_accounting_card_income
		where report_id = 5 and area_code = 'A'
	)x11 on 1=1
	join
	(		
		-- lay ra ty le phan bo
		select kpi_month,
				 area_code,
				so_the_psdn/so_the_psdn_toan_hang::float8 as rate_allocate
		from finalproject.the_psdn
	)x12 on t1.area_code = x12.area_code and t1.report_id = 5
	where t1.report_id = 5
	;
	--4.3.4. insert vao bang report tieu chi phi tang han muc
	insert into finalproject.report_tong_hop
	(area_code, kpi_month, report_id, total_value)
	select t1.area_code,
			t1.kpi_month,
			t1.report_id,
			t1.total_value + (x13.total_value*x14.rate_allocate) as total_value
	from finalproject.tmp_accurate_accounting_card_income t1
	join
	(
		-- lay ra gia tri hach toan chinh xac
		select total_value
		from finalproject.tmp_accurate_accounting_card_income
		where report_id = 6 and area_code = 'A'
	)x13 on 1=1
	join
	(		
		-- lay ra ty le phan bo
		select kpi_month,
				 area_code,
				avg_total_os_area/avg_total_os_all as rate_allocate
		from finalproject.tmp_total_os_db_grp_1_after_wo
	)x14 on t1.area_code = x14.area_code and t1.report_id = 6
	where t1.report_id = 6
	;
	--4.3.5. insert vao bang report tieu chi phi thanh toan cham khac
	insert into finalproject.report_tong_hop
	(area_code, kpi_month, report_id, total_value)
	select t1.area_code,
			t1.kpi_month,
			t1.report_id,
			t1.total_value + (x15.total_value*x16.rate_allocate) as total_value
	from finalproject.tmp_accurate_accounting_card_income t1
	join
	(
		-- lay ra gia tri hach toan chinh xac
		select total_value
		from finalproject.tmp_accurate_accounting_card_income
		where report_id = 7 and area_code = 'A'
	)x15 on 1=1
	join
	(		
		-- lay ra ty le phan bo
		select kpi_month,
				 area_code,
				avg_total_os_area/avg_total_os_all as rate_allocate
		from finalproject.tmp_total_os_db_grp_2_to_5_after_wo
	)x16 on t1.area_code = x16.area_code and t1.report_id = 7
	where t1.report_id = 7
	;
	-- bước 5: chi phí kinh doanh vốn
	-- 5.1. insert vào bảng hạch toán chính xác các tiêu chí về chi phí kinh doanh vốn các khu vực
	
	insert into finalproject.tmp_accurate_accounting_captial_business
	(kpi_month, report_id, area_code, total_value)
	-- tong doanh thu nguon von toan hang
	select  v_in_date_month as kpi_month,
			9 as report_id,
			'NO' as area_code,
			sum(f.amount) as total_value
	from finalproject.fact_txn_month_raw_data f
	where (f.transaction_date between v_begining_year and in_date)
			  and f.account_code in  ('702000040001','702000040002','703000000001','703000000002','703000000003','703000000004', '721000000041',
								'721000000037','721000000039','721000000013','721000000014','721000000036','723000000014', '723000000037',
								'821000000014','821000000037','821000000039','821000000041','821000000013','821000000036','823000000014',
								'823000000037','741031000001','741031000002','841000000001','841000000005','841000000004','701000000001',
								'701000000002','701037000001','701037000002','701000000101')
	union
	-- hach toan cua chi phi von thi truong 2
	select  v_in_date_month as kpi_month,
			10 as report_id,
			'A' as area_code,
			sum(f.amount) as total_value
	from finalproject.fact_txn_month_raw_data f
	where (f.transaction_date between v_begining_year and in_date) and analysis_code like 'HEAD%'
			  and f.account_code in ('801000000001','802000000001')
	union
	-- hach toan cua chi phi von thi truong 1
	select  v_in_date_month as kpi_month,
			11 as report_id,
			'A' as area_code,
			coalesce(sum(f.amount),0) as total_value
	from finalproject.fact_txn_month_raw_data f
	where (f.transaction_date between v_begining_year and in_date) and analysis_code like 'HEAD%'
			  and f.account_code in ('802000000002','802000000003','802014000001','802037000001')
	union
	-- hach toan cua chi phi von cctg
	select  v_in_date_month as kpi_month,
			12 as report_id,
			'A' as area_code,
			sum(f.amount) as total_value
	from finalproject.fact_txn_month_raw_data f
	where (f.transaction_date between v_begining_year and in_date) and analysis_code like 'HEAD%'
			  and f.account_code in ('803000000001')
		;
	
	-- 5.2. insert vào bảng tỷ lệ phân bổ tiêu chí trong chi phí kinh doanh vốn các khu vực
	insert into finalproject.tmp_allocate_capital_business
	(kpi_month, area_code, card_income, interest_credit_card)
	select x17.kpi_month,
			x17.area_code,
			x17.card_income,
			x18.interest_credit_card
	from
	(	-- thu nhap tu hoat dong the DVML
		select area_code,kpi_month,sum(total_value) as card_income
		from finalproject.report_tong_hop r
		where (report_id between 3 and 7 ) and kpi_month = v_in_date_month
		group by area_code,kpi_month
	)x17
	join
	(
		-- lai thu tu the vay toan hang
		select sum(total_value) as interest_credit_card
		from finalproject.report_tong_hop r
		where area_code <> 'A' and (report_id between 3 and 7 ) and kpi_month = v_in_date_month
	)x18 on 1=1
	;
	-- 5.3. insert vào bảng report 1 cac tieu chi cua chi phí kinh doanh vốn
	--5.3.1. insert vao bang report doanh thu nguon von
	insert into finalproject.report_tong_hop
	(area_code, kpi_month, report_id, total_value)
	select t1.area_code,
			t1.kpi_month,
			9 as report_id,
			0 as total_value
	from finalproject.tmp_allocate_capital_business t1
	;
	
	--5.3.2. insert vao bang report cp von tt2
	insert into finalproject.report_tong_hop
	(area_code, kpi_month, report_id, total_value)
	select t1.area_code,
			t1.kpi_month,
			t2.report_id,
			(t2.total_value)::float8*(t1.card_income::float8/(x19.revenue_capital + t1.interest_credit_card)) as total_value
		from finalproject.tmp_allocate_capital_business t1
		join finalproject.tmp_accurate_accounting_captial_business t2 on 1=1
		join
		(
			select total_value as revenue_capital
			from finalproject.tmp_accurate_accounting_captial_business
			where report_id = 9
		)x19 on 1=1
		where t2.report_id = 10
	
	;
	
	--5.3.3.insert vao bang report cp von tt1
	insert into finalproject.report_tong_hop
	(area_code, kpi_month, report_id, total_value)
	select t1.area_code,
			t1.kpi_month,
			t2.report_id,
			(t2.total_value*t1.card_income)::float8/(x20.revenue_capital + t1.interest_credit_card) as total_value
	from finalproject.tmp_allocate_capital_business t1
	join finalproject.tmp_accurate_accounting_captial_business t2 on 1=1
	join
	(
		select total_value as revenue_capital
		from finalproject.tmp_accurate_accounting_captial_business
		where report_id = 9
	)x20 on 1=1
	where t2.report_id = 11
	;
	
	--5.3.4..insert vao bang report cp von cctg
	insert into finalproject.report_tong_hop
	(area_code, kpi_month, report_id, total_value)
	select t1.area_code,
			t1.kpi_month,
			t2.report_id,
			(t2.total_value*t1.card_income)::float8/(x21.revenue_capital + t1.interest_credit_card) as total_value
	from finalproject.tmp_allocate_capital_business t1
	join finalproject.tmp_accurate_accounting_captial_business t2 on 1=1
	join
	(
		select total_value as revenue_capital
		from finalproject.tmp_accurate_accounting_captial_business
		where report_id = 9
	)x21 on 1=1
	where t2.report_id = 12
	;
	
	-- bước 6: chi phí thuần hoạt động khác
	-- 6.1. insert vào bảng hạch toán chính xác tiêu chí trong chi phí thuần hoạt động khác
	insert into finalproject.tmp_accurate_accounting_net_other_operating_expenses
	(kpi_month, report_id, area_code, total_value)
	-- hach toan chinh xac doanh thu kinh doanh
	select  v_in_date_month as kpi_month,
			16 as report_id,
			substring(f.analysis_code,9,1) as area_code,
			sum(f.amount) as total_value
	from finalproject.fact_txn_month_raw_data f
	where (f.transaction_date between v_begining_year and in_date) and analysis_code like 'DVML%'
			  and f.account_code in ('702000010001','702000010002','704000000001','705000000001','709000000001','714000000002','714000000003',
							'714037000001','714000000004','714014000001','715000000001','715037000001','719000000001','709000000101','719000000101')
	group by  substring(f.analysis_code,9,1)
	union
	-- hach toan chinh xac doanh thu kinh doanh cua head
	select  v_in_date_month as kpi_month,
			16 as report_id,
			'A' as area_code,
			sum(f.amount) as total_value
	from finalproject.fact_txn_month_raw_data f
	where (f.transaction_date between v_begining_year and in_date) and analysis_code like 'HEAD%'
			  and f.account_code in ('702000010001','702000010002','704000000001','705000000001','709000000001','714000000002','714000000003',
							'714037000001','714000000004','714014000001','715000000001','715037000001','719000000001','709000000101','719000000101')
	union
	-- hach toan chinh xac chi phi hoa hong
	select  v_in_date_month as kpi_month,
			17 as report_id,
			substring(f.analysis_code,9,1) as area_code,
			sum(f.amount) as total_value
	from finalproject.fact_txn_month_raw_data f
	where (f.transaction_date between v_begining_year and in_date) and analysis_code like 'DVML%'
			  and f.account_code in ('816000000001','816000000002','816000000003')
	group by  substring(f.analysis_code,9,1)
	union
	-- hach toan chinh xac chi phi hoa hong cua head
	select  v_in_date_month as kpi_month,
			17 as report_id,
			'A' as area_code,
			sum(f.amount) as total_value
	from finalproject.fact_txn_month_raw_data f
	where (f.transaction_date between v_begining_year and in_date) and analysis_code like 'HEAD%'
			  and f.account_code in ('816000000001','816000000002','816000000003')
	union 	
	-- hach toan chinh xac chi phi thuan kinh doanh khac
	select  v_in_date_month as kpi_month,
			18 as report_id,
			substring(f.analysis_code,9,1) as area_code,
			sum(f.amount) as total_value
	from finalproject.fact_txn_month_raw_data f
	where (f.transaction_date between v_begining_year and in_date) and analysis_code like 'DVML%'
			  and f.account_code in ('809000000002','809000000001','811000000001','811000000102','811000000002','811014000001','811037000001',
								'811039000001',	'811041000001','815000000001','819000000002','819000000003','819000000001','790000000003','790000050101',
								'790000000101','790037000001','849000000001','899000000003','899000000002','811000000101','819000060001')
	group by  substring(f.analysis_code,9,1)
	union
	-- hach toan chinh xac chi phi thuan kinh doanh khac cua head
	select  v_in_date_month as kpi_month,
			18 as report_id,
			'A' as area_code,
			sum(f.amount) as total_value
	from finalproject.fact_txn_month_raw_data f
	where (f.transaction_date between v_begining_year and in_date) and analysis_code like 'HEAD%'
			  and f.account_code in ('809000000002','809000000001','811000000001','811000000102','811000000002','811014000001','811037000001',
								'811039000001',	'811041000001','815000000001','819000000002','819000000003','819000000001','790000000003','790000050101',
								'790000000101','790037000001','849000000001','899000000003','899000000002','811000000101','819000060001')
	
		;
	
	-- 6.2. insert vào bảng tỷ lệ phân bổ tiêu chí trong chi phí thuần hoạt động khác
	insert into finalproject.tmp_total_os_db_after_wo
	(kpi_month, area_code, avg_total_os_area, avg_total_os_all)
	select  v_in_date_month as kpi_month,
			x1.parent_id as area_code,
			x1.avg_total_os_area,
			x2.avg_total_os_all	
	from 	
	(	
		-- tinh trung binh du no cuoi ki trung binh theo tung khu vuc sau khi wo nhom 1 ( t2= avg(t1,t2) )
		select 	parent_id, v_in_date_month as kpi_month, avg(dnck_kv) as avg_total_os_area
		from
		(	-- tinh du no cuoi ki tu dau nam den thang hien tai theo tung nhom, tung khu vuc
			select d.parent_id,f2.kpi_month, sum(f2.outstanding_principal) as dnck_kv
			from finalproject.fact_kpi_month_raw_data f2
			join finalproject.dim_city_structure d on  d.danh_sach_vung = f2.pos_city
			where (f2.kpi_month between v_begining_month_of_year and v_in_date_month )
			group by d.parent_id,f2.kpi_month
		)
		group by parent_id
	)x1
	join
	(		-- dnck trung binh toan hang ( t2= avg(t1,t2) )
		select v_in_date_month as kpi_month, avg(avg_dnck_toan_hang ) as avg_total_os_all
		from
		(
			select f2.kpi_month,sum(f2.outstanding_principal) as avg_dnck_toan_hang
			from finalproject.fact_kpi_month_raw_data f2
			where (f2.kpi_month between v_begining_month_of_year and v_in_date_month)
			group by f2.kpi_month
		)
	)x2 on 1=1
	;
	-- 6.3. insert vào bảng report 1 cac tieu chi cua chi phí thuần hoạt động khác
	--6.3.1. insert vao bang report chi tieu DT Fintech 
	insert into finalproject.report_tong_hop
	(area_code, kpi_month, report_id, total_value)
	select area_code,
		 	kpi_month,
			14 as report_id,
			0 as total_value
	from finalproject.tmp_total_os_db_after_wo
	;
	
	--6.3.2. insert vao bang report chi tieu DT tiểu thương, cá nhân 
	insert into finalproject.report_tong_hop
	(area_code, kpi_month, report_id, total_value)
	select area_code,
		 	kpi_month,
			15 as report_id,
			0 as total_value
	from finalproject.tmp_total_os_db_after_wo
	;
	-- 6.3.3. insert vao bang report chi tieu doanh thu kinh doanh
	insert into finalproject.report_tong_hop
	(area_code, kpi_month, report_id, total_value)
	select  t1.area_code,
			t1.kpi_month,
			t2.report_id,
			t2.total_value + (x.total_value*t1.avg_total_os_area)/t1.avg_total_os_all as total_value
	from finalproject.tmp_total_os_db_after_wo t1
	join finalproject.tmp_accurate_accounting_net_other_operating_expenses t2 on t1.area_code = t2.area_code and t2.report_id = 16
	join
	(
		select total_value
		from finalproject.tmp_accurate_accounting_net_other_operating_expenses
		where report_id = 16 and area_code = 'A'
	)x on 1=1
	;
	--6.3.4.insert vao bang report chi tieu CP hoa hồng 
	insert into finalproject.report_tong_hop
	(area_code, kpi_month, report_id, total_value)
	select  t1.area_code,
			t1.kpi_month,
			t2.report_id,
			t2.total_value + (x.total_value*t1.avg_total_os_area)/t1.avg_total_os_all as total_value
	from finalproject.tmp_total_os_db_after_wo t1
	join finalproject.tmp_accurate_accounting_net_other_operating_expenses t2 on t1.area_code = t2.area_code and t2.report_id = 17
	join
	(
		select total_value
		from finalproject.tmp_accurate_accounting_net_other_operating_expenses
		where report_id = 17 and area_code = 'A'
	)x on 1=1
	;
	--6.3.5.insert vao bang report chi tieu CP thuần KD khác 
	insert into finalproject.report_tong_hop
	(area_code, kpi_month, report_id, total_value)
	select  t1.area_code,
			t1.kpi_month,
			t2.report_id,
			t2.total_value + (x.total_value*t1.avg_total_os_area)/t1.avg_total_os_all as total_value
	from finalproject.tmp_total_os_db_after_wo t1
	join finalproject.tmp_accurate_accounting_net_other_operating_expenses t2 on t1.area_code = t2.area_code and t2.report_id = 18
	join
	(
		select total_value
		from finalproject.tmp_accurate_accounting_net_other_operating_expenses
		where report_id = 18 and area_code = 'A'
	)x on 1=1
	;
	--6.3.6.insert vao bang report chi tieu CP hợp tác kd tàu (net) 
	insert into finalproject.report_tong_hop
	(area_code, kpi_month, report_id, total_value)
	select area_code,
		 	kpi_month,
			19 as report_id,
			0 as total_value
	from finalproject.tmp_total_os_db_after_wo
	;
	-- bước 7: tổng chi phí hoạt động
	-- 7.1. insert vào bảng so_nhan_vien 	
	
	insert into finalproject.number_of_employees
	(area_code, kpi_month, no_of_employees_area, no_of_employees_all)
	select case
				when k.area_name ='Đông Bắc Bộ' then 'B'
				when k.area_name ='Tây Bắc Bộ' then 'C'
				when k.area_name ='Đồng Bằng Sông Hồng' then 'D'
				when k.area_name ='Bắc Trung Bộ' then 'E'
				when k.area_name ='Nam Trung Bộ' then 'F'
				when k.area_name ='Tây Nam Bộ' then 'G'
				when k.area_name ='Đông Nam Bộ' then 'H'
			END as area_code,
			v_in_date_month as kpi_month,
			k.so_nhan_vien as no_of_employees_area,
			j.so_nhan_vien_toan_hang as no_of_employees_all
	from
	(
		select area_name, count(distinct email) as so_nhan_vien
		from finalproject.kpi_asm_data
	-- boi vi co the tháng cần làm bao cao nhan vien do chua lam viec
		where (v_in_date_month = '202301' and jan_ltn is not null) or (v_in_date_month = '202302' and feb_ltn is not null) or
				 (v_in_date_month = '202303' and mar_ltn is not null) or (v_in_date_month = '202304' and apr_ltn is not null)
				or (v_in_date_month = '202305' and may_ltn is not null)
		group by area_name
	)k
	join
	(
		select count(distinct k.email) as so_nhan_vien_toan_hang
		from finalproject.kpi_asm_data k
		where (v_in_date_month = '202301' and jan_ltn is not null) or (v_in_date_month = '202302' and feb_ltn is not null) or
				 (v_in_date_month = '202303' and mar_ltn is not null) or (v_in_date_month = '202304' and apr_ltn is not null)
				or (v_in_date_month = '202305' and may_ltn is not null)
	)j on 1=1
	
	;
	
	-- 7.2. insert vào bảng hạch toán chính xác trong tổng chi phí hoạt động
	insert into finalproject.tmp_accurate_accounting_operating_expenses
	(kpi_month, report_id, area_code, total_value)
	-- hach toan chinh xac chi phi nhan vien
	select  v_in_date_month as kpi_month,
			23 as report_id,
			substring(f.analysis_code,9,1) as area_code,
			sum(f.amount) as total_value
	from finalproject.fact_txn_month_raw_data f
	where (f.transaction_date between v_begining_year and in_date) and analysis_code like 'DVML%'
			  and f.account_code like '85%'
	group by  substring(f.analysis_code,9,1)
	union
	-- hach toan chinh xac chi phi nhan vien  cua head
	select  v_in_date_month as kpi_month,
			23 as report_id,
			'A' as area_code,
			sum(f.amount) as total_value
	from finalproject.fact_txn_month_raw_data f
	where (f.transaction_date between v_begining_year and in_date) and analysis_code like 'HEAD%'
			  and f.account_code like '85%'
	union
	-- hach toan chinh xac CP quản lý
	select  v_in_date_month as kpi_month,
			24 as report_id,
			substring(f.analysis_code,9,1) as area_code,
			sum(f.amount) as total_value
	from finalproject.fact_txn_month_raw_data f
	where (f.transaction_date between v_begining_year and in_date) and analysis_code like 'DVML%'
			  and f.account_code like '86%'
	group by  substring(f.analysis_code,9,1)
	union
	-- hach toan chinh xac CP quản lý cua head
	select  v_in_date_month as kpi_month,
			24 as report_id,
			'A' as area_code,
			sum(f.amount) as total_value
	from finalproject.fact_txn_month_raw_data f
	where (f.transaction_date between v_begining_year and in_date) and analysis_code like 'HEAD%'
			  and f.account_code like '86%'
	union
	-- hach toan chinh xac CP tài sản
	select  v_in_date_month as kpi_month,
			25 as report_id,
			substring(f.analysis_code,9,1) as area_code,
			sum(f.amount) as total_value
	from finalproject.fact_txn_month_raw_data f
	where (f.transaction_date between v_begining_year and in_date) and analysis_code like 'DVML%'
			  and f.account_code like '87%'
	group by  substring(f.analysis_code,9,1)
	union
	-- hach toan chinh xac CP tài sản cua head
	select  v_in_date_month as kpi_month,
			25 as report_id,
			'A' as area_code,
			sum(f.amount) as total_value
	from finalproject.fact_txn_month_raw_data f
	where (f.transaction_date between v_begining_year and in_date) and analysis_code like 'HEAD%'
			  and f.account_code like '87%'
	;
	-- 7.3. insert vào bảng report 1 cac tieu chi cua tổng chi phí hoạt động
	--7.3.1. insert vao bang report tieu chi CP thuế, phí
	insert into finalproject.report_tong_hop
	(area_code, kpi_month, report_id, total_value)
	select area_code,
			 kpi_month,
			22 as report_id,
			0 as total_value
	from finalproject.number_of_employees
	;
	--7.3.2.insert vao bang report tieu chi CP nhân viên
	insert into finalproject.report_tong_hop
	(area_code, kpi_month, report_id, total_value)
	select t1.area_code,
			t1.kpi_month,
			t1.report_id,
			t1.total_value + (x.total_value*n.no_of_employees_area)/n.no_of_employees_all as total_value
	from finalproject.tmp_accurate_accounting_operating_expenses t1
	join finalproject.number_of_employees n on t1.area_code = n.area_code and t1.report_id = 23 and n.kpi_month = t1.kpi_month
	join
	(
		select total_value
		from finalproject.tmp_accurate_accounting_operating_expenses
		where report_id = 23 and area_code = 'A'
	)x on 1=1
	where t1.report_id = 23
		;
	--7.3.3.insert vao bang report tieu chi CP quản lý
	insert into finalproject.report_tong_hop
	(area_code, kpi_month, report_id, total_value)
	select t1.area_code,
			t1.kpi_month,
			t1.report_id,
			t1.total_value + (x.total_value*n.no_of_employees_area)/n.no_of_employees_all as total_value
	from finalproject.tmp_accurate_accounting_operating_expenses t1
	join finalproject.number_of_employees n on t1.area_code = n.area_code and t1.report_id = 24
	join
	(
		select total_value
		from finalproject.tmp_accurate_accounting_operating_expenses
		where report_id = 24 and area_code = 'A'
	)x on 1=1
	where t1.report_id = 24
		;
	--7.3.4.insert vao bang report tieu chi CP tài sản
	insert into finalproject.report_tong_hop
	(area_code, kpi_month, report_id, total_value)
	select t1.area_code,
			t1.kpi_month,
			t1.report_id,
			t1.total_value + (x.total_value*n.no_of_employees_area)/n.no_of_employees_all as total_value
	from finalproject.tmp_accurate_accounting_operating_expenses t1
	join finalproject.number_of_employees n on t1.area_code = n.area_code and t1.report_id = 25 and n.kpi_month = t1.kpi_month
	join
	(
		select total_value
		from finalproject.tmp_accurate_accounting_operating_expenses
		where report_id = 24 and area_code = 'A'
	)x on 1=1
	where t1.report_id = 25
		;
	-- bước 8: chi phí dự phòng
	-- 8.1. insert vào bảng hạch toán chính xác trong chi phí dự phòng
	insert into finalproject.tmp_accurate_accounting_provision_expenses
	(kpi_month, report_id, area_code, total_value)
	-- hach toan chinh xac chi phi du phong
	select  v_in_date_month as kpi_month,
			26 as report_id,
			substring(f.analysis_code,9,1) as area_code,
			sum(f.amount) as total_value
	from finalproject.fact_txn_month_raw_data f
	where (f.transaction_date between v_begining_year and in_date) and analysis_code like 'DVML%'
			  and f.account_code in ('790000050001', '882200050001', '790000030001','882200030001', '790000000001', '790000020101', '882200000001',
								'882200050101', '882200020101', '882200060001','790000050101', '882200030101')
	group by  substring(f.analysis_code,9,1)
	union
	-- hach toan chinh xac chi phi du phong cua head
	select  v_in_date_month as kpi_month,
			26 as report_id,
			'A' as area_code,
			sum(f.amount) as total_value
	from finalproject.fact_txn_month_raw_data f
	where (f.transaction_date between v_begining_year and in_date) and analysis_code like 'HEAD%'
			  and f.account_code in ('790000050001', '882200050001', '790000030001','882200030001', '790000000001', '790000020101', '882200000001',
								'882200050101', '882200020101', '882200060001','790000050101', '882200030101')
	
		;
	-- 8.2. insert vào bảng tỷ lệ phân bổ tiêu chí trong chi phí dự phòng
	--8.2.1. insert vao bang wo luy ke wo_by_month_grp_2_to_5 ( su dung bang nay tinh luy ke )
	insert into finalproject.wo_by_month
	(area_code, kpi_month, write_off_month, wo_by_month)
	-- tinh so tien wo theo thang, theo tung khu vuc
	select d.parent_id as area_code,
			f2.kpi_month,
			f2.write_off_month,
			sum(write_off_balance_principal) as wo_by_month
	from finalproject.fact_kpi_month_raw_data f2
	join finalproject.dim_city_structure d on f2.pos_city = d.danh_sach_vung
	where  (f2.kpi_month between v_begining_month_of_year and v_in_date_month )
		and (f2.write_off_month  between v_begining_month_of_year and v_in_date_month) -- thang wo
		and (f2.kpi_month = f2.write_off_month)
	group by d.parent_id,f2.kpi_month,f2.write_off_month
	union
	-- tinh so tien wo theo thangs, theo head
	select 'ALL' as area_code,
			f2.kpi_month,
			f2.write_off_month,
			sum(write_off_balance_principal) as wo_by_month
	from finalproject.fact_kpi_month_raw_data f2
	where  (f2.kpi_month between v_begining_month_of_year and v_in_date_month )
		and (f2.write_off_month  between v_begining_month_of_year and v_in_date_month) -- thang wo
		and (f2.kpi_month = f2.write_off_month)
	group by f2.kpi_month,f2.write_off_month
	;
	-- update cot wo_luyke cho bang finalproject.wo_by_month_grp_2_to_5
	update finalproject.wo_by_month
	set wo_luyke = x.wo_luyke
		from
			(
				select area_code,
						 kpi_month,
					-- ham sum() over tinh luy ke
					 sum(wo_by_month) over (partition by area_code order by kpi_month) as wo_luyke
				from finalproject.wo_by_month
			) x
	where x.area_code = finalproject.wo_by_month.area_code
			and x.kpi_month = finalproject.wo_by_month.kpi_month and x.area_code is not null and x.kpi_month is not null
	
	;
	--8.2.2. insert vao bang raw os_bef_wo
	insert into finalproject.os_bef_wo
	(area_code, kpi_month, os_bef_wo, avg_total_os_all)
	select l.parent_id as area_code,
			l.kpi_month,
			l.avg_total_os_area + s.wo_luyke as os_bef_wo,
			o1.avg_total_os_all + k.wo_luyke as avg_total_os_all
	from
	(			-- tinh avg_total_os_area tu dau nam den thang xet, tung khu vuc theo nhom 2->5 ( t2= avg(t1,t2) )
			-- tinh du no cuoi ki tu dau nam den thang hien tai theo tung nhom, tung khu vuc
			select d.parent_id,f2.kpi_month, sum(f2.outstanding_principal) as avg_total_os_area
			from finalproject.fact_kpi_month_raw_data f2
			join finalproject.dim_city_structure d on  d.danh_sach_vung = f2.pos_city
			where (f2.kpi_month between v_begining_month_of_year and v_in_date_month ) and (f2.max_bucket between 2 and 5)
			group by d.parent_id,f2.kpi_month
	)l
	join finalproject.wo_by_month s on s.area_code = l.parent_id and s.kpi_month = l.kpi_month
	join
	(
		select area_code , kpi_month , wo_luyke
		from finalproject.wo_by_month
		where area_code = 'ALL'
	)k on k.kpi_month = s.kpi_month
	join
	(		-- dnck trung binh toan hang ( t2= avg(t1,t2) )
		
			select f2.kpi_month,sum(f2.outstanding_principal) as avg_total_os_all
			from finalproject.fact_kpi_month_raw_data f2
			where (f2.kpi_month between v_begining_month_of_year and v_in_date_month) and  (f2.max_bucket between 2 and 5)
			group by f2.kpi_month
		
	)o1 on o1.kpi_month = l.kpi_month
	;
	--8.2.3. insert vao bang avg_os_bef_wo
	insert into finalproject.total_os_bef_wo
	(area_code, kpi_month, total_os_area_bef_wo, total_os_all)
	select area_code,
			v_in_date_month as kpi_month,
			sum(os_bef_wo) as total_os_area_bef_wo,
			sum(avg_total_os_all) as total_os_all
	from finalproject.os_bef_wo
	group by area_code
	;
	-- 8.3. insert vào bảng report 1 cac tieu chi cua chi phí dự phòng
	insert into finalproject.report_tong_hop
	(area_code, kpi_month, report_id, total_value)
	select t1.area_code,
			t1.kpi_month,
			t1.report_id,
			t1.total_value + (x.total_value*a.total_os_area_bef_wo)::float8/a.total_os_all as total_value
	from finalproject.tmp_accurate_accounting_provision_expenses t1
	join finalproject.total_os_bef_wo a on t1.area_code = a.area_code and t1.kpi_month = a.kpi_month
	join
	(
		select total_value
		from finalproject.tmp_accurate_accounting_provision_expenses
		where area_code = 'A'
	)x on 1=1
	;
	-- buoc 10. insert vao report tieu chi hoi so 'A'
	insert into finalproject.report_tong_hop
	(area_code, kpi_month, report_id, total_value)
	-- id 3-> 7
	select 'A' as area_code,
			t1.kpi_month,
			t1.report_id,
			t1.total_value as total_value
	from finalproject.tmp_accurate_accounting_card_income t1
	where t1.area_code = 'A'
	union
	-- id 9
	select 'A' as area_code,
			t2.kpi_month,
			'9' as report_id,
			0 as total_value
	from finalproject.tmp_accurate_accounting_captial_business t2
	union
	-- id 10-> 12
	select 'A' as area_code,
			t2.kpi_month,
			t2.report_id,
			t2.total_value as total_value
	from finalproject.tmp_accurate_accounting_captial_business t2
	where t2.area_code = 'A'
	union
	-- id 14
	select 'A' as area_code,
			t3.kpi_month,
			'14' as report_id,
			0 as total_value
	from finalproject.tmp_accurate_accounting_net_other_operating_expenses t3
	union
	-- id 15
	select 'A' as area_code,
			t3.kpi_month,
			'15' as report_id,
			0 as total_value
	from finalproject.tmp_accurate_accounting_net_other_operating_expenses t3
	union
	-- id 16, 17,18
	select 'A' as area_code,
			t3.kpi_month,
			t3.report_id,
			t3.total_value as total_value
	from finalproject.tmp_accurate_accounting_net_other_operating_expenses t3
	where t3.area_code = 'A'
	union
	-- id 19
	select 'A' as area_code,
			t3.kpi_month,
			'19' as report_id,
			0 as total_value
	from finalproject.tmp_accurate_accounting_net_other_operating_expenses t3
	union
	-- id 22
	select 'A' as area_code,
			t4.kpi_month,
			'22' as report_id,
			0 as total_value
	from finalproject.tmp_accurate_accounting_operating_expenses t4
	union
	-- id 23,24,25
	select 'A' as area_code,
			t4.kpi_month,
			t4.report_id,
			t4.total_value as total_value
	from finalproject.tmp_accurate_accounting_operating_expenses t4
	where t4.area_code = 'A'
	union
	-- id 26
	select 'A' as area_code,
			t5.kpi_month,
			t5.report_id,
			t5.total_value as total_value
	from finalproject.tmp_accurate_accounting_provision_expenses t5
	where t5.area_code = 'A'
	;
	-- bước 10: insert vào report tieu chi report level 1
	insert into finalproject.report_tong_hop
	(area_code, kpi_month, report_id, total_value)
	-- tinh tieu chi level 1 Thu nhập từ hoạt động thẻ 
	select area_code,
			kpi_month,
			2 as report_id,
			sum(coalesce(total_value,0)) as total_value
	from finalproject.report_tong_hop
	where (report_id between 3 and 7) and kpi_month = v_in_date_month
	group by area_code, kpi_month
	union
	-- tinh tieu chi level 1 Chi phí thuần KDV 
	select area_code,
			kpi_month,
			8 as report_id,
			sum(coalesce(total_value,0)) as total_value
	from finalproject.report_tong_hop
	where (report_id between 9 and 12) and kpi_month = v_in_date_month
	group by area_code, kpi_month
	union
	-- tinh tieu chi level 1 Chi phí thuần hoạt động khác 
	select area_code,
			kpi_month,
			13 as report_id,
			sum(coalesce(total_value,0)) as total_value
	from finalproject.report_tong_hop
	where (report_id between 14 and 19) and kpi_month = v_in_date_month
	group by area_code, kpi_month
	union
	-- tinh tieu chi level 1 Tổng chi phí hoạt động
	select area_code,
			kpi_month,
			21 as report_id,
			sum(coalesce(total_value,0)) as total_value
	from finalproject.report_tong_hop
	where (report_id between 22 and 25) and kpi_month = v_in_date_month
	group by area_code, kpi_month
	
	;
	-- tinh tieu chi level 1 Tổng thu nhập hoạt động
	insert into finalproject.report_tong_hop
	(area_code, kpi_month, report_id, total_value)
	select area_code,
			kpi_month,
			20 as report_id,
			sum(coalesce(total_value,0)) as total_value
	from finalproject.report_tong_hop
	where (report_id in (2,8,13)) and kpi_month = v_in_date_month
	group by area_code, kpi_month
	;
	-- tinh tieu chi level 0 Lợi nhuận trước thuế
	insert into finalproject.report_tong_hop
	(area_code, kpi_month, report_id, total_value)
	select area_code,
			kpi_month,
			1 as report_id,
			sum(coalesce(total_value,0)) as total_value
	from finalproject.report_tong_hop
	where (report_id in (20,21,26)) and kpi_month = v_in_date_month
	group by area_code, kpi_month
	;
	-- B11. insert vao bang cac chi so tai chinh
	insert into finalproject.index_finance
	(area_code, kpi_month, cir, margin, return_of_capital, avg_profit_per_employee)
	SELECT
   x.area_code,
   x.kpi_month,
   CASE WHEN y.total_operating_income = 0 THEN 0
        ELSE -((x.total_operating_expenses*100)::float8 / (y.total_operating_income) )
   END AS cir,
  
   CASE WHEN q.tong_mau_margin = 0 THEN 0
        ELSE ((z.profit_bef_tax*100)::float8 / (q.tong_mau_margin) )
   END AS margin,
  
   CASE WHEN w.net_operating_expenses = 0 THEN 0
        ELSE -((z.profit_bef_tax*100)::float8 / (w.net_operating_expenses) )
   END AS return_of_capital,
  
   CASE WHEN e.no_of_employees_area = 0 THEN 0
        ELSE ((z.profit_bef_tax)::float8 / (e.no_of_employees_area) )
   END AS avg_profit_per_employee
	from	
	(	-- tong cp hoat dong
		select area_code,
				kpi_month,
				total_value as total_operating_expenses
		from  finalproject.report_tong_hop
		where (report_id = 21) and kpi_month = v_in_date_month
	)x
	join
	(	-- tong thu nhap hd
		select area_code,
				kpi_month,
				total_value as total_operating_income
		from  finalproject.report_tong_hop
		where (report_id = 20) and kpi_month = v_in_date_month
	)y on x.area_code = y.area_code
	join
	( 	-- loi nhuan truoc thue
		select area_code,
				kpi_month,
				total_value as profit_bef_tax
		from  finalproject.report_tong_hop
		where (report_id = 1) and kpi_month = v_in_date_month
	)z on z.area_code = y.area_code
	join
	(	-- tong : r.thu_nhap_tu_hd_the+ r.dt_nguon_von + r.dt_fintech + r.dt_tieu_thuong_ca_nhan + r.dt_kinh_doanh
		select area_code,
				kpi_month,
				sum(total_value) as tong_mau_margin
		from  finalproject.report_tong_hop
		where (report_id in (2,9,14,15,16)) and kpi_month = v_in_date_month
		group by area_code,kpi_month
	)q on z.area_code = q.area_code
	join
	(	-- chi_phi_thuan_kdv
		select area_code,
				kpi_month,
				total_value as net_operating_expenses
		from  finalproject.report_tong_hop
		where (report_id = 8) and kpi_month = v_in_date_month
	)w on w.area_code = q.area_code
	join
	(	-- so_nhan_vien
		select area_code,
				kpi_month,
				no_of_employees_area
		from  finalproject.number_of_employees
		where kpi_month = v_in_date_month
	)e on w.area_code = e.area_code
	;
	
	-- B12. REPORT 2 : insert vao report 2
	 -- 12.1. insert vao bang report 2
		-- insert report 2 : ltn avg ( id = 1)
		insert into finalproject.report_rank_asm
		(kpi_month, area_code,sale_name, email, report_id, total_value )
		select v_in_date_month as kpi_month,
				d.ma_tinh_thanh as area_code,
				k.sale_name,
				k.email,
				1 as report_id,
				case
					when v_in_date_month = '202301' then coalesce(jan_ltn::float,0)
					when v_in_date_month = '202302' then coalesce((coalesce(jan_ltn,0) + coalesce(feb_ltn,0))::float/2,0)
					when v_in_date_month = '202303' then coalesce((coalesce(jan_ltn,0) + coalesce(feb_ltn,0) + coalesce(mar_ltn,0))::float/3, 0)
					when v_in_date_month = '202304' then coalesce((coalesce(jan_ltn,0) + coalesce(feb_ltn,0) + coalesce(mar_ltn,0) + coalesce(apr_ltn,0))::float/4,0)
					when v_in_date_month = '202305' then coalesce((coalesce(jan_ltn,0) + coalesce(feb_ltn,0) + coalesce(mar_ltn,0) + coalesce(apr_ltn,0) + coalesce(may_ltn,0))::float/5,0)
				end as total_value
		from finalproject.kpi_asm_data k
		left join finalproject.dim_city_structure d on k.area_name = d.danh_sach_vung
		-- loai bo nhung gia tri null tai thang truyen vao ( do null thi asm do chua lam viec tai thang do )
		where (v_in_date_month = '202301' and jan_ltn is not null) or (v_in_date_month = '202302' and feb_ltn is not null) or
				 (v_in_date_month = '202303' and mar_ltn is not null) or (v_in_date_month = '202304' and apr_ltn is not null)
				or (v_in_date_month = '202305' and may_ltn is not null)
		
		;
		-- insert report 2 : psdn avg (id = 2)
		insert into finalproject.report_rank_asm
		(kpi_month, area_code,sale_name, email, report_id, total_value )
		select v_in_date_month as kpi_month,
				d.ma_tinh_thanh as area_code,
				k.sale_name,
				k.email,
				2 as report_id,
				case
					when v_in_date_month = '202301' then coalesce(jan_psdn::float,0)
					when v_in_date_month = '202302' then coalesce((coalesce(jan_psdn,0) + coalesce(feb_psdn,0))::float/2,0)
					when v_in_date_month = '202303' then coalesce((coalesce(jan_ltn,0) + coalesce(feb_psdn,0) + coalesce(mar_psdn,0))::float/3,0)
					when v_in_date_month = '202304' then coalesce((coalesce(jan_psdn,0) + coalesce(feb_psdn,0) + coalesce(mar_psdn,0) + coalesce(apr_psdn,0))::float/4, 0)
					when v_in_date_month = '202305' then  coalesce((coalesce(jan_psdn,0) + coalesce(feb_psdn,0) + coalesce(mar_psdn,0) + coalesce(apr_psdn,0) + coalesce(may_psdn,0))::float/5, 0)
				end as total_value
		from finalproject.kpi_asm_data k
		left join finalproject.dim_city_structure d on k.area_name = d.danh_sach_vung
		-- loai bo nhung gia tri null tai thang truyen vao ( do null thi asm do chua lam viec tai thang do )
		where (v_in_date_month = '202301' and jan_ltn is not null) or (v_in_date_month = '202302' and feb_ltn is not null) or
				 (v_in_date_month = '202303' and mar_ltn is not null) or (v_in_date_month = '202304' and apr_ltn is not null)
				or (v_in_date_month = '202305' and may_ltn is not null)
			;
		-- insert report 2 : approval_rate avg (id = 3)
		insert into finalproject.report_rank_asm
		(kpi_month, area_code, sale_name, email, report_id, total_value )
		select v_in_date_month as kpi_month,
				d.ma_tinh_thanh as area_code,
				k.sale_name,
				k.email,
				3 as report_id,
				case
					when v_in_date_month = '202301' then coalesce(jan_approval_rate,0)
					when v_in_date_month = '202302' then coalesce((coalesce(jan_approval_rate,0) + coalesce(feb_approval_rate,0))::float/2, 0)
					when v_in_date_month = '202303' then coalesce((coalesce(jan_approval_rate,0) + coalesce(feb_approval_rate,0) + coalesce(mar_approval_rate,0))::float/3 ,0)
					when v_in_date_month = '202304' then coalesce((coalesce(jan_approval_rate,0) + coalesce(feb_approval_rate,0) + coalesce(mar_approval_rate,0) + coalesce(apr_approval_rate,0))::float/4, 0)
					when v_in_date_month = '202305' then coalesce((coalesce(jan_approval_rate,0) + coalesce(feb_approval_rate,0) + coalesce(mar_approval_rate,0) + coalesce(apr_approval_rate,0) + coalesce(may_approval_rate,0))::float/5, 0)
				end as total_value
		from finalproject.kpi_asm_data k
		left join finalproject.dim_city_structure d on k.area_name = d.danh_sach_vung
		-- loai bo nhung gia tri null tai thang truyen vao ( do null thi asm do chua lam viec tai thang do )
		where (v_in_date_month = '202301' and jan_ltn is not null) or (v_in_date_month = '202302' and feb_ltn is not null) or
				 (v_in_date_month = '202303' and mar_ltn is not null) or (v_in_date_month = '202304' and apr_ltn is not null)
				or (v_in_date_month = '202305' and may_ltn is not null)
			;
	-- insert vao bang SDCK sau wo
	insert into finalproject.os_after_wo
	(area_code, kpi_month, total_os_area, total_os_all)
	-- lay ra dnck sau wo nhom 3-5 tung khu vuc va dnck sau wo toan hang
	select l.parent_id as area_code,
			v_in_date_month as kpi_month,
			total_os_area_grp_3_to_5 as total_os_area ,
			 total_os_area as total_os_all
	
	from
	(	
		-- tinh dnck_kv tu dau nam den thang xet, tung khu vuc theo nhom 3->5
			select d.parent_id,f2.kpi_month, sum(f2.outstanding_principal) as total_os_area_grp_3_to_5
			from finalproject.fact_kpi_month_raw_data f2
			join finalproject.dim_city_structure d on  d.danh_sach_vung = f2.pos_city
			where (f2.kpi_month = v_in_date_month) and (f2.max_bucket between 3 and 5)
			group by d.parent_id, f2.kpi_month
	)l
	join
	(	
			-- dnck khu vuc sau wo
			select d.parent_id,f2.kpi_month, sum(f2.outstanding_principal) as total_os_area
			from finalproject.fact_kpi_month_raw_data f2
			join finalproject.dim_city_structure d on  d.danh_sach_vung = f2.pos_city
			where (f2.kpi_month = v_in_date_month)
			group by d.parent_id, f2.kpi_month
		
	)o1 on o1.kpi_month = l.kpi_month and l.parent_id = o1.parent_id
	
	;
	
	-- insert vao bang npl
	insert into finalproject.npl_truoc_wo_luy_ke
	(area_code, kpi_month, npl_bef_wo)
	select o.area_code,
			o.kpi_month,
			(o.total_os_area + w.wo_luyke)::float8*100/(o.total_os_all + w.wo_luyke) as npl_bef_wo
	from finalproject.os_after_wo o
	join finalproject.wo_by_month w on w.area_code = o.area_code and w.kpi_month = o.kpi_month
	
	;
	-- insert report 2 : npl
	insert into finalproject.report_rank_asm
		(kpi_month, area_code,sale_name, email, report_id, total_value )
		select n.kpi_month,
				n.area_code,
				k.sale_name,
				k.email,
				4 as report_id,
				npl_bef_wo as npl_truoc_wo_luy_ke
		from finalproject.kpi_asm_data k
		left join finalproject.dim_city_structure d on k.area_name = d.danh_sach_vung
		join finalproject.npl_truoc_wo_luy_ke n on n.area_code = d.ma_tinh_thanh
	;
	-- insert report 2 : cac chi tieu tai chinh
	-- cir
	insert into finalproject.report_rank_asm
		(kpi_month, area_code, sale_name, email, report_id, total_value )
	select  i.kpi_month,
			i.area_code,
			k.sale_name ,
			k.email,
			5 as report_id,
			i.cir as total_value
	from finalproject.kpi_asm_data k
	left join finalproject.dim_city_structure d on k.area_name = d.danh_sach_vung
	join finalproject.index_finance i on i.area_code = d.ma_tinh_thanh
	;
	-- margin
	insert into finalproject.report_rank_asm
		(kpi_month, area_code, sale_name, email, report_id, total_value )
	select  i.kpi_month,
			i.area_code,
			k.sale_name ,
			k.email,
			6 as report_id,
			i.margin as total_value
	from finalproject.kpi_asm_data k
	left join finalproject.dim_city_structure d on k.area_name = d.danh_sach_vung
	join finalproject.index_finance i on i.area_code = d.ma_tinh_thanh
	;
	
	-- hs_von
	insert into finalproject.report_rank_asm
		(kpi_month, area_code,sale_name, email, report_id, total_value )
	select  i.kpi_month,
			i.area_code,
			k.sale_name,
			k.email,
			7 as report_id,
			i.return_of_capital as total_value
	from finalproject.kpi_asm_data k
	left join finalproject.dim_city_structure d on k.area_name = d.danh_sach_vung
	join finalproject.index_finance i on i.area_code = d.ma_tinh_thanh
	;
	-- hieu_suat_binh_quan_tren_nhan_su
	insert into finalproject.report_rank_asm
		(kpi_month, area_code, sale_name, email, report_id, total_value )
	select  i.kpi_month,
			i.area_code,
			k.sale_name,
			k.email,
			8 as report_id,
			i.avg_profit_per_employee as total_value
	from finalproject.kpi_asm_data k
	left join finalproject.dim_city_structure d on k.area_name = d.danh_sach_vung
	join finalproject.index_finance i on i.area_code = d.ma_tinh_thanh
	;
	-- B13. ghi thoi gian bat dau va ket thuc chay procedure , xu ly ngoai le va ghi loi
	-- Nếu chạy xong không lỗi, ghi nhận thời gian kết thúc và trạng thái thành công
begin
	update finalproject.log_tracking
	set end_time = clock_timestamp(),
		is_successful = true
	where procedure_name = 'report_tong_hop_T2_prc' and start_time = (
																		SELECT MAX(start_time)
															            FROM finalproject.log_tracking
															            WHERE procedure_name = 'report_tong_hop_T2_prc'
															        	);
	-- bat loi voi exception : ghi nhan tg ket thuc, trang thai va chi tiet loi
	exception when others then
	update finalproject.log_tracking
	set end_time = clock_timestamp(),
		is_successful = false,
		 error_log = 'Error while inserting employee: ' || SQLERRM || ' - ' || SQLSTATE
	where procedure_name = 'report_tong_hop_T2_prc' and start_time =(
																		SELECT MAX(start_time)
															            FROM finalproject.log_tracking
															            WHERE procedure_name = 'report_tong_hop_T2_prc'
															        	);	
end;
end;
$$ language plpgsql;


call finalproject.report_tong_hop_T2_prc('2023-05-31');



--- 3.Viết các Direct Query 
-- lấy ra bảng kết quả hoạt động kinh doanh theo từng khu vực
select r.kpi_month,
		d.name as tieu_chi,
		max(case
			when r.area_code = 'A'  then coalesce(r.total_value,0)
		end ) as "Hội Sở",
		max(case
			when r.area_code = 'B'  then coalesce(r.total_value,0)
		end ) as "Đông Bắc Bộ",
		max(case
			when r.area_code = 'C'  then coalesce(r.total_value,0)
		end ) as "Tây Bắc Bộ",
		max(case
			when r.area_code = 'D'  then coalesce(r.total_value,0)
		end ) as "Đồng Bằng Sông Hồng",
		max( case
			when r.area_code = 'E'  then coalesce(r.total_value,0)
		end ) as "Bắc Trung Bộ",
		max(case
			when r.area_code = 'F'  then coalesce(r.total_value,0)
		end)  as "Nam Trung Bộ",
		max(case
			when r.area_code = 'G'  then coalesce(r.total_value,0)
		end ) as "Tây Nam Bộ",
		max(case
			when r.area_code = 'H'  then coalesce(r.total_value,0)
		end) as "Đông Nam Bộ"
from finalproject.report_tong_hop r
join finalproject.dim_rpt_criteria_structure d on r.report_id = d.report_id
group by r.kpi_month,d.name,d.sortorder
order by r.kpi_month asc,d.sortorder asc
;



-- lấy ra bảng đánh giá hoạt động từng asm dựa theo các KPI metrics, đánh rank cho từng tiêu chí KPI metrics 
SELECT
   kpi_month,
   area_code,
   name_area,
   sale_name,
   email,
   diem_quy_mo + diem_fin AS tong_diem,
   RANK() OVER (PARTITION BY kpi_month ORDER BY (diem_quy_mo + diem_fin) ASC) AS rank_final,
   ltn_avg,
   ltn_avg_rank,
   psdn_avg,
   psdn_avg_rank,
   approval_rate_avg,
   approval_rate_avg_rank,
   npl_truoc_wo_luy_ke,
   npl_truoc_wo_luy_ke_rank,
   diem_quy_mo,
   RANK() OVER (PARTITION BY kpi_month ORDER BY diem_quy_mo ASC) AS rank_ptkd,
   cir,
   cir_rank,
   margin,
   margin_rank,
   hs_von,
   hs_von_rank,
   hsbq_nhan_su,
   hsbq_nhan_su_rank,
   diem_fin,
   RANK() OVER (PARTITION BY kpi_month ORDER BY diem_fin ASC) AS rank_fin
FROM (
   SELECT
       kpi_month,
       area_code,
       danh_sach_vung AS name_area,
       sale_name,
       email,
       ltn_avg,
       ltn_avg_rank,
       psdn_avg,
       psdn_avg_rank,
       approval_rate_avg,
       approval_rate_avg_rank,
       npl_truoc_wo_luy_ke,
       npl_truoc_wo_luy_ke_rank,
       ltn_avg_rank + psdn_avg_rank + approval_rate_avg_rank + npl_truoc_wo_luy_ke_rank AS diem_quy_mo,
       cir,
       cir_rank,
       margin,
       margin_rank,
       hs_von,
       hs_von_rank,
       hsbq_nhan_su,
       hsbq_nhan_su_rank,
       cir_rank + margin_rank + hs_von_rank + hsbq_nhan_su_rank AS diem_fin
   FROM (
	
       SELECT
           r.kpi_month,
           r.area_code,
           dcs.danh_sach_vung,
           r.sale_name,
           r.email,
           MAX(CASE WHEN r.report_id = 1 THEN r.total_value END) AS ltn_avg,
           MAX(CASE WHEN r.report_id = 1 THEN r.ranked_desc END) AS ltn_avg_rank,
           MAX(CASE WHEN r.report_id = 2 THEN r.total_value END) AS psdn_avg,
           MAX(CASE WHEN r.report_id = 2 THEN r.ranked_desc END) AS psdn_avg_rank,
           MAX(CASE WHEN r.report_id = 3 THEN r.total_value END) AS approval_rate_avg,
           MAX(CASE WHEN r.report_id = 3 THEN r.ranked_desc END) AS approval_rate_avg_rank,
           MAX(CASE WHEN z.report_id = 4 THEN z.total_value END) AS npl_truoc_wo_luy_ke,
           MAX(CASE WHEN z.report_id = 4 THEN z.ranked_asc_4 END) AS npl_truoc_wo_luy_ke_rank,
           MAX(CASE WHEN x.report_id = 5 THEN x.total_value END) AS cir,
           MAX(CASE WHEN x.report_id = 5 THEN x.ranked_asc_5 END) AS cir_rank,
           MAX(CASE WHEN r.report_id = 6 THEN r.total_value END) AS margin,
           MAX(CASE WHEN r.report_id = 6 THEN r.ranked_desc END) AS margin_rank,
           MAX(CASE WHEN r.report_id = 7 THEN r.total_value END) AS hs_von,
           MAX(CASE WHEN r.report_id = 7 THEN r.ranked_desc END) AS hs_von_rank,
           MAX(CASE WHEN r.report_id = 8 THEN r.total_value END) AS hsbq_nhan_su,
           MAX(CASE WHEN r.report_id = 8 THEN r.ranked_desc END) AS hsbq_nhan_su_rank
       FROM
           (
               SELECT
                   kpi_month,
                   area_code,
                   sale_name,
                   email,
                   report_id,
                   total_value,
                   DENSE_RANK() OVER (PARTITION BY kpi_month, report_id ORDER BY total_value DESC) AS ranked_desc
               FROM finalproject.report_rank_asm
               WHERE report_id IN (1,2,3,6,7,8)
           ) r
       JOIN
           (
               SELECT
                   kpi_month,
                   area_code,
                   sale_name,
                   email,
                   report_id,
                   total_value,
                   DENSE_RANK() OVER (PARTITION BY kpi_month, report_id ORDER BY total_value ASC) AS ranked_asc_5
               FROM finalproject.report_rank_asm
               WHERE report_id  = 5
           ) x 
       ON r.email = x.email AND r.kpi_month = x.kpi_month AND r.area_code = x.area_code
       JOIN
           (
               SELECT
                   kpi_month,
                   area_code,
                   sale_name,
                   email,
                   report_id,
                   total_value,
                   RANK() OVER (PARTITION BY kpi_month, report_id ORDER BY total_value ASC) AS ranked_asc_4
               FROM finalproject.report_rank_asm
               WHERE report_id = 4
           ) z
       ON z.email = x.email AND z.kpi_month = x.kpi_month AND z.area_code = x.area_code
       JOIN finalproject.dim_city_structure dcs ON dcs.ma_tinh_thanh = z.area_code
       GROUP BY r.kpi_month, r.area_code,r.sale_name, r.email, dcs.danh_sach_vung
   )
   WHERE ltn_avg IS NOT NULL
)
;


-- lấy ra bảng index finance 
select dcs.danh_sach_vung ,
		if2.kpi_month ,
		if2.cir ,
		if2.change_cir,
		if2.margin ,
		if2.change_margin,
		if2.return_of_capital ,
		if2.change_roc,
		if2.avg_profit_per_employee,
		if2.change_appe
from finalproject.index_finance if2
join finalproject.dim_city_structure dcs  on if2.area_code = dcs.ma_tinh_thanh
order by if2.kpi_month asc;




-- lay bang so nhan vien
select d.danh_sach_vung as region_name,
		n.kpi_month,
		n.no_of_employees_area,
		n.no_of_employees_all
from finalproject.number_of_employees n
join finalproject.dim_city_structure d on n.area_code = d.ma_tinh_thanh




