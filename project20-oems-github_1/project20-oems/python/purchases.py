# ============================================================
#  PROJECT 20: Office Equipment Management System
#  File: purchases.py
#  Description: Purchase record management
# ============================================================

from db_connection import get_connection


def add_purchase(equipment_id: int, purchase_date: str,
                 value: float, vendor: str):
    """Record a new equipment purchase."""
    conn = get_connection()
    cursor = conn.cursor()
    cursor.execute(
        """INSERT INTO Purchases (EquipmentID, PurchaseDate, Value, VendorName)
           VALUES (%s, %s, %s, %s)""",
        (equipment_id, purchase_date, value, vendor)
    )
    conn.commit()
    print(f"[OK] Purchase recorded for equipment {equipment_id} — {value:,.0f} VND from {vendor}.")
    cursor.close()
    conn.close()


def list_purchases():
    """Display all purchase records with equipment names."""
    conn = get_connection()
    cursor = conn.cursor()
    cursor.execute("""
        SELECT e.EquipmentName, p.PurchaseDate, p.Value, p.VendorName
        FROM   Purchases  p
        JOIN   Equipment  e ON p.EquipmentID = e.EquipmentID
        ORDER  BY p.PurchaseDate DESC
    """)
    rows = cursor.fetchall()

    print(f"\n{'Equipment':<30} {'Date':<12} {'Value (VND)':>16} {'Vendor'}")
    print("-" * 80)
    for r in rows:
        print(f"{r[0]:<30} {str(r[1]):<12} {r[2]:>16,.0f} {r[3] or 'N/A'}")

    cursor.close()
    conn.close()


def total_asset_value():
    """Display total asset value using UDF."""
    conn = get_connection()
    cursor = conn.cursor()
    cursor.execute("SELECT fn_TotalAssetValue()")
    total = cursor.fetchone()[0]
    print(f"\n[ASSET] Total Asset Value: {total:,.0f} VND")
    cursor.close()
    conn.close()
