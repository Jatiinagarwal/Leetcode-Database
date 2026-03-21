/*
603. Consecutive Available Seats 🔒


Description
Table: Cinema

+-------------+------+
| Column Name | Type |
+-------------+------+
| seat_id     | int  |
| free        | bool |
+-------------+------+
seat_id is an auto-increment column for this table.
Each row of this table indicates whether the ith seat is free or not. 1 means free while 0 means occupied.
 

Find all the consecutive available seats in the cinema.

Return the result table ordered by seat_id in ascending order.

The test cases are generated so that more than two seats are consecutively available.

The result format is in the following example.

 

Example 1:

Input: 
Cinema table:
+---------+------+
| seat_id | free |
+---------+------+
| 1       | 1    |
| 2       | 0    |
| 3       | 1    |
| 4       | 1    |
| 5       | 1    |
+---------+------+
Output: 
+---------+
| seat_id |
+---------+
| 3       |
| 4       |
| 5       |
+---------+
*/

with CTE as(
    select seat_id, free, 
        lag(free, 1) over(order by seat_id) as lag_free, 
        lead(free, 1) over(order by seat_id) as lead_free
    from Cinema)

select seat_id 
from CTE
where (free = 1 and lag_free = 1) or (free = 1 and lead_free = 1)
order by 1

select seat_id
from Cinema
where free = 1 and
     (seat_id - 1 in (select seat_id
                      from Cinema
                      where free = 1)
    or
    seat_id + 1 in (select seat_id
                      from Cinema
                      where free = 1))