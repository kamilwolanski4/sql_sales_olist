/* 26. Jaki jest średni koszt dostawy (freight) na zamówienie? */ 


select 
	round(avg(t.freight_value), 2) as avg_freight_value 
from 
	(
	select 
		o.order_id 
		,sum(oi.freight_value) as freight_value
	from orders 			o
	inner join order_items  oi on o.order_id = oi.order_id  
	where o.order_status = 'delivered'
	group by 1
	) t

-- 22.79
	
	
	
	
	
	
/* 27. Jaki jest średni czas dostawy (od zakupu do dostarczenia)? */ 
	
select
	round(avg(t.delivery_days), 2) as avg_delivery_days
from 
	(
	select 
		order_id
		,DATEDIFF(order_delivered_customer_date, order_purchase_timestamp) as delivery_days
	from orders 
	where order_delivered_customer_date is not null
		and order_purchase_timestamp is not null 
		and order_status = 'delivered'
	group by 1, 2
	) t
	
-- 12.5 dnia 

	
	
	

	
/* 28. Jaki jest średni czas od zatwierdzenia zamówienia do dostarczenia? */ 
	
select
	round(avg(t.days_from_approved), 2)  as avg_days_from_approved
from 
	(
	select
		order_id 
		,DATEDIFF(order_delivered_customer_date, order_approved_at) as days_from_approved
	from orders
	where order_delivered_customer_date is not null 
		and order_approved_at is not null
		and order_status = 'delivered'
	group by 1, 2
	) t

-- 11.98
	
	
	
	
	
/* 29.Jaki % zamówień dostarczono po czasie (late deliveries)? */
	
with
delayed_days as 
	(
	select
		order_id 
		,DATEDIFF(order_delivered_customer_date, o.order_estimated_delivery_date) as delayed_days
	from orders			   o 
	where order_delivered_customer_date is not null
		and order_estimated_delivery_date  is not null
		and order_status = 'delivered'
	group by 1, 2
	),
all_orders as
	(
	select 
		count(distinct order_id) as total_orders
	from orders
	where order_status = 'delivered'
		and order_delivered_customer_date is not null
		and order_estimated_delivery_date is not null /* chce dać te same filtry na mianownik co w liczniku by było bardziej spójnie i nie zaniżało wyniku */ 
	)
select
	round(count(dd.delayed_days) / ao.total_orders * 100, 2) as pct_delayed_orders
from delayed_days 		dd 
cross join all_orders   ao
where dd.delayed_days > 0
group by ao.total_orders 
	
	
-- 6.77 %
	
	
/* 30. Jaki % zamówień dostarczono przed estymowaną datą dostawy? */

with 
base as 
	(
	select
		order_id 
		,DATEDIFF(order_estimated_delivery_date, order_delivered_customer_date) as delivery_days
	from orders 
	where order_estimated_delivery_date is not null 
		and order_delivered_customer_date is not null
		and order_status = 'delivered'
	group by 1, 2
	),
total_orders as 
	(
	select 
		count(distinct order_id) as total_orders
	from orders 
	where order_status = 'delivered'
		and order_estimated_delivery_date is not null
		and order_delivered_customer_date is not null
	)
select
	round(count(b.delivery_days) / to1.total_orders * 100, 2)
from base 					b
cross join total_orders		to1
where b.delivery_days > 0
group by to1.total_orders 

	
-- 91.89 %





/* 31. W których stanach dostawy trwają najdłużej (średni delivery time)? */ 


with 
base as 
	(
	select
		c.customer_state 
		,o.order_id
		,DATEDIFF(o.order_delivered_customer_date, o.order_purchase_timestamp) as delivery_time
	from orders				o
	inner join customers    c on o.customer_id = c.customer_id 
	where o.order_purchase_timestamp is not null 
		and o.order_delivered_customer_date is not null 
		and o.order_status = 'delivered'
	group by 1, 2, 3
	)
select 
	customer_state 
	,AVG(delivery_time) as avg_delivery_time
from base 
group by 1
order by 2 desc



-- to samo ale z zastosowaniem window functions 

with 
base as 
	(
	select
		c.customer_state 
		,o.order_id 
		,DATEDIFF(o.order_delivered_customer_date, o.order_purchase_timestamp) as delivery_time
	from orders 		 o
	inner join customers c on o.customer_id = c.customer_id  
	where o.order_delivered_customer_date is not null
		and o.order_purchase_timestamp is not null 
		and o.order_status = 'delivered'
	),
avg_delivery_time as 
	(
	select 
		customer_state
		,avg(delivery_time) as avg_delivery_time
	from base 
	group by 1
	)
select 
	customer_state as state
	,avg_delivery_time 
	,rank() over(order by avg_delivery_time desc) as delivery_time_rank
from avg_delivery_time
order by 3


/*
stan delivery time     rank
RR			29.3415		1
AP			27.1791		2
AM			26.3586		3
AL			24.5013		4
PA			23.7252		5
MA			21.5119		6
SE			21.4627		7
CE			21.2002		8
AC			21.0000		9
PB			20.3888		10
 */



/* 32. Jak różni się czas dostawy pomiędzy kategoriami produktów? */

/* to zapytanie jest dość niepozorne, ale ze względu na to, że jedno order_id może
 nam się pojawić kilka razy to branie z tego średniej zaburzałoby wynik (ziarnistość danych)
 daltego też zrobiłem następujące rzeczy:
 - w pierwszym cte policzylem sredni czas dostawy na dane zamówienie
 - w drugim cte policzylem ile produkto
 */
with 
base as 
	(
	select
		order_id 
		,DATEDIFF(order_delivered_customer_date, order_purchase_timestamp) as delivery_time
	from orders 			o 
	where o.order_delivered_customer_date is not null
		and o.order_purchase_timestamp is not null 
		and o.order_status = 'delivered'
	),
category_rank as 
	(
	select
		oi.order_id
		,p.product_category_name as category
		,count(*) 				 as items_in_category
		,row_number() over (partition by oi.order_id order by count(*) desc, p.product_category_name) as rn
	from order_items 	oi 
	inner join products p  on oi.product_id = p.product_id  
	group by 1, 2
	),
order_main_category as 
	(
	select 
		order_id
		,category
	from category_rank
	where rn = 1
	)
select
	omc.category 
	,round(avg(b.delivery_time), 2) as avg_delivery_time
from base 						b
inner join order_main_category omc  on b.order_id = omc.order_id
group by 1
order by 2 
	
/* 
artes_e_artesanato								5.74
la_cuisine										7.09
livros_importados								7.61
portateis_cozinha_e_preparadores_de_alimentos	8.23
artigos_de_festas								8.82
fashion_roupa_infanto_juvenil					9.60
alimentos										9.74
construcao_ferramentas_iluminacao				9.77
portateis_casa_forno_e_cafe						9.89
bebidas											10.27
 */
