# Most Common Upgraded Plans

WITH common_upgrades AS (
    SELECT 
	CASE
	   WHEN subscription_plan = 'Free' and new_subscription_plan = 'Basic' THEN 'Free_to_Basic'
	   WHEN subscription_plan = 'Free' and new_subscription_plan = 'Premium' Then 'Free_to_Premium'
	   WHEN subscription_plan = 'Free' and new_subscription_plan = 'VIP' THEN 'Free_to_VIP'
	END as LioCinema_upgrades
    FROM subscribers
    WHERE subscription_plan = 'Free' and new_subscription_plan IS NOT NULL
)
SELECT LioCinema_upgrades, COUNT(*) as total_upgrades
FROM common_upgrades
GROUP BY LioCinema_upgrades
ORDER BY total_upgrades DESC;