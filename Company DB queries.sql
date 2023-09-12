-- #1 Provide the complete info on all employees.
SELECT * FROM employee;

-- #2 What is the count of all employees?
SELECT COUNT(*) FROM employee;

-- #3 What is the count of all departments?
SELECT COUNT(*) FROM department;

-- #4 Names of employees that work for Department # 4.
SELECT CONCAT(Fname, ' ', Minit, ' ', Lname) AS employee_name
FROM employee
WHERE employee.Dno = '4';

-- #5 Name of projects in Sugarland
SELECT pname
FROM project
WHERE plocation = 'Sugarland';

-- #6 Employees name and hours information (provide only the script)
SELECT CONCAT(Fname, ' ', Minit, ' ', Lname) AS employee_name, 
employee.SSN, SUM(works_on.hours)
FROM employee
JOIN works_on ON employee.SSN = works_on.essn
GROUP BY employee.SSN, employee_name;

-- #7 Employees name that don't work on Project ProductX
SELECT CONCAT(Fname, ' ', Minit, ' ', Lname) AS employee_name
FROM employee
JOIN project ON employee.Dno = project.dnum
WHERE NOT pname= 'ProductX'
GROUP BY employee_name;

-- #8 Who worked the most hours? the least hours?
SELECT employee.SSN, CONCAT(Fname, ' ', Minit, ' ', Lname) AS employee_name, 
SUM(works_on.hours) as hours_worked
FROM employee
JOIN works_on ON employee.SSN = works_on.essn
GROUP BY employee.SSN, employee_name
ORDER BY hours_worked DESC
LIMIT 1; -- Employee who worked the most hours;

SELECT employee.SSN, CONCAT(Fname, ' ', Minit, ' ', Lname) AS employee_name, 
SUM(works_on.hours) as hours_worked
FROM employee
JOIN works_on ON employee.SSN = works_on.essn
GROUP BY employee.SSN, employee_name
ORDER BY hours_worked ASC
LIMIT 1; -- Employee who worked the least hours;

-- #9 Who worked the most hours in Research dept?
SELECT employee.SSN, CONCAT(Fname, ' ', Minit, ' ', Lname) AS employee_name, 
SUM(works_on.hours) as hours_worked, department.dname AS dept
FROM employee
JOIN works_on ON employee.SSN = works_on.essn
JOIN department on employee.Dno = department.dnumber
WHERE department.dname = 'Research'
GROUP BY employee.SSN, department.dname;


-- #10 Names of dependents for person who worked most hours in Research dept. 
SELECT employee.SSN, CONCAT(employee.Fname, ' ', employee.Minit, ' ', employee.Lname) AS employee_name,
SUM(works_on.hours) as hours_worked,department.dname AS dept, dependent.dependent_name
FROM employee
JOIN department ON employee.Dno = department.dnumber
JOIN works_on ON employee.SSN = works_on.essn
JOIN dependent ON employee.SSN = dependent.essn
WHERE department.dname = 'Research'
GROUP BY employee.SSN, employee_name, dept, dependent.dependent_name;

-- #11 Provide the name of projects in either Department number 4 or 5
SELECT pname, dnum
FROM project
WHERE dnum = 4 OR dnum = 5;

-- #12 Provide the names of employees with either a son or wife dependent
SELECT employee.SSN, CONCAT(employee.Fname, ' ', employee.Minit, ' ', employee.Lname) AS employee_name,
dependent.sex, dependent.relationship
FROM employee
JOIN dependent ON employee.SSN = dependent.essn
WHERE (relationship = 'Spouse' AND dependent.sex = 'F') OR relationship = 'Son';

-- #13 Provide the names of employees with salary between $5k and $30k
 SELECT CONCAT(employee.Fname, ' ', employee.Minit, ' ', employee.Lname) AS employee_name,
 employee.Salary
 FROM employee
 WHERE Salary BETWEEN 5000 AND 30000;
 
-- #14 Provide the names of employees that worked between 30 and 40 hours
 SELECT CONCAT(employee.Fname, ' ', employee.Minit, ' ', employee.Lname) AS employee_name,
 SUM(works_on.hours) AS hours_worked
 FROM employee
 JOIN works_on ON employee.SSN = works_on.essn
 GROUP BY employee_name
 HAVING SUM(works_on.hours) BETWEEN 30 AND 40;
 
 -- #15 Provide the department name and project name for projects in Houston, Sugarland, or Stafford
 SELECT department.dname, project.pname, project.plocation
 FROM department
 JOIN project ON department.dnumber = project.dnum
 WHERE project.plocation = 'Houston' OR plocation = 'Sugarland' OR plocation = 'Stafford';
 
 # NOT in Houston, Sugarland, Stafford
SELECT department.dname, project.pname, project.plocation
FROM department
JOIN project ON department.dnumber = project.dnum
WHERE NOT project.plocation in ('Houston','Sugarland','Stafford');

 -- #16 Provide employees with A in First Name
SELECT employee.Fname, employee.Lname
FROM employee
WHERE Fname LIKE '%A%';

 -- #17 Provide employees with Last Name that does not begin with W
 SELECT employee.Fname, employee.Lname
 FROM employee
 WHERE Lname NOT LIKE 'W%';

-- #18 Provide employees with ‘a’ as the second letter
 SELECT employee.Fname, employee.Lname
 FROM employee
 WHERE Fname LIKE '_a%';

-- #19 What is the average hours worked for employees in the Research department?
SELECT  department.dname AS dept, AVG(works_on.hours) AS hours_worked
FROM works_on
INNER JOIN project ON works_on.pno = project.pnumber
INNER JOIN department ON project.dnum = department.dnumber
WHERE department.dname = 'Research'
GROUP BY department.dname;

-- #20 What is the total salary for employees that worked on either Product Z or X?
SELECT SUM(employee.salary), project.pname
FROM employee
JOIN project ON employee.Dno=project.dnum
WHERE project.pname = 'ProductZ' OR pname = 'ProductX'
GROUP BY project.pname;

-- #21 Name of employees who first name start with A and order last name alphabetically
SELECT employee.Fname, employee.Lname
FROM employee
WHERE Fname LIKE 'A%'
ORDER BY Lname ASC;

-- #22 Name of employees in Department number 5 and salary ordered largest to smallest
 SELECT CONCAT(employee.Fname, ' ', employee.Minit, ' ', employee.Lname) AS employee_name,
 employee.salary, department.dnumber
 FROM employee
 JOIN department ON employee.Dno = department.dnumber
 WHERE department.dnumber = '5'
 ORDER BY salary DESC;
 
 -- #23 Sort employee birthdates from oldest to newest and then sort first names in alphabetical order
 SELECT employee.bdate, employee.Fname
 FROM employee
 ORDER BY employee.bdate DESC, employee.Fname ASC;
 
  -- #24 Sort employee salaries by largest to smallest and employee last names alphabetically
 SELECT employee.Lname, employee.salary
 FROM employee
 ORDER BY employee.salary DESC, employee.Lname ASC;
 
 -- #25 How many male and female employees are there?
SELECT employee.sex, COUNT(employee.sex) AS Total
FROM employee
GROUP BY sex;

-- #26 How many male and female dependents are there?
SELECT dependent.sex, COUNT(dependent.sex) AS Total
FROM dependent
GROUP BY sex;

-- #27 How many projects are there for each location?
SELECT project.plocation, COUNT(project.plocation) AS Total
FROM project
GROUP BY plocation;

-- #28 Identify the number of projects in each location and order by most to least projects
SELECT project.plocation, COUNT(project.plocation) AS Total
FROM project
GROUP BY plocation
ORDER BY COUNT(plocation) DESC;

-- #29 Identify the number of male and female employees and order from most to least
SELECT sex, COUNT(sex) AS Total
FROM employee
GROUP BY sex
ORDER BY COUNT(sex) DESC; 

-- #30 How many male and female spouses are there?
SELECT sex, COUNT(Sex) AS Total 
FROM dependent
WHERE relationship='Spouse'
GROUP BY sex;

-- #31 What departments pay over $50,000 to employees?
SELECT department.dname, SUM(employee.salary)
FROM department
JOIN employee ON department.dnumber = employee.Dno
GROUP BY department.dname
HAVING SUM(salary) > 50000;

-- #32 Provide the employee SSN and number of dependents for employees with more than 1 dependent
SELECT dependent.essn, COUNT(dependent_name)
FROM dependent
GROUP BY essn
HAVING COUNT(dependent_name) > 1;

-- #33 Provide the project locations with more than 1 project
SELECT plocation, COUNT(pname)
FROM project
GROUP BY plocation
HAVING COUNT(pname) > 1;

#34.Get the name, birthdate, sex, and salary for each employee.
SELECT Fname, Lname, bdate, sex, salary
FROM employee;

#a.	Modify query to get only employees born after 1960.
SELECT Fname, Lname, bdate, sex, salary
FROM employee
WHERE bdate > '1960-12-31';

#b.	Modify query to group by sex for those born after 1960 (remove name and salary)
SELECT COUNT(bdate), sex
FROM employee
WHERE bdate > '1960-12-31'
GROUP BY sex;

#c.	Modify query to get the average salary for men and women employees born after 1960
SELECT AVG(salary), sex
FROM employee
WHERE bdate > '1960-12-31'
GROUP BY sex;

#d.	Modify query to get the average salary for men and women employees born after 1960 and with an average over $15,000 ranked from smallest to largest
SELECT AVG(salary), sex
FROM (
    SELECT salary, sex
    FROM employee
    WHERE bdate > '1960-12-31'
) AS subquery
GROUP BY sex
HAVING AVG(salary) > 15000
ORDER BY AVG(salary)