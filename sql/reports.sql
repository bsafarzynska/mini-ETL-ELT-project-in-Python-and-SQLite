SELECT 'inventory_value' AS report, total_inventory_value
FROM v_inventory_value;

SELECT 'top_3_expensive' AS report, id, book_title, book_author, book_price, stock_available
FROM v_top_expensive
LIMIT 3;

SELECT 'value_by_author' AS report, *
FROM v_value_by_author
LIMIT 5;

SELECT 'low_stock' AS report, id, book_title, book_author, book_price, stock_available, total_value
FROM v_low_stock;

SELECT 'price_stats' AS report,
       MIN(book_price) AS min_price,
       ROUND(AVG(book_price), 2) AS avg_price,
       MAX(book_price) AS max_price
FROM books;