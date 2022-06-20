-- num dado distrito (i.e. “Lisboa”), por concelho, categoria, dia da semana e no total
-- TODO -> é isto que o enunciado quer dizer? dado um distrito ver por concelho, categoria, dia da semana e total separadamente?
SELECT district, county, category_name, day_of_week, SUM(nr_units) AS tot_units
FROM sales
GROUP BY
	GROUPING SETS ((district, county), (district, category_name), (district, day_of_week), (district))
HAVING district = 'Lisboa';

-- OU

SELECT county, category_name, day_of_week, SUM(nr_units) AS tot_units
FROM (
  SELECT *
  FROM sales
  WHERE district = 'Lisboa'
) AS s
GROUP BY
	GROUPING SETS ((county), (category_name), (day_of_week), ());

-- TODO -> é suposto o input ser mesmo uma data? ou podemos discrimar logo em year, quarter e day?
SELECT sale_year, quarter, day_of_month, day_of_week, county, SUM(nr_units)
FROM sales
GROUP BY
	GROUPING SETS ((sale_year, quarter, day_of_month, day_of_week), (sale_year, quarter, day_of_month, county), (sale_year, quarter, day_of_month))
HAVING sale_year = 2021 AND quarter <= 4 AND quarter >= 3 AND day_of_month <= 30 AND day_of_month >= 1;

SELECT day_of_week, county, SUM(nr_units) AS tot_units
FROM ( 
  SELECT *
  FROM sales
  WHERE sale_year = 2021 AND quarter <= 4 AND quarter >= 3 AND day_of_month <= 30 AND day_of_month >= 1
) AS s
GROUP BY
	GROUPING SETS ((day_of_week), (county), ());

