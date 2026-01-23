## 1) Przegląd danych i wolumen

1. Ilu unikalnych klientów znajduje się w danych (customers)?
- 96 096

2. Ile łącznie złożono zamówień?
- 99 441

3. Jaka jest liczba zamówień w podziale na status (delivered / canceled / shipped itd.)?
 ```text
  delivered: 96 478
  shipped: 1 107
  canceled: 625
  unavailable: 609
  invoiced: 314
  processing: 301
  created: 5
  approved: 2
```

4. Ile unikalnych sprzedawców działa w systemie?
- 3 095

5. Ile unikalnych produktów i kategorii produktów występuje w bazie?
- produkty: 32 951, kategorie: 74

## 2) Sprzedaż i przychód (Sales & Revenue)

6. Jaki jest łączny przychód (GMV) ze sprzedaży?
- 13,221,498.11 
7. Jak zmienia się liczba zamówień w czasie (trend miesięczny / roczny)?
```text
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
```

8. Jak zmienia się przychód w czasie (trend miesięczny / roczny)?
```text
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
```

9. Który miesiąc był najlepszy pod względem liczby zamówień?
```text
year   month  nr_of_orders
2017	11	     7395
```
10. Który miesiąc był najlepszy pod względem przychodu?
```text 
year   month    total_revenue
2018	 5		   999867.28
```
11. Jaka jest średnia wartość zamówienia (AOV – Average Order Value)?
- 137.04
12. Jaka jest średnia liczba produktów (pozycji) w zamówieniu?
- 1.14 
13. Ile zamówień ma więcej niż jeden produkt (multi-item orders)?
- 9 803
## 3) Produkty i kategorie

14. Które kategorie produktów sprzedają się najczęściej (wolumen)?
```text
category:     nr of items
cama_mesa_banho:	11115
beleza_saude:	9670
esporte_lazer:	8641
moveis_decoracao:	8334
informatica_acessorios:	7827
utilidades_domesticas:	6964
```

15. Które kategorie generują najwyższy przychód?
```text 
category    		 	  income 
beleza_saude			1233131.72
relogios_presentes		1166176.98
cama_mesa_banho			1023434.76
esporte_lazer			954852.55
informatica_acessorios	888724.61
 ```

16. Które kategorie mają najniższy przychód lub najniższą sprzedaż?
```text 
category  						income
seguros_e_servicos				283.29
fashion_roupa_infanto_juvenil	519.95
cds_dvds_musicais				730.00
casa_conforto_2					760.27
flores							1110.04
 ```
17. Jak różnią się średnie wartości zamówień w zależności od kategorii produktu?
```text
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
 ```

## 4) Klienci i geografia

18. Jakie są top 5 miast z największą liczbą zamówień?
```text
city 				nr of orders
sao paulo	15540
rio de janeiro	6882
belo horizonte	2773
brasilia	2131
curitiba	1521
``` 

19. Ile klientów znajduje się w każdym stanie (customer_state)?
```text
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
``` 

20. Ile zamówień zostało dostarczonych w każdym stanie?
```text
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
```

21. W których stanach średnia wartość zamówienia jest najwyższa?
```text
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
```

## 5) Sprzedawcy (Sellers)

22. Ilu sprzedawców działa w każdym stanie?
```text 
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
```

23. Który sprzedawca generuje największy przychód?
- 4869f7a5dfa277a7dca6462dcf3b52b2:	226,987.93

24. Który sprzedawca ma najwyższą średnią wartość zamówienia?
- e3b4998c7a498169dc7bce44e6bb6277:	6,735.00

25. Czy istnieją sprzedawcy, którzy mają wyraźnie wyższy odsetek opóźnionych dostaw?
```text
mamy wielu sprzedawców którzy mają spore opóźnienia względem estymacji dostawy 
wklejam tylko piersze 10 rekordów 

		seller_id				    ordersdelayed_orders   pct_rate
ede0c03645598cdfc63ca8237acbe73d		43		14			32.56
ad781527c93d00d89a11eecd9dcad7c1		38		12			31.58
54965bbe3e4f07ae045b90b0b8541f52		73		22			30.14
2a1348e9addc1af5aaa619b1a3679d6b		48		13			27.08
835f0f7810c76831d6c7d24c7a646d4d		42		11			26.19
beadbee30901a7f61d031b6b686095ad		64		15			23.44
a49928bcdf77c55c6d6e05e09a9b4ca5		96		21			21.88
ef990a83bbea832f36ebe81376335aa8		43		9			20.93
712e6ed8aa4aa1fa65dab41fed5737e4		77		16			20.78
71039d19d4303bf9054d69e9a9236699		35		7			20.00
```

## 6) Dostawa i logistyka (Delivery / SLA)

26. Jaki jest średni koszt dostawy (freight) na zamówienie?
- 22.79

27. Jaki jest średni czas dostawy (od zakupu do dostarczenia)?
- 12.5 dnia 

28. Jaki jest średni czas od zatwierdzenia zamówienia do dostarczenia?
- 11.98 dnia

29. Jaki % zamówień dostarczono po czasie (late deliveries)?
- 6.77 %

30. Jaki % zamówień dostarczono przed estymowaną datą dostawy?
- 91.89 %

31. W których stanach dostawy trwają najdłużej (średni delivery time)?
```text
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
```

32. Jak różni się czas dostawy pomiędzy kategoriami produktów?
```text 
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
```

## 7) Płatności

33. Jakie metody płatności są najczęściej wybierane?
```text
credit_card		76505
boleto			19784
voucher			3866
debit_card		1528
not_defined		3
```


34. Jaka jest średnia kwota płatności na zamówienie?
- 160.99

35. Jaka jest średnia liczba rat (installments) na zamówienie?
- 2.98

36. Czy zamówienia opłacane różnymi metodami mają różną średnią wartość?
```text 
credit_card			163.94
boleto				145.03
debit_card			142.66
voucher				98.15
not_defined			0.00

Średnia wartość wg metody pokazuje średnią kwotę zapłaconą tą metodą,
ale ~2246 zamówień było opłaconych mieszanymi metodami, 
więc część wartości zamówienia jest rozbita między typy płatności

Można uwzględnić to w analizach jeśli kontekst biznesowy by tego wymagał
 ```

## 8) Opinie i satysfakcja klienta (Reviews)

37. Jaka jest średnia ocena (review_score) w całym zbiorze?
- 4.09

38. Jak oceny różnią się pomiędzy kategoriami produktów?
```text
wypisuje pierwsze 10
 livros_interesse_geral				4.47
construcao_ferramentas_ferramentas	4.43
livros_tecnicos						4.41
livros_importados					4.38
alimentos_bebidas					4.38
malas_acessorios					4.34
fashion_roupa_infanto_juvenil		4.33 
```

39. Czy zamówienia z dłuższym czasem dostawy mają niższe oceny?
```text  
delivery_group     score    ranking
fast_delivery   	4.49	1
mid_delivery	    4.42	2
slow_delivery	    4.32	3
very_slow_delivery	3.67	4
```

40. Jaki jest odsetek zamówień z oceną 1–2 (negatywne) i ile z nich było opóźnionych?
```text
 nr_low_reviews		pct		 nr_low_and_delay_reviews	
 12310				12.76		3986
```

41. Które top 10 kategorii ma najwyższy średni koszt dostawy w relacji do ceny produktu (freight/price ratio)?
```text
 category				nr_of_orders  freight/price ratio   rank
casa_conforto_2				22			0.540444			1
flores						28			0.469462			2
moveis_colchao_e_estofado	37			0.365772			3
artigos_de_natal			125			0.365120			4
fraldas_higiene				25			0.363409			5
cds_dvds_musicais			12			0.308205			6
sinalizacao_e_seguranca		137			0.303977			7
alimentos_bebidas			218			0.295383			8
eletronicos					2503		0.294659			9
fashion_esporte				25			0.274110			10
```

42. Czy klienci powracający (2+ zamówienia) wystawiają wyższe oceny niż nowi klienci?
```text 
 returning     new
  4.11		   4.08
```

43. Którzy sprzedawcy mają najwięcej anulowanych zamówień (i jaki jest ich cancel rate)?
```text
wypisze top 10 canceled 
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
```

44. Czy istnieje próg liczby rat (np. ≥6), po którym wyraźnie spada średnia ocena zamówienia?* 
```text
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
```

	
