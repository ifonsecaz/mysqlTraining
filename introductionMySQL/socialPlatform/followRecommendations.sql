/*
	Generates and populates the table recommnedations for the follow recommendations for a given user 
	by checking mutual connections.
	It first clears any existing recommendations for the target user and then inserts new recommendations
	based on the following logic:
	
	- Finds users who are followed by the people that the target user follows (mutual connections).
	- Ensures that the recommended users are not already followed by the target user.
	- Ensures that the recommended users are not the target user themselves.

	PARAMETERS:
	- IN target_user_id INT: The ID of the user for whom follow recommendations are to be generated.

	To use it: 
	CALL FollowRecommendations(target_user_id);
*/
CREATE DEFINER=`root`@`localhost` PROCEDURE `FollowRecommendations`(IN target_user_id INT)
BEGIN
      Delete from recommendations where user_id=target_user_id;
      
      Insert into recommendations (user_id,recommended_id) 
      SELECT DISTINCT target_user_id, f1.following_id
		FROM follows f1
		JOIN follows f2 ON f1.follower_id = f2.following_id
		WHERE f2.follower_id = target_user_id
		  AND f1.following_id != target_user_id
		  AND f1.following_id NOT IN (
			  SELECT f3.following_id
			  FROM follows f3
			  WHERE f3.follower_id = target_user_id
		  );
END