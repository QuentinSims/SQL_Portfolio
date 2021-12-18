CREATE TABLE tblEmployee
(
	EmployeeNumber int NOT NULL,
	EmployeeFirstName varchar(50) NOT NULL,
	EmployeeMiddleName varchar(50) NULL,
	EmployeeLastName varchar(50) NOT NULL,
	EmployeeGovernmentID char(10) NULL,
	DateOfBirth date NOT NULL
)

ALTER TABLE tblEmployee
ADD Department VARCHAR(10);

INSERT INTO tblEmployee
VALUES (
	132, 'Dylan', 'A', 'Word', 'HN513777D', '19920914', 'Customer Relations'
)

ALTER TABLE tblEmployee
DROP COLUMN Department

ALTER TABLE tblEmployee
ADD Department VARCHAR(20); 


INSERT INTO tblEmployee
(
[EmployeeNumber],
[EmployeeFirstName],
[EmployeeMiddleName],
[EmployeeLastName],
[EmployeeGovernmentID],
[DateOfBirth],
[Department]
)
VALUES (
	131, 'Jossef', 'H', 'Wright', 'TX593671R', '19711224', 'Litigation'
)

--select all data
SELECT * FROM tblEmployee

--select specific data
SELECT *
FROM tblEmployee
WHERE EmployeeLastName = 'word'

--select people with specific last name
SELECT *
FROM tblEmployee
WHERE EmployeeLastName LIKE 'w%'

--select people with specific last name, letter w is the second letter
SELECT *
FROM tblEmployee
WHERE EmployeeLastName LIKE '_w%'

-- % infinity characters
-- _ is one character
--[A-G] - in a range from A-G
--[AGQ] - A, G, Q
--[^AGQ] - not A, G, Q

-- select employee greater than 200
SELECT *
FROM tblEmployee
WHERE EmployeeNumber > 200

-- select employee number two conditons
SELECT *
FROM tblEmployee
WHERE EmployeeNumber BETWEEN 100 and 200 

SELECT *
FROM tblEmployee
WHERE EmployeeNumber >= 200 and EmployeeNumber <= 200 


SELECT *
FROM tblEmployee
WHERE EmployeeNumber IN (200, 204, 208) 

