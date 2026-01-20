/* 33. Jakie metody płatności są najczęściej wybierane? */ 

select 	
	op.payment_type  
	,count(distinct o.order_id ) as nr_of_payments
from orders 			  o
inner join order_payments op on o.order_id = op.order_id  
group by 1
order by 2 desc


/*
credit_card		76505
boleto			19784
voucher			3866
debit_card		1528
not_defined		3
*/




/* 34. Jaka jest średnia kwota płatności na zamówienie? */ 

with 
base as 
	(
	select 
		o.order_id 
		,SUM(op.payment_value) as payment_value
	from orders 				o
	inner join order_payments   op on o.order_id = op.order_id  
	group by 1
	)
select 
	round(avg(payment_value ), 2) as avg_payment_value
from base 

-- 160.99






/* 35. Jaka jest średnia liczba rat (installments) na zamówienie? */

with 
base as
	(
	select
		o.order_id 
		,sum(op.payment_installments) as nr_of_installments
	from orders			      o
	inner join order_payments op on o.order_id = op.order_id  
	group by 1
	)
select 
	round(AVG(nr_of_installments ), 2) as avg_nr_of_installments
from base 

-- 2.98




/* 36.Czy zamówienia opłacane różnymi metodami mają różną średnią wartość? */ 


/* dodatkowo sprawdzam czy były zamówienia, które miały płatność dzieloną na różne metody 
 ponieważ może to mieć wpływ na wynik */ 

select
	count(t.order_id )
from 
	(
	select
		order_id
		,count(distinct payment_type)
	from order_payments 
	group by 1
	having count(distinct payment_type) > 1
	order by 2 desc
	) t

-- było 2 246 takich zamówień gdzie były wiecej niż jedna metoda płatności 

/* zapytanie które zwraca porównanie ile było zamówień z 'single' i ile z 'mixed' typami płatności*/ 
	
with 
base as 
	(
	select
		order_id
		,count(distinct payment_type) as types_cnt
	from order_payments
	group by 1
	),
total_orders as
	(
	select 
		count(distinct order_id) as total_orders
	from order_payments
	),
final_1 as 
	(
	select
		case when types_cnt = 1 then 'single_method' else 'mixed_method' end as order_group
		,count(*) as nr_of_orders
	from base 
	group by 1
	)
select 
	f1.order_group 
	,f1.nr_of_orders 
	,ROUND(f1.nr_of_orders / to1.total_orders * 100, 2) as pct_group
from final_1 f1
cross join total_orders to1


/* finalne zapytanie */ 

with 
base as 
	(
	select
		o.order_id 
		,op.payment_type 
		,sum(op.payment_value) as order_value
	from orders 				o
	inner join order_payments   op on o.order_id = op.order_id 
	group by 1, 2
	)
select 
	payment_type 
	,round(avg(order_value), 2) as avg_order_value
from base
group by 1
order by 2 desc


/* 
credit_card			163.94
boleto				145.03
debit_card			142.66
voucher				98.15
not_defined			0.00

Średnia wartość wg metody pokazuje średnią kwotę zapłaconą tą metodą,
ale ~2246 zamówień było opłaconych mieszanymi metodami, 
więc część wartości zamówienia jest rozbita między typy płatności

Można uwzględnić to w analizach jeśli kontekst biznesowy by tego wymagał
 */



