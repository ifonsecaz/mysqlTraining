/*
Creates a new notification for a user. It generates a notification message 
indicating that the user has received a new message from a specified sender and inserts the 
notification into the `notifications` table.

Parameters:
- IN notificationID INT: The unique identifier for the notification.
- IN userID INT: The unique identifier of the user who will receive the notification.
- IN sender VARCHAR(50): The name of the sender who triggered the notification.
*/
CREATE DEFINER=`root`@`localhost` PROCEDURE `createNotification`(IN notificationID INT, IN userID INT, IN sender VARCHAR(50))
BEGIN
	DECLARE message varchar(200);
    set message = concat('You have a new message from ',sender);
    
    INSERT INTO notifications (notification_id, user_id, notification_text, notification_date, is_read) VALUES
    (notificationID,userID,message,CURRENT_DATE,false);
END