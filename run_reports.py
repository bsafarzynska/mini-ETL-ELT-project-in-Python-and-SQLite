import sqlite3
import pandas as pd
from pathlib import Path

DB_PATH = Path("books.db")

REPORTS = {
    "inventory_value": """
        SELECT total_inventory_value FROM v_inventory_value;
    """,
    "top_3_expensive": """
        SELECT id, book_title, book_author, book_price, stock_available
        FROM v_top_expensive
        LIMIT 3;
    """,
    "value_by_author": """
        SELECT * FROM v_value_by_author
        LIMIT 5;
    """,
    "low_stock": """
        SELECT id, book_title, book_author, book_price, stock_available, total_value
        FROM v_low_stock;
    """,
    "price_stats": """
        SELECT MIN(book_price) AS min_price,
               ROUND(AVG(book_price), 2) AS avg_price,
               MAX(book_price) AS max_price
        FROM books;
    """
}

def main():
    with sqlite3.connect(DB_PATH) as conn:
        for name, sql in REPORTS.items():
            print(f"\n=== {name} ===")
            df = pd.read_sql_query(sql, conn)
            print(df.to_string(index=False))

if __name__ == "__main__":
    main()