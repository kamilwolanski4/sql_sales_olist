/* UNIKALNOŚĆ KLUCZA */ 

select 
	order_id
	,count(*) as cnt
from orders
group by 1
having count(*) > 1
order by 2 desc

-- brak więc order_id jest unikalny



/* SPÓJNOŚĆ RELACJI (orphans) */
select 
	count(*) as orphan_order_items
from order_items oi
left join orders o on o.order_id = oi.order_id
where o.order_id is null
-- 0


select 
	count(*) as orphan_orders_customers
from orders o
left join customers c on c.customer_id = o.customer_id
where c.customer_id is null
-- 0



select 
	count(*) as orphan_reviews
from order_reviews r
left join orders o on o.order_id = r.order_id
where o.order_id is null
-- 0



select
	count(*) as orphan_payments
from order_payments p
left join orders o on o.order_id = p.order_id
where o.order_id is null
-- 0



/* null-e w order_status i order_purchase_timestamp */
select
	sum(case when order_status is null then 1 else 0 end) as null_order_status
	,sum(case when order_purchase_timestamp is null then 1 else 0 end) as null_order_purchase_timestamp
from orders
-- 0 , 0



/* pokrycie ocena dla delivered */ 
select
  count(*) as delivered_orders,
  sum(case when r.order_id is not null then 1 else 0 end) as delivered_orders_with_review,
  round(sum(case when r.order_id is not null then 1 else 0 end) / nullif(count(*),0)* 100,2) as pct_with_review
from orders o
left join order_reviews r on r.order_id = o.order_id
where o.order_status = 'delivered'





/* POPRAWNOŚĆ DANYCH W REVIEW SCORE */ 

select 
	count(*) as invalid_score_number
from order_reviews 
where review_score is not null
	and review_score > 5
	and review_score < 1 
-- 0
	

	
/* PRICE / FREIGHT UJEMNE LUB NULL */ 
	
select 
	sum(case when price is null or price < 0 then 1 else 0 end) as invalid_price
	,sum(case when freight_value is null or freight_value < 0 then 1 else 0 end) invalid_freight_value
from order_items
-- 0, 0 



/* PAYMENT_INSTALLMENTS */ 

select 
	sum(case when payment_installments is null or payment_installments < 0 then 1 else 0 end) as invalid_payment_installments
from order_payments
-- 0




/* SPÓJNOŚĆ STATUSTU DELIVERED Z DATĄ DELIVERED */

select
	count(*)
from orders 
where order_status ='delivered'
	and order_delivered_customer_date is null 

-- 8 statusów delivered bez daty delivered 
	
	
	

/* PŁATNOŚCI VS WARTOŚĆ KOSZYKA*
 */	

with 
items_total as 
	(
	select 
		order_id
		,SUM(price + freight_value) as items_total
	from order_items
	group by 1
	),
payments as 
	(
	select
		order_id
		,sum(payment_value) as total_payment
	from order_payments 
	group by 1
	),
joined as 
	(
	select
		it.order_id 
		,it.items_total 
		,p.total_payment 
		,(it.items_total - p.total_payment) as difference
	from items_total   it
	left join payments p on it.order_id = p.order_id
	)
select
	count(*) as orders_in_items
	,sum(case when total_payment is null then 1 else 0 end) as missing_payments
	,round(avg(difference), 2)      as avg_diff
	,round(AVG(ABS(difference)), 2) as avg_abs_diff
	,round(MAX(ABS(difference)), 2) as max_abs_diff
from joined 

/* 
orders_in_items		missing_payments    avg_diff   avg_abs_diff   max_abs_diff
 	98666				1				-0.03	     0.03			182.81
*/











