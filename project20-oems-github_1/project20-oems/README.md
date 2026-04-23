# Project 20 — Office Equipment Management System (OEMS)

> **NEU – College of Technology | DATCOM Lab**
> Course: Database Management Systems
> Academic Year: 2024–2025

---

## Project Overview

A system that manages the full lifecycle of office equipment:
**Procurement → Assignment → Maintenance → Disposal**

---

## Tech Stack

| Component | Technology |
|-----------|-----------|
| Database  | MySQL 8.0 |
| Language  | Python 3.11 |
| Connector | mysql-connector-python |
| Design    | MySQL Workbench |

---

## Project Structure

```
project20-oems/
├── sql/
│   ├── 01_schema.sql              # Create database and tables
│   ├── 02_indexes.sql             # Performance indexes
│   ├── 03_views.sql               # Reporting views
│   ├── 04_procedures_functions.sql # Stored procedures + UDFs
│   ├── 05_triggers.sql            # Automation triggers
│   ├── 06_security.sql            # User roles and permissions
│   └── 07_sample_data.sql         # Sample data (5-10 rows/table)
├── python/
│   ├── db_connection.py           # MySQL connection factory
│   ├── equipment.py               # Equipment CRUD
│   ├── maintenance.py             # Maintenance management
│   ├── purchases.py               # Purchase tracking
│   ├── reports.py                 # Business reports
│   ├── main.py                    # CLI entry point
│   └── requirements.txt
├── docs/
│   └── er_diagram.png             # ER Diagram (MySQL Workbench)
└── README.md
```

---

## Setup Instructions

### 1. Database Setup

Run SQL files in order:

```bash
mysql -u root -p < sql/01_schema.sql
mysql -u root -p < sql/02_indexes.sql
mysql -u root -p < sql/03_views.sql
mysql -u root -p < sql/04_procedures_functions.sql
mysql -u root -p < sql/05_triggers.sql
mysql -u root -p < sql/06_security.sql
mysql -u root -p < sql/07_sample_data.sql
```

### 2. Python Setup

```bash
cd python
pip install -r requirements.txt
```

### 3. Configure Connection

Edit `python/db_connection.py` and update:

```python
DB_CONFIG = {
    'host':     'localhost',
    'database': 'oems',
    'user':     'it_admin',
    'password': 'YOUR_PASSWORD_HERE',
}
```

### 4. Run Application

```bash
cd python
python main.py
```

---

## Features

- Equipment cataloging and status tracking
- Department and employee assignment
- Purchase history and vendor tracking
- Maintenance scheduling with auto-status triggers
- Asset depreciation calculation (straight-line)
- Role-based access control (3 user roles)
- Automated backup strategy

---



## Team Members

| Name       | Student ID |
|----------------|-----------|
| Đào Trung Phúc | 11247215 |

