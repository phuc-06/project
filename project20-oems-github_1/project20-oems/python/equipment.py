# ============================================================
#  PROJECT 20: Office Equipment Management System
#  File: equipment.py
#  Description: Equipment CRUD operations
# ============================================================

from db_connection import get_connection


def add_equipment(name: str, eq_type: str, unit: str, dept_id: int) -> int:
    """Add new equipment via stored procedure. Returns new EquipmentID."""
    conn = get_connection()
    cursor = conn.cursor()
    cursor.callproc('sp_AddEquipment', [name, eq_type, unit, dept_id, 0])
    conn.commit()
    new_id = None
    for result in cursor.stored_results():
        row = result.fetchone()
        if row:
            new_id = row[0]
    cursor.close()
    conn.close()
    print(f"[OK] Equipment '{name}' added successfully. ID: {new_id}")
    return new_id


def list_equipment():
    """Display all equipment grouped by department."""
    conn = get_connection()
    cursor = conn.cursor()
    cursor.execute("SELECT * FROM vw_EquipmentByDepartment")
    rows = cursor.fetchall()

    if not rows:
        print("[INFO] No equipment found.")
        cursor.close()
        conn.close()
        return

    print(f"\n{'Department':<25} {'ID':>4}  {'Equipment Name':<30} {'Type':<15} {'Status'}")
    print("-" * 90)
    for r in rows:
        print(f"{r[0]:<25} {r[1]:>4}  {r[2]:<30} {r[3]:<15} {r[4]}")

    cursor.close()
    conn.close()


def update_equipment_status(equipment_id: int, status: str):
    """Manually update equipment status."""
    valid = ('Active', 'Under Maintenance', 'Retired')
    if status not in valid:
        print(f"[ERROR] Invalid status. Choose from: {valid}")
        return
    conn = get_connection()
    cursor = conn.cursor()
    cursor.execute(
        "UPDATE Equipment SET Status = %s WHERE EquipmentID = %s",
        (status, equipment_id)
    )
    conn.commit()
    print(f"[OK] Equipment {equipment_id} status updated to '{status}'.")
    cursor.close()
    conn.close()


def retire_equipment(equipment_id: int):
    """Mark equipment as retired."""
    update_equipment_status(equipment_id, 'Retired')
