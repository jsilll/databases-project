-- num dado distrito (i.e. “Lisboa”), por concelho, categoria, dia da semana e no total
SELECT district, county, category_name, day_of_week, SUM(nr_units) AS tot_units
FROM sales
GROUP BY
	GROUPING SETS ((district, county), (district, category_name), (district, day_of_week), (district))
HAVING district = 'Lisboa';

SELECT day_of_week, county, SUM(nr_units) AS tot_units
FROM sales
WHERE sale_year <= EXTRACT(YEAR FROM TO_DATE('2021-10-17', 'YYYY-MM-DD'))
		AND sale_year >= EXTRACT(YEAR FROM TO_DATE('2021-09-05', 'YYYY-MM-DD'))
       	AND sale_month <= EXTRACT(MONTH FROM TO_DATE('2021-10-17', 'YYYY-MM-DD'))
		AND sale_month >= EXTRACT(MONTH FROM TO_DATE('2021-09-05', 'YYYY-MM-DD'))
       	AND day_of_month <= EXTRACT(DAY FROM TO_DATE('2021-10-17', 'YYYY-MM-DD'))
	   	AND day_of_month >= EXTRACT(DAY FROM TO_DATE('2021-09-05', 'YYYY-MM-DD'))
GROUP BY
	GROUPING SETS ((day_of_week), (county), ());