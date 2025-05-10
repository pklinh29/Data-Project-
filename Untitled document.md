1. # **Tạo các bảng cần thiết** 

\-- bang hach toan chinh xac card income  
**create** **table** finalproject.tmp\_accurate\_accounting\_card\_income(  
kpi\_month **int8**,  
report\_id **int8**,  
area\_code **varchar**(1024),  
total\_value **decimal**  
);  
\-- bang dnck binh quan sau wo nhom 1  
**create** **table** finalproject.tmp\_total\_os\_db\_grp\_1\_after\_wo(  
kpi\_month **int8**,  
area\_code **varchar**(1024),  
avg\_total\_os\_area **decimal**,  
avg\_total\_os\_all **decimal**  
);  
\-- bang dnck binh quan sau wo nhom 2  
**create** **table** finalproject.tmp\_total\_os\_db\_grp\_2\_after\_wo(  
kpi\_month **int8**,  
area\_code **varchar**(1024),  
avg\_total\_os\_area **decimal**,  
avg\_total\_os\_all **decimal**  
);  
\--bang dnck binh quan sau wo nhom 2 \-\> 5  
**create** **table** finalproject.tmp\_total\_os\_db\_grp\_2\_to\_5\_after\_wo(  
kpi\_month **int8**,  
area\_code **varchar**(1024),  
avg\_total\_os\_area **decimal**,  
avg\_total\_os\_all **decimal**  
);  
\-- bang so luong the psdn  
**create** **table** finalproject.the\_psdn(  
area\_code **varchar**(1024),  
kpi\_month **int8**,  
so\_the\_psdn **int8**,  
so\_the\_psdn\_toan\_hang **int8**  
);  
\-- report 1  
**create** **table** finalproject.report\_tong\_hop(  
area\_code **varchar**(1024) ,  
kpi\_month **int8**,  
report\_id **int8**,  
total\_value **decimal**  
) ;  
\--bảng hạch toán chính xác các tiêu chí về chi phí kinh doanh vốn các khu vực  
	**create** **table** finalproject.tmp\_accurate\_accounting\_captial\_business(  
	kpi\_month **int8**,  
	report\_id **int8**,  
	area\_code **varchar**(1024),  
	total\_value **decimal**  
	);  
\--bảng tỷ lệ phân bổ tiêu chí trong chi phí kinh doanh vốn các khu vực  
**create** **table** finalproject.tmp\_allocate\_capital\_business(  
kpi\_month **int8**,  
area\_code **varchar**(1024),  
card\_income **decimal**,  
interest\_credit\_card **decimal**  
);  
\--bảng hạch toán chính xác tiêu chí trong chi phí thuần hoạt động khác  
**create** **table** finalproject.tmp\_accurate\_accounting\_net\_other\_operating\_expenses(  
kpi\_month **int8**,  
report\_id **int8**,  
area\_code **varchar**(1024),  
total\_value **decimal**  
);  
\--bảng tỷ lệ phân bổ tiêu chí trong chi phí thuần hoạt động khác  
**create** **table** finalproject.tmp\_total\_os\_db\_after\_wo(  
kpi\_month **int8**,  
area\_code **varchar**(1024),  
avg\_total\_os\_area **decimal**,  
avg\_total\_os\_all **decimal**  
);  
\-- bảng so\_nhan\_vien  
**create** **table** finalproject.number\_of\_employees(  
area\_code **varchar**(1024),  
kpi\_month **int8**,  
no\_of\_employees\_area **int8**,  
no\_of\_employees\_all **int8**  
);		  
\--bảng hạch toán chính xác trong tổng chi phí hoạt động  
**create** **table** finalproject.tmp\_accurate\_accounting\_operating\_expenses(  
kpi\_month **int8**,  
report\_id **int8**,  
area\_code **varchar**(1024),  
total\_value **decimal**  
);  
\---- chi phi du phong  
\--bảng hạch toán chính xác trong chi phí dự phòng  
**create** **table** finalproject.tmp\_accurate\_accounting\_provision\_expenses(  
kpi\_month **int8**,  
report\_id **int8**,  
area\_code **varchar**(1024),  
total\_value **decimal**  
);  
\-- bang wo luy ke  
**create** **table** finalproject.wo\_by\_month(  
area\_code **varchar**(1024),  
kpi\_month **int8**,  
write\_off\_month **int8**,  
wo\_by\_month **decimal**,  
wo\_luyke **decimal**  
);  
\-- bang dnck truoc wo  
**create** **table** finalproject.os\_bef\_wo(  
area\_code **varchar**(1024),  
kpi\_month **int8**,  
os\_bef\_wo **decimal**,  
avg\_total\_os\_all **decimal**  
);  
\-- bang dnck truoc wo binh quan  
**create** **table** finalproject.total\_os\_bef\_wo(  
area\_code **varchar**(1024),  
kpi\_month **int8**,  
total\_os\_area\_bef\_wo **decimal**,  
total\_os\_all **decimal**  
);  
\--bang cac chi so tai chinh  
**create** **table** finalproject.index\_finance(  
area\_code **varchar**(1024),  
kpi\_month **int8**,  
cir **decimal**,  
change\_cir **float8**,  
margin **decimal**,  
change\_margin **float8**,  
return\_of\_capital **decimal**,  
change\_roc **float8**,  
avg\_profit\_per\_employee **decimal**,  
change\_appe **float8**  
);  
\-- bang SDCK sau wo  
**create** **table** finalproject.os\_after\_wo  
(  
area\_code **varchar**(1024),  
kpi\_month **int8**,  
total\_os\_area **decimal**,  
total\_os\_all **decimal**  
);  
\-- insert vao bang npl\_truoc\_wo\_luy\_ke  
**create** **table** finalproject.npl\_truoc\_wo\_luy\_ke  
(  
area\_code **varchar**(1024),  
kpi\_month **int8**,   
npl\_bef\_wo **float8**  
);  
\-- bang target report 2  
**create** **table** finalproject.report\_rank\_asm(  
kpi\_month **int8**,  
area\_code **varchar**(1024),  
sale\_name **varchar**(1024),  
email **varchar**(1024),  
report\_id **int8**,  
total\_value **decimal**  
);

2. # **Tạo Stored Procedure** 

**create** **or** **replace** **procedure** finalproject.report\_tong\_hop\_T2\_prc(in\_date **date** )  
**as**  
**$$**  
**declare**  
v\_begining\_year **date**; \-- bien luu ngay dau nam dang YYYY-MM-DD  
v\_in\_date\_month **int8**; \--  bien luu namthang dang YYYYMM  
v\_begining\_month\_of\_year **int8**; \-- bien luu namthang dau nam : YYYY01  
v\_start\_time **timestamp** ; \-- bien luu thoi gian bat dau chay procedure  
**begin**  
\-- \---------------------  
   \-- THÔNG TIN NGƯỜI TẠO  
   \-- \---------------------  
   \-- Tên người tạo: Phung Khanh Linh  
   \-- Ngày tạo: 21/01/2025  
   \-- \---------------------  
   \-- THÔNG TIN NGƯỜI CẬP NHẬT  
   \-- \---------------------  
   \-- Tên người cập nhật: Phung Khanh Linh  
   \-- Ngày cập nhật: 26/02/2025  
   \-- Mục đích cập nhật: Thêm cột sale\_name vào bảng report\_rank\_asm

   \-- \---------------------  
   \-- SUMMARY LUỒNG XỬ LÝ  
   \-- \---------------------  
   \-- Bước 1: khởi tạo thời gian bắt đầu , thêm thời giam bắt đầu chạy procedure vao bảng log tracking  
   \-- Bước 2: gán giá trị cho các biến  
   \-- Bước 3: xoá dữ liệu các bảng cũ  
   \-- Bước 4: thu nhập từ hoạt động thẻ  
		\-- 4.1. insert vào bảng hạch toán chính xác các tiêu chí trong thu nhập từ hoạt động thẻ các khu vực  
   	\-- 4.2. insert vào bảng tỷ lệ phân bổ tiêu chí trong thu nhập từ hoạt động thẻ các khu vực  
   	\-- 4.3. insert vào bảng report 1 cac tieu chi cua thu nhập từ hoạt động thẻ  
	\-- bước 5: chi phí kinh doanh vốn  
		\-- 5.1. insert vào bảng hạch toán chính xác các tiêu chí về chi phí kinh doanh vốn các khu vực  
		\-- 5.2. insert vào bảng tỷ lệ phân bổ tiêu chí trong chi phí kinh doanh vốn các khu vực  
		\-- 5.3. insert vào bảng report 1 cac tieu chi cua chi phí kinh doanh vốn  
	\-- bước 6: chi phí thuần hoạt động khác  
		\-- 6.1. insert vào bảng hạch toán chính xác tiêu chí trong chi phí thuần hoạt động khác  
		\-- 6.2. insert vào bảng tỷ lệ phân bổ tiêu chí trong chi phí thuần hoạt động khác  
		\-- 6.3. insert vào bảng report 1 cac tieu chi cua chi phí thuần hoạt động khác  
	\-- bước 7: tổng chi phí hoạt động  
		\-- 7.1. insert vào bảng so\_nhan\_vien ( đây cũng là bảng sử dụng để phân bổ )  
		\-- 7.2. insert vào bảng hạch toán chính xác trong tổng chi phí hoạt động  
		\-- 7.3. insert vào bảng report 1 cac tieu chi cua tổng chi phí hoạt động  
	\-- bước 8: chi phí dự phòng  
		\-- 8.1. insert vào bảng hạch toán chính xác trong chi phí dự phòng  
		\-- 8.2. insert vào bảng tỷ lệ phân bổ tiêu chí trong chi phí dự phòng  
		\-- 8.3. insert vào bảng report 1 cac tieu chi cua chi phí dự phòng  
	\-- bước 9: insert vào report level 1 va 0  
	\-- Buoc 10\. insert vao report tieu chi hoi so 'A'  
	\-- bước 11 : insert vao bang cac chi so tai chinh  
	\-- B12. REPORT 2 : insert vao report 2  
	 \-- 12.1. insert vao bang report 2  
		\-- id ve quy mo  
		\-- id ve tai chinh  
	\-- B13. ghi thoi gian bat dau va ket thuc chay procedure , xu ly ngoai le va ghi loi  
		  
   \-- \---------------------  
   \-- CHI TIẾT CÁC BƯỚC  
   \-- \---------------------  
	\-- B1. ghi nhan tg bat dau chay procedure  
	v\_start\_time := **clock\_timestamp**() ; \-- khoi tao tg bat dau chay procedure  
	  
	\-- Ghi nhận thời gian bắt đầu chạy procedure  
   **INSERT** **INTO** finalproject.log\_tracking  
   (procedure\_name, start\_time, is\_successful, rec\_created\_dt)  
   **VALUES** ( 'report\_tong\_hop\_T2\_prc', **clock\_timestamp**() , **NULL**, **now**() );  
   
	\--B2.định nghĩa các biến  
	v\_begining\_year := **date\_trunc**('year',in\_date);  
	v\_begining\_month\_of\_year := **cast**(**substring**(**to\_char**(v\_begining\_year,'YYYYMM') **from** 1 **for** 6) **as** **int8**);  
	v\_in\_date\_month := **cast**(**substring**(**to\_char**(in\_date,'YYYYMMDD') **from** 1 **for** 6) **as** **int8**);  
	  
	\-- B3. xoa du lieu ngay cu di  
		\-- xoa cac bang lq den report 1  
	**truncate** **table** finalproject.tmp\_accurate\_accounting\_card\_income;  
	**truncate** **table** finalproject.tmp\_total\_os\_db\_grp\_1\_after\_wo;  
	**truncate** **table** finalproject.tmp\_total\_os\_db\_grp\_2\_after\_wo;  
	**truncate** **table** finalproject.tmp\_total\_os\_db\_grp\_2\_to\_5\_after\_wo;  
	**truncate** **table**  finalproject.the\_psdn ;  
	**truncate** **table** finalproject.tmp\_accurate\_accounting\_captial\_business;  
	**truncate** **table** finalproject.tmp\_allocate\_capital\_business;  
	**truncate** **table** finalproject.tmp\_accurate\_accounting\_net\_other\_operating\_expenses;  
	**truncate** **table** finalproject.tmp\_total\_os\_db\_after\_wo;  
	**delete** **from** finalproject.number\_of\_employees **where** kpi\_month \= v\_in\_date\_month ;  
	**truncate** **table** finalproject.tmp\_accurate\_accounting\_operating\_expenses;  
	**truncate** **table** finalproject.tmp\_accurate\_accounting\_provision\_expenses;  
	**truncate** **table** finalproject.wo\_by\_month;  
	**truncate** **table** finalproject.os\_bef\_wo;  
	**truncate** **table** finalproject.total\_os\_bef\_wo;  
	**delete** **from** finalproject.index\_finance **where** kpi\_month \= v\_in\_date\_month;  
	**delete** **from** finalproject.report\_tong\_hop **where** kpi\_month \= v\_in\_date\_month;  
		\-- xoa cac bang lq den report 2  
	**truncate** **table** finalproject.os\_after\_wo ;  
	**truncate** **table** finalproject.npl\_truoc\_wo\_luy\_ke;  
	**delete** **from** finalproject.report\_rank\_asm **where** kpi\_month \= v\_in\_date\_month;  
\-- Bước 4: thu nhập từ hoạt động thẻ  
	\-- 4.1. insert vào bảng hạch toán chính xác các tiêu chí trong thu nhập từ hoạt động thẻ các khu vực  
	**insert** **into** finalproject.tmp\_accurate\_accounting\_card\_income  
	(kpi\_month,report\_id, area\_code, total\_value)  
	\-- hach toan chinh xac lai trong han cac khu vuc  
	**select**  v\_in\_date\_month **as** kpi\_month,  
			3 **as** report\_id,  
			**substring**(f.analysis\_code,9,1) **as** area\_code,  
			**sum**(f.amount) **as** total\_value  
	**from** finalproject.fact\_txn\_month\_raw\_data f  
	**where** (f.transaction\_date **between** v\_begining\_year **and** in\_date) **and** f.analysis\_code **like** 'DVML%'  
			  **and** f.account\_code **in** ('702000030002','702000030001','702000030102')  
	**group** **by**  **substring**(f.analysis\_code,9,1)  
	**union**  
	\-- hach toan chinh xac lai trong han cua head  
	**select**  v\_in\_date\_month **as** kpi\_month,  
			3 **as** report\_id,  
			'A' **as** area\_code,  
			**sum**(f.amount) **as** total\_value  
	**from** finalproject.fact\_txn\_month\_raw\_data f  
	**where** (f.transaction\_date **between** v\_begining\_year **and** in\_date) **and** analysis\_code **like** 'HEAD%'  
			  **and** f.account\_code **in** ('702000030002','702000030001','702000030102')  
	**union**  
	\-- hach toan chinh xac lai qua han cac khu vuc  
	**select**  v\_in\_date\_month **as** kpi\_month,  
			4 **as** report\_id,  
			**substring**(f.analysis\_code,9,1) **as** area\_code,  
			**sum**(f.amount) **as** total\_value  
	**from** finalproject.fact\_txn\_month\_raw\_data f  
	**where** (f.transaction\_date **between** v\_begining\_year **and** in\_date) **and** analysis\_code **like** 'DVML%'  
			  **and** f.account\_code **in** ('702000030012','702000030112')  
	**group** **by**  **substring**(f.analysis\_code,9,1)  
	**union**  
	\-- hach toan chinh xac lai qua han cua head  
	**select**  v\_in\_date\_month **as** kpi\_month,  
			4 **as** report\_id,  
			'A' **as** area\_code,  
			**sum**(f.amount) **as** total\_value  
	**from** finalproject.fact\_txn\_month\_raw\_data f  
	**where** (f.transaction\_date **between** v\_begining\_year **and** in\_date) **and** analysis\_code **like** 'HEAD%'  
			  **and** f.account\_code **in** ('702000030012','702000030112')  
	**union**  
	\-- hach toan chinh xac phi bao hiem cac khu vuc  
	**select**  v\_in\_date\_month **as** kpi\_month,  
			5 **as** report\_id,  
			**substring**(f.analysis\_code,9,1) **as** area\_code,  
			**sum**(f.amount) **as** total\_value  
	**from** finalproject.fact\_txn\_month\_raw\_data f  
	**where** (f.transaction\_date **between** v\_begining\_year **and** in\_date) **and** analysis\_code **like** 'DVML%'  
			  **and** f.account\_code **in** ('716000000001')  
	**group** **by**  **substring**(f.analysis\_code,9,1)  
	**union**  
	\-- hach toan chinh xac phi bao hiem cua head  
	**select**  v\_in\_date\_month **as** kpi\_month,  
			5 **as** report\_id,  
			'A' **as** area\_code,  
			**sum**(f.amount) **as** total\_value  
	**from** finalproject.fact\_txn\_month\_raw\_data f  
	**where** (f.transaction\_date **between** v\_begining\_year **and** in\_date) **and** analysis\_code **like** 'HEAD%'  
			  **and** f.account\_code **in** ('716000000001')  
	**union**  
	\-- hach toan chinh xac phi tang han muc cac khu vuc  
	**select**  v\_in\_date\_month **as** kpi\_month,  
			6 **as** report\_id,  
			**substring**(f.analysis\_code,9,1) **as** area\_code,  
			**sum**(f.amount) **as** total\_value  
	**from** finalproject.fact\_txn\_month\_raw\_data f  
	**where** (f.transaction\_date **between** v\_begining\_year **and** in\_date) **and** analysis\_code **like** 'DVML%'  
			  **and** f.account\_code **in** ('719000030002')  
	**group** **by**  **substring**(f.analysis\_code,9,1)  
	**union**  
	\-- hach toan chinh xac phi tang han muc cua head  
	**select**  v\_in\_date\_month **as** kpi\_month,  
			6 **as** report\_id,  
			'A' **as** area\_code,  
			**sum**(f.amount) **as** total\_value  
	**from** finalproject.fact\_txn\_month\_raw\_data f  
	**where** (f.transaction\_date **between** v\_begining\_year **and** in\_date) **and** analysis\_code **like** 'HEAD%'  
			  **and** f.account\_code **in** ('719000030002')  
	**union**  
	\-- hach toan chinh xac phi thanh toan cham khac cua khu vuc  
	**select**  v\_in\_date\_month **as** kpi\_month,  
			7 **as** report\_id,  
			**substring**(f.analysis\_code,9,1) **as** area\_code,  
			**sum**(f.amount) **as** total\_value  
	**from** finalproject.fact\_txn\_month\_raw\_data f  
	**where** (f.transaction\_date **between** v\_begining\_year **and** in\_date) **and** analysis\_code **like** 'DVML%'  
			  **and** f.account\_code **in** ('719000030003','719000030103','790000030003','790000030103','790000030004','790000030104')  
	**group** **by**  **substring**(f.analysis\_code,9,1)  
	**union**  
	\-- hach toan chinh xac phi thanh toan cham khac cua head  
	**select**  v\_in\_date\_month **as** kpi\_month,  
			7 **as** report\_id,  
			'A' **as** area\_code,  
			**sum**(f.amount) **as** total\_value  
	**from** finalproject.fact\_txn\_month\_raw\_data f  
	**where** (f.transaction\_date **between** v\_begining\_year **and** in\_date) **and** analysis\_code **like** 'HEAD%'  
			  **and** f.account\_code **in** ('719000030003','719000030103','790000030003','790000030103','790000030004','790000030104')  
	;  
   	\-- 4.2. insert vào bảng tỷ lệ phân bổ tiêu chí trong thu nhập từ hoạt động thẻ các khu vực  
	\--4.2.1. insert vao bang dnck binh quan sau wo nhom 1  
	**insert** **into** finalproject.tmp\_total\_os\_db\_grp\_1\_after\_wo  
	(kpi\_month, area\_code, avg\_total\_os\_area, avg\_total\_os\_all)  
	**select**  v\_in\_date\_month **as** kpi\_month,  
			x1.parent\_id **as** area\_code,  
			x1.avg\_total\_os\_area,  
			x2.avg\_total\_os\_all	  
	**from** 	  
	(	\-- tinh trung binh du no cuoi ki trung binh theo tung khu vuc sau khi wo nhom 1 ( t2= avg(t1,t2) )  
		**select** 	parent\_id, v\_in\_date\_month **as** kpi\_month, **avg**(dnck\_kv) **as** avg\_total\_os\_area  
		**from**  
		(	\-- tinh du no cuoi ki tu dau nam den thang hien tai theo tung nhom, tung khu vuc  
			**select** d.parent\_id,f2.kpi\_month, **sum**(f2.outstanding\_principal) **as** dnck\_kv  
			**from** finalproject.fact\_kpi\_month\_raw\_data f2  
			**join** finalproject.dim\_city\_structure d **on**  d.danh\_sach\_vung \= f2.pos\_city  
			**where** (f2.kpi\_month **between**  v\_begining\_month\_of\_year **and** v\_in\_date\_month ) **and** max\_bucket \= 1  
			**group** **by** d.parent\_id,f2.kpi\_month  
		)  
		**group** **by** parent\_id  
	)x1  
	**join**  
	(		\-- dnck trung binh toan hang ( t2= avg(t1,t2) )  
		**select** v\_in\_date\_month **as** kpi\_month, **avg**(avg\_dnck\_toan\_hang ) **as** avg\_total\_os\_all  
		**from**  
		(  
			**select** f2.kpi\_month,**sum**(f2.outstanding\_principal) **as** avg\_dnck\_toan\_hang  
			**from** finalproject.fact\_kpi\_month\_raw\_data f2  
			**where** (f2.kpi\_month **between** v\_begining\_month\_of\_year **and** v\_in\_date\_month) **and** max\_bucket \= 1  
			**group** **by** f2.kpi\_month  
		)  
	)x2 **on** 1\=1  
	;  
	\--4.2.2. insert vao bang dnck binh quan sau wo nhom 2  
	**insert** **into** finalproject.tmp\_total\_os\_db\_grp\_2\_after\_wo  
	(kpi\_month, area\_code, avg\_total\_os\_area, avg\_total\_os\_all)  
	\-- dnck sau wo nhom 2  
	**select**  v\_in\_date\_month **as** kpi\_month,  
			x3.parent\_id **as** area\_code,  
			x3.avg\_total\_os\_area,  
			x4.avg\_total\_os\_all	  
	**from** 	  
	(	\-- tinh trung binh du no cuoi ki trung binh theo tung khu vuc sau khi wo nhom 2 ( t2= avg(t1,t2) )  
		**select** 	parent\_id, v\_in\_date\_month **as** kpi\_month, **avg**(dnck\_kv) **as** avg\_total\_os\_area  
		**from**  
		(	\-- tinh du no cuoi ki tu dau nam den thang hien tai theo tung nhom, tung khu vuc  
			**select** d.parent\_id,f2.kpi\_month, **sum**(f2.outstanding\_principal) **as** dnck\_kv  
			**from** finalproject.fact\_kpi\_month\_raw\_data f2  
			**join** finalproject.dim\_city\_structure d **on**  d.danh\_sach\_vung \= f2.pos\_city  
			**where** (f2.kpi\_month **between**  v\_begining\_month\_of\_year **and** v\_in\_date\_month ) **and** max\_bucket \= 2  
			**group** **by** d.parent\_id,f2.kpi\_month  
		)  
		**group** **by** parent\_id  
	)x3    
	**join**  
	(		\-- dnck trung binh toan hang ( t2= avg(t1,t2) )  
		**select** v\_in\_date\_month **as** kpi\_month, **avg**(avg\_dnck\_toan\_hang ) **as** avg\_total\_os\_all  
		**from**  
		(  
			**select** f2.kpi\_month,**sum**(f2.outstanding\_principal) **as** avg\_dnck\_toan\_hang  
			**from** finalproject.fact\_kpi\_month\_raw\_data f2  
			**where** (f2.kpi\_month **between** v\_begining\_month\_of\_year **and** v\_in\_date\_month) **and** max\_bucket \= 2  
			**group** **by** f2.kpi\_month  
		)  
	)x4 **on** 1\=1  
	;  
	\--4.2.3. insert vao bang dnck binh quan sau wo nhom 2 \-\> 5  
	**insert** **into** finalproject.tmp\_total\_os\_db\_grp\_2\_to\_5\_after\_wo  
	(kpi\_month, area\_code, avg\_total\_os\_area, avg\_total\_os\_all)  
	\-- dnck sau wo nhom 2-\> 5  
	**select**  v\_in\_date\_month **as** kpi\_month,  
			x5.parent\_id **as** area\_code,  
			x5.avg\_total\_os\_area,  
			x6.avg\_total\_os\_all	  
	**from** 	  
	(	\-- tinh trung binh du no cuoi ki trung binh theo tung khu vuc sau khi wo nhom 2-5 ( t2= avg(t1,t2) )  
		**select** 	parent\_id, v\_in\_date\_month **as** kpi\_month, **avg**(dnck\_kv) **as** avg\_total\_os\_area  
		**from**  
		(	\-- tinh du no cuoi ki tu dau nam den thang hien tai theo tung nhom, tung khu vuc  
			**select** d.parent\_id,f2.kpi\_month, **sum**(f2.outstanding\_principal) **as** dnck\_kv  
			**from** finalproject.fact\_kpi\_month\_raw\_data f2  
			**join** finalproject.dim\_city\_structure d **on**  d.danh\_sach\_vung \= f2.pos\_city  
			**where** (f2.kpi\_month **between**  v\_begining\_month\_of\_year **and** v\_in\_date\_month ) **and** (max\_bucket **between** 2 **and** 5)  
			**group** **by** d.parent\_id,f2.kpi\_month  
		)  
		**group** **by** parent\_id  
	)x5   
	**join**  
	(		\-- dnck trung binh toan hang ( t2= avg(t1,t2) )  
		**select** v\_in\_date\_month **as** kpi\_month, **avg**(avg\_dnck\_toan\_hang ) **as** avg\_total\_os\_all  
		**from**  
		(  
			**select** f2.kpi\_month,**sum**(f2.outstanding\_principal) **as** avg\_dnck\_toan\_hang  
			**from** finalproject.fact\_kpi\_month\_raw\_data f2  
			**where** (f2.kpi\_month **between** v\_begining\_month\_of\_year **and** v\_in\_date\_month) **and**  (max\_bucket **between** 2 **and** 5)  
			**group** **by** f2.kpi\_month  
		)  
	)x6 **on** 1\=1  
	;  
	\--4.2.4. insert vao bang so luong the psdn  
	\-- the psdn  
	**insert** **into** finalproject.the\_psdn  
	(area\_code, kpi\_month, so\_the\_psdn, so\_the\_psdn\_toan\_hang)  
	**select** z.parent\_id **as** area\_code,  
			z.kpi\_month,  
			z.so\_the\_psdn,  
			d.so\_the\_psdn\_toan\_hang  
	**from**  
	(	  
		 \-- the psdn theo kv  
			**select** parent\_id,v\_in\_date\_month **as** kpi\_month, **count**(f2.psdn) **as** so\_the\_psdn  
			**from** finalproject.fact\_kpi\_month\_raw\_data f2  
			**join** finalproject.dim\_city\_structure d **on** f2.pos\_city \= d.danh\_sach\_vung  
			**where** (f2.kpi\_month **between**  v\_begining\_month\_of\_year **and** v\_in\_date\_month ) **and** f2.psdn \=1  
			**group** **by** parent\_id  
	  
	)z  
	**join**  
	(	  
			\-- the psdn toan hang  
			**select**  **count**(f2.psdn) **as** so\_the\_psdn\_toan\_hang  
			**from** finalproject.fact\_kpi\_month\_raw\_data f2  
			**where** (f2.kpi\_month **between** v\_begining\_month\_of\_year **and** v\_in\_date\_month) **and** f2.psdn \=1  
	)d **on** 1\=1  
	;  
	\-- 4.3. insert vào bảng report 1 tong thu nhap tu hoat dong the  
	\--4.3.1. insert vao bang report tieu chi lai trong han  
	**insert** **into** finalproject.report\_tong\_hop  
	(area\_code, kpi\_month, report\_id, total\_value)  
	**select** t1.area\_code,  
			t1.kpi\_month,  
			t1.report\_id,  
			t1.total\_value \+ (x7.total\_value\*x8.rate\_allocate) **as** total\_value  
	**from** finalproject.tmp\_accurate\_accounting\_card\_income t1  
	**join**  
	(  
		\-- lay ra gia tri hach toan chinh xac  
		**select** total\_value  
		**from** finalproject.tmp\_accurate\_accounting\_card\_income  
		**where** report\_id \= 3 **and** area\_code \= 'A'  
	)x7 **on** 1\=1  
	**join**  
	(		  
		\-- lay ra ty le phan bo  
		**select** kpi\_month,  
				 area\_code,  
				avg\_total\_os\_area/avg\_total\_os\_all **as** rate\_allocate  
		**from** finalproject.tmp\_total\_os\_db\_grp\_1\_after\_wo  
	)x8 **on** t1.area\_code \= x8.area\_code **and** t1.report\_id \= 3  
	**where** t1.report\_id \= 3  
	;  
	  
	\--4.3.2. insert vao bang report tieu chi lai qua han  
	**insert** **into** finalproject.report\_tong\_hop  
	(area\_code, kpi\_month, report\_id, total\_value)  
	**select** t1.area\_code,  
			t1.kpi\_month,  
			t1.report\_id,  
			t1.total\_value \+ (x9.total\_value\*x10.rate\_allocate) **as** total\_value  
	**from** finalproject.tmp\_accurate\_accounting\_card\_income t1  
	**join**  
	(  
		\-- lay ra gia tri hach toan chinh xac  
		**select** total\_value  
		**from** finalproject.tmp\_accurate\_accounting\_card\_income  
		**where** report\_id \= 4 **and** area\_code \= 'A'  
	)x9 **on** 1\=1  
	**join**  
	(		  
		\-- lay ra ty le phan bo  
		**select** kpi\_month,  
				 area\_code,  
				avg\_total\_os\_area/avg\_total\_os\_all **as** rate\_allocate  
		**from** finalproject.tmp\_total\_os\_db\_grp\_2\_after\_wo  
	)x10 **on** t1.area\_code \= x10.area\_code **and** t1.report\_id \= 4  
	**where** t1.report\_id \= 4  
	;  
	\--4.3.3. insert vao bang report tieu chi phi bao hiem  
	**insert** **into** finalproject.report\_tong\_hop  
	(area\_code, kpi\_month, report\_id, total\_value)  
	 **select** t1.area\_code,  
			t1.kpi\_month,  
			t1.report\_id,  
			t1.total\_value \+ (x11.total\_value\*x12.rate\_allocate) **as** total\_value  
	**from** finalproject.tmp\_accurate\_accounting\_card\_income t1  
	**join**  
	(  
		\-- lay ra gia tri hach toan chinh xac  
		**select** total\_value  
		**from** finalproject.tmp\_accurate\_accounting\_card\_income  
		**where** report\_id \= 5 **and** area\_code \= 'A'  
	)x11 **on** 1\=1  
	**join**  
	(		  
		\-- lay ra ty le phan bo  
		**select** kpi\_month,  
				 area\_code,  
				so\_the\_psdn/so\_the\_psdn\_toan\_hang::**float8** **as** rate\_allocate  
		**from** finalproject.the\_psdn  
	)x12 **on** t1.area\_code \= x12.area\_code **and** t1.report\_id \= 5  
	**where** t1.report\_id \= 5  
	;  
	\--4.3.4. insert vao bang report tieu chi phi tang han muc  
	**insert** **into** finalproject.report\_tong\_hop  
	(area\_code, kpi\_month, report\_id, total\_value)  
	**select** t1.area\_code,  
			t1.kpi\_month,  
			t1.report\_id,  
			t1.total\_value \+ (x13.total\_value\*x14.rate\_allocate) **as** total\_value  
	**from** finalproject.tmp\_accurate\_accounting\_card\_income t1  
	**join**  
	(  
		\-- lay ra gia tri hach toan chinh xac  
		**select** total\_value  
		**from** finalproject.tmp\_accurate\_accounting\_card\_income  
		**where** report\_id \= 6 **and** area\_code \= 'A'  
	)x13 **on** 1\=1  
	**join**  
	(		  
		\-- lay ra ty le phan bo  
		**select** kpi\_month,  
				 area\_code,  
				avg\_total\_os\_area/avg\_total\_os\_all **as** rate\_allocate  
		**from** finalproject.tmp\_total\_os\_db\_grp\_1\_after\_wo  
	)x14 **on** t1.area\_code \= x14.area\_code **and** t1.report\_id \= 6  
	**where** t1.report\_id \= 6  
	;  
	\--4.3.5. insert vao bang report tieu chi phi thanh toan cham khac  
	**insert** **into** finalproject.report\_tong\_hop  
	(area\_code, kpi\_month, report\_id, total\_value)  
	**select** t1.area\_code,  
			t1.kpi\_month,  
			t1.report\_id,  
			t1.total\_value \+ (x15.total\_value\*x16.rate\_allocate) **as** total\_value  
	**from** finalproject.tmp\_accurate\_accounting\_card\_income t1  
	**join**  
	(  
		\-- lay ra gia tri hach toan chinh xac  
		**select** total\_value  
		**from** finalproject.tmp\_accurate\_accounting\_card\_income  
		**where** report\_id \= 7 **and** area\_code \= 'A'  
	)x15 **on** 1\=1  
	**join**  
	(		  
		\-- lay ra ty le phan bo  
		**select** kpi\_month,  
				 area\_code,  
				avg\_total\_os\_area/avg\_total\_os\_all **as** rate\_allocate  
		**from** finalproject.tmp\_total\_os\_db\_grp\_2\_to\_5\_after\_wo  
	)x16 **on** t1.area\_code \= x16.area\_code **and** t1.report\_id \= 7  
	**where** t1.report\_id \= 7  
	;  
	\-- bước 5: chi phí kinh doanh vốn  
	\-- 5.1. insert vào bảng hạch toán chính xác các tiêu chí về chi phí kinh doanh vốn các khu vực  
	  
	**insert** **into** finalproject.tmp\_accurate\_accounting\_captial\_business  
	(kpi\_month, report\_id, area\_code, total\_value)  
	\-- tong doanh thu nguon von toan hang  
	**select**  v\_in\_date\_month **as** kpi\_month,  
			9 **as** report\_id,  
			'NO' **as** area\_code,  
			**sum**(f.amount) **as** total\_value  
	**from** finalproject.fact\_txn\_month\_raw\_data f  
	**where** (f.transaction\_date **between** v\_begining\_year **and** in\_date)  
			  **and** f.account\_code **in**  ('702000040001','702000040002','703000000001','703000000002','703000000003','703000000004', '721000000041',  
								'721000000037','721000000039','721000000013','721000000014','721000000036','723000000014', '723000000037',  
								'821000000014','821000000037','821000000039','821000000041','821000000013','821000000036','823000000014',  
								'823000000037','741031000001','741031000002','841000000001','841000000005','841000000004','701000000001',  
								'701000000002','701037000001','701037000002','701000000101')  
	**union**  
	\-- hach toan cua chi phi von thi truong 2  
	**select**  v\_in\_date\_month **as** kpi\_month,  
			10 **as** report\_id,  
			'A' **as** area\_code,  
			**sum**(f.amount) **as** total\_value  
	**from** finalproject.fact\_txn\_month\_raw\_data f  
	**where** (f.transaction\_date **between** v\_begining\_year **and** in\_date) **and** analysis\_code **like** 'HEAD%'  
			  **and** f.account\_code **in** ('801000000001','802000000001')  
	**union**  
	\-- hach toan cua chi phi von thi truong 1  
	**select**  v\_in\_date\_month **as** kpi\_month,  
			11 **as** report\_id,  
			'A' **as** area\_code,  
			**coalesce**(**sum**(f.amount),0) **as** total\_value  
	**from** finalproject.fact\_txn\_month\_raw\_data f  
	**where** (f.transaction\_date **between** v\_begining\_year **and** in\_date) **and** analysis\_code **like** 'HEAD%'  
			  **and** f.account\_code **in** ('802000000002','802000000003','802014000001','802037000001')  
	**union**  
	\-- hach toan cua chi phi von cctg  
	**select**  v\_in\_date\_month **as** kpi\_month,  
			12 **as** report\_id,  
			'A' **as** area\_code,  
			**sum**(f.amount) **as** total\_value  
	**from** finalproject.fact\_txn\_month\_raw\_data f  
	**where** (f.transaction\_date **between** v\_begining\_year **and** in\_date) **and** analysis\_code **like** 'HEAD%'  
			  **and** f.account\_code **in** ('803000000001')  
		;  
	  
	\-- 5.2. insert vào bảng tỷ lệ phân bổ tiêu chí trong chi phí kinh doanh vốn các khu vực  
	**insert** **into** finalproject.tmp\_allocate\_capital\_business  
	(kpi\_month, area\_code, card\_income, interest\_credit\_card)  
	**select** x17.kpi\_month,  
			x17.area\_code,  
			x17.card\_income,  
			x18.interest\_credit\_card  
	**from**  
	(	\-- thu nhap tu hoat dong the DVML  
		**select** area\_code,kpi\_month,**sum**(total\_value) **as** card\_income  
		**from** finalproject.report\_tong\_hop r  
		**where** (report\_id **between** 3 **and** 7 ) **and** kpi\_month \= v\_in\_date\_month  
		**group** **by** area\_code,kpi\_month  
	)x17  
	**join**  
	(  
		\-- lai thu tu the vay toan hang  
		**select** **sum**(total\_value) **as** interest\_credit\_card  
		**from** finalproject.report\_tong\_hop r  
		**where** area\_code \<\> 'A' **and** (report\_id **between** 3 **and** 7 ) **and** kpi\_month \= v\_in\_date\_month  
	)x18 **on** 1\=1  
	;  
	\-- 5.3. insert vào bảng report 1 cac tieu chi cua chi phí kinh doanh vốn  
	\--5.3.1. insert vao bang report doanh thu nguon von  
	**insert** **into** finalproject.report\_tong\_hop  
	(area\_code, kpi\_month, report\_id, total\_value)  
	**select** t1.area\_code,  
			t1.kpi\_month,  
			9 **as** report\_id,  
			0 **as** total\_value  
	**from** finalproject.tmp\_allocate\_capital\_business t1  
	;  
	  
	\--5.3.2. insert vao bang report cp von tt2  
	**insert** **into** finalproject.report\_tong\_hop  
	(area\_code, kpi\_month, report\_id, total\_value)  
	**select** t1.area\_code,  
			t1.kpi\_month,  
			t2.report\_id,  
			(t2.total\_value)::**float8**\*(t1.card\_income::**float8**/(x19.revenue\_capital \+ t1.interest\_credit\_card)) **as** total\_value  
		**from** finalproject.tmp\_allocate\_capital\_business t1  
		**join** finalproject.tmp\_accurate\_accounting\_captial\_business t2 **on** 1\=1  
		**join**  
		(  
			**select** total\_value **as** revenue\_capital  
			**from** finalproject.tmp\_accurate\_accounting\_captial\_business  
			**where** report\_id \= 9  
		)x19 **on** 1\=1  
		**where** t2.report\_id \= 10  
	  
	;  
	  
	\--5.3.3.insert vao bang report cp von tt1  
	**insert** **into** finalproject.report\_tong\_hop  
	(area\_code, kpi\_month, report\_id, total\_value)  
	**select** t1.area\_code,  
			t1.kpi\_month,  
			t2.report\_id,  
			(t2.total\_value\*t1.card\_income)::**float8**/(x20.revenue\_capital \+ t1.interest\_credit\_card) **as** total\_value  
	**from** finalproject.tmp\_allocate\_capital\_business t1  
	**join** finalproject.tmp\_accurate\_accounting\_captial\_business t2 **on** 1\=1  
	**join**  
	(  
		**select** total\_value **as** revenue\_capital  
		**from** finalproject.tmp\_accurate\_accounting\_captial\_business  
		**where** report\_id \= 9  
	)x20 **on** 1\=1  
	**where** t2.report\_id \= 11  
	;  
	  
	\--5.3.4..insert vao bang report cp von cctg  
	**insert** **into** finalproject.report\_tong\_hop  
	(area\_code, kpi\_month, report\_id, total\_value)  
	**select** t1.area\_code,  
			t1.kpi\_month,  
			t2.report\_id,  
			(t2.total\_value\*t1.card\_income)::**float8**/(x21.revenue\_capital \+ t1.interest\_credit\_card) **as** total\_value  
	**from** finalproject.tmp\_allocate\_capital\_business t1  
	**join** finalproject.tmp\_accurate\_accounting\_captial\_business t2 **on** 1\=1  
	**join**  
	(  
		**select** total\_value **as** revenue\_capital  
		**from** finalproject.tmp\_accurate\_accounting\_captial\_business  
		**where** report\_id \= 9  
	)x21 **on** 1\=1  
	**where** t2.report\_id \= 12  
	;  
	  
	\-- bước 6: chi phí thuần hoạt động khác  
	\-- 6.1. insert vào bảng hạch toán chính xác tiêu chí trong chi phí thuần hoạt động khác  
	**insert** **into** finalproject.tmp\_accurate\_accounting\_net\_other\_operating\_expenses  
	(kpi\_month, report\_id, area\_code, total\_value)  
	\-- hach toan chinh xac doanh thu kinh doanh  
	**select**  v\_in\_date\_month **as** kpi\_month,  
			16 **as** report\_id,  
			**substring**(f.analysis\_code,9,1) **as** area\_code,  
			**sum**(f.amount) **as** total\_value  
	**from** finalproject.fact\_txn\_month\_raw\_data f  
	**where** (f.transaction\_date **between** v\_begining\_year **and** in\_date) **and** analysis\_code **like** 'DVML%'  
			  **and** f.account\_code **in** ('702000010001','702000010002','704000000001','705000000001','709000000001','714000000002','714000000003',  
							'714037000001','714000000004','714014000001','715000000001','715037000001','719000000001','709000000101','719000000101')  
	**group** **by**  **substring**(f.analysis\_code,9,1)  
	**union**  
	\-- hach toan chinh xac doanh thu kinh doanh cua head  
	**select**  v\_in\_date\_month **as** kpi\_month,  
			16 **as** report\_id,  
			'A' **as** area\_code,  
			**sum**(f.amount) **as** total\_value  
	**from** finalproject.fact\_txn\_month\_raw\_data f  
	**where** (f.transaction\_date **between** v\_begining\_year **and** in\_date) **and** analysis\_code **like** 'HEAD%'  
			  **and** f.account\_code **in** ('702000010001','702000010002','704000000001','705000000001','709000000001','714000000002','714000000003',  
							'714037000001','714000000004','714014000001','715000000001','715037000001','719000000001','709000000101','719000000101')  
	**union**  
	\-- hach toan chinh xac chi phi hoa hong  
	**select**  v\_in\_date\_month **as** kpi\_month,  
			17 **as** report\_id,  
			**substring**(f.analysis\_code,9,1) **as** area\_code,  
			**sum**(f.amount) **as** total\_value  
	**from** finalproject.fact\_txn\_month\_raw\_data f  
	**where** (f.transaction\_date **between** v\_begining\_year **and** in\_date) **and** analysis\_code **like** 'DVML%'  
			  **and** f.account\_code **in** ('816000000001','816000000002','816000000003')  
	**group** **by**  **substring**(f.analysis\_code,9,1)  
	**union**  
	\-- hach toan chinh xac chi phi hoa hong cua head  
	**select**  v\_in\_date\_month **as** kpi\_month,  
			17 **as** report\_id,  
			'A' **as** area\_code,  
			**sum**(f.amount) **as** total\_value  
	**from** finalproject.fact\_txn\_month\_raw\_data f  
	**where** (f.transaction\_date **between** v\_begining\_year **and** in\_date) **and** analysis\_code **like** 'HEAD%'  
			  **and** f.account\_code **in** ('816000000001','816000000002','816000000003')  
	**union** 	  
	\-- hach toan chinh xac chi phi thuan kinh doanh khac  
	**select**  v\_in\_date\_month **as** kpi\_month,  
			18 **as** report\_id,  
			**substring**(f.analysis\_code,9,1) **as** area\_code,  
			**sum**(f.amount) **as** total\_value  
	**from** finalproject.fact\_txn\_month\_raw\_data f  
	**where** (f.transaction\_date **between** v\_begining\_year **and** in\_date) **and** analysis\_code **like** 'DVML%'  
			  **and** f.account\_code **in** ('809000000002','809000000001','811000000001','811000000102','811000000002','811014000001','811037000001',  
								'811039000001',	'811041000001','815000000001','819000000002','819000000003','819000000001','790000000003','790000050101',  
								'790000000101','790037000001','849000000001','899000000003','899000000002','811000000101','819000060001')  
	**group** **by**  **substring**(f.analysis\_code,9,1)  
	**union**  
	\-- hach toan chinh xac chi phi thuan kinh doanh khac cua head  
	**select**  v\_in\_date\_month **as** kpi\_month,  
			18 **as** report\_id,  
			'A' **as** area\_code,  
			**sum**(f.amount) **as** total\_value  
	**from** finalproject.fact\_txn\_month\_raw\_data f  
	**where** (f.transaction\_date **between** v\_begining\_year **and** in\_date) **and** analysis\_code **like** 'HEAD%'  
			  **and** f.account\_code **in** ('809000000002','809000000001','811000000001','811000000102','811000000002','811014000001','811037000001',  
								'811039000001',	'811041000001','815000000001','819000000002','819000000003','819000000001','790000000003','790000050101',  
								'790000000101','790037000001','849000000001','899000000003','899000000002','811000000101','819000060001')  
	  
		;  
	  
	\-- 6.2. insert vào bảng tỷ lệ phân bổ tiêu chí trong chi phí thuần hoạt động khác  
	**insert** **into** finalproject.tmp\_total\_os\_db\_after\_wo  
	(kpi\_month, area\_code, avg\_total\_os\_area, avg\_total\_os\_all)  
	**select**  v\_in\_date\_month **as** kpi\_month,  
			x1.parent\_id **as** area\_code,  
			x1.avg\_total\_os\_area,  
			x2.avg\_total\_os\_all	  
	**from** 	  
	(	  
		\-- tinh trung binh du no cuoi ki trung binh theo tung khu vuc sau khi wo nhom 1 ( t2= avg(t1,t2) )  
		**select** 	parent\_id, v\_in\_date\_month **as** kpi\_month, **avg**(dnck\_kv) **as** avg\_total\_os\_area  
		**from**  
		(	\-- tinh du no cuoi ki tu dau nam den thang hien tai theo tung nhom, tung khu vuc  
			**select** d.parent\_id,f2.kpi\_month, **sum**(f2.outstanding\_principal) **as** dnck\_kv  
			**from** finalproject.fact\_kpi\_month\_raw\_data f2  
			**join** finalproject.dim\_city\_structure d **on**  d.danh\_sach\_vung \= f2.pos\_city  
			**where** (f2.kpi\_month **between** v\_begining\_month\_of\_year **and** v\_in\_date\_month )  
			**group** **by** d.parent\_id,f2.kpi\_month  
		)  
		**group** **by** parent\_id  
	)x1  
	**join**  
	(		\-- dnck trung binh toan hang ( t2= avg(t1,t2) )  
		**select** v\_in\_date\_month **as** kpi\_month, **avg**(avg\_dnck\_toan\_hang ) **as** avg\_total\_os\_all  
		**from**  
		(  
			**select** f2.kpi\_month,**sum**(f2.outstanding\_principal) **as** avg\_dnck\_toan\_hang  
			**from** finalproject.fact\_kpi\_month\_raw\_data f2  
			**where** (f2.kpi\_month **between** v\_begining\_month\_of\_year **and** v\_in\_date\_month)  
			**group** **by** f2.kpi\_month  
		)  
	)x2 **on** 1\=1  
	;  
	\-- 6.3. insert vào bảng report 1 cac tieu chi cua chi phí thuần hoạt động khác  
	\--6.3.1. insert vao bang report chi tieu DT Fintech   
	**insert** **into** finalproject.report\_tong\_hop  
	(area\_code, kpi\_month, report\_id, total\_value)  
	**select** area\_code,  
		 	kpi\_month,  
			14 **as** report\_id,  
			0 **as** total\_value  
	**from** finalproject.tmp\_total\_os\_db\_after\_wo  
	;  
	  
	\--6.3.2. insert vao bang report chi tieu DT tiểu thương, cá nhân   
	**insert** **into** finalproject.report\_tong\_hop  
	(area\_code, kpi\_month, report\_id, total\_value)  
	**select** area\_code,  
		 	kpi\_month,  
			15 **as** report\_id,  
			0 **as** total\_value  
	**from** finalproject.tmp\_total\_os\_db\_after\_wo  
	;  
	\-- 6.3.3. insert vao bang report chi tieu doanh thu kinh doanh  
	**insert** **into** finalproject.report\_tong\_hop  
	(area\_code, kpi\_month, report\_id, total\_value)  
	**select**  t1.area\_code,  
			t1.kpi\_month,  
			t2.report\_id,  
			t2.total\_value \+ (x.total\_value\*t1.avg\_total\_os\_area)/t1.avg\_total\_os\_all **as** total\_value  
	**from** finalproject.tmp\_total\_os\_db\_after\_wo t1  
	**join** finalproject.tmp\_accurate\_accounting\_net\_other\_operating\_expenses t2 **on** t1.area\_code \= t2.area\_code **and** t2.report\_id \= 16  
	**join**  
	(  
		**select** total\_value  
		**from** finalproject.tmp\_accurate\_accounting\_net\_other\_operating\_expenses  
		**where** report\_id \= 16 **and** area\_code \= 'A'  
	)x **on** 1\=1  
	;  
	\--6.3.4.insert vao bang report chi tieu CP hoa hồng   
	**insert** **into** finalproject.report\_tong\_hop  
	(area\_code, kpi\_month, report\_id, total\_value)  
	**select**  t1.area\_code,  
			t1.kpi\_month,  
			t2.report\_id,  
			t2.total\_value \+ (x.total\_value\*t1.avg\_total\_os\_area)/t1.avg\_total\_os\_all **as** total\_value  
	**from** finalproject.tmp\_total\_os\_db\_after\_wo t1  
	**join** finalproject.tmp\_accurate\_accounting\_net\_other\_operating\_expenses t2 **on** t1.area\_code \= t2.area\_code **and** t2.report\_id \= 17  
	**join**  
	(  
		**select** total\_value  
		**from** finalproject.tmp\_accurate\_accounting\_net\_other\_operating\_expenses  
		**where** report\_id \= 17 **and** area\_code \= 'A'  
	)x **on** 1\=1  
	;  
	\--6.3.5.insert vao bang report chi tieu CP thuần KD khác   
	**insert** **into** finalproject.report\_tong\_hop  
	(area\_code, kpi\_month, report\_id, total\_value)  
	**select**  t1.area\_code,  
			t1.kpi\_month,  
			t2.report\_id,  
			t2.total\_value \+ (x.total\_value\*t1.avg\_total\_os\_area)/t1.avg\_total\_os\_all **as** total\_value  
	**from** finalproject.tmp\_total\_os\_db\_after\_wo t1  
	**join** finalproject.tmp\_accurate\_accounting\_net\_other\_operating\_expenses t2 **on** t1.area\_code \= t2.area\_code **and** t2.report\_id \= 18  
	**join**  
	(  
		**select** total\_value  
		**from** finalproject.tmp\_accurate\_accounting\_net\_other\_operating\_expenses  
		**where** report\_id \= 18 **and** area\_code \= 'A'  
	)x **on** 1\=1  
	;  
	\--6.3.6.insert vao bang report chi tieu CP hợp tác kd tàu (net)   
	**insert** **into** finalproject.report\_tong\_hop  
	(area\_code, kpi\_month, report\_id, total\_value)  
	**select** area\_code,  
		 	kpi\_month,  
			19 **as** report\_id,  
			0 **as** total\_value  
	**from** finalproject.tmp\_total\_os\_db\_after\_wo  
	;  
	\-- bước 7: tổng chi phí hoạt động  
	\-- 7.1. insert vào bảng so\_nhan\_vien 	  
	  
	**insert** **into** finalproject.number\_of\_employees  
	(area\_code, kpi\_month, no\_of\_employees\_area, no\_of\_employees\_all)  
	**select** **case**  
				**when** k.area\_name \='Đông Bắc Bộ' **then** 'B'  
				**when** k.area\_name \='Tây Bắc Bộ' **then** 'C'  
				**when** k.area\_name \='Đồng Bằng Sông Hồng' **then** 'D'  
				**when** k.area\_name \='Bắc Trung Bộ' **then** 'E'  
				**when** k.area\_name \='Nam Trung Bộ' **then** 'F'  
				**when** k.area\_name \='Tây Nam Bộ' **then** 'G'  
				**when** k.area\_name \='Đông Nam Bộ' **then** 'H'  
			**END** **as** area\_code,  
			v\_in\_date\_month **as** kpi\_month,  
			k.so\_nhan\_vien **as** no\_of\_employees\_area,  
			j.so\_nhan\_vien\_toan\_hang **as** no\_of\_employees\_all  
	**from**  
	(  
		**select** area\_name, **count**(**distinct** email) **as** so\_nhan\_vien  
		**from** finalproject.kpi\_asm\_data  
	\-- boi vi co the tháng cần làm bao cao nhan vien do chua lam viec  
		**where** (v\_in\_date\_month \= '202301' **and** jan\_ltn **is** **not** **null**) **or** (v\_in\_date\_month \= '202302' **and** feb\_ltn **is** **not** **null**) **or**  
				 (v\_in\_date\_month \= '202303' **and** mar\_ltn **is** **not** **null**) **or** (v\_in\_date\_month \= '202304' **and** apr\_ltn **is** **not** **null**)  
				**or** (v\_in\_date\_month \= '202305' **and** may\_ltn **is** **not** **null**)  
		**group** **by** area\_name  
	)k  
	**join**  
	(  
		**select** **count**(**distinct** k.email) **as** so\_nhan\_vien\_toan\_hang  
		**from** finalproject.kpi\_asm\_data k  
		**where** (v\_in\_date\_month \= '202301' **and** jan\_ltn **is** **not** **null**) **or** (v\_in\_date\_month \= '202302' **and** feb\_ltn **is** **not** **null**) **or**  
				 (v\_in\_date\_month \= '202303' **and** mar\_ltn **is** **not** **null**) **or** (v\_in\_date\_month \= '202304' **and** apr\_ltn **is** **not** **null**)  
				**or** (v\_in\_date\_month \= '202305' **and** may\_ltn **is** **not** **null**)  
	)j **on** 1\=1  
	  
	;  
	  
	\-- 7.2. insert vào bảng hạch toán chính xác trong tổng chi phí hoạt động  
	**insert** **into** finalproject.tmp\_accurate\_accounting\_operating\_expenses  
	(kpi\_month, report\_id, area\_code, total\_value)  
	\-- hach toan chinh xac chi phi nhan vien  
	**select**  v\_in\_date\_month **as** kpi\_month,  
			23 **as** report\_id,  
			**substring**(f.analysis\_code,9,1) **as** area\_code,  
			**sum**(f.amount) **as** total\_value  
	**from** finalproject.fact\_txn\_month\_raw\_data f  
	**where** (f.transaction\_date **between** v\_begining\_year **and** in\_date) **and** analysis\_code **like** 'DVML%'  
			  **and** f.account\_code **like** '85%'  
	**group** **by**  **substring**(f.analysis\_code,9,1)  
	**union**  
	\-- hach toan chinh xac chi phi nhan vien  cua head  
	**select**  v\_in\_date\_month **as** kpi\_month,  
			23 **as** report\_id,  
			'A' **as** area\_code,  
			**sum**(f.amount) **as** total\_value  
	**from** finalproject.fact\_txn\_month\_raw\_data f  
	**where** (f.transaction\_date **between** v\_begining\_year **and** in\_date) **and** analysis\_code **like** 'HEAD%'  
			  **and** f.account\_code **like** '85%'  
	**union**  
	\-- hach toan chinh xac CP quản lý  
	**select**  v\_in\_date\_month **as** kpi\_month,  
			24 **as** report\_id,  
			**substring**(f.analysis\_code,9,1) **as** area\_code,  
			**sum**(f.amount) **as** total\_value  
	**from** finalproject.fact\_txn\_month\_raw\_data f  
	**where** (f.transaction\_date **between** v\_begining\_year **and** in\_date) **and** analysis\_code **like** 'DVML%'  
			  **and** f.account\_code **like** '86%'  
	**group** **by**  **substring**(f.analysis\_code,9,1)  
	**union**  
	\-- hach toan chinh xac CP quản lý cua head  
	**select**  v\_in\_date\_month **as** kpi\_month,  
			24 **as** report\_id,  
			'A' **as** area\_code,  
			**sum**(f.amount) **as** total\_value  
	**from** finalproject.fact\_txn\_month\_raw\_data f  
	**where** (f.transaction\_date **between** v\_begining\_year **and** in\_date) **and** analysis\_code **like** 'HEAD%'  
			  **and** f.account\_code **like** '86%'  
	**union**  
	\-- hach toan chinh xac CP tài sản  
	**select**  v\_in\_date\_month **as** kpi\_month,  
			25 **as** report\_id,  
			**substring**(f.analysis\_code,9,1) **as** area\_code,  
			**sum**(f.amount) **as** total\_value  
	**from** finalproject.fact\_txn\_month\_raw\_data f  
	**where** (f.transaction\_date **between** v\_begining\_year **and** in\_date) **and** analysis\_code **like** 'DVML%'  
			  **and** f.account\_code **like** '87%'  
	**group** **by**  **substring**(f.analysis\_code,9,1)  
	**union**  
	\-- hach toan chinh xac CP tài sản cua head  
	**select**  v\_in\_date\_month **as** kpi\_month,  
			25 **as** report\_id,  
			'A' **as** area\_code,  
			**sum**(f.amount) **as** total\_value  
	**from** finalproject.fact\_txn\_month\_raw\_data f  
	**where** (f.transaction\_date **between** v\_begining\_year **and** in\_date) **and** analysis\_code **like** 'HEAD%'  
			  **and** f.account\_code **like** '87%'  
	;  
	\-- 7.3. insert vào bảng report 1 cac tieu chi cua tổng chi phí hoạt động  
	\--7.3.1. insert vao bang report tieu chi CP thuế, phí  
	**insert** **into** finalproject.report\_tong\_hop  
	(area\_code, kpi\_month, report\_id, total\_value)  
	**select** area\_code,  
			 kpi\_month,  
			22 **as** report\_id,  
			0 **as** total\_value  
	**from** finalproject.number\_of\_employees  
	;  
	\--7.3.2.insert vao bang report tieu chi CP nhân viên  
	**insert** **into** finalproject.report\_tong\_hop  
	(area\_code, kpi\_month, report\_id, total\_value)  
	**select** t1.area\_code,  
			t1.kpi\_month,  
			t1.report\_id,  
			t1.total\_value \+ (x.total\_value\*n.no\_of\_employees\_area)/n.no\_of\_employees\_all **as** total\_value  
	**from** finalproject.tmp\_accurate\_accounting\_operating\_expenses t1  
	**join** finalproject.number\_of\_employees n **on** t1.area\_code \= n.area\_code **and** t1.report\_id \= 23 **and** n.kpi\_month \= t1.kpi\_month  
	**join**  
	(  
		**select** total\_value  
		**from** finalproject.tmp\_accurate\_accounting\_operating\_expenses  
		**where** report\_id \= 23 **and** area\_code \= 'A'  
	)x **on** 1\=1  
	**where** t1.report\_id \= 23  
		;  
	\--7.3.3.insert vao bang report tieu chi CP quản lý  
	**insert** **into** finalproject.report\_tong\_hop  
	(area\_code, kpi\_month, report\_id, total\_value)  
	**select** t1.area\_code,  
			t1.kpi\_month,  
			t1.report\_id,  
			t1.total\_value \+ (x.total\_value\*n.no\_of\_employees\_area)/n.no\_of\_employees\_all **as** total\_value  
	**from** finalproject.tmp\_accurate\_accounting\_operating\_expenses t1  
	**join** finalproject.number\_of\_employees n **on** t1.area\_code \= n.area\_code **and** t1.report\_id \= 24  
	**join**  
	(  
		**select** total\_value  
		**from** finalproject.tmp\_accurate\_accounting\_operating\_expenses  
		**where** report\_id \= 24 **and** area\_code \= 'A'  
	)x **on** 1\=1  
	**where** t1.report\_id \= 24  
		;  
	\--7.3.4.insert vao bang report tieu chi CP tài sản  
	**insert** **into** finalproject.report\_tong\_hop  
	(area\_code, kpi\_month, report\_id, total\_value)  
	**select** t1.area\_code,  
			t1.kpi\_month,  
			t1.report\_id,  
			t1.total\_value \+ (x.total\_value\*n.no\_of\_employees\_area)/n.no\_of\_employees\_all **as** total\_value  
	**from** finalproject.tmp\_accurate\_accounting\_operating\_expenses t1  
	**join** finalproject.number\_of\_employees n **on** t1.area\_code \= n.area\_code **and** t1.report\_id \= 25 **and** n.kpi\_month \= t1.kpi\_month  
	**join**  
	(  
		**select** total\_value  
		**from** finalproject.tmp\_accurate\_accounting\_operating\_expenses  
		**where** report\_id \= 24 **and** area\_code \= 'A'  
	)x **on** 1\=1  
	**where** t1.report\_id \= 25  
		;  
	\-- bước 8: chi phí dự phòng  
	\-- 8.1. insert vào bảng hạch toán chính xác trong chi phí dự phòng  
	**insert** **into** finalproject.tmp\_accurate\_accounting\_provision\_expenses  
	(kpi\_month, report\_id, area\_code, total\_value)  
	\-- hach toan chinh xac chi phi du phong  
	**select**  v\_in\_date\_month **as** kpi\_month,  
			26 **as** report\_id,  
			**substring**(f.analysis\_code,9,1) **as** area\_code,  
			**sum**(f.amount) **as** total\_value  
	**from** finalproject.fact\_txn\_month\_raw\_data f  
	**where** (f.transaction\_date **between** v\_begining\_year **and** in\_date) **and** analysis\_code **like** 'DVML%'  
			  **and** f.account\_code **in** ('790000050001', '882200050001', '790000030001','882200030001', '790000000001', '790000020101', '882200000001',  
								'882200050101', '882200020101', '882200060001','790000050101', '882200030101')  
	**group** **by**  **substring**(f.analysis\_code,9,1)  
	**union**  
	\-- hach toan chinh xac chi phi du phong cua head  
	**select**  v\_in\_date\_month **as** kpi\_month,  
			26 **as** report\_id,  
			'A' **as** area\_code,  
			**sum**(f.amount) **as** total\_value  
	**from** finalproject.fact\_txn\_month\_raw\_data f  
	**where** (f.transaction\_date **between** v\_begining\_year **and** in\_date) **and** analysis\_code **like** 'HEAD%'  
			  **and** f.account\_code **in** ('790000050001', '882200050001', '790000030001','882200030001', '790000000001', '790000020101', '882200000001',  
								'882200050101', '882200020101', '882200060001','790000050101', '882200030101')  
	  
		;  
	\-- 8.2. insert vào bảng tỷ lệ phân bổ tiêu chí trong chi phí dự phòng  
	\--8.2.1. insert vao bang wo luy ke wo\_by\_month\_grp\_2\_to\_5 ( su dung bang nay tinh luy ke )  
	**insert** **into** finalproject.wo\_by\_month  
	(area\_code, kpi\_month, write\_off\_month, wo\_by\_month)  
	\-- tinh so tien wo theo thang, theo tung khu vuc  
	**select** d.parent\_id **as** area\_code,  
			f2.kpi\_month,  
			f2.write\_off\_month,  
			**sum**(write\_off\_balance\_principal) **as** wo\_by\_month  
	**from** finalproject.fact\_kpi\_month\_raw\_data f2  
	**join** finalproject.dim\_city\_structure d **on** f2.pos\_city \= d.danh\_sach\_vung  
	**where**  (f2.kpi\_month **between** v\_begining\_month\_of\_year **and** v\_in\_date\_month )  
		**and** (f2.write\_off\_month  **between** v\_begining\_month\_of\_year **and** v\_in\_date\_month) \-- thang wo  
		**and** (f2.kpi\_month \= f2.write\_off\_month)  
	**group** **by** d.parent\_id,f2.kpi\_month,f2.write\_off\_month  
	**union**  
	\-- tinh so tien wo theo thangs, theo head  
	**select** 'ALL' **as** area\_code,  
			f2.kpi\_month,  
			f2.write\_off\_month,  
			**sum**(write\_off\_balance\_principal) **as** wo\_by\_month  
	**from** finalproject.fact\_kpi\_month\_raw\_data f2  
	**where**  (f2.kpi\_month **between** v\_begining\_month\_of\_year **and** v\_in\_date\_month )  
		**and** (f2.write\_off\_month  **between** v\_begining\_month\_of\_year **and** v\_in\_date\_month) \-- thang wo  
		**and** (f2.kpi\_month \= f2.write\_off\_month)  
	**group** **by** f2.kpi\_month,f2.write\_off\_month  
	;  
	\-- update cot wo\_luyke cho bang finalproject.wo\_by\_month\_grp\_2\_to\_5  
	**update** finalproject.wo\_by\_month  
	**set** wo\_luyke \= x.wo\_luyke  
		**from**  
			(  
				**select** area\_code,  
						 kpi\_month,  
					\-- ham sum() over tinh luy ke  
					 **sum**(wo\_by\_month) **over** (**partition** **by** area\_code **order** **by** kpi\_month) **as** wo\_luyke  
				**from** finalproject.wo\_by\_month  
			) x  
	**where** x.area\_code \= finalproject.wo\_by\_month.area\_code  
			**and** x.kpi\_month \= finalproject.wo\_by\_month.kpi\_month **and** x.area\_code **is** **not** **null** **and** x.kpi\_month **is** **not** **null**  
	  
	;  
	\--8.2.2. insert vao bang raw os\_bef\_wo  
	**insert** **into** finalproject.os\_bef\_wo  
	(area\_code, kpi\_month, os\_bef\_wo, avg\_total\_os\_all)  
	**select** l.parent\_id **as** area\_code,  
			l.kpi\_month,  
			l.avg\_total\_os\_area \+ s.wo\_luyke **as** os\_bef\_wo,  
			o1.avg\_total\_os\_all \+ k.wo\_luyke **as** avg\_total\_os\_all  
	**from**  
	(			\-- tinh avg\_total\_os\_area tu dau nam den thang xet, tung khu vuc theo nhom 2-\>5 ( t2= avg(t1,t2) )  
			\-- tinh du no cuoi ki tu dau nam den thang hien tai theo tung nhom, tung khu vuc  
			**select** d.parent\_id,f2.kpi\_month, **sum**(f2.outstanding\_principal) **as** avg\_total\_os\_area  
			**from** finalproject.fact\_kpi\_month\_raw\_data f2  
			**join** finalproject.dim\_city\_structure d **on**  d.danh\_sach\_vung \= f2.pos\_city  
			**where** (f2.kpi\_month **between** v\_begining\_month\_of\_year **and** v\_in\_date\_month ) **and** (f2.max\_bucket **between** 2 **and** 5)  
			**group** **by** d.parent\_id,f2.kpi\_month  
	)l  
	**join** finalproject.wo\_by\_month s **on** s.area\_code \= l.parent\_id **and** s.kpi\_month \= l.kpi\_month  
	**join**  
	(  
		**select** area\_code , kpi\_month , wo\_luyke  
		**from** finalproject.wo\_by\_month  
		**where** area\_code \= 'ALL'  
	)k **on** k.kpi\_month \= s.kpi\_month  
	**join**  
	(		\-- dnck trung binh toan hang ( t2= avg(t1,t2) )  
		  
			**select** f2.kpi\_month,**sum**(f2.outstanding\_principal) **as** avg\_total\_os\_all  
			**from** finalproject.fact\_kpi\_month\_raw\_data f2  
			**where** (f2.kpi\_month **between** v\_begining\_month\_of\_year **and** v\_in\_date\_month) **and**  (f2.max\_bucket **between** 2 **and** 5)  
			**group** **by** f2.kpi\_month  
		  
	)o1 **on** o1.kpi\_month \= l.kpi\_month  
	;  
	\--8.2.3. insert vao bang avg\_os\_bef\_wo  
	**insert** **into** finalproject.total\_os\_bef\_wo  
	(area\_code, kpi\_month, total\_os\_area\_bef\_wo, total\_os\_all)  
	**select** area\_code,  
			v\_in\_date\_month **as** kpi\_month,  
			**sum**(os\_bef\_wo) **as** total\_os\_area\_bef\_wo,  
			**sum**(avg\_total\_os\_all) **as** total\_os\_all  
	**from** finalproject.os\_bef\_wo  
	**group** **by** area\_code  
	;  
	\-- 8.3. insert vào bảng report 1 cac tieu chi cua chi phí dự phòng  
	**insert** **into** finalproject.report\_tong\_hop  
	(area\_code, kpi\_month, report\_id, total\_value)  
	**select** t1.area\_code,  
			t1.kpi\_month,  
			t1.report\_id,  
			t1.total\_value \+ (x.total\_value\*a.total\_os\_area\_bef\_wo)::**float8**/a.total\_os\_all **as** total\_value  
	**from** finalproject.tmp\_accurate\_accounting\_provision\_expenses t1  
	**join** finalproject.total\_os\_bef\_wo a **on** t1.area\_code \= a.area\_code **and** t1.kpi\_month \= a.kpi\_month  
	**join**  
	(  
		**select** total\_value  
		**from** finalproject.tmp\_accurate\_accounting\_provision\_expenses  
		**where** area\_code \= 'A'  
	)x **on** 1\=1  
	;  
	\-- buoc 10\. insert vao report tieu chi hoi so 'A'  
	**insert** **into** finalproject.report\_tong\_hop  
	(area\_code, kpi\_month, report\_id, total\_value)  
	\-- id 3-\> 7  
	**select** 'A' **as** area\_code,  
			t1.kpi\_month,  
			t1.report\_id,  
			t1.total\_value **as** total\_value  
	**from** finalproject.tmp\_accurate\_accounting\_card\_income t1  
	**where** t1.area\_code \= 'A'  
	**union**  
	\-- id 9  
	**select** 'A' **as** area\_code,  
			t2.kpi\_month,  
			'9' **as** report\_id,  
			0 **as** total\_value  
	**from** finalproject.tmp\_accurate\_accounting\_captial\_business t2  
	**union**  
	\-- id 10-\> 12  
	**select** 'A' **as** area\_code,  
			t2.kpi\_month,  
			t2.report\_id,  
			t2.total\_value **as** total\_value  
	**from** finalproject.tmp\_accurate\_accounting\_captial\_business t2  
	**where** t2.area\_code \= 'A'  
	**union**  
	\-- id 14  
	**select** 'A' **as** area\_code,  
			t3.kpi\_month,  
			'14' **as** report\_id,  
			0 **as** total\_value  
	**from** finalproject.tmp\_accurate\_accounting\_net\_other\_operating\_expenses t3  
	**union**  
	\-- id 15  
	**select** 'A' **as** area\_code,  
			t3.kpi\_month,  
			'15' **as** report\_id,  
			0 **as** total\_value  
	**from** finalproject.tmp\_accurate\_accounting\_net\_other\_operating\_expenses t3  
	**union**  
	\-- id 16, 17,18  
	**select** 'A' **as** area\_code,  
			t3.kpi\_month,  
			t3.report\_id,  
			t3.total\_value **as** total\_value  
	**from** finalproject.tmp\_accurate\_accounting\_net\_other\_operating\_expenses t3  
	**where** t3.area\_code \= 'A'  
	**union**  
	\-- id 19  
	**select** 'A' **as** area\_code,  
			t3.kpi\_month,  
			'19' **as** report\_id,  
			0 **as** total\_value  
	**from** finalproject.tmp\_accurate\_accounting\_net\_other\_operating\_expenses t3  
	**union**  
	\-- id 22  
	**select** 'A' **as** area\_code,  
			t4.kpi\_month,  
			'22' **as** report\_id,  
			0 **as** total\_value  
	**from** finalproject.tmp\_accurate\_accounting\_operating\_expenses t4  
	**union**  
	\-- id 23,24,25  
	**select** 'A' **as** area\_code,  
			t4.kpi\_month,  
			t4.report\_id,  
			t4.total\_value **as** total\_value  
	**from** finalproject.tmp\_accurate\_accounting\_operating\_expenses t4  
	**where** t4.area\_code \= 'A'  
	**union**  
	\-- id 26  
	**select** 'A' **as** area\_code,  
			t5.kpi\_month,  
			t5.report\_id,  
			t5.total\_value **as** total\_value  
	**from** finalproject.tmp\_accurate\_accounting\_provision\_expenses t5  
	**where** t5.area\_code \= 'A'  
	;  
	\-- bước 10: insert vào report tieu chi report level 1  
	**insert** **into** finalproject.report\_tong\_hop  
	(area\_code, kpi\_month, report\_id, total\_value)  
	\-- tinh tieu chi level 1 Thu nhập từ hoạt động thẻ   
	**select** area\_code,  
			kpi\_month,  
			2 **as** report\_id,  
			**sum**(**coalesce**(total\_value,0)) **as** total\_value  
	**from** finalproject.report\_tong\_hop  
	**where** (report\_id **between** 3 **and** 7) **and** kpi\_month \= v\_in\_date\_month  
	**group** **by** area\_code, kpi\_month  
	**union**  
	\-- tinh tieu chi level 1 Chi phí thuần KDV   
	**select** area\_code,  
			kpi\_month,  
			8 **as** report\_id,  
			**sum**(**coalesce**(total\_value,0)) **as** total\_value  
	**from** finalproject.report\_tong\_hop  
	**where** (report\_id **between** 9 **and** 12) **and** kpi\_month \= v\_in\_date\_month  
	**group** **by** area\_code, kpi\_month  
	**union**  
	\-- tinh tieu chi level 1 Chi phí thuần hoạt động khác   
	**select** area\_code,  
			kpi\_month,  
			13 **as** report\_id,  
			**sum**(**coalesce**(total\_value,0)) **as** total\_value  
	**from** finalproject.report\_tong\_hop  
	**where** (report\_id **between** 14 **and** 19) **and** kpi\_month \= v\_in\_date\_month  
	**group** **by** area\_code, kpi\_month  
	**union**  
	\-- tinh tieu chi level 1 Tổng chi phí hoạt động  
	**select** area\_code,  
			kpi\_month,  
			21 **as** report\_id,  
			**sum**(**coalesce**(total\_value,0)) **as** total\_value  
	**from** finalproject.report\_tong\_hop  
	**where** (report\_id **between** 22 **and** 25) **and** kpi\_month \= v\_in\_date\_month  
	**group** **by** area\_code, kpi\_month  
	  
	;  
	\-- tinh tieu chi level 1 Tổng thu nhập hoạt động  
	**insert** **into** finalproject.report\_tong\_hop  
	(area\_code, kpi\_month, report\_id, total\_value)  
	**select** area\_code,  
			kpi\_month,  
			20 **as** report\_id,  
			**sum**(**coalesce**(total\_value,0)) **as** total\_value  
	**from** finalproject.report\_tong\_hop  
	**where** (report\_id **in** (2,8,13)) **and** kpi\_month \= v\_in\_date\_month  
	**group** **by** area\_code, kpi\_month  
	;  
	\-- tinh tieu chi level 0 Lợi nhuận trước thuế  
	**insert** **into** finalproject.report\_tong\_hop  
	(area\_code, kpi\_month, report\_id, total\_value)  
	**select** area\_code,  
			kpi\_month,  
			1 **as** report\_id,  
			**sum**(**coalesce**(total\_value,0)) **as** total\_value  
	**from** finalproject.report\_tong\_hop  
	**where** (report\_id **in** (20,21,26)) **and** kpi\_month \= v\_in\_date\_month  
	**group** **by** area\_code, kpi\_month  
	;  
	\-- B11. insert vao bang cac chi so tai chinh  
	**insert** **into** finalproject.index\_finance  
	(area\_code, kpi\_month, cir, margin, return\_of\_capital, avg\_profit\_per\_employee)  
	**SELECT**  
   x.area\_code,  
   x.kpi\_month,  
   **CASE** **WHEN** y.total\_operating\_income \= 0 **THEN** 0  
        **ELSE** \-((x.total\_operating\_expenses\*100)::**float8** / (y.total\_operating\_income) )  
   **END** **AS** cir,  
    
   **CASE** **WHEN** q.tong\_mau\_margin \= 0 **THEN** 0  
        **ELSE** ((z.profit\_bef\_tax\*100)::**float8** / (q.tong\_mau\_margin) )  
   **END** **AS** margin,  
    
   **CASE** **WHEN** w.net\_operating\_expenses \= 0 **THEN** 0  
        **ELSE** \-((z.profit\_bef\_tax\*100)::**float8** / (w.net\_operating\_expenses) )  
   **END** **AS** return\_of\_capital,  
    
   **CASE** **WHEN** e.no\_of\_employees\_area \= 0 **THEN** 0  
        **ELSE** ((z.profit\_bef\_tax)::**float8** / (e.no\_of\_employees\_area) )  
   **END** **AS** avg\_profit\_per\_employee  
	**from**	  
	(	\-- tong cp hoat dong  
		**select** area\_code,  
				kpi\_month,  
				total\_value **as** total\_operating\_expenses  
		**from**  finalproject.report\_tong\_hop  
		**where** (report\_id \= 21) **and** kpi\_month \= v\_in\_date\_month  
	)x  
	**join**  
	(	\-- tong thu nhap hd  
		**select** area\_code,  
				kpi\_month,  
				total\_value **as** total\_operating\_income  
		**from**  finalproject.report\_tong\_hop  
		**where** (report\_id \= 20) **and** kpi\_month \= v\_in\_date\_month  
	)y **on** x.area\_code \= y.area\_code  
	**join**  
	( 	\-- loi nhuan truoc thue  
		**select** area\_code,  
				kpi\_month,  
				total\_value **as** profit\_bef\_tax  
		**from**  finalproject.report\_tong\_hop  
		**where** (report\_id \= 1) **and** kpi\_month \= v\_in\_date\_month  
	)z **on** z.area\_code \= y.area\_code  
	**join**  
	(	\-- tong : r.thu\_nhap\_tu\_hd\_the+ r.dt\_nguon\_von \+ r.dt\_fintech \+ r.dt\_tieu\_thuong\_ca\_nhan \+ r.dt\_kinh\_doanh  
		**select** area\_code,  
				kpi\_month,  
				**sum**(total\_value) **as** tong\_mau\_margin  
		**from**  finalproject.report\_tong\_hop  
		**where** (report\_id **in** (2,9,14,15,16)) **and** kpi\_month \= v\_in\_date\_month  
		**group** **by** area\_code,kpi\_month  
	)q **on** z.area\_code \= q.area\_code  
	**join**  
	(	\-- chi\_phi\_thuan\_kdv  
		**select** area\_code,  
				kpi\_month,  
				total\_value **as** net\_operating\_expenses  
		**from**  finalproject.report\_tong\_hop  
		**where** (report\_id \= 8) **and** kpi\_month \= v\_in\_date\_month  
	)w **on** w.area\_code \= q.area\_code  
	**join**  
	(	\-- so\_nhan\_vien  
		**select** area\_code,  
				kpi\_month,  
				no\_of\_employees\_area  
		**from**  finalproject.number\_of\_employees  
		**where** kpi\_month \= v\_in\_date\_month  
	)e **on** w.area\_code \= e.area\_code  
	;  
	  
	\-- B12. REPORT 2 : insert vao report 2  
	 \-- 12.1. insert vao bang report 2  
		\-- insert report 2 : ltn avg ( id \= 1\)  
		**insert** **into** finalproject.report\_rank\_asm  
		(kpi\_month, area\_code,sale\_name, email, report\_id, total\_value )  
		**select** v\_in\_date\_month **as** kpi\_month,  
				d.ma\_tinh\_thanh **as** area\_code,  
				k.sale\_name,  
				k.email,  
				1 **as** report\_id,  
				**case**  
					**when** v\_in\_date\_month \= '202301' **then** **coalesce**(jan\_ltn::**float**,0)  
					**when** v\_in\_date\_month \= '202302' **then** **coalesce**((**coalesce**(jan\_ltn,0) \+ **coalesce**(feb\_ltn,0))::**float**/2,0)  
					**when** v\_in\_date\_month \= '202303' **then** **coalesce**((**coalesce**(jan\_ltn,0) \+ **coalesce**(feb\_ltn,0) \+ **coalesce**(mar\_ltn,0))::**float**/3, 0)  
					**when** v\_in\_date\_month \= '202304' **then** **coalesce**((**coalesce**(jan\_ltn,0) \+ **coalesce**(feb\_ltn,0) \+ **coalesce**(mar\_ltn,0) \+ **coalesce**(apr\_ltn,0))::**float**/4,0)  
					**when** v\_in\_date\_month \= '202305' **then** **coalesce**((**coalesce**(jan\_ltn,0) \+ **coalesce**(feb\_ltn,0) \+ **coalesce**(mar\_ltn,0) \+ **coalesce**(apr\_ltn,0) \+ **coalesce**(may\_ltn,0))::**float**/5,0)  
				**end** **as** total\_value  
		**from** finalproject.kpi\_asm\_data k  
		**left** **join** finalproject.dim\_city\_structure d **on** k.area\_name \= d.danh\_sach\_vung  
		\-- loai bo nhung gia tri null tai thang truyen vao ( do null thi asm do chua lam viec tai thang do )  
		**where** (v\_in\_date\_month \= '202301' **and** jan\_ltn **is** **not** **null**) **or** (v\_in\_date\_month \= '202302' **and** feb\_ltn **is** **not** **null**) **or**  
				 (v\_in\_date\_month \= '202303' **and** mar\_ltn **is** **not** **null**) **or** (v\_in\_date\_month \= '202304' **and** apr\_ltn **is** **not** **null**)  
				**or** (v\_in\_date\_month \= '202305' **and** may\_ltn **is** **not** **null**)  
		  
		;  
		\-- insert report 2 : psdn avg (id \= 2\)  
		**insert** **into** finalproject.report\_rank\_asm  
		(kpi\_month, area\_code,sale\_name, email, report\_id, total\_value )  
		**select** v\_in\_date\_month **as** kpi\_month,  
				d.ma\_tinh\_thanh **as** area\_code,  
				k.sale\_name,  
				k.email,  
				2 **as** report\_id,  
				**case**  
					**when** v\_in\_date\_month \= '202301' **then** **coalesce**(jan\_psdn::**float**,0)  
					**when** v\_in\_date\_month \= '202302' **then** **coalesce**((**coalesce**(jan\_psdn,0) \+ **coalesce**(feb\_psdn,0))::**float**/2,0)  
					**when** v\_in\_date\_month \= '202303' **then** **coalesce**((**coalesce**(jan\_ltn,0) \+ **coalesce**(feb\_psdn,0) \+ **coalesce**(mar\_psdn,0))::**float**/3,0)  
					**when** v\_in\_date\_month \= '202304' **then** **coalesce**((**coalesce**(jan\_psdn,0) \+ **coalesce**(feb\_psdn,0) \+ **coalesce**(mar\_psdn,0) \+ **coalesce**(apr\_psdn,0))::**float**/4, 0)  
					**when** v\_in\_date\_month \= '202305' **then**  **coalesce**((**coalesce**(jan\_psdn,0) \+ **coalesce**(feb\_psdn,0) \+ **coalesce**(mar\_psdn,0) \+ **coalesce**(apr\_psdn,0) \+ **coalesce**(may\_psdn,0))::**float**/5, 0)  
				**end** **as** total\_value  
		**from** finalproject.kpi\_asm\_data k  
		**left** **join** finalproject.dim\_city\_structure d **on** k.area\_name \= d.danh\_sach\_vung  
		\-- loai bo nhung gia tri null tai thang truyen vao ( do null thi asm do chua lam viec tai thang do )  
		**where** (v\_in\_date\_month \= '202301' **and** jan\_ltn **is** **not** **null**) **or** (v\_in\_date\_month \= '202302' **and** feb\_ltn **is** **not** **null**) **or**  
				 (v\_in\_date\_month \= '202303' **and** mar\_ltn **is** **not** **null**) **or** (v\_in\_date\_month \= '202304' **and** apr\_ltn **is** **not** **null**)  
				**or** (v\_in\_date\_month \= '202305' **and** may\_ltn **is** **not** **null**)  
			;  
		\-- insert report 2 : approval\_rate avg (id \= 3\)  
		**insert** **into** finalproject.report\_rank\_asm  
		(kpi\_month, area\_code, sale\_name, email, report\_id, total\_value )  
		**select** v\_in\_date\_month **as** kpi\_month,  
				d.ma\_tinh\_thanh **as** area\_code,  
				k.sale\_name,  
				k.email,  
				3 **as** report\_id,  
				**case**  
					**when** v\_in\_date\_month \= '202301' **then** **coalesce**(jan\_approval\_rate,0)  
					**when** v\_in\_date\_month \= '202302' **then** **coalesce**((**coalesce**(jan\_approval\_rate,0) \+ **coalesce**(feb\_approval\_rate,0))::**float**/2, 0)  
					**when** v\_in\_date\_month \= '202303' **then** **coalesce**((**coalesce**(jan\_approval\_rate,0) \+ **coalesce**(feb\_approval\_rate,0) \+ **coalesce**(mar\_approval\_rate,0))::**float**/3 ,0)  
					**when** v\_in\_date\_month \= '202304' **then** **coalesce**((**coalesce**(jan\_approval\_rate,0) \+ **coalesce**(feb\_approval\_rate,0) \+ **coalesce**(mar\_approval\_rate,0) \+ **coalesce**(apr\_approval\_rate,0))::**float**/4, 0)  
					**when** v\_in\_date\_month \= '202305' **then** **coalesce**((**coalesce**(jan\_approval\_rate,0) \+ **coalesce**(feb\_approval\_rate,0) \+ **coalesce**(mar\_approval\_rate,0) \+ **coalesce**(apr\_approval\_rate,0) \+ **coalesce**(may\_approval\_rate,0))::**float**/5, 0)  
				**end** **as** total\_value  
		**from** finalproject.kpi\_asm\_data k  
		**left** **join** finalproject.dim\_city\_structure d **on** k.area\_name \= d.danh\_sach\_vung  
		\-- loai bo nhung gia tri null tai thang truyen vao ( do null thi asm do chua lam viec tai thang do )  
		**where** (v\_in\_date\_month \= '202301' **and** jan\_ltn **is** **not** **null**) **or** (v\_in\_date\_month \= '202302' **and** feb\_ltn **is** **not** **null**) **or**  
				 (v\_in\_date\_month \= '202303' **and** mar\_ltn **is** **not** **null**) **or** (v\_in\_date\_month \= '202304' **and** apr\_ltn **is** **not** **null**)  
				**or** (v\_in\_date\_month \= '202305' **and** may\_ltn **is** **not** **null**)  
			;  
	\-- insert vao bang SDCK sau wo  
	**insert** **into** finalproject.os\_after\_wo  
	(area\_code, kpi\_month, total\_os\_area, total\_os\_all)  
	\-- lay ra dnck sau wo nhom 3-5 tung khu vuc va dnck sau wo toan hang  
	**select** l.parent\_id **as** area\_code,  
			v\_in\_date\_month **as** kpi\_month,  
			total\_os\_area\_grp\_3\_to\_5 **as** total\_os\_area ,  
			 total\_os\_area **as** total\_os\_all  
	  
	**from**  
	(	  
		\-- tinh dnck\_kv tu dau nam den thang xet, tung khu vuc theo nhom 3-\>5  
			**select** d.parent\_id,f2.kpi\_month, **sum**(f2.outstanding\_principal) **as** total\_os\_area\_grp\_3\_to\_5  
			**from** finalproject.fact\_kpi\_month\_raw\_data f2  
			**join** finalproject.dim\_city\_structure d **on**  d.danh\_sach\_vung \= f2.pos\_city  
			**where** (f2.kpi\_month \= v\_in\_date\_month) **and** (f2.max\_bucket **between** 3 **and** 5)  
			**group** **by** d.parent\_id, f2.kpi\_month  
	)l  
	**join**  
	(	  
			\-- dnck khu vuc sau wo  
			**select** d.parent\_id,f2.kpi\_month, **sum**(f2.outstanding\_principal) **as** total\_os\_area  
			**from** finalproject.fact\_kpi\_month\_raw\_data f2  
			**join** finalproject.dim\_city\_structure d **on**  d.danh\_sach\_vung \= f2.pos\_city  
			**where** (f2.kpi\_month \= v\_in\_date\_month)  
			**group** **by** d.parent\_id, f2.kpi\_month  
		  
	)o1 **on** o1.kpi\_month \= l.kpi\_month **and** l.parent\_id \= o1.parent\_id  
	  
	;  
	  
	\-- insert vao bang npl  
	**insert** **into** finalproject.npl\_truoc\_wo\_luy\_ke  
	(area\_code, kpi\_month, npl\_bef\_wo)  
	**select** o.area\_code,  
			o.kpi\_month,  
			(o.total\_os\_area \+ w.wo\_luyke)::**float8**\*100/(o.total\_os\_all \+ w.wo\_luyke) **as** npl\_bef\_wo  
	**from** finalproject.os\_after\_wo o  
	**join** finalproject.wo\_by\_month w **on** w.area\_code \= o.area\_code **and** w.kpi\_month \= o.kpi\_month  
	  
	;  
	\-- insert report 2 : npl  
	**insert** **into** finalproject.report\_rank\_asm  
		(kpi\_month, area\_code,sale\_name, email, report\_id, total\_value )  
		**select** n.kpi\_month,  
				n.area\_code,  
				k.sale\_name,  
				k.email,  
				4 **as** report\_id,  
				npl\_bef\_wo **as** npl\_truoc\_wo\_luy\_ke  
		**from** finalproject.kpi\_asm\_data k  
		**left** **join** finalproject.dim\_city\_structure d **on** k.area\_name \= d.danh\_sach\_vung  
		**join** finalproject.npl\_truoc\_wo\_luy\_ke n **on** n.area\_code \= d.ma\_tinh\_thanh  
	;  
	\-- insert report 2 : cac chi tieu tai chinh  
	\-- cir  
	**insert** **into** finalproject.report\_rank\_asm  
		(kpi\_month, area\_code, sale\_name, email, report\_id, total\_value )  
	**select**  i.kpi\_month,  
			i.area\_code,  
			k.sale\_name ,  
			k.email,  
			5 **as** report\_id,  
			i.cir **as** total\_value  
	**from** finalproject.kpi\_asm\_data k  
	**left** **join** finalproject.dim\_city\_structure d **on** k.area\_name \= d.danh\_sach\_vung  
	**join** finalproject.index\_finance i **on** i.area\_code \= d.ma\_tinh\_thanh  
	;  
	\-- margin  
	**insert** **into** finalproject.report\_rank\_asm  
		(kpi\_month, area\_code, sale\_name, email, report\_id, total\_value )  
	**select**  i.kpi\_month,  
			i.area\_code,  
			k.sale\_name ,  
			k.email,  
			6 **as** report\_id,  
			i.margin **as** total\_value  
	**from** finalproject.kpi\_asm\_data k  
	**left** **join** finalproject.dim\_city\_structure d **on** k.area\_name \= d.danh\_sach\_vung  
	**join** finalproject.index\_finance i **on** i.area\_code \= d.ma\_tinh\_thanh  
	;  
	  
	\-- hs\_von  
	**insert** **into** finalproject.report\_rank\_asm  
		(kpi\_month, area\_code,sale\_name, email, report\_id, total\_value )  
	**select**  i.kpi\_month,  
			i.area\_code,  
			k.sale\_name,  
			k.email,  
			7 **as** report\_id,  
			i.return\_of\_capital **as** total\_value  
	**from** finalproject.kpi\_asm\_data k  
	**left** **join** finalproject.dim\_city\_structure d **on** k.area\_name \= d.danh\_sach\_vung  
	**join** finalproject.index\_finance i **on** i.area\_code \= d.ma\_tinh\_thanh  
	;  
	\-- hieu\_suat\_binh\_quan\_tren\_nhan\_su  
	**insert** **into** finalproject.report\_rank\_asm  
		(kpi\_month, area\_code, sale\_name, email, report\_id, total\_value )  
	**select**  i.kpi\_month,  
			i.area\_code,  
			k.sale\_name,  
			k.email,  
			8 **as** report\_id,  
			i.avg\_profit\_per\_employee **as** total\_value  
	**from** finalproject.kpi\_asm\_data k  
	**left** **join** finalproject.dim\_city\_structure d **on** k.area\_name \= d.danh\_sach\_vung  
	**join** finalproject.index\_finance i **on** i.area\_code \= d.ma\_tinh\_thanh  
	;  
	\-- B13. ghi thoi gian bat dau va ket thuc chay procedure , xu ly ngoai le va ghi loi  
	\-- Nếu chạy xong không lỗi, ghi nhận thời gian kết thúc và trạng thái thành công  
**begin**  
	**update** finalproject.log\_tracking  
	**set** end\_time \= **clock\_timestamp**(),  
		is\_successful \= **true**  
	**where** procedure\_name \= 'report\_tong\_hop\_T2\_prc' **and** start\_time \= (  
																		**SELECT** **MAX**(start\_time)  
															            **FROM** finalproject.log\_tracking  
															            **WHERE** procedure\_name \= 'report\_tong\_hop\_T2\_prc'  
															        	);  
	\-- bat loi voi exception : ghi nhan tg ket thuc, trang thai va chi tiet loi  
	**exception** **when** **others** **then**  
	**update** finalproject.log\_tracking  
	**set** end\_time \= **clock\_timestamp**(),  
		is\_successful \= **false**,  
		 error\_log \= 'Error while inserting employee: ' || **SQLERRM** || ' \- ' || **SQLSTATE**  
	**where** procedure\_name \= 'report\_tong\_hop\_T2\_prc' **and** start\_time \=(  
																		**SELECT** **MAX**(start\_time)  
															            **FROM** finalproject.log\_tracking  
															            **WHERE** procedure\_name \= 'report\_tong\_hop\_T2\_prc'  
															        	);	  
**end**;  
**end**;  
**$$** **language** plpgsql;

**call** finalproject.report\_tong\_hop\_T2\_prc('2023-05-31');

3. # Viết các Direct Query 

**SELECT**  
   kpi\_month,  
   area\_code,  
   name\_area,  
   sale\_name,  
   email,  
   diem\_quy\_mo \+ diem\_fin **AS** tong\_diem,  
   **RANK**() **OVER** (**PARTITION** **BY** kpi\_month **ORDER** **BY** (diem\_quy\_mo \+ diem\_fin) **ASC**) **AS** rank\_final,  
   ltn\_avg,  
   ltn\_avg\_rank,  
   psdn\_avg,  
   psdn\_avg\_rank,  
   approval\_rate\_avg,  
   approval\_rate\_avg\_rank,  
   npl\_truoc\_wo\_luy\_ke,  
   npl\_truoc\_wo\_luy\_ke\_rank,  
   diem\_quy\_mo,  
   **RANK**() **OVER** (**PARTITION** **BY** kpi\_month **ORDER** **BY** diem\_quy\_mo **ASC**) **AS** rank\_ptkd,  
   cir,  
   cir\_rank,  
   margin,  
   margin\_rank,  
   hs\_von,  
   hs\_von\_rank,  
   hsbq\_nhan\_su,  
   hsbq\_nhan\_su\_rank,  
   diem\_fin,  
   **RANK**() **OVER** (**PARTITION** **BY** kpi\_month **ORDER** **BY** diem\_fin **ASC**) **AS** rank\_fin  
**FROM** (  
   **SELECT**  
       kpi\_month,  
       area\_code,  
       danh\_sach\_vung **AS** name\_area,  
       sale\_name,  
       email,  
       ltn\_avg,  
       ltn\_avg\_rank,  
       psdn\_avg,  
       psdn\_avg\_rank,  
       approval\_rate\_avg,  
       approval\_rate\_avg\_rank,  
       npl\_truoc\_wo\_luy\_ke,  
       npl\_truoc\_wo\_luy\_ke\_rank,  
       ltn\_avg\_rank \+ psdn\_avg\_rank \+ approval\_rate\_avg\_rank \+ npl\_truoc\_wo\_luy\_ke\_rank **AS** diem\_quy\_mo,  
       cir,  
       cir\_rank,  
       margin,  
       margin\_rank,  
       hs\_von,  
       hs\_von\_rank,  
       hsbq\_nhan\_su,  
       hsbq\_nhan\_su\_rank,  
       cir\_rank \+ margin\_rank \+ hs\_von\_rank \+ hsbq\_nhan\_su\_rank **AS** diem\_fin  
   **FROM** (  
       **SELECT**  
           r.kpi\_month,  
           r.area\_code,  
           dcs.danh\_sach\_vung,  
           r.sale\_name,  
           r.email,  
           **MAX**(**CASE** **WHEN** r.report\_id \= 1 **THEN** r.total\_value **END**) **AS** ltn\_avg,  
           **MAX**(**CASE** **WHEN** r.report\_id \= 1 **THEN** r.ranked\_desc **END**) **AS** ltn\_avg\_rank,  
           **MAX**(**CASE** **WHEN** r.report\_id \= 2 **THEN** r.total\_value **END**) **AS** psdn\_avg,  
           **MAX**(**CASE** **WHEN** r.report\_id \= 2 **THEN** r.ranked\_desc **END**) **AS** psdn\_avg\_rank,  
           **MAX**(**CASE** **WHEN** r.report\_id \= 3 **THEN** r.total\_value **END**) **AS** approval\_rate\_avg,  
           **MAX**(**CASE** **WHEN** r.report\_id \= 3 **THEN** r.ranked\_desc **END**) **AS** approval\_rate\_avg\_rank,  
           **MAX**(**CASE** **WHEN** z.report\_id \= 4 **THEN** z.total\_value **END**) **AS** npl\_truoc\_wo\_luy\_ke,  
           **MAX**(**CASE** **WHEN** z.report\_id \= 4 **THEN** z.ranked\_asc\_4 **END**) **AS** npl\_truoc\_wo\_luy\_ke\_rank,  
           **MAX**(**CASE** **WHEN** x.report\_id \= 5 **THEN** x.total\_value **END**) **AS** cir,  
           **MAX**(**CASE** **WHEN** x.report\_id \= 5 **THEN** x.ranked\_asc\_5 **END**) **AS** cir\_rank,  
           **MAX**(**CASE** **WHEN** r.report\_id \= 6 **THEN** r.total\_value **END**) **AS** margin,  
           **MAX**(**CASE** **WHEN** r.report\_id \= 6 **THEN** r.ranked\_desc **END**) **AS** margin\_rank,  
           **MAX**(**CASE** **WHEN** r.report\_id \= 7 **THEN** r.total\_value **END**) **AS** hs\_von,  
           **MAX**(**CASE** **WHEN** r.report\_id \= 7 **THEN** r.ranked\_desc **END**) **AS** hs\_von\_rank,  
           **MAX**(**CASE** **WHEN** r.report\_id \= 8 **THEN** r.total\_value **END**) **AS** hsbq\_nhan\_su,  
           **MAX**(**CASE** **WHEN** r.report\_id \= 8 **THEN** r.ranked\_desc **END**) **AS** hsbq\_nhan\_su\_rank  
       **FROM**  
           (  
               **SELECT**  
                   kpi\_month,  
                   area\_code,  
                   sale\_name,  
                   email,  
                   report\_id,  
                   total\_value,  
                   **DENSE\_RANK**() **OVER** (**PARTITION** **BY** kpi\_month, report\_id **ORDER** **BY** total\_value **DESC**) **AS** ranked\_desc  
               **FROM** finalproject.report\_rank\_asm  
               **WHERE** report\_id **IN** (1,2,3,6,7,8)  
           ) r  
       **JOIN**  
           (  
               **SELECT**  
                   kpi\_month,  
                   area\_code,  
                   sale\_name,  
                   email,  
                   report\_id,  
                   total\_value,  
                   **DENSE\_RANK**() **OVER** (**PARTITION** **BY** kpi\_month, report\_id **ORDER** **BY** total\_value **ASC**) **AS** ranked\_asc\_5  
               **FROM** finalproject.report\_rank\_asm  
               **WHERE** report\_id  \= 5  
           ) x   
       **ON** r.email \= x.email **AND** r.kpi\_month \= x.kpi\_month **AND** r.area\_code \= x.area\_code  
       **JOIN**  
           (  
               **SELECT**  
                   kpi\_month,  
                   area\_code,  
                   sale\_name,  
                   email,  
                   report\_id,  
                   total\_value,  
                   **RANK**() **OVER** (**PARTITION** **BY** kpi\_month, report\_id **ORDER** **BY** total\_value **ASC**) **AS** ranked\_asc\_4  
               **FROM** finalproject.report\_rank\_asm  
               **WHERE** report\_id \= 4  
           ) z  
       **ON** z.email \= x.email **AND** z.kpi\_month \= x.kpi\_month **AND** z.area\_code \= x.area\_code  
       **JOIN** finalproject.dim\_city\_structure dcs **ON** dcs.ma\_tinh\_thanh \= z.area\_code  
       **GROUP** **BY** r.kpi\_month, r.area\_code,r.sale\_name, r.email, dcs.danh\_sach\_vung  
   )  
   **WHERE** ltn\_avg **IS** **NOT** **NULL**  
)  
;  
\-- lấy ra bảng index finance   
**select** dcs.danh\_sach\_vung ,  
		if2.kpi\_month ,  
		if2.cir ,  
		if2.change\_cir,  
		if2.margin ,  
		if2.change\_margin,  
		if2.return\_of\_capital ,  
		if2.change\_roc,  
		if2.avg\_profit\_per\_employee,  
		if2.change\_appe  
**from** finalproject.index\_finance if2  
**join** finalproject.dim\_city\_structure dcs  **on** if2.area\_code \= dcs.ma\_tinh\_thanh  
**order** **by** if2.kpi\_month **asc**;  
\-- lay bang so nhan vien  
**select** d.danh\_sach\_vung **as** region\_name,  
		n.kpi\_month,  
		n.no\_of\_employees\_area,  
		n.no\_of\_employees\_all  
**from** finalproject.number\_of\_employees n  
**join** finalproject.dim\_city\_structure d **on** n.area\_code \= d.ma\_tinh\_thanh

