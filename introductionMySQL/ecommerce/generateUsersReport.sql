CREATE DEFINER=`root`@`localhost` PROCEDURE `GenerateActiveUsersReport`(
    IN p_start_date DATE,
    IN p_end_date DATE,
    IN p_limit INT
)
BEGIN
    SELECT 
        u.user_id,
        u.username,
        u.email,
        COUNT(DISTINCT o.order_id) AS total_orders,
        SUM(o.total_amount) AS total_spent,
        COUNT(r.review_id) AS total_reviews,
        MAX(o.order_date) AS last_order_date
    FROM 
        users u
        LEFT JOIN orders o ON u.user_id = o.user_id
        LEFT JOIN reviews r ON u.user_id = r.user_id
    WHERE 
        o.order_date BETWEEN p_start_date AND p_end_date
    GROUP BY 
        u.user_id, u.username, u.email
    ORDER BY 
        total_spent DESC, total_orders DESC
    LIMIT p_limit;
END