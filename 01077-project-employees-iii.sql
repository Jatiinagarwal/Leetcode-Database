/*
1077. Project Employees III 🔒


Description
Table: Project

+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| project_id  | int     |
| employee_id | int     |
+-------------+---------+
(project_id, employee_id) is the primary key (combination of columns with unique values) of this table.
employee_id is a foreign key (reference column) to Employee table.
Each row of this table indicates that the employee with employee_id is working on the project with project_id.
 

Table: Employee

+------------------+---------+
| Column Name      | Type    |
+------------------+---------+
| employee_id      | int     |
| name             | varchar |
| experience_years | int     |
+------------------+---------+
employee_id is the primary key (column with unique values) of this table.
Each row of this table contains information about one employee.
 

Write a solution to report the most experienced employees in each project. In case of a tie, report all employees with the maximum number of experience years.

Return the result table in any order.

The result format is in the following example.
*/

with CTE as
    (select p.project_id, p.employee_id, e.experience_years, 
        dense_rank() over(partition by p.project_id order by e.experience_years desc) as rnk
    from Project p
    left join Employee e
    on p.employee_id = e.employee_id)

select project_id, employee_id
from CTE
where rnk = 1
