-- ============================================================
--  PROJECT 20: Office Equipment Management System
--  File: 02_indexes.sql
--  Description: Create indexes for performance optimization
-- ============================================================

USE oems;

-- Speed up equipment lookups by department
CREATE INDEX idx_equipment_dept
    ON Equipment(DepartmentID);

-- Accelerate maintenance schedule queries by date
CREATE INDEX idx_maintenance_date
    ON Maintenance(Date);

-- Composite index for status + equipment lookups
CREATE INDEX idx_maintenance_status_equip
    ON Maintenance(Status, EquipmentID);

-- Speed up purchase date-range queries
CREATE INDEX idx_purchases_date
    ON Purchases(PurchaseDate);
