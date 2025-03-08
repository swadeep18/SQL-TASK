-- Task 1: Create a table named Employee Details with the following 10 columns and use 
-- suitable constraint for every column:

CREATE TABLE employee_details (
EmployeeID SERIAL, 
FirstName varchar(50),
LastName varchar(50),
Email varchar(100), 
PhoneNumber varchar(15),
HireDate Date,
Salary decimal(10,2),
DepartmentID Int,
IsActive Boolean,
JobTitle varchar(100)
) 

-- Task 2: Insert data into the Employee_Details Table
INSERT INTO employee_details values (
5,'Dhruvv', 'Malpe', 'dhruvv2@gmail.com',9503535642,'2025-04-27',40000,5,'No','Graphics Designer'
)

-- Task 3: Insert Data from a CSV File into the SQL Table 

copy employee_details from 'D:\Data Analytics\SQL\SQL Task File\SQL Task-1\Employee_Details.csv' DELIMITER ',' csv header;

-- Task 4: Update the Employee_Details Table 
UPDATE employee_details set departmentid = 0;

-- Task 5: Update the Employee_Details Table - Salary Increment 
UPDATE employee_details set salary=salary*1.08
WHERE 
isactive=FALSE AND
departmentid=0 AND
jobtitle IN ('HR Manager','Financial Analyst','Business Analyst','Data Analyst');

-- Task 6: Query to Find Employees with Custom Column Names
SELECT firstname AS Name,lastname AS Surname
FROM employee_details
WHERE salary BETWEEN 30000 AND 50000;

-- Task 7: Query to Find Employees Whose FirstName Starts with 'A' 
SELECT * FROM employee_details
WHERE firstname LIKE ('A%');

-- Task 8: Delete Rows with EmployeeID from 1 to 5
DELETE FROM employee_details
WHERE employeeid BETWEEN 1 AND 5;


-- Task 9: Rename Table and Columns
ALTER Table employee_details RENAME TO employee_database;
ALTER TABLE employee_database RENAME COLUMN firstname TO name;
ALTER TABLE employee_database RENAME COLUMN lastname TO surname;

-- Task 10: Add State Column and Update Data in PostgreSQL
ALTER TABLE employee_database 
ADD COLUMN state varchar;

UPDATE employee_database 
SET state=
 case 
  WHEN isactive=true THEN 'India'
  ELSE 'USA'
 END;

ALTER TABLE employee_database
ALTER COLUMN state SET NOT NULL;







