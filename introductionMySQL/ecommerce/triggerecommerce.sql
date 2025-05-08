/*
Trigger executed afte insesting a payment, to call UpdateOrderStatus with the order_id 
*/
USE ecommerceplatform

DELIMITER //
CREATE TRIGGER after_payment_insert
AFTER INSERT ON payments
FOR EACH ROW
BEGIN
    CALL UpdateOrderStatus(NEW.order_id);
END//

DELIMITER ;