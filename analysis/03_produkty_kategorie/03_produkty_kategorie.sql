/* 14. Które kategorie produktów sprzedają się najczęściej (wolumen)? */

select 
	p.product_category_name as category
	,count(*)      as nr_of_items
from orders 			o
left join order_items 	oi on o.order_id = oi.order_id 
left join products 		p  on oi.product_id = p.product_id  
group by 1 
order by 2 desc

/* 
category     nr of items
cama_mesa_banho	11115
beleza_saude	9670
esporte_lazer	8641
moveis_decoracao	8334
informatica_acessorios	7827
utilidades_domesticas	6964
*/






/* 15. Które kategorie generują najwyższy przychód? */ 

select
	p.product_category_name as category 
	,sum(oi.price) 			as income
from orders 				o
inner join order_items 		oi on o.order_id = oi.order_id 
inner join products 			p  on oi.product_id = p.product_id 
where o.order_status = 'delivered'
group by 1 
order by 2 desc

/* 
category    		 	  income 
beleza_saude			1233131.72
relogios_presentes		1166176.98
cama_mesa_banho			1023434.76
esporte_lazer			954852.55
informatica_acessorios	888724.61
 */





/* 16. Które kategorie mają najniższy przychód lub najniższą sprzedaż? */

select
	p.product_category_name as category 
	,sum(oi.price) 			as income
from orders 				o
inner join order_items 		oi on o.order_id = oi.order_id 
inner join products 			p  on oi.product_id = p.product_id 
where o.order_status = 'delivered'
group by 1 
order by 2 asc 
limit 5

/* 
category  						income
seguros_e_servicos				283.29
fashion_roupa_infanto_juvenil	519.95
cds_dvds_musicais				730.00
casa_conforto_2					760.27
flores							1110.04
 */






/* 17. Jak różnią się średnie wartości zamówień w zależności od kategorii produktu? */ 

with 
base as 
	(
	select 
		p.product_category_name as category
		,o.order_id 
		,SUM(oi.price)			as order_value
	from orders 				o
	inner join order_items 		oi on o.order_id = oi.order_id  
	inner join products 		p  on oi.product_id = p.product_id 
	where o.order_status = 'delivered'
		and p.product_category_name  is not null 
		and TRIM(p.product_category_name) <> ''
	group by 1, 2
	)
select 
	category
	,round(AVG(order_value),2) as avg_order_value
from base 
group by 1 
order by 2 desc 

/*
wyswietle tylko top 10 kategorii 

category    									avg_order_value
pcs													1235.50
portateis_casa_forno_e_cafe							647.08
eletrodomesticos_2									475.57
agro_industria_e_comercio							398.68
portateis_cozinha_e_preparadores_de_alimentos		302.59
instrumentos_musicais								301.66	
eletroportateis										300.09
telefonia_fixa										260.92
construcao_ferramentas_seguranca					243.86
climatizacao										216.76
 */



















