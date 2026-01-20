## Assessment I

The goal is to replicate data from a PostgreSQL source to Snowflake using Hevo (Logical Replication), apply transformations, and deliver a clean analytics-ready dataset.

## Project Overview

**Source:** PostgreSQL (Neon)  
**ETL Tool:** Hevo Data (Logical Replication)  
**Destination:** Snowflake (Free Trial)

The task includes:
1. Creating PostgreSQL tables and loading CSV data  
2. Creating Hevo pipeline to replicate data  
3. Applying transformations in Hevo  
4. Validating the final dataset in Snowflake  
5. Documenting the process  

## Repository Structure

├── README.md
├── sql/
│ ├── 01_create_postgres_tables.sql
│ ├── 02_load_postgres_data.sql
│ ├── 03_snowflake_raw_validation.sql
│ ├── 04_customers_transform.sql
│ ├── 05_orders_transform.sql
│ └── 06_feedback_transform.sql
└── loom_instructions.md

### Step 1 — Set up Snowflake
1. Sign up for Snowflake free trial.
2. Create a database (example: `PC_HEVODATA_DB`).
3. Create a schema `PUBLIC`.

### Step 2 — Set up Hevo via Snowflake Partner Connect
1. Open Snowflake UI.
2. Go to **Partner Connect**.
3. Select **Hevo** and create an account.
4. Login to Hevo.

### Step 3 — Set up PostgreSQL (Neon)
1. Create a free Neon PostgreSQL database.
2. Connect to the database using **pgAdmin**.
3. Create the following tables:
   - customers  
   - orders  
   - feedback

### Step 4 — Load CSV Data
1. Download the CSV files from `/hevo-assessment-csv`.
2. Load them into PostgreSQL using pgAdmin import or SQL COPY.

### Step 5 — Connect PostgreSQL to Hevo
1. In Hevo, create a new **Source**.
2. Choose **PostgreSQL**.
3. Provide the Neon connection details:
   - Host
   - Port
   - Database
   - Username
   - Password
4. Test the connection and save.

> **Note:** This exercise uses **Neon PostgreSQL**, connected via **pgAdmin**, then linked to Hevo.

### Step 6 — Set up Hevo Pipeline
1. Create a new pipeline in Hevo.
2. Source: PostgreSQL (Neon)
3. Destination: Snowflake
4. Ingestion mode: **Logical Replication**
5. Select tables:
   - customers
   - orders
   - feedback

### Step 7 — Apply Transformations in Hevo
Transformations were applied using Hevo’s transformation interface:

#### A. Orders → Order Events
- Created a new table `order_events`
- Each order status generates one event row

| status | event_type |
|--------|------------|
| placed | order_placed |
| shipped | order_shipped |
| delivered | order_delivered |
| cancelled | order_cancelled |

#### B. Customers → Username
- Added a derived field `username`
- Extracted from email (text before `@`)

Example:
`jane.doe@gmail.com` → `jane.doe`

## Assumptions Made

### 1. Status field
- Implemented as **VARCHAR**, not ENUM.
- This avoids compatibility issues with Hevo and simplifies transformation.

### 2. Default Values
- If any required field is missing:
  - `username` derived from email only if email exists
  - Invalid or missing values handled in transformation logic

### 3. Data types
- `address` stored as JSON in PostgreSQL.
- No transformation was applied to `address`.

---

## How Postgres was Connected to Hevo

**Database Provider:** Neon (PostgreSQL)  
**Connection Tool:** pgAdmin  
**Process:**

1. Created a Neon database.
2. Connected using pgAdmin to confirm tables and data.
3. Used the same Neon database connection details in Hevo.
4. Hevo connected successfully using the host, port, database, username, and password.


## Transformation Choices & Implementation

### Orders → Event Table
**Reasoning:**
- The status field is event-like.
- Converting to event table allows analytics on order lifecycle.

**Implementation:**
- Hevo transformation: conditional mapping of status to event_type
- Result stored in Snowflake as `order_events`.

### Customers → Username
**Reasoning:**
- Username is a common analytics dimension.
- It can be derived from email without extra data.

**Implementation:**
- Extract substring before `@` using Hevo transformation formula.

