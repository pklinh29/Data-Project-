--1.Tạo các bảng cần thiết 
​​-- bảng target model lại data tổng toàn hàng
create table finalproject.wide_report(
area_code varchar(1024),
kpi_month int8,
report_id int8,
total_value decimal
) ;
--bảng target index_fin của toan hang
create table finalproject.finance_metrics_wide(
area_code varchar(1024),
kpi_month int8,
cir float8,
change_cir float8,
margin float8,
change_margin float8,
return_of_capital float8,
change_roc float8,
avg_profit_per_employee float8,
change_appe float8
);
-- bảng target model lại data từng khu vực ( tách bỏ tháng cộng dồn )
create table finalproject.report_model_region(
area_code varchar(1024),
kpi_month int8,
report_id int8,
total_value decimal
) ;
-- bảng target model lại data toan hang ( tách bỏ tháng cộng dồn )
create table finalproject.report_model_wide(
area_code varchar(1024),
kpi_month int8,
report_id int8,
total_value decimal
) ;



--2.Tạo Procedure 
create or replace procedure finalproject.model_data(in_date date )
as
$$
declare
v_in_date_month int8; --  bien luu namthang dang YYYYMM
begin
	v_in_date_month := cast(substring(to_char(in_date,'YYYYMMDD') from 1 for 6) as int8);
	--B0. xoa du lieu cu
	truncate finalproject.wide_report;
	delete from finalproject.finance_metrics_wide where kpi_month = v_in_date_month;
	truncate finalproject.report_model_region;
	truncate finalproject.report_model_wide ;
	-- B1. insert vào bảng wide_report ( bảng tổng toàn hàng )
	insert into finalproject.wide_report
	(area_code, kpi_month, report_id, total_value)
	SELECT
	    'ALL' AS area_code,
	    kpi_month,
	    report_id,
	    SUM(total_value) AS total_value
	from finalproject.report_tong_hop
	where area_code <> 'A'
	group by kpi_month, report_id
	order by kpi_month, report_id
	;
-- B1.2. insert vao bang cac chi so tai chinh
	insert into finalproject.finance_metrics_wide
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
  
   CASE WHEN e.so_nhan_vien_toan_hang = 0 THEN 0
        ELSE ((z.profit_bef_tax)::float8 / (e.so_nhan_vien_toan_hang) )
   END AS avg_profit_per_employee
	from	
	(	-- tong cp hoat dong
		select area_code,
				kpi_month,
				total_value as total_operating_expenses
		from  finalproject.wide_report
		where (report_id = 21) and kpi_month = v_in_date_month
	)x
	join
	(	-- tong thu nhap hd
		select area_code,
				kpi_month,
				total_value as total_operating_income
		from  finalproject.wide_report
		where (report_id = 20) and kpi_month = v_in_date_month
	)y on x.area_code = y.area_code and x.kpi_month = y.kpi_month
	join
	( 	-- loi nhuan truoc thue
		select area_code,
				kpi_month,
				total_value as profit_bef_tax
		from  finalproject.wide_report
		where (report_id = 1) and kpi_month = v_in_date_month
	)z on z.area_code = y.area_code and z.kpi_month = y.kpi_month
	join
	(	-- tong : r.thu_nhap_tu_hd_the+ r.dt_nguon_von + r.dt_fintech + r.dt_tieu_thuong_ca_nhan + r.dt_kinh_doanh
		select area_code,
				kpi_month,
				sum(total_value) as tong_mau_margin
		from  finalproject.wide_report
		where (report_id in (2,9,14,15,16)) and kpi_month = v_in_date_month
		group by area_code,kpi_month
	)q on z.area_code = q.area_code and z.kpi_month = q.kpi_month
	join
	(	-- chi_phi_thuan_kdv
		select area_code,
				kpi_month,
				total_value as net_operating_expenses
		from  finalproject.wide_report
		where (report_id = 8) and kpi_month = v_in_date_month
	)w on w.area_code = q.area_code and w.kpi_month = q.kpi_month
	join
	(	-- so_nhan_vien
		select v_in_date_month as kpi_month, count(distinct k.email) as so_nhan_vien_toan_hang
		from finalproject.kpi_asm_data k
		where (v_in_date_month = '202301' and jan_ltn is not null) or (v_in_date_month = '202302' and feb_ltn is not null) or
				 (v_in_date_month = '202303' and mar_ltn is not null) or (v_in_date_month = '202304' and apr_ltn is not null)
				or (v_in_date_month = '202305' and may_ltn is not null)
	)e on w.kpi_month = e.kpi_month
	;
	-- update change growth trong finalproject.finance_metrics_wide
	update finalproject.finance_metrics_wide f2
	set change_cir = 0,
	    change_margin = 0,
	    change_roc = 0,
	    change_appe = 0
	from finalproject.finance_metrics_wide f1
	where f2.kpi_month = 202301  and f2.area_code = f1.area_code
	;
	update finalproject.finance_metrics_wide f2
	set change_cir = f2.cir - f1.cir,
	    change_margin = f2.margin - f1.margin,
	    change_roc = f2.return_of_capital - f1.return_of_capital,
	    change_appe = (f2.avg_profit_per_employee - f1.avg_profit_per_employee) / f1.avg_profit_per_employee
	from finalproject.finance_metrics_wide f1
	where f2.kpi_month = f1.kpi_month + 1 and f2.area_code = f1.area_code
	;
	
	-- B2.insert vào bảng model lại từng tháng theo khu vực ( tách cộng dồn ra )
	--B2.1. INSERT thang 2-5 truoc
	insert into finalproject.report_model_region
	( area_code, kpi_month, report_id, total_value)
	--lay ra gia tri khi chua cong don cua thang 2,3,4,5
	select r2.area_code,
		    r2.kpi_month,
		    r2.report_id,
		    r2.total_value - r1.total_value as total_value
	from finalproject.report_tong_hop r1
	join finalproject.report_tong_hop r2 on r1.report_id = r2.report_id and r1.area_code = r2.area_code  and r2.kpi_month = r1.kpi_month + 1
	;
	
	-- B2.2.insert thang 1
	insert into finalproject.report_model_region
	( area_code, kpi_month, report_id, total_value)
	-- lay gia tri cua thang 1 ( original)
	select *
	from finalproject.report_tong_hop r
	where r.kpi_month = 202301
	
	;
	
	-- B3. insert vao bang model lại từng tháng toan hang ( tách cộng dồn ra )
	-- B3.1. insert vao thang 2-> 5 truoc
	insert into finalproject.report_model_wide
	( area_code, kpi_month, report_id, total_value)
	--lay ra gia tri khi chua cong don cua thang 2,3,4,5
	select w2.area_code,
		    w2.kpi_month,
		    w2.report_id,
		    w2.total_value - w1.total_value as total_value
	from finalproject.wide_report w1
	join finalproject.wide_report w2 on w1.report_id = w2.report_id  and w2.kpi_month = w1.kpi_month + 1
	
	;
	-- B2.2.insert thang 1
	insert into finalproject.report_model_wide
	( area_code, kpi_month, report_id, total_value)
	-- lay gia tri cua thang 1 ( original)
	select *
	from finalproject.wide_report w
	where w.kpi_month = 202301
	
	;
end;
$$  language plpgsql ;
call finalproject.model_data('2023-01-31') ;


--3. Viết các Direct Query
-- format lai finalproject.report_model_region
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
from finalproject.report_model_region r
join finalproject.dim_rpt_criteria_structure d on r.report_id = d.report_id
group by r.kpi_month,d.name,d.sortorder
order by r.kpi_month asc, d.sortorder asc
;
-- format lai bang wide_report
select r.kpi_month,
	d.name as tieu_chi,
	max(case
		when r.area_code = 'ALL'  then coalesce(r.total_value,0)
	end ) as "Toàn hàng"
from finalproject.wide_report r
join finalproject.dim_rpt_criteria_structure d on r.report_id = d.report_id
group by r.kpi_month,d.name,d.sortorder
order by r.kpi_month asc, d.sortorder asc
;
-- format lai bang finalproject.report_model_wide
select r.kpi_month,
	d.name as tieu_chi,
	max(case
		when r.area_code = 'ALL'  then coalesce(r.total_value,0)
	end ) as "Toàn hàng"
from finalproject.report_model_wide r
join finalproject.dim_rpt_criteria_structure d on r.report_id = d.report_id
group by r.kpi_month,d.name,d.sortorder
order by r.kpi_month asc, d.sortorder asc
;

