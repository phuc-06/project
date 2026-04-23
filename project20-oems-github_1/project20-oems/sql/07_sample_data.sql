-- ============================================================
--  PROJECT 20: Office Equipment Management System
--  File: 07_sample_data.sql
--  Description: Insert sample data for all tables
-- ============================================================

USE oems;

-- ── Departments ──────────────────────────────────────────────
INSERT INTO Departments (DepartmentName) VALUES
    ('Information Technology'),
    ('Human Resources'),
    ('Finance & Accounting'),
    ('Marketing'),
    ('Operations & Logistics');

-- ── Employees ────────────────────────────────────────────────
INSERT INTO Employees (EmployeeName, DepartmentID) VALUES
    ('Nguyen Van An',    1),
    ('Tran Thi Bich',   1),
    ('Le Minh Cuong',   2),
    ('Pham Thu Dung',   3),
    ('Hoang Van Em',    4),
    ('Vu Thi Phuong',   5),
    ('Do Quoc Hung',    1),
    ('Bui Lan Anh',     2);

-- ── Equipment ────────────────────────────────────────────────
INSERT INTO Equipment (EquipmentName, Type, Unit, DepartmentID) VALUES
    ('Dell Latitude 5540',       'Laptop',    'unit', 1),
    ('HP LaserJet Pro M404',     'Printer',   'unit', 2),
    ('Epson EB-S41 Projector',   'Projector', 'unit', 4),
    ('Cisco Router 2900',        'Network',   'unit', 1),
    ('HP EliteDesk 800 G6',      'Desktop',   'unit', 3),
    ('Samsung 27 inch Monitor',  'Monitor',   'unit', 1),
    ('Canon imageRUNNER 2525',   'Printer',   'unit', 5),
    ('APC UPS Back-Pro 1500VA',  'UPS',       'unit', 1);

-- ── Purchases ────────────────────────────────────────────────
INSERT INTO Purchases (EquipmentID, PurchaseDate, Value, VendorName) VALUES
    (1, '2022-03-15', 25000000, 'FPT Trading JSC'),
    (2, '2021-07-20',  8500000, 'Nguyen Kim'),
    (3, '2023-01-10', 12000000, 'DienMayXanh'),
    (4, '2020-11-05', 35000000, 'Cisco Vietnam'),
    (5, '2022-06-30', 18000000, 'HP Vietnam'),
    (6, '2023-04-12',  7200000, 'FPT Trading JSC'),
    (7, '2021-09-08', 15000000, 'Canon Vietnam'),
    (8, '2022-01-20',  6500000, 'APC Vietnam');

-- ── Maintenance ──────────────────────────────────────────────
INSERT INTO Maintenance (EquipmentID, Date, Description, Cost, Status) VALUES
    (1, '2025-06-01', 'Annual hardware checkup',          500000, 'Scheduled'),
    (2, '2025-05-15', 'Replace toner cartridge',          350000, 'Scheduled'),
    (5, '2025-04-20', 'Fan replacement and dust cleaning', 700000, 'Scheduled'),
    (4, '2025-07-10', 'Firmware update',                        0, 'Scheduled'),
    (3, '2025-05-30', 'Projector lamp replacement',        900000, 'Scheduled'),
    (1, '2024-06-10', 'SSD upgrade',                     1200000, 'Completed'),
    (7, '2024-11-20', 'Drum unit replacement',             800000, 'Completed'),
    (8, '2024-09-05', 'Battery replacement',               450000, 'Completed');
