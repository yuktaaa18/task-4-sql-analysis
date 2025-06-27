USE myntra;

-- 1. Top 10 by price
SELECT 
  ProductID,
  ProductName,
  ProductBrand,
  Price_INR
FROM products
ORDER BY Price_INR DESC
LIMIT 10;
-- 2. Avg price grouped by Gender
SELECT 
  Gender,
  ROUND(AVG(Price_INR),2) AS avg_price_inr,
  COUNT(*)            AS product_count
FROM products
GROUP BY Gender;
-- 3. Brand popularity
SELECT 
  ProductBrand,
  COUNT(*) AS num_products
FROM products
GROUP BY ProductBrand
ORDER BY num_products DESC
LIMIT 20;
-- 4. Price metrics by color
SELECT
  PrimaryColor,
  MIN(Price_INR)    AS min_price,
  MAX(Price_INR)    AS max_price,
  ROUND(AVG(Price_INR),2) AS avg_price,
  COUNT(*)          AS count_products
FROM products
GROUP BY PrimaryColor
ORDER BY count_products DESC
LIMIT 15;
-- 5. Unisex items above overall avg
SELECT
  ProductID,
  ProductName,
  Price_INR
FROM products
WHERE Gender = 'Unisex'
  AND Price_INR > (SELECT AVG(Price_INR) FROM products)
ORDER BY Price_INR DESC;
-- 6. Rank within brand
SELECT
  ProductBrand,
  ProductName,
  Price_INR,
  ROW_NUMBER() OVER (
    PARTITION BY ProductBrand
    ORDER BY Price_INR DESC
  ) AS rank_by_brand
FROM products
ORDER BY ProductBrand, rank_by_brand
LIMIT 100;
-- 7. Brands whose avg price > overall avg
SELECT
  ProductBrand,
  ROUND(AVG(Price_INR),2) AS avg_brand_price
FROM products
GROUP BY ProductBrand
HAVING AVG(Price_INR) > (SELECT AVG(Price_INR) FROM products)
ORDER BY avg_brand_price DESC
LIMIT 20;
-- 8. Color popularity
SELECT
  PrimaryColor,
  COUNT(*) AS occurrences
FROM products
GROUP BY PrimaryColor
ORDER BY occurrences DESC
LIMIT 10;
