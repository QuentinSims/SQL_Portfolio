SELECT LEFT(EmployeeLastName, 1) as Initial, COUNT(*) as CountOfInitial
FROM tblEmployee
GROUP BY LEFT(EmployeeLastName, 1)
ORDER BY LEFT(EmployeeLastName, 1) asc

SELECT TOP(5) LEFT(EmployeeLastName, 1) as Initial, COUNT(*) as CountOfInitial
FROM tblEmployee
GROUP BY LEFT(EmployeeLastName, 1)
ORDER BY COUNT(*) DESC

SELECT LEFT(EmployeeLastName, 1) as Initial, COUNT(*) as CountOfInitial
FROM tblEmployee
GROUP BY LEFT(EmployeeLastName, 1)
HAVING COUNT(*) >= 50
ORDER BY COUNT(*) DESC

SELECT LEFT(EmployeeLastName, 1) as Initial, COUNT(*) as CountOfInitial
FROM tblEmployee
WHERE DateOfBirth > '19860101'
GROUP BY LEFT(EmployeeLastName, 1)
HAVING COUNT(*) >= 20
ORDER BY COUNT(*) DESC

