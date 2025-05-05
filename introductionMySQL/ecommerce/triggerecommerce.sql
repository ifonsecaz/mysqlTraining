USE ecommerceplatform

DELIMITER //
CREATE TRIGGER after_payment_insert
AFTER INSERT ON payments
FOR EACH ROW
BEGIN
    CALL UpdateOrderStatus(NEW.order_id);
END//

DELIMITER ;