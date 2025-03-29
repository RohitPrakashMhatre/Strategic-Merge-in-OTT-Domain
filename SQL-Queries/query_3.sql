# Watched time Analysis
  
with watched_hrs as (
SELECT user_id , device_type,total_watch_time_mins , (total_watch_time_mins/ 60) as hrs
FROM content_consumption )
SELECT AVG(hrs) as avg_hrs_per_user
FROM watched_hrs;


with watched_hrs_by_citytier as  (
SELECT user_id , device_type,total_watch_time_mins , (total_watch_time_mins/ 60) as hrs
FROM content_consumption )

SELECT sb.city_tier as city_tier,AVG(hrs) as Jotstar_avg_hrs
FROM watched_hrs_by_citytier wh 
JOIN subscribers sb ON wh.user_id = sb.user_id
GROUP BY city_tier
ORDER BY Jotstar_avg_hrs desc;
