-- num dado distrito (i.e. “Lisboa”), por concelho, categoria, dia da semana e no total
-- TODO -> é isto que o enunciado quer dizer? dado um distrito ver por concelho, categoria, dia da semana e total separadamente?
SELECT district, county, category_name, day_of_week, SUM(nr_units) AS tot_units
FROM sales
GROUP BY
	GROUPING SETS ((district, county), (district, category_name), (district, day_of_week), (district))
HAVING district = 'Lisboa';

-- TODO justificar
SELECT sale_year, sale_month, day_of_month, day_of_week, county, SUM(nr_units) AS tot_units
FROM sales
GROUP BY
	GROUPING SETS ((sale_year, sale_month, day_of_month, day_of_week), (sale_year, sale_month, day_of_month, county), (sale_year, sale_month, day_of_month))
HAVING CONCAT(CAST(sale_year AS varchar), '-', CAST(sale_month AS varchar), '-', CAST(day_of_month AS varchar)) > '2021-9-01'
       AND CONCAT(CAST(sale_year AS varchar), '-', CAST(sale_month AS varchar), '-', CAST(day_of_month AS varchar)) < '2021-10-27'