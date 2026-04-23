# ============================================================
#  PROJECT 20: Office Equipment Management System
#  File: db_connection.py
#  Description: MySQL connection factory
# ============================================================

import mysql.connector
from mysql.connector import Error

DB_CONFIG = {
    'host':     'localhost',
    'database': 'oems',
    'user':     'it_admin',
    'password': 'SecureAdmin#2025!',
    'charset':  'utf8mb4',
}

def get_connection():
    """Return a live MySQL connection or raise on failure."""
    try:
        conn = mysql.connector.connect(**DB_CONFIG)
        if conn.is_connected():
            return conn
    except Error as e:
        print(f"[DB ERROR] Cannot connect to database: {e}")
        raise
