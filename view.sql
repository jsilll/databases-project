CREATE VIEW sales(ean, category_name, sale_year, sale_month, quarter, day_of_month, day_of_week, district, county, nr_units)
AS
SELECT ean, category_name,
EXTRACT(YEAR FROM instant) AS sale_year,
EXTRACT(MONTH FROM instant) AS sale_month,
EXTRACT(QUARTER FROM instant) AS quarter,
EXTRACT(DAY FROM instant) AS day_of_month,
EXTRACT(DOW FROM instant) AS day_of_week,
district, county, nr_units
FROM replenishment_event NATURAL JOIN shelve NATURAL JOIN installed_at NATURAL JOIN point_of_retail;