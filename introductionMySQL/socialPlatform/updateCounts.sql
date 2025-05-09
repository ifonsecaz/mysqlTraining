/*
Updates the analytics data for a user in the `usersAnalytics` table. 
It handles two scenarios:
1. When a new post is created by a user (indicated by `newPost` parameter).
2. When a new follower is added to a user (indicated by `newFollower` parameter).

Parameters:
- IN newFollower (integer): The ID of the user who gained a new follower. If this is 0, the procedure assumes the operation is related to a new post.
- IN newPost (integer): The ID of the user who created a new post. If this is 0, the procedure assumes the operation is related to a new follower.

Logic:
1. Determines if the user exists in the `usersAnalytics` table.
2. If `newFollower` is 0:
	- Updates the `postCount` for the user specified by `newPost`.
	- If the user does not exist in `usersAnalytics`, it calculates the total posts for the user and inserts a new record.
	- If the user exists but `postCount` is 0, it recalculates the total posts and updates the record.
	- Otherwise, it increments the `postCount` by 1.
3. If `newPost` is 0:
	- Updates the `followerCount` for the user specified by `newFollower`.
	- If the user does not exist in `usersAnalytics`, it calculates the total followers for the user and inserts a new record.
	- If the user exists but `followerCount` is 0, it recalculates the total followers and updates the record.
	- Otherwise, it increments the `followerCount` by 1.
*/
CREATE DEFINER=`root`@`localhost` PROCEDURE `updateCount`(IN newFollower integer, IN newPost integer)
BEGIN
	DECLARE counter integer DEFAULt 0;
    DECLARE user_exists INT DEFAULT 0;
    
    SELECT COUNT(*) INTO user_exists 
	FROM usersAnalytics 
	WHERE user_id = IF(newFollower = 0, newPost, newFollower);
        
	IF newFollower=0 THEN
		select postCount into counter from usersAnalytics where usersAnalytics.user_id=newPost;
        IF user_exists=0 THEN
			set counter:=(select count(*) from posts where posts.user_id=newPost);
            INSERT INTO usersAnalytics (user_id,postCount,followerCount) values
            (newPost,counter,0);
		ELSEIF counter =0 THEN
			set counter:=(select count(*) from posts where posts.user_id=newPost);
			UPDATE usersAnalytics SET postCount = counter 
			WHERE  usersAnalytics.user_id= newPost;
        ELSE 
			set counter:=counter+1;
            UPDATE usersAnalytics SET postCount = counter 
			WHERE  usersAnalytics.user_id= newPost;
		END IF;
	ELSE 
		select followerCount into counter from usersAnalytics where usersAnalytics.user_id=newFollower;
        IF user_exists=0 THEN
			set counter:=(select count(*) from follows where follows.following_id=newFollower);
            INSERT INTO usersAnalytics (user_id,postCount,followerCount) values
            (newFollower,0,counter);
		ELSEIF counter =0 THEN
			set counter:=(select count(*) from follows where follows.following_id=newFollower);
            UPDATE usersAnalytics SET followerCount = counter 
			WHERE  usersAnalytics.user_id= newFollower;
		ELSE 
			set counter:=counter+1;
            UPDATE usersAnalytics SET followerCount = counter 
			WHERE  usersAnalytics.user_id= newFollower;
		END IF;
		
    END IF;
END