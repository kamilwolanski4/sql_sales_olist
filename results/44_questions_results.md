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

19. Ile klientów znajduje się w każdym stanie (customer_state)?

20. Ile zamówień zostało dostarczonych w każdym stanie?

21. W których stanach średnia wartość zamówienia jest najwyższa?

## 5) Sprzedawcy (Sellers)

22. Ilu sprzedawców działa w każdym stanie?

23. Który sprzedawca generuje największy przychód?

24. Który sprzedawca ma najwyższą średnią wartość zamówienia?

25. Czy istnieją sprzedawcy, którzy mają wyraźnie wyższy odsetek opóźnionych dostaw?

## 6) Dostawa i logistyka (Delivery / SLA)

26. Jaki jest średni koszt dostawy (freight) na zamówienie?

27. Jaki jest średni czas dostawy (od zakupu do dostarczenia)?

28. Jaki jest średni czas od zatwierdzenia zamówienia do dostarczenia?

29. Jaki % zamówień dostarczono po czasie (late deliveries)?

30. Jaki % zamówień dostarczono przed estymowaną datą dostawy?

31. W których stanach dostawy trwają najdłużej (średni delivery time)?

32. Jak różni się czas dostawy pomiędzy kategoriami produktów?

## 7) Płatności

33. Jakie metody płatności są najczęściej wybierane?

34. Jaka jest średnia kwota płatności na zamówienie?

35. Jaka jest średnia liczba rat (installments) na zamówienie?

36. Czy zamówienia opłacane różnymi metodami mają różną średnią wartość?

## 8) Opinie i satysfakcja klienta (Reviews)

37. Jaka jest średnia ocena (review_score) w całym zbiorze?

38. Jak oceny różnią się pomiędzy kategoriami produktów?

39. Czy zamówienia z dłuższym czasem dostawy mają niższe oceny?

40. Jaki jest odsetek zamówień z oceną 1–2 (negatywne) i ile z nich było opóźnionych?

41. Które top 10 kategorii ma najwyższy średni koszt dostawy w relacji do ceny produktu (freight/price ratio)?

42. Czy klienci powracający (2+ zamówienia) wystawiają wyższe oceny niż nowi klienci?
