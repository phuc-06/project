# ============================================================
#  PROJECT 20: Office Equipment Management System
#  File: maintenance.py
#  Description: Maintenance scheduling and logging
# ============================================================

from db_connection import get_connection


def schedule_maintenance(equipment_id: int, date: str,
                          description: str, cost: float = 0.0):
    """Schedule a new maintenance record. Trigger auto-updates equipment status."""
    conn = get_connection()
    cursor = conn.cursor()
    cursor.execute(
        """INSERT INTO Maintenance (EquipmentID, Date, Description, Cost, Status)
           VALUES (%s, %s, %s, %s, 'Scheduled')""",
        (equipment_id, date, description, cost)
    )
    conn.commit()
    print(f"[OK] Maintenance scheduled for equipment {equipment_id} on {date}.")
    cursor.close()
    conn.close()


def complete_maintenance(maintenance_id: int, actual_cost: float):
    """Mark maintenance as completed via stored procedure."""
    conn = get_connection()
    cursor = conn.cursor()
    cursor.callproc('sp_CompleteMaintenance', [maintenance_id, actual_cost])
    conn.commit()
    print(f"[OK] Maintenance {maintenance_id} marked as completed.")
    cursor.close()
    conn.close()


def check_overdue():
    """Run overdue alert stored procedure and display results."""
    conn = get_connection()
    cursor = conn.cursor()
    cursor.callproc('sp_OverdueAlerts')

    found = False
    for result in cursor.stored_results():
        rows = result.fetchall()
        if rows:
            found = True
            print(f"\n{'Equipment':<28} {'Department':<22} {'Date':<12} {'Days Overdue':>12}")
            print("-" * 80)
            for r in rows:
                print(f"{r[0]:<28} {r[1]:<22} {str(r[2]):<12} {r[4]:>12}")

    if not found:
        print("[OK] No overdue maintenance found.")

    cursor.close()
    conn.close()


def list_upcoming():
    """Display maintenance scheduled in the next 30 days."""
    conn = get_connection()
    cursor = conn.cursor()
    cursor.execute("SELECT * FROM vw_UpcomingMaintenance")
    rows = cursor.fetchall()

    if not rows:
        print("[INFO] No upcoming maintenance in the next 30 days.")
        cursor.close()
        conn.close()
        return

    print(f"\n{'Equipment':<28} {'Department':<22} {'Date':<12} {'Description':<30} {'Cost':>12}")
    print("-" * 110)
    for r in rows:
        print(f"{r[0]:<28} {r[1]:<22} {str(r[2]):<12} {str(r[3]):<30} {(r[4] or 0):>12,.0f}")

    cursor.close()
    conn.close()
