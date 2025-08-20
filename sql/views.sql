CREATE VIEW IF NOT EXISTS v_inventory_value AS
SELECT SUM(total_value) AS total_inventory_value
FROM books;

CREATE VIEW IF NOT EXISTS v_top_expensive AS
SELECT id, book_title, book_author, book_price, stock_available
FROM books
ORDER BY book_price DESC;

CREATE VIEW IF NOT EXISTS v_value_by_author AS
SELECT
  book_author,
  COUNT(*) AS titles_count,
  SUM(stock_available) AS total_stock,
  ROUND(AVG(book_price), 2) AS avg_price,
  ROUND(SUM(total_value), 2) AS total_value
FROM books
GROUP BY book_author
ORDER BY total_value DESC;

CREATE VIEW IF NOT EXISTS v_low_stock AS
SELECT *
FROM books
WHERE stock_available <= 5
ORDER BY stock_available ASC, book_price DESC;