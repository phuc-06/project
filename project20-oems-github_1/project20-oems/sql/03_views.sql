-- ============================================================
--  PROJECT 20: Office Equipment Management System
--  File: 03_views.sql
--  Description: Create views for reporting
-- ============================================================

USE oems;

-- ── View 1: Equipment by Department ─────────────────────────
CREATE OR REPLACE VIEW vw_EquipmentByDepartment AS
    SELECT
        d.DepartmentName,
        e.EquipmentID,
        e.EquipmentName,
        e.Type,
        e.Status
    FROM  Equipment   e
    JOIN  Departments d ON e.DepartmentID = d.DepartmentID
    ORDER BY d.DepartmentName, e.EquipmentName;

-- ── View 2: Upcoming Maintenance (Next 30 Days) ──────────────
CREATE OR REPLACE VIEW vw_UpcomingMaintenance AS
    SELECT
        e.EquipmentName,
        d.DepartmentName,
        m.Date         AS ScheduledDate,
        m.Description,
        m.Cost         AS EstimatedCost
    FROM  Maintenance  m
    JOIN  Equipment    e ON m.EquipmentID  = e.EquipmentID
    JOIN  Departments  d ON e.DepartmentID = d.DepartmentID
    WHERE m.Date   BETWEEN CURDATE()
                       AND DATE_ADD(CURDATE(), INTERVAL 30 DAY)
      AND m.Status = 'Scheduled'
    ORDER BY m.Date;

-- ── View 3: Maintenance Cost Summary ─────────────────────────
CREATE OR REPLACE VIEW vw_MaintenanceCostSummary AS
    SELECT
        e.EquipmentName,
        COUNT(m.MaintenanceID)  AS TotalServices,
        SUM(m.Cost)             AS TotalCost,
        MAX(m.Date)             AS LastServiceDate
    FROM  Equipment   e
    LEFT JOIN Maintenance m ON e.EquipmentID = m.EquipmentID
    GROUP BY e.EquipmentID, e.EquipmentName
    ORDER BY TotalCost DESC;
