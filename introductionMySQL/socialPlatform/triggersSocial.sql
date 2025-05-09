/*
Definitions for triggers for the `socialmediaplatform` database. 

1. Trigger: `after_new_message`
    - Event: AFTER INSERT on the `messages` table.
    - Purpose: 
      - Retrieves the receiver's user ID and the sender's username for the newly inserted message.
      - Generates a new notification ID.
      - Calls the `createNotification` procedure to create a notification for the receiver.

2. Trigger: `after_new_follower`
    - Event: AFTER INSERT on the `follows` table.
    - Purpose:
      - Retrieves the `following_id` for the newly inserted follow record.
      - Calls the `updateCount` procedure to update the follower count for the user being followed.

3. Trigger: `after_new_post`
    - Event: AFTER INSERT on the `posts` table.
    - Purpose:
      - Retrieves the `user_id` for the newly inserted post.
      - Calls the `updateCount` procedure to update the post count for the user who created the post.
*/
USE socialmediaplatform

DELIMITER //
CREATE TRIGGER after_new_message
AFTER INSERT ON messages
FOR EACH ROW
BEGIN
	DECLARE userID integer;
    DECLARE sender varchar(50);
    DECLARE notificationID integer;
	select messages.receiver_id, users.username into userID, sender
    from messages
    inner join users on messages.sender_id=users.user_id
    order by messages.message_id desc
    limit 1;
    set notificationID :=(select notification_id from notifications order by notification_id desc limit 1)+1;
    CALL createNotification(notificationID,userID,sender);
END//

DELIMITER ;

DELIMITER //
CREATE TRIGGER after_new_follower
AFTER INSERT ON follows
FOR EACH ROW
BEGIN
	DECLARE followingID integer;
    set followingID :=(select following_id from follows order by follow_date desc limit 1);
    CALL updateCount(followingID,0);
END//

DELIMITER ;


DELIMITER //
CREATE TRIGGER after_new_post
AFTER INSERT ON posts
FOR EACH ROW
BEGIN
	DECLARE userID integer;
    set userID :=(select user_id from posts order by post_id desc limit 1);
    CALL updateCount(0,userID);
END//

DELIMITER ;