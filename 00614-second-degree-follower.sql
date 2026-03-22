/*
614. Second Degree Follower 🔒


Description
Table: Follow

+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| followee    | varchar |
| follower    | varchar |
+-------------+---------+
(followee, follower) is the primary key (combination of columns with unique values) for this table.
Each row of this table indicates that the user follower follows the user followee on a social network.
There will not be a user following themself.
 

A second-degree follower is a user who:

follows at least one user, and
is followed by at least one user.
Write a solution to report the second-degree users and the number of their followers.

Return the result table ordered by follower in alphabetical order.

The result format is in the following example.
*/

select a.followee as follower, a.followed_by as num
from (select followee, count(*) as followed_by
from follow
group by followee) a
inner join
(select follower, count(*) as follows
from follow
group by follower) b
on a.followee=b.follower
order by follower