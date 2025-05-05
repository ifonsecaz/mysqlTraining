CREATE DEFINER=`root`@`localhost` PROCEDURE `UpdateOrderStatus`(IN p_order_id INT)
BEGIN
    DECLARE v_payment_count INT;
    DECLARE v_order_status VARCHAR(50);
    DECLARE v_order_date DATE;
    
    SELECT order_status, order_date INTO v_order_status, v_order_date
    FROM orders WHERE order_id = p_order_id;
    
    SELECT COUNT(*) INTO v_payment_count
    FROM payments WHERE order_id = p_order_id;
    
    IF v_order_status = 'Processing' AND v_payment_count > 0 THEN
        SET v_order_status = 'Paid';
    ELSEIF v_order_status = 'Paid' AND DATEDIFF(CURDATE(), v_order_date) >= 1 THEN
        SET v_order_status = 'Shipped';
    ELSEIF v_order_status = 'Shipped' AND DATEDIFF(CURDATE(), v_order_date) >= 3 THEN
        SET v_order_status = 'Delivered';
    END IF;
    
    IF v_order_status != (SELECT order_status FROM orders WHERE order_id = p_order_id) THEN
        UPDATE orders SET order_status = v_order_status 
        WHERE order_id = p_order_id;
    END IF;
END