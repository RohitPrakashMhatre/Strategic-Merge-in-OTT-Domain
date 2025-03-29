# Distribution of subscribers by age group and city tier

SELECT COUNT(user_id) as user_counts, age_group
 FROM subscribers
 GROUP BY age_group
 ORDER BY user_counts desc;

 SELECT COUNT(user_id) as user_counts, city_tier
 FROM subscribers
 GROUP BY city_tier
 ORDER BY user_counts desc;
