# Mini ETL/ELT Project in Python + SQLite

Practical portfolio project showing both ETL (Python transform) and ELT (SQL transform) patterns.

## What it does
- **ETL path**: CSV → Pandas cleaning → SQLite (typed table + views + reports)
- **ELT path**: CSV → raw table → SQL transformations → final analytics tables/views

## How to run
```bash
# 1) Install
pip install -r requirements.txt

# 2) Run ETL (Python transforms) – creates books.db, schema, views
python etl.py

# 3) Run reports (pretty-printed to console)
python run_reports.py