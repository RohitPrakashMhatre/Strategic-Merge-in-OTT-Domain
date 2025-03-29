# Correlation Analysis between Inactive users and total watch time 

WITH user_engagement AS (
    SELECT DISTINCT user_id,
           CASE
               WHEN last_active_date IS NULL THEN 1  
               ELSE 0
           END AS inactivity_status
    FROM subscribers
),
watched_hrs AS (
    SELECT user_id,
           SUM(total_watch_time_mins) AS total_min,
           AVG(total_watch_time_mins) AS avg_min
    FROM content_consumption
    GROUP BY user_id
),
combined AS (
    SELECT ue.user_id, ue.inactivity_status, wh.total_min, wh.avg_min
    FROM user_engagement ue
    LEFT JOIN watched_hrs wh ON ue.user_id = wh.user_id
),
stats AS (
    SELECT 
	COUNT(*) as n,
	SUM(inactivity_status) as sum_x,
	sum(total_min) as sum_y_total,
	sum(inactivity_status * total_min) as sum_xy_total,
	sum(total_min * total_min) as sum_y2_total,
	sum(inactivity_status * inactivity_status) as sum_x2
    FROM combined
)
SELECT 
    ROUND( (sum_xy_total - (sum_x * sum_y_total) / n) /
      SQRT((sum_x2 - (sum_x * sum_x) / n) * (sum_y2_total - (sum_y_total * sum_y_total) / n))
    ,2) AS Jotstar_correlation_watch_min 
FROM stats;
