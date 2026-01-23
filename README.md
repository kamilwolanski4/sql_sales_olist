W tym projekcie przeanalizuję dane sprzedażowe brazylijskiego e-commerce (Olist), aby odpowiedzieć na 44 pytania biznesowe z wykorzystaniem SQL. Następnie zbuduję dashboard w Power BI, aby wyróżnić najważniejsze KPI oraz wskaźniki dotyczące działalności firmy.

Surowe dane można pobrać pod tym linkiem: 
https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce

Pytania zanjdują się w innym pliku o nazwie 44_questions_to_olist

Folder *analysis* powstał z myślą aby jak najbardziej ułatwić poruszanie się w tym projekcie. 
Foldery, które się w nim znajdują odpowiadają pytaniom biznesowym, które zostały podzielone na sekcje/kategorie. (nazwy folderów)
Najlepiej spojrzeć na głównej stronie plik *44_questions_to_olist* i zapoznać się z pytaniami, a następnie wrócić do folderu analysis. 

Folder base mieści w sobie quelity checks aby wiedzieć czy dane mają kluczowe błedy, które mogłyby utrudnić analizę.

Co znajdziesz w tym projekcie?

Czysczenie danych, sprawdzanie ich popraności

Analizę brakujących wartości

Funkcje agregujące takie jak: COUNT, SUM, AVG, MIN, MAX, ROUND, EXTRACT itp.

Klauzule takie jak: SELECT, WHERE, HAVING, GROUP BY, ORDER BY, LEFT JOIN, INNER JOIN, CASE WHEN, LIMIT.

Funkcje okna (window functions) takie jak: RANK, ROW_NUMBER, OVER, PARTITION BY.

CTE (Common Table Expressions) oraz podzapytania (subqueries).


INFORMACJE DODATKOWE / MODYFIKACJE DANYCH: 
- tabela *olist_geolocation_dataset*.
  
Tabela geolokalizacji zawiera wiele punktów dla jednego prefiksu kodu pocztowego, dlatego została zagregowana do jednego rekordu na prefiks poprzez uśrednienie wartości szerokości i długości geograficznej (latitude/longitude), aby uniknąć zwielokrotnienia wierszy podczas wykonywania złączeń (JOIN).


EXECUTIVE SUMMARY
1. Total revenue: 13,221,498.11 brl
2. Number of orders: 99 441
3. Number of customers: 96 096
4. Avereage order value: 137.04
5. Average freight value: 22.79
6. Freight / price ratio(sum freight / sum price): 0.17
7. Average review score: 4.09
8. Cancel rate %: 0.63% 
9. Returning customers %(customers with +2 orders): 3.12%
10. On-time delivery %: 91.89%
