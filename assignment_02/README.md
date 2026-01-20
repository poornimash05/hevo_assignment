## Assignment-2

Project Overview
This repository contains the SQL scripts and documentation for the data pipeline assignment using:

- **Source**: PostgreSQL
- **ETL/ELT Tool**: Hevo (Logical Replication)
- **Destination**: Snowflake (PUBLIC schema)

## Project Structure

├── README.md
├── sql/
│ ├── 01_create_postgres_tables.sql
│ ├── 02_load_postgres_data.sql
│ ├── 03_hevo_pipeline_setup_notes.md
│ ├── 04_snowflake_raw_validation.sql
│ ├── 05_customers_clean.sql
│ ├── 06_customers_country_fix.sql
│ ├── 07_orders_clean.sql
│ ├── 08_products_clean.sql
│ ├── 09_final_join.sql
│ └── 10_final_validation.sql
└── loom_recording_notes.md


---

## Requirements

### 1. PostgreSQL Setup
- Install PostgreSQL locally
- Create database `Assignment_02`
- Create tables:
  - `customers_raw`
  - `orders_raw`
  - `products_raw`
  - `country_dim`

### 2. Load Data
- Insert sample rows into each table using SQL inserts.

### 3. Hevo Pipeline
- Source: PostgreSQL
- Destination: Snowflake (PUBLIC schema)
- Ingestion Mode: Logical Replication
- Select all raw tables for replication.

### 4. Snowflake Validation
- Confirm raw tables exist in Snowflake.
- Validate row counts and sample records.

## 🧼 Data Cleaning Steps (SQL Models)

### Step 5 — Deduplicate Customers
- Keep latest record per customer_id
- Lowercase email
- Normalize phone (10 digits or "Unknown")

### Step 6 — Fix NULLs & Country Issues
- Standardize `country_code` using `country_dim`
- Replace NULL `created_at` with `1900-01-01`

### Step 7 — Clean Orders
- Remove duplicates
- Fix invalid amounts (negative/NULL)
- Standardize currency
- Add `amount_usd`

### Step 8 — Clean Products
- Title case names/categories
- Mark inactive products as “Discontinued Product”

### Step 9 — Join All Data
- Join customers + orders + products
- Handle orphan customers and unknown products

### Step 10 — Edge Cases
- Mark completely NULL customers as “Invalid Customer”
- Preserve orders with missing customer/product

---

## Assumptions
- Default currency is `USD` when missing.
- Currency conversion rates are:
  - INR → 0.012 USD
  - SGD → 0.74 USD
  - EUR → 1.08 USD
- If median amount is unavailable, fallback to `0`.

---


