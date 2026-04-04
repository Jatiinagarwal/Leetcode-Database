/*
1241. Number of Comments per Post 🔒


Description
Table: Submissions

+---------------+----------+
| Column Name   | Type     |
+---------------+----------+
| sub_id        | int      |
| parent_id     | int      |
+---------------+----------+
This table may have duplicate rows.
Each row can be a post or comment on the post.
parent_id is null for posts.
parent_id for comments is sub_id for another post in the table.
 

Write a solution to find the number of comments per post. The result table should contain post_id and its corresponding number_of_comments.

The Submissions table may contain duplicate comments. You should count the number of unique comments per post.

The Submissions table may contain duplicate posts. You should treat them as one post.

The result table should be ordered by post_id in ascending order.

The result format is in the following example.

 

Example 1:

Input: 
Submissions table:
+---------+------------+
| sub_id  | parent_id  |
+---------+------------+
| 1       | Null       |
| 2       | Null       |
| 1       | Null       |
| 12      | Null       |
| 3       | 1          |
| 5       | 2          |
| 3       | 1          |
| 4       | 1          |
| 9       | 1          |
| 10      | 2          |
| 6       | 7          |
+---------+------------+
Output: 
+---------+--------------------+
| post_id | number_of_comments |
+---------+--------------------+
| 1       | 3                  |
| 2       | 2                  |
| 12      | 0                  |
+---------+--------------------+
Explanation: 
The post with id 1 has three comments in the table with id 3, 4, and 9. The comment with id 3 is repeated in the table, we counted it only once.
The post with id 2 has two comments in the table with id 5 and 10.
The post with id 12 has no comments in the table.
The comment with id 6 is a comment on a deleted post with id 7 so we ignored it.
*/

with left_table as
(select distinct sub_id
from Submissions
where parent_id is null),

right_table as
(select parent_id, count(distinct sub_id) as num
from Submissions
where parent_id is not null
group by 1)

select l.sub_id as post_id, case when num is not null then num else o end as number_of_comments
from left_table l
left join right_table r
on l.sub_id = r.parent_id
order by 1

select distinct l.sub_id as post_id, count(distinct r.sub_id) as number_of_comments
from Submissions l
left join Submissions r
on l.sub_id = r.parent_id
where l.parent_id is null
group by 1
order by 1