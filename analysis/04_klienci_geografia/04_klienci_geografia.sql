/* 18. Jakie są top 5 miast z największą liczbą zamówień? */

select 
	c.customer_city 			as city
	,count(distinct o.order_id) as nr_of_orders
from orders 			o
inner join customers 	c on o.customer_id = c.customer_id 
group by 1
order by 2 desc 
limit 5

/* 
city 				nr of orders
sao paulo	15540
rio de janeiro	6882
belo horizonte	2773
brasilia	2131
curitiba	1521
*/ 






/* 19. Ile klientów znajduje się w każdym stanie (customer_state)? */

select
	customer_state 
	,count(distinct customer_unique_id) as nr_of_customers
from customers 
group by 1
order by 2 desc 

/*
wypisuje tylko 10 pierwszych
state	 nr_of_customers 
SP			40302
RJ			12384
MG			11259
RS			5277
PR			4882
SC			3534
BA			3277
DF			2075
ES			1964
GO			1952
 */





/* 20. Ile zamówień zostało dostarczonych w każdym stanie? */

select
	c.customer_state 
	,count(distinct o.order_id) 	as nr_of_orders
from orders 			o
inner join customers 	c on o.customer_id = c.customer_id 
where o.order_status = 'delivered'
group by 1
order by 2 desc


/*
 wypisuje pierwsze 10 stanów
state 	nr_of_orders
SP			40501
RJ			12350
MG			11354
RS			5345
PR			4923
SC			3546
BA			3256	
DF			2080
ES			1995
GO			1957
 */





/* 21. W których stanach średnia wartość zamówienia jest najwyższa? */

with 
base as 
	(
	select
		c.customer_state as state
		,o.order_id 
		,SUM(oi.price )	 as order_value
	from orders 			o
	inner join order_items 	oi on o.order_id = oi.order_id
	inner join customers 	c  on o.customer_id = c.customer_id 
	where c.customer_state is not null 
		and TRIM(c.customer_state ) <> ''
		and o.order_status = 'delivered'
	group by 1, 2
	)
select 
	state 
	,round(AVG(order_value), 2) as avg_order_value
from base
group by 1
order by 2 desc 


/*
state  avg_order_value
PB			217.77
AP			199.62
AC			199.14
AL			198.63
RO			187.99
PA			184.43
PI			177.99
TO			176.65
RN			173.22
RR			172.13
 */





























