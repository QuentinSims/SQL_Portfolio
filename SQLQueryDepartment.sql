--number of distinct departments 
SELECT Department, COUNT(*) AS NumberOfDepartments
FROM tblEmployee
GROUP BY Department

--derived table
SELECT Department
FROM
(
	SELECT Department, COUNT(*) AS NumberOfDepartments
	FROM tblEmployee
	GROUP BY Department
) AS newTable

--using word distinct 
SELECT DISTINCT(Department)
FROM tblEmployee

--new table
SELECT DISTINCT(Department), '' AS DepartmentHead
INTO tblDepartment
FROM tblEmployee

SELECT *
FROM tblDepartment

--join three tables
SELECT *
FROM tblDepartment
JOIN tblEmployee
ON tblDepartment.Department = tblEmployee.Department
JOIN tblTransaction
ON tblEmployee.EmployeeNumber = tblTransaction.[(EmployeeNumber)]