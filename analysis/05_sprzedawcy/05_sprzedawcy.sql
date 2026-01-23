/* 22. Ilu sprzedawców działa w każdym stanie? */ 

select
	seller_state 
	,count(distinct seller_id )		as nr_of_sellers
from sellers 
group by 1 
order by 2 desc

/* 
wypisuje tylko 10 pierwszych
state 	nr_of_sellers
SP			1849
PR			349
MG			244
SC			190
RJ			171
RS			129
GO			40
DF			30
ES			23
BA			19
 */






/* 23. Który sprzedawca generuje największy przychód? */ 

select
	oi.seller_id 
	,SUM(oi.price )		as total_income
from orders 			o
inner join order_items  oi on o.order_id = oi.order_id 
where o.order_status = 'delivered'
group by 1 
order by 2 desc
limit 1

-- 4869f7a5dfa277a7dca6462dcf3b52b2	226987.93


 


/* 24. Który sprzedawca ma najwyższą średnią wartość zamówienia? */ 

with
base as 
	(
	select
		oi.seller_id 
		,o.order_id 
		,SUM(oi.price)  as order_value
	from orders				o
	inner join order_items  oi on o.order_id = oi.order_id 
	where o.order_status = 'delivered'
	group by 1, 2
	)
select 
	seller_id 
	,round(AVG(order_value), 2) as avg_order_value
from base
group by 1
order by 2 desc


-- e3b4998c7a498169dc7bce44e6bb6277 :	6735.00

-- To samo jeszcze raz policzone z subqueries


select
	t.seller_id
	,avg(t.order_value) as avg_order_value
from 
	(
	select
		oi.seller_id			as seller_id
		,o.order_id
		,sum(oi.price)		as order_value
	from orders 			o
	inner join order_items  oi on o.order_id = oi.order_id 
	where o.order_status = 'delivered'
	group by 1, 2
	) t
group by 1 
order by 2 desc
limit 1
	
-- e3b4998c7a498169dc7bce44e6bb6277	6735.000000
	
	
	
	

/* 25.Czy istnieją sprzedawcy, którzy mają wyraźnie wyższy odsetek opóźnionych dostaw? */

with base as (
  select
    oi.seller_id,
    o.order_id,
    datediff(o.order_delivered_customer_date, o.order_estimated_delivery_date) as delay_days
  from orders o
  join order_items oi on o.order_id = oi.order_id
  where o.order_status = 'delivered'
    and o.order_delivered_customer_date is not null
    and o.order_estimated_delivery_date is not null
),
per_seller as (
  select
    seller_id,
    count(distinct order_id) as total_orders,
    count(distinct case when delay_days > 0 then order_id end) as delayed_orders
  from base
  group by seller_id
)
select
  seller_id,
  total_orders,
  delayed_orders,
  round(delayed_orders / nullif(total_orders, 0) * 100 , 2) as delayed_rate_pct
from per_seller
where total_orders >= 30
order by delayed_rate_pct desc, total_orders desc

/*
mamy wielu sprzedawców którzy mają spore opóźnienia względem estymacji dostawy 
wklejam tylko piersze 10 rekordów 

seller_id							delay_days					
7a67c85e85bb2ce8582c35f2203ad736	188
2a1348e9addc1af5aaa619b1a3679d6b	181
cb41bfbcbda0aea354a834ab222f9a59	175
df683dfda87bf71ac3fc63063fba369d	167
c847e075301870dd144a116762eaff9a	166
2a1348e9addc1af5aaa619b1a3679d6b	165
054694fa03fe82cec4b7551487331d74	162
cac4c8e7b1ca6252d8f20b2fc1a2e4af	161
7e93a43ef30c4f03f38b393420bc753a	161
e83c76265fc54bf41eac728805e4da77	159
 */












	
	
	
	
	
	
	
	
	




