-- ============================================================
--  PROJECT 20: Office Equipment Management System
--  File: 04_procedures_functions.sql
--  Description: Stored procedures and user-defined functions
-- ============================================================

USE oems;

-- ── Stored Procedure 1: Add Equipment ───────────────────────
DELIMITER $$
CREATE PROCEDURE sp_AddEquipment(
    IN  p_name    VARCHAR(150),
    IN  p_type    VARCHAR(80),
    IN  p_unit    VARCHAR(30),
    IN  p_deptID  INT,
    OUT p_newID   INT
)
BEGIN
    INSERT INTO Equipment(EquipmentName, Type, Unit, DepartmentID)
    VALUES (p_name, p_type, p_unit, p_deptID);
    SET p_newID = LAST_INSERT_ID();
END $$
DELIMITER ;

-- ── Stored Procedure 2: Complete Maintenance ────────────────
DELIMITER $$
CREATE PROCEDURE sp_CompleteMaintenance(
    IN p_maintID    INT,
    IN p_actualCost DECIMAL(12,2)
)
BEGIN
    UPDATE Maintenance
    SET    Status = 'Completed',
           Cost   = p_actualCost
    WHERE  MaintenanceID = p_maintID;
END $$
DELIMITER ;

-- ── Stored Procedure 3: Overdue Alerts ──────────────────────
DELIMITER $$
CREATE PROCEDURE sp_OverdueAlerts()
BEGIN
    -- Mark all past-due scheduled records as Overdue
    UPDATE Maintenance
    SET    Status = 'Overdue'
    WHERE  Date < CURDATE()
      AND  Status = 'Scheduled';

    -- Return overdue list
    SELECT
        e.EquipmentName,
        d.DepartmentName,
        m.Date        AS OverdueDate,
        m.Description,
        DATEDIFF(CURDATE(), m.Date) AS DaysOverdue
    FROM  Maintenance  m
    JOIN  Equipment    e ON m.EquipmentID  = e.EquipmentID
    JOIN  Departments  d ON e.DepartmentID = d.DepartmentID
    WHERE m.Status = 'Overdue'
    ORDER BY DaysOverdue DESC;
END $$
DELIMITER ;

-- ── UDF 1: Total Asset Value ─────────────────────────────────
DELIMITER $$
CREATE FUNCTION fn_TotalAssetValue()
RETURNS DECIMAL(18, 2)
DETERMINISTIC READS SQL DATA
BEGIN
    DECLARE total DECIMAL(18, 2);
    SELECT IFNULL(SUM(Value), 0) INTO total FROM Purchases;
    RETURN total;
END $$
DELIMITER ;

-- ── UDF 2: Straight-Line Depreciation ───────────────────────
-- Formula: CurrentValue = PurchaseValue * (1 - YearsUsed / UsefulLife)
DELIMITER $$
CREATE FUNCTION fn_Depreciation(
    purchase_value     DECIMAL(15, 2),
    purchase_date      DATE,
    useful_life_years  INT
)
RETURNS DECIMAL(15, 2)
DETERMINISTIC
BEGIN
    DECLARE years_used DECIMAL(6, 2);
    SET years_used = DATEDIFF(CURDATE(), purchase_date) / 365.0;

    IF years_used >= useful_life_years THEN
        RETURN 0.00;
    END IF;

    RETURN ROUND(
        purchase_value * (1 - years_used / useful_life_years), 2
    );
END $$
DELIMITER ;
