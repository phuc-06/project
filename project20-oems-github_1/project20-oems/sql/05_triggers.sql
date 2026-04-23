-- ============================================================
--  PROJECT 20: Office Equipment Management System
--  File: 05_triggers.sql
--  Description: Triggers for automatic status management
-- ============================================================

USE oems;

-- ── Trigger 1: Auto-set "Under Maintenance" on Schedule ─────
DELIMITER $$
CREATE TRIGGER trg_MaintenanceScheduled
AFTER INSERT ON Maintenance
FOR EACH ROW
BEGIN
    IF NEW.Status = 'Scheduled' THEN
        UPDATE Equipment
        SET    Status = 'Under Maintenance'
        WHERE  EquipmentID = NEW.EquipmentID;
    END IF;
END $$
DELIMITER ;

-- ── Trigger 2: Auto-restore "Active" on Completion ──────────
DELIMITER $$
CREATE TRIGGER trg_MaintenanceComplete
AFTER UPDATE ON Maintenance
FOR EACH ROW
BEGIN
    IF NEW.Status = 'Completed'
       AND OLD.Status != 'Completed'
    THEN
        UPDATE Equipment
        SET    Status = 'Active'
        WHERE  EquipmentID = NEW.EquipmentID;
    END IF;
END $$
DELIMITER ;
