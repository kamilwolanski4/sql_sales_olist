/* 37. Jaka jest średnia ocena (review_score) w całym zbiorze? */ 

select
	round(avg(review_score), 2) as avg_review_score
from order_reviews 

-- 4.09



/* 38. Jak oceny różnią się pomiędzy kategoriami produktów? */ 
/* trzeba zrobić znowu to samo z ziarnistośią danych */
with 
reviews as 
	(
	select
		distinct o.order_id 
		,or1.review_score 
	from orders 			 o
	inner join order_reviews or1  on o.order_id = or1.order_id 
	group by 1, 2
	), 
category_rank as 
	(
	select
		oi.order_id 
		,p.product_category_name 	as category
		,count(*) 					as items_in_category
		,row_number() over (partition by oi.order_id order by count(*) desc, p.product_category_name) as rn
	from order_items		oi
	inner join products 	p on oi.product_id = p.product_id  
	group by 1, 2
	),
main_category as 
	(
	select 
		order_id
		,category
	from category_rank 
	where rn = 1
	)
select
	mc.category
	,round(avg(r.review_score), 2) as avg_review_score
from reviews			 r
inner join main_category mc on r.order_id = mc.order_id
group by 1
order by 2 desc


/* wypisuje pierwsze 10
 livros_interesse_geral				4.47
construcao_ferramentas_ferramentas	4.43
livros_tecnicos						4.41
livros_importados					4.38
alimentos_bebidas					4.38
malas_acessorios					4.34
fashion_roupa_infanto_juvenil		4.33 

 */




/* 39. Czy zamówienia z dłuższym czasem dostawy mają niższe oceny? */ 
with 
delivery_time as
	(
	select
		o.order_id 
		,DATEDIFF(o.order_delivered_customer_date, o.order_purchase_timestamp) as delivery_time
		,t.review_score 
	from orders 			 o
	inner join order_reviews t on o.order_id = t.order_id  
	where o.order_delivered_customer_date is not null
		and o.order_purchase_timestamp is not null 
		and o.order_status = 'delivered'
	group by 1, 2, 3
	),
delivery_group as
	(
	select
		order_id
		,delivery_time
		,review_score 
		,(case when delivery_time <= 2 then 'fast_delivery' 
			when delivery_time > 2 and delivery_time <= 5 then 'mid_delivery'
			when delivery_time > 5 and delivery_time <= 14 then 'slow_delivery'
			else 'very_slow_delivery'
			end ) as delivery_group_time	
	from delivery_time 
	), 
avg_review as 
	(
	select 
		delivery_group_time 
		,AVG(review_score) as avg_review_score
	from delivery_group
	group by 1
	order by 2 desc
	)
select 
	delivery_group_time 
	,round(avg_review_score, 2) 
	,rank() over(order by avg_review_score desc) as ranking
from avg_review 


/* 
 
delivery_group     score    ranking
fast_delivery   	4.49	1
mid_delivery	    4.42	2
slow_delivery	    4.32	3
very_slow_delivery	3.67	4

*/




/* 40. Jaki jest odsetek zamówień z oceną 1–2 (negatywne) i ile z nich było opóźnionych? */

with 
base as 
	(
	select 
		distinct o.order_id 
		,t.review_score 
		,DATEDIFF(o.order_delivered_customer_date, o.order_estimated_delivery_date) as delay_time
	from orders 			 o
	inner join order_reviews t on o.order_id = t.order_id  
	where t.review_score <= 2
		and o.order_delivered_customer_date is not null 
		and o.order_estimated_delivery_date is not null 
		and o.order_status = 'delivered'
	), 
total_orders as
	(
	select 
		count(distinct o.order_id) as nr_of_orders 
	from orders 			 o
	where o.order_delivered_customer_date is not null 
		and o.order_estimated_delivery_date is not null 
		and o.order_status = 'delivered'
	),
nr_low_reviews as
	(
	select
		count(distinct order_id) as nr_of_low_reviews
	from base	
	),
nr_of_low_delay as 
	(
	select 
		count(distinct order_id) as nr_of_low_and_delay_reviews
	from base
	where delay_time > 0
	)
select 
	nlr.nr_of_low_reviews 
	,round((nlr.nr_of_low_reviews / to1.nr_of_orders * 100 ),2) as pct__low_reviews
	,nold.nr_of_low_and_delay_reviews 
from nr_low_reviews 			nlr
cross join total_orders 		to1
cross join nr_of_low_delay		nold 



/*
 nr_low_reviews		pct		 nr_low_and_delay_reviews	
 12310				12.76		3986
 */






/*41. Które top 10 kategorii ma najwyższy średni koszt dostawy w relacji do ceny produktu (freight/price ratio)? */

with
base as
	(
	select
		o.order_id 
		,sum(oi.freight_value) as sum_freight
		,sum(oi.price)		   as sum_price
	from orders				o
	inner join order_items  oi on o.order_id = oi.order_id 
	where o.order_status = 'delivered'
	group by 1
	),
category_rank as
	(
	select
		o.order_id 
		,p.product_category_name 	as category
		,sum(oi.price) 					as value_of_category
		,row_number() over (partition by o.order_id order by sum(oi.price) desc, p.product_category_name ) as rn 
	from orders				o
	inner join order_items  oi on o.order_id = oi.order_id 
	inner join products 	p  on oi.product_id = p.product_id 
	where o.order_status = 'delivered'
	group by 1, 2
	),
final_1 as 
	(
	select
		cr.category
		,b.sum_freight 
		,b.sum_price 
	from base					b
	inner join category_rank 	cr on b.order_id = cr.order_id
	where rn = 1
	)
select
	category
	,count(*) as nr_of_orders 
	,sum(sum_freight) / NULLIF(sum(sum_price), 0) as freight_price_ratio
	,rank() over(order by sum(sum_freight) / NULLIF(sum(sum_price), 0) desc) as ranking
from final_1
group by 1
order by 3 desc
limit 10






/* 42. Czy klienci powracający (2+ zamówienia) wystawiają wyższe oceny niż nowi klienci? */ 
with
base as 
	(
	select 
		c.customer_unique_id as unique_customer_id 
		,count(o.order_id) as nr_of_orders 
	    ,avg(t.review_score) as avg_score
	from orders 			 o
	inner join customers 	 c on o.customer_id = c.customer_id 
	inner join order_reviews t on o.order_id = t.order_id  
	group by 1
	),
returning_customers as 
	(
	select 
		unique_customer_id 
		,avg_score as avg_score_returning_client
	from base 
	where nr_of_orders >= 2
	),
new_customers as 
	(
	select 
		unique_customer_id
		,avg_score as avg_score_new_client 
	from base 
	where nr_of_orders = 1
	),
avg_returning_clients as 
	(
	select
		round(avg(avg_score_returning_client),2) as avg_score_returning_client
	from returning_customers 
	),
avg_score_new_clients as 
	(
	select 
		round(avg(nc.avg_score_new_client), 2) as avg_score_new_client
	from new_customers nc
	)
select 
	arc.avg_score_returning_client 
	,asnc.avg_score_new_client
from avg_returning_clients arc
cross join avg_score_new_clients asnc

/* 
 returning     new
  4.11		   4.08
 */


/* to samo zapytanie można napisać znacznie szybciej */

with
base as 
	(
	select 
		c.customer_unique_id as unique_customer_id 
		,count(o.order_id) as nr_of_orders 
	    ,avg(t.review_score) as avg_score
	from orders 			 o
	inner join customers 	 c on o.customer_id = c.customer_id 
	inner join order_reviews t on o.order_id = t.order_id  
	group by 1
	)
select
	round(avg(case when nr_of_orders >=2 then avg_score end ), 2) as avg_score_returning_clients
	,round(avg(case when nr_of_orders = 1 then avg_score end), 2) as avg_score_new_clients
from base 

/* 
returning new 
  4.11    4.08
 */




/*43. Którzy sprzedawcy mają najwięcej anulowanych zamówień (i jaki jest ich cancel rate)? */ 

with 
canceled_orders as 
	(
	select
		oi.seller_id 
		,COUNT(distinct o.order_id) as nr_of_canceled_orders
	from orders 			o
	inner join order_items  oi on o.order_id = oi.order_id  
	where o.order_status = 'canceled'
	group by 1
	),
total_orders as
	(
	select 
		oi.seller_id 
		,count(distinct o.order_id) as total_orders
	from orders	 		   o
	inner join order_items oi on o.order_id = oi.order_id 
	group by 1
	)
select
	co.seller_id 
	,co.nr_of_canceled_orders 
	,to1.total_orders 
	,round(co.nr_of_canceled_orders / NULLIF(to1.total_orders, 0) * 100, 2) as cancel_rate
from canceled_orders co
inner join total_orders to1 on co.seller_id = to1.seller_id 
order by 2 desc

/* wypisze 10 
   			seller_id			nr_canceled 	total   rate
cc419e0650a3c5ba77189a1882b7556a	9			1706	0.53
6560211a19b47992c3666cc44a7e94c0	7			1854	0.38
620c87c171fb2a6dd6e8bb4dec959fc6	6			740		0.81
81783131d2a97c8d44d406a4be81b5d9	5			13		38.46
a416b6a846a11724393025641d4edd5e	5			162		3.09
c3867b4666c7d76867627c2f7fb22e21	5			245		2.04
1127b7f2594683f2510f1c2c834a486b	4			114		3.51
3d871de0142ce09b7081e2b9d1733cb1	4			1080	0.37
4c8b8048e33af2bf94f2eb547746a916	4			23		17.39
7e93a43ef30c4f03f38b393420bc753a	4			336		1.19
*/




/*Czy istnieje próg liczby rat (np. ≥6), po którym wyraźnie spada średnia ocena zamówienia? */

with
installments as 
	(
	select 
		distinct o.order_id
		,max(op.payment_installments) as payment_installments 
	from orders 				o
	inner join order_payments   op on o.order_id =op.order_id  
	where o.order_status = 'delivered'
	group by 1
	),
reviews as 
	(
	select
		distinct o.order_id 
		,avg(t.review_score) as review_score
	from orders				 o
	inner join order_reviews t on o.order_id = t.order_id  
	where o.order_status = 'delivered'
	group by 1
	)
select
	i.payment_installments 
	,round(avg(r.review_score), 2) as avg_review_score
	,count(*) as nr_of_orders 
from installments		i
inner join reviews 		r on i.order_id = r.order_id 
group by 1
order by 1

/* 
installments  review_score	nr_of_orders 
0					5.00	2
1					4.19	46518
2					4.17	11954
3					4.12	10061
4					4.12	6828
5					4.12	5042
6					4.14	3764
7					4.14	1546
8					4.09	4095
9					4.19	610
 */













