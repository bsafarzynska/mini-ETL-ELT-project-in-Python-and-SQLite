DROP TABLE IF EXISTS books;
CREATE TABLE books (
    id            INTEGER PRIMARY KEY,
    book_title    TEXT NOT NULL,
    book_author   TEXT NOT NULL,
    book_price    REAL NOT NULL CHECK (book_price >= 0),
    stock_available INTEGER NOT NULL CHECK (stock_available >= 0),
    total_value   REAL GENERATED ALWAYS AS (book_price * stock_available) VIRTUAL
);

CREATE INDEX IF NOT EXISTS idx_books_author ON books(book_author);
CREATE INDEX IF NOT EXISTS idx_books_total_value ON books(total_value);
CREATE INDEX IF NOT EXISTS idx_books_price ON books(book_price);