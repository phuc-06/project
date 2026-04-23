-- ============================================================
--  PROJECT 20: Office Equipment Management System
--  File: 01_schema.sql
--  Description: Create database and all tables
-- ============================================================

CREATE DATABASE IF NOT EXISTS oems
    CHARACTER SET utf8mb4
    COLLATE utf8mb4_unicode_ci;

USE oems;

-- ── Table: Departments ──────────────────────────────────────
CREATE TABLE Departments (
    DepartmentID   INT          PRIMARY KEY AUTO_INCREMENT,
    DepartmentName VARCHAR(100) NOT NULL UNIQUE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ── Table: Employees ────────────────────────────────────────
CREATE TABLE Employees (
    EmployeeID   INT          PRIMARY KEY AUTO_INCREMENT,
    EmployeeName VARCHAR(100) NOT NULL,
    DepartmentID INT          NOT NULL,
    FOREIGN KEY (DepartmentID)
        REFERENCES Departments(DepartmentID)
        ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ── Table: Equipment ────────────────────────────────────────
CREATE TABLE Equipment (
    EquipmentID   INT          PRIMARY KEY AUTO_INCREMENT,
    EquipmentName VARCHAR(150) NOT NULL,
    Type          VARCHAR(80)  NOT NULL,
    Unit          VARCHAR(30)  NOT NULL DEFAULT 'unit',
    Status        ENUM('Active','Under Maintenance','Retired')
                               NOT NULL DEFAULT 'Active',
    DepartmentID  INT,
    FOREIGN KEY (DepartmentID)
        REFERENCES Departments(DepartmentID)
        ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ── Table: Maintenance ──────────────────────────────────────
CREATE TABLE Maintenance (
    MaintenanceID INT            PRIMARY KEY AUTO_INCREMENT,
    EquipmentID   INT            NOT NULL,
    Date          DATE           NOT NULL,
    Description   TEXT,
    Cost          DECIMAL(12, 2) NOT NULL DEFAULT 0.00,
    Status        ENUM('Scheduled','Completed','Overdue')
                                 NOT NULL DEFAULT 'Scheduled',
    FOREIGN KEY (EquipmentID)
        REFERENCES Equipment(EquipmentID)
        ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ── Table: Purchases ────────────────────────────────────────
CREATE TABLE Purchases (
    PurchaseID   INT            PRIMARY KEY AUTO_INCREMENT,
    EquipmentID  INT            NOT NULL,
    PurchaseDate DATE           NOT NULL,
    Value        DECIMAL(15, 2) NOT NULL,
    VendorName   VARCHAR(100),
    FOREIGN KEY (EquipmentID)
        REFERENCES Equipment(EquipmentID)
        ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
