/*
612. Shortest Distance in a Plane 🔒


Description
Table: Point2D

+-------------+------+
| Column Name | Type |
+-------------+------+
| x           | int  |
| y           | int  |
+-------------+------+
(x, y) is the primary key column (combination of columns with unique values) for this table.
Each row of this table indicates the position of a point on the X-Y plane.
 

The distance between two points p1(x1, y1) and p2(x2, y2) is sqrt((x2 - x1)2 + (y2 - y1)2).

Write a solution to report the shortest distance between any two points from the Point2D table. Round the distance to two decimal points.

The result format is in the following example.

 

Example 1:

Input: 
Point2D table:
+----+----+
| x  | y  |
+----+----+
| -1 | -1 |
| 0  | 0  |
| -1 | -2 |
+----+----+
Output: 
+----------+
| shortest |
+----------+
| 1.00     |
+----------+
Explanation: The shortest distance is 1.00 from point (-1, -1) to (-1, 2).
*/

select round(sqrt(min(power(p1.x - p2.x, 2) + power(p1.y - p2.y, 2))), 2) as shortest
from  Point2D p1
join Point2D p2 
where (p1.x, p1.y) != (p2.x, p2.y)

select round(sqrt(power(p1.x - p2.x, 2) + power(p1.y - p2.y, 2)), 2) as shortest
from  Point2D p1
join Point2D p2 
where (p1.x, p1.y) != (p2.x, p2.y)
order by 1
limit 1

