import pandas as pd
import sqlite3
from pathlib import Path

DATA_PATH = Path("data/books.csv")
DB_PATH = Path("books.db")

def main():
    print("Extract: loading CSV...")
    df = pd.read_csv(DATA_PATH)

    print("Transform: cleaning...")
    df["stock"] = df["stock"].astype(str).str.extract(r"(\d+)").astype(int)
    df["price"] = pd.to_numeric(df["price"], errors="coerce").fillna(0.0)
    df["id"] = pd.to_numeric(df["id"], errors="coerce").astype("Int64")

    df = df.dropna(subset=["id", "title", "author"])

    df = df.drop_duplicates(subset=["id"])

    df = df.rename(columns={
        "title": "book_title",
        "author": "book_author",
        "price": "book_price",
        "stock": "stock_available"
    })

    print("Load: writing to SQLite...")
    with sqlite3.connect(DB_PATH) as conn:
        df.to_sql("stg_books", conn, if_exists="replace", index=False)

        schema_sql = Path("sql/schema.sql").read_text(encoding="utf-8")
        conn.executescript(schema_sql)

        conn.executescript("""
            INSERT INTO books (id, book_title, book_author, book_price, stock_available)
            SELECT id, book_title, book_author, book_price, stock_available
            FROM stg_books;
            DROP TABLE IF EXISTS stg_books;
        """)

        views_sql = Path("sql/views.sql").read_text(encoding="utf-8")
        conn.executescript(views_sql)

    print("ETL finished. Database:", DB_PATH)

if __name__ == "__main__":
    main()