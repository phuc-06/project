-- ============================================================
--  PROJECT 20: Office Equipment Management System
--  File: 06_security.sql
--  Description: User roles and access control
-- ============================================================

USE oems;

-- ── IT Administrator: full control ──────────────────────────
CREATE USER IF NOT EXISTS 'it_admin'@'localhost'
    IDENTIFIED BY 'SecureAdmin#2025!';
GRANT ALL PRIVILEGES ON oems.* TO 'it_admin'@'localhost';

-- ── Department Manager: read/write own data ──────────────────
CREATE USER IF NOT EXISTS 'dept_manager'@'localhost'
    IDENTIFIED BY 'DeptMgr#2025!';
GRANT SELECT, INSERT, UPDATE
    ON oems.Equipment   TO 'dept_manager'@'localhost';
GRANT SELECT, INSERT, UPDATE
    ON oems.Maintenance TO 'dept_manager'@'localhost';
GRANT SELECT
    ON oems.vw_EquipmentByDepartment TO 'dept_manager'@'localhost';
GRANT SELECT
    ON oems.vw_UpcomingMaintenance   TO 'dept_manager'@'localhost';

-- ── Auditor: read-only financial data ───────────────────────
CREATE USER IF NOT EXISTS 'auditor'@'localhost'
    IDENTIFIED BY 'AuditRO#2025!';
GRANT SELECT ON oems.Purchases
    TO 'auditor'@'localhost';
GRANT SELECT ON oems.vw_MaintenanceCostSummary
    TO 'auditor'@'localhost';

FLUSH PRIVILEGES;
