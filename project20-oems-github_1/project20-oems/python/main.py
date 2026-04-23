# ============================================================
#  PROJECT 20: Office Equipment Management System
#  File: main.py
#  Description: CLI entry point
# ============================================================

from equipment   import add_equipment, list_equipment, retire_equipment
from maintenance import (schedule_maintenance, complete_maintenance,
                          check_overdue, list_upcoming)
from purchases   import add_purchase, list_purchases, total_asset_value
from reports     import (report_equipment_by_department,
                          report_maintenance_costs,
                          report_depreciation,
                          report_full_inventory)


HEADER = """
+===========================================================+
|      OFFICE EQUIPMENT MANAGEMENT SYSTEM  (OEMS)          |
|      NEU - College of Technology | DATCOM Lab             |
+===========================================================+"""

MAIN_MENU = """
  [EQUIPMENT]
    1. List all equipment by department
    2. Add new equipment
    3. Retire equipment

  [MAINTENANCE]
    4. Schedule maintenance
    5. Complete maintenance
    6. Check overdue maintenance
    7. Upcoming maintenance (next 30 days)

  [PURCHASES]
    8. Record purchase
    9. List all purchases
   10. Total asset value

  [REPORTS]
   11. Equipment count by department
   12. Maintenance cost summary
   13. Asset depreciation report
   14. Full inventory report

    0. Exit
"""


def input_int(prompt: str) -> int:
    while True:
        try:
            return int(input(f"  {prompt}: ").strip())
        except ValueError:
            print("  [!] Please enter a valid number.")


def input_float(prompt: str) -> float:
    while True:
        try:
            return float(input(f"  {prompt}: ").strip())
        except ValueError:
            print("  [!] Please enter a valid number.")


def main():
    print(HEADER)
    while True:
        print(MAIN_MENU)
        choice = input("  Select option: ").strip()

        if choice == '1':
            list_equipment()

        elif choice == '2':
            name   = input("  Equipment name  : ").strip()
            etype  = input("  Type            : ").strip()
            unit   = input("  Unit            : ").strip()
            dept   = input_int("Department ID")
            add_equipment(name, etype, unit, dept)

        elif choice == '3':
            eid = input_int("Equipment ID to retire")
            retire_equipment(eid)

        elif choice == '4':
            eid   = input_int("Equipment ID")
            date  = input("  Date (YYYY-MM-DD): ").strip()
            desc  = input("  Description      : ").strip()
            cost  = input_float("Estimated cost (VND)")
            schedule_maintenance(eid, date, desc, cost)

        elif choice == '5':
            mid  = input_int("Maintenance ID")
            cost = input_float("Actual cost (VND)")
            complete_maintenance(mid, cost)

        elif choice == '6':
            check_overdue()

        elif choice == '7':
            list_upcoming()

        elif choice == '8':
            eid    = input_int("Equipment ID")
            date   = input("  Purchase date (YYYY-MM-DD): ").strip()
            value  = input_float("Value (VND)")
            vendor = input("  Vendor name               : ").strip()
            add_purchase(eid, date, value, vendor)

        elif choice == '9':
            list_purchases()

        elif choice == '10':
            total_asset_value()

        elif choice == '11':
            report_equipment_by_department()

        elif choice == '12':
            report_maintenance_costs()

        elif choice == '13':
            life = input("  Useful life years [default=5]: ").strip()
            report_depreciation(int(life) if life else 5)

        elif choice == '14':
            report_full_inventory()

        elif choice == '0':
            print("\n  Goodbye! / Tam biet!\n")
            break

        else:
            print("  [!] Invalid option. Please try again.")

        input("\n  Press Enter to continue...")


if __name__ == '__main__':
    main()
