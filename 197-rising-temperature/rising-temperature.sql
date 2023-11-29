# Write your MySQL query statement below
WITH CTE AS (
select
id,
coalesce(LEAD(id) OVER(ORDER BY recorddate ASC),0) AS id_next,
recorddate,
coalesce(LEAD(recorddate) OVER(ORDER BY recorddate ASC),0) AS recorddate_next,
temperature,
LEAD(temperature) OVER(ORDER BY recorddate ASC) AS temperature_next
from weather
)
SELECT  id_next as Id
from cte
where
temperature_next>temperature and
recorddate<recorddate_next  and
date_add(recorddate, INTERVAL 1 DAY)=recorddate_next