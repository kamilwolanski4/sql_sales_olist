/* 6. Jaki jest łączny przychód (GMV) ze sprzedaży? */ 

select 
	sum(oi.price)
from orders 			o
left join order_items   oi on o.order_id = oi.order_id 
where o.order_status = 'delivered'

-- 13,221,498.11 





/* 7. Jak zmienia się liczba zamówień w czasie (trend miesięczny / roczny)? */ 

select
	year(order_approved_at)		 as year
	,month(order_approved_at)	 as month 
	,count(distinct order_id) 	 as total_orders
from orders
where order_approved_at is not null 
group by 1, 2 

/*
year  month quantity
2016	9	1
2016	10	320
2016	12	1
2017	1	760
2017	2	1765
2017	3	2689
2017	4	2374
2017	5	3693
2017	6	3252
2017	7	3974
2017	8	4348
2017	9	4301
2017	10	4590
2017	11	7395
2017	12	5832
2018	1	7187
2018	2	6706
2018	3	7288
2018	4	6778
2018	5	7066
2018	6	6164
2018	7	6176
2018	8	6620
2018	9	1
*/




/* 8. Jak zmienia się przychód w czasie (trend miesięczny / roczny)? */ 

select
	year(o.order_approved_at)  		as year
	,MONTH(o.order_approved_at) 	as month
	,SUM(oi.price)					as total_revenue
from orders 			 o
left join order_items	 oi on o.order_id = oi.order_id 
where o.order_approved_at is not null 
	and o.order_status = 'delivered'
group by 1, 2
order by 1, 2

/*
year  month  revenue
2016	9	134.97
2016	10	40325.11
2016	12	10.90
2017	1	106888.10
2017	2	234163.38
2017	3	355372.21
2017	4	338207.85
2017	5	490696.21
2017	6	425825.55
2017	7	476556.89
2017	8	555061.46
2017	9	597240.93
2017	10	652987.87
2017	11	972604.18
2017	12	747390.69
2018	1	917667.20
2018	2	819355.27
2018	3	963604.25
2018	4	953526.94
2018	5	999867.28
2018	6	859882.79
2018	7	849818.11
2018	8	862639.54
/*





/* 9. Który miesiąc był najlepszym pod względem liczby zamówień? */ 

select
	year(order_approved_at)		as year
	,month(order_approved_at) 	as month
	,count(distinct order_id)	as nr_of_orders
from orders
where order_approved_at is not null 
group by 1, 2
order by 3 desc
limit 1 

/*
year   month  nr_of_orders
2017	11	     7395
 */






/* 10. Który miesiąc był najlepszy pod względem przychodu? */ 

select 
	year(o.order_approved_at)   as year
	,month(o.order_approved_at)	as month
	,sum(oi.price )				as total_revenue
from orders				o
left join order_items   oi on o.order_id = oi.order_id  
where o.order_approved_at is not null 
	and o.order_status = 'delivered'
group by 1, 2 
order by 3 desc
limit 1 

/* 
year   month    total_revenue
2018	 5		   999867.28
 */





/* 11. Jaka jest średnia wartość zamówienia (AOV – Average Order Value)? */ 

with 
base as 
	(
	select 
		oi.order_id 
		,sum(oi.price)  as income_per_order
	from orders 			o
	left join order_items   oi on o.order_id = oi.order_id 
	where o.order_status = 'delivered'
	group by 1
	)
select 
	AVG(income_per_order) as avg_order_value
from base 
	

-- 137.04





/* 12. Jaka jest średnia liczba produktów (pozycji) w zamówieniu? */ 

with
base as 
	(
	select 
		order_id
		,count(order_item_id) as order_quantity
	from order_items
	group by 1
	)
select
	AVG(order_quantity) avg_quantity
from base 

-- 1.14 






/* 13. Ile zamówień ma więcej niż jeden produkt (multi-item orders)? */

with
base as 
	(
	select
		 order_id
		,count(order_item_id )	as item_quantity
	from order_items
	group by 1
	)
select 
	count(order_id)
from base 
where item_quantity > 1

-- 9 803





























