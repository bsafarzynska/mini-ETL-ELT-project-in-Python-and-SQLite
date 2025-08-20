DROP TABLE IF EXISTS raw_books;
CREATE TABLE raw_books (
    id TEXT,
    title TEXT,
    author TEXT,
    price TEXT,
    stock TEXT
);

INSERT INTO books (id, book_title, book_author, book_price, stock_available)
SELECT
    CAST(id AS INTEGER) AS id,
    title AS book_title,
    author AS book_author,
    CAST(COALESCE(NULLIF(price, ''), '0') AS REAL) AS book_price,
    CAST(
        COALESCE(
          REGEXP_REPLACE(stock, '[^0-9]', ''),
          '0'
        ) AS INTEGER
    ) AS stock_available
FROM (
    SELECT * FROM raw_books
    GROUP BY id
);