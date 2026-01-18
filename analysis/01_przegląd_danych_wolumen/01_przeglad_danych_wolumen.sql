/* 1. Ilu unikalnych klientów znajduje się w danych (customers)? */

select
	count(distinct customer_unique_id) as nr_of_customers
from customers

-- 96 096



/* 2. Ile łącznie złożono zamówień? */ 

select 
	count(distinct order_id) as total_nr_of_orders
from orders 

-- 99 441



/* 3. Jaka jest liczba zamówień w podziale na status (delivered / canceled / shipped itd.)? */

select 
	order_status
	,count(*) as nr_of_orders
from orders
group by 1
order by 2 desc

/* 
delivered	96 478
shipped		1 107
canceled	625
unavailable	609
invoiced	314
processing	301
created		5
approved	2
*/ 



/*4. Ile unikalnych sprzedawców działa w systemie? */ 

select
	count(distinct seller_id)
from sellers

-- 3 095



/*5. Ile unikalnych produktów i kategorii produktów występuje w bazie? */ 

select 
	count(distinct product_id)
	,count(distinct product_category_name)
from products

-- produkty: 32 951, kategorie: 74



