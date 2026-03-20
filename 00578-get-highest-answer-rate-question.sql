/*
578. Get Highest Answer Rate Question 🔒


Description
Table: SurveyLog

+-------------+------+
| Column Name | Type |
+-------------+------+
| id          | int  |
| action      | ENUM |
| question_id | int  |
| answer_id   | int  |
| q_num       | int  |
| timestamp   | int  |
+-------------+------+
This table may contain duplicate rows.
action is an ENUM (category) of the type: "show", "answer", or "skip".
Each row of this table indicates the user with ID = id has taken an action with the question question_id at time timestamp.
If the action taken by the user is "answer", answer_id will contain the id of that answer, otherwise, it will be null.
q_num is the numeral order of the question in the current session.
 

The answer rate for a question is the number of times a user answered the question by the number of times a user showed the question.

Write a solution to report the question that has the highest answer rate. If multiple questions have the same maximum answer rate, report the question with the smallest question_id.

The result format is in the following example.

 

Example 1:

Input: 
SurveyLog table:
+----+--------+-------------+-----------+-------+-----------+
| id | action | question_id | answer_id | q_num | timestamp |
+----+--------+-------------+-----------+-------+-----------+
| 5  | show   | 285         | null      | 1     | 123       |
| 5  | answer | 285         | 124124    | 1     | 124       |
| 5  | show   | 369         | null      | 2     | 125       |
| 5  | skip   | 369         | null      | 2     | 126       |
+----+--------+-------------+-----------+-------+-----------+
Output: 
+------------+
| survey_log |
+------------+
| 285        |
+------------+
Explanation: 
Question 285 was showed 1 time and answered 1 time. The answer rate of question 285 is 1.0
Question 369 was showed 1 time and was not answered. The answer rate of question 369 is 0.0
Question 285 has the highest answer rate.

select question_id as survey_log
from SurveyLog
group by question_id
order by round(sum(action = 'answer')/sum(action = 'show'), 2) desc, 1 asc
limit 1

with cte as
(select questionId, sum(case when action = 'answer' then 1 else 0 end) / sum(case when action = 'show' then 1 else 0 end)
as answer_rate
from SurveyLog
group by question_id)

select question_id as Surver_log
from cte
order by answer_rate desc, question_id
limit 1

with t1 as
(select question_id, sum(case when action = 'answer' then 1 else 0 end) as ans_cnt
from SurveyLog
group by question_id),

t2 as
(select question_id, sum(case when action = 'show' then 1 else 0 end) as show_cnt
from SurveyLog
group by question_id)

select t1.question_id as survey_log
from t1
join t2
order by t1.ans_cnt/t2.show_cnt desc, 1
limit 1