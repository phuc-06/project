# ============================================================
#  PROJECT 20: Office Equipment Management System
#  File: reports.py
#  Description: Business report generation
# ============================================================

from db_connection import get_connection


def report_equipment_by_department():
    """Report: Equipment count per department."""
    conn = get_connection()
    cursor = conn.cursor()
    cursor.execute("""
        SELECT d.DepartmentName,
               COUNT(e.EquipmentID) AS Total,
               SUM(CASE WHEN e.Status = 'Active' THEN 1 ELSE 0 END) AS Active,
               SUM(CASE WHEN e.Status = 'Under Maintenance' THEN 1 ELSE 0 END) AS InMaintenance,
               SUM(CASE WHEN e.Status = 'Retired' THEN 1 ELSE 0 END) AS Retired
        FROM   Departments d
        LEFT JOIN Equipment e ON d.DepartmentID = e.DepartmentID
        GROUP BY d.DepartmentID, d.DepartmentName
        ORDER BY Total DESC
    """)
    rows = cursor.fetchall()

    print(f"\n{'Department':<28} {'Total':>7} {'Active':>8} {'Maintenance':>13} {'Retired':>9}")
    print("-" * 70)
    for r in rows:
        print(f"{r[0]:<28} {r[1]:>7} {r[2]:>8} {r[3]:>13} {r[4]:>9}")

    cursor.close()
    conn.close()


def report_maintenance_costs():
    """Report: Maintenance cost summary per equipment."""
    conn = get_connection()
    cursor = conn.cursor()
    cursor.execute("SELECT * FROM vw_MaintenanceCostSummary")
    rows = cursor.fetchall()

    print(f"\n{'Equipment':<30} {'Services':>10} {'Total Cost (VND)':>18} {'Last Service'}")
    print("-" * 75)
    for r in rows:
        cost = f"{r[2]:,.0f}" if r[2] else "0"
        last = str(r[3]) if r[3] else "Never"
        print(f"{r[0]:<30} {r[1]:>10} {cost:>18} {last}")

    cursor.close()
    conn.close()


def report_depreciation(useful_life_years: int = 5):
    """Report: Asset depreciation using straight-line method (UDF)."""
    conn = get_connection()
    cursor = conn.cursor()
    cursor.execute("""
        SELECT e.EquipmentName,
               p.PurchaseDate,
               p.Value AS OriginalValue,
               fn_Depreciation(p.Value, p.PurchaseDate, %s) AS CurrentValue,
               ROUND((1 - fn_Depreciation(p.Value, p.PurchaseDate, %s)
                          / NULLIF(p.Value, 0)) * 100, 1) AS DepreciationPct
        FROM   Equipment e
        JOIN   Purchases p ON e.EquipmentID = p.EquipmentID
        ORDER BY CurrentValue DESC
    """, (useful_life_years, useful_life_years))
    rows = cursor.fetchall()

    print(f"\nDepreciation Report (Useful life: {useful_life_years} years, Straight-line method)")
    print(f"\n{'Equipment':<28} {'Purchased':<12} {'Original':>14} {'Current':>14} {'Depr%':>7}")
    print("-" * 82)
    for r in rows:
        pct = f"{r[4]}%" if r[4] is not None else "N/A"
        print(f"{r[0]:<28} {str(r[1]):<12} {r[2]:>14,.0f} {(r[3] or 0):>14,.0f} {pct:>7}")

    cursor.close()
    conn.close()


def report_full_inventory():
    """Report: Full inventory with purchase value."""
    conn = get_connection()
    cursor = conn.cursor()
    cursor.execute("""
        SELECT e.EquipmentID,
               e.EquipmentName,
               e.Type,
               d.DepartmentName,
               e.Status,
               IFNULL(p.Value, 0) AS PurchaseValue
        FROM   Equipment    e
        LEFT JOIN Departments d ON e.DepartmentID = d.DepartmentID
        LEFT JOIN Purchases   p ON e.EquipmentID  = p.EquipmentID
        ORDER BY e.EquipmentID
    """)
    rows = cursor.fetchall()

    print(f"\n{'ID':>4} {'Name':<28} {'Type':<12} {'Department':<22} {'Status':<20} {'Value':>14}")
    print("-" * 105)
    for r in rows:
        print(f"{r[0]:>4} {r[1]:<28} {r[2]:<12} {(r[3] or 'N/A'):<22} {r[4]:<20} {r[5]:>14,.0f}")

    cursor.close()
    conn.close()
