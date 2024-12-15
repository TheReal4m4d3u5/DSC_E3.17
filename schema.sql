DROP TABLE IF EXISTS Manages CASCADE;
DROP TABLE IF EXISTS Works CASCADE;
DROP TABLE IF EXISTS Company CASCADE;
DROP TABLE IF EXISTS Employee CASCADE;

-- Create Employee table
CREATE TABLE Employee (
    Employee_name VARCHAR(50) PRIMARY KEY,
    street VARCHAR(100),
    city VARCHAR(50)
);

-- Create Works table
CREATE TABLE Works (
    Employee_name VARCHAR(50),
    company_name VARCHAR(50),
    salary DECIMAL(10, 2),
    PRIMARY KEY (Employee_name, company_name),
    FOREIGN KEY (Employee_name) REFERENCES Employee(Employee_name)
);

-- Create Company table
CREATE TABLE Company (
    company_name VARCHAR(50) PRIMARY KEY,
    city VARCHAR(50)
);

-- Create Manages table
CREATE TABLE Manages (
    Employee_name VARCHAR(50),
    Manager_name VARCHAR(50),
    PRIMARY KEY (Employee_name, Manager_name),
    FOREIGN KEY (Employee_name) REFERENCES Employee(Employee_name),
    FOREIGN KEY (Manager_name) REFERENCES Employee(Employee_name)
);

INSERT INTO Employee (Employee_name, street, city) VALUES
('Alice', '123 Main St', 'New York'),
('Bob', '456 Maple Ave', 'Los Angeles'),
('Charlie', '789 Oak St', 'New York'),
('David', '321 Pine Rd', 'Chicago'),
('Eve', '654 Elm St', 'New York'),
('Frank', '987 Cedar St', 'Los Angeles');

-- Insert data into Works table
INSERT INTO Works (Employee_name, company_name, salary) VALUES
('Alice', 'First Bank Corporation', 120000.00),
('Bob', 'Tech Solutions', 95000.00),
('Charlie', 'First Bank Corporation', 110000.00),
('David', 'Financial Group', 105000.00),
('Eve', 'First Bank Corporation', 115000.00),
('Frank', 'Tech Solutions', 98000.00);

-- Insert data into Company table
INSERT INTO Company (company_name, city) VALUES
('First Bank Corporation', 'New York'),
('Tech Solutions', 'Los Angeles'),
('Financial Group', 'Chicago');

-- Insert data into Manages table
INSERT INTO Manages (Employee_name, Manager_name) VALUES
('Alice', 'Charlie'),
('Bob', 'Frank'),
('Charlie', 'Alice'),
('David', 'Charlie'),
('Eve', 'Charlie');


INSERT INTO Employee (Employee_name, street, city) 
VALUES ('Grace', '111 Birch St', 'Boston');

-- Then, insert Grace into the Works table with "Small Bank Corporation"
INSERT INTO Works (Employee_name, company_name, salary) 
VALUES ('Grace', 'Small Bank Corporation', 90000.00);


-- a. Give all employees of “First Bank Corporation” a 10 percent raise.
UPDATE Works
SET salary = salary * 1.10
WHERE company_name = 'First Bank Corporation';

-- b. Give all managers of “First Bank Corporation” a 10 percent raise.
UPDATE Works
SET salary = salary * 1.10
WHERE Employee_name IN (
    SELECT M.Manager_name
    FROM Manages M
    JOIN Works W ON M.Employee_name = W.Employee_name
    WHERE W.company_name = 'First Bank Corporation'
);

-- c. Delete all tuples in the Works relation for employees of “Small Bank Corporation.”
DELETE FROM Works
WHERE company_name = 'Small Bank Corporation';