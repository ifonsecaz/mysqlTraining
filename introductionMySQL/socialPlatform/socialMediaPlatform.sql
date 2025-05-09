create database socialMediaPlatform;

use socialmediaplatform;

create table users(
	user_id int primary key,
    username varchar(50) unique,
    email varchar(50) unique,
    password varchar(50),
    date_of_birth date,
    profile_picture varchar(200)
);

create table posts(
	post_id int primary key,
    user_id int,
    post_text varchar(500),
    post_date date,
    media_url varchar(200),
    foreign key (user_id) references users (user_id)
);

create table comments(
	comment_id int primary key,
    post_id int,
    user_id int, 
    comment_text varchar(500),
    comment_date date,
    foreign key (post_id) references posts (post_id),
    foreign key (user_id) references users (user_id)
);

create table likes(
	like_id int primary key,
    post_id int,
    user_id int,
    like_date date,
    foreign key (post_id) references posts (post_id),
    foreign key (user_id) references users (user_id)
);

create table follows(
	follower_id int,
    following_id int,
    follow_date date,
    primary key(follower_id,following_id),
    foreign key (follower_id) references users (user_id),
    foreign key (following_id) references users (user_id)
);

create table messages(
	message_id int primary key,
    sender_id int,
    receiver_id int,
    message_text varchar(500),
    message_date date,
    is_read boolean,
    foreign key (sender_id) references users (user_id),
    foreign key (receiver_id) references users (user_id)
);

create table notifications(
	notification_id int primary key,
    user_id int,
    notification_text varchar(500),
    notification_date date,
    is_read boolean,
    foreign key (user_id) references users (user_id)
);

#2
INSERT INTO users (user_id, username, email, password, date_of_birth, profile_picture) VALUES
(1, 'john_doe', 'john@example.com', 'password123', '1990-05-15', 'https://example.com/profiles/john.jpg'),
(2, 'jane_smith', 'jane@example.com', 'securepass', '1988-08-22', 'https://example.com/profiles/jane.jpg'),
(3, 'mike_jones', 'mike@example.com', 'mikepass', '1995-03-10', 'https://example.com/profiles/mike.jpg'),
(4, 'sarah_wilson', 'sarah@example.com', 'sarahpass', '1992-11-28', 'https://example.com/profiles/sarah.jpg'),
(5, 'david_brown', 'david@example.com', 'davidpass', '1985-07-17', 'https://example.com/profiles/david.jpg'),
(6, 'emily_clark', 'emily@example.com', 'emilypass', '1998-01-30', 'https://example.com/profiles/emily.jpg'),
(7, 'robert_taylor', 'robert@example.com', 'robertpass', '1993-09-05', 'https://example.com/profiles/robert.jpg'),
(8, 'lisa_miller', 'lisa@example.com', 'lisapass', '1991-12-12', 'https://example.com/profiles/lisa.jpg'),
(9, 'william_lee', 'william@example.com', 'williampass', '1987-04-25', 'https://example.com/profiles/william.jpg'),
(10, 'olivia_harris', 'olivia@example.com', 'oliviapass', '1996-06-08', 'https://example.com/profiles/olivia.jpg');

INSERT INTO posts (post_id, user_id, post_text, post_date, media_url) VALUES
(1, 1, 'Just finished my morning hike! The view was amazing.', '2023-01-15', 'https://example.com/media/hike.jpg'),
(2, 2, 'Working on a new project. Can''t wait to share it with you all!', '2023-02-16', NULL),
(3, 3, 'Happy Friday everyone! What are your plans for the weekend?', '2023-01-17', NULL),
(4, 4, 'Just adopted this cute puppy! Meet Max!', '2023-04-18', 'https://example.com/media/puppy.jpg'),
(5, 5, 'Reading an interesting book about database design.', '2023-01-19', NULL),
(6, 1, 'Delicious dinner at the new Italian restaurant downtown.', '2023-01-20', 'https://example.com/media/dinner.jpg'),
(7, 6, 'My vacation photos from Hawaii!', '2023-02-21', 'https://example.com/media/hawaii.jpg'),
(8, 2, 'Just completed a marathon! Personal best time!', '2023-02-22', NULL),
(9, 1, 'Baking cookies today. The house smells amazing!', '2023-03-23', 'https://example.com/media/cookies.jpg'),
(10, 9, 'Working from home today. Productivity level: high.', '2023-03-24', NULL);

INSERT INTO comments (comment_id, post_id, user_id, comment_text, comment_date) VALUES
(1, 1, 2, 'Looks beautiful! Where was this?', '2023-01-15'),
(2, 1, 3, 'Great photo!', '2023-01-15'),
(3, 2, 1, 'Exciting! What kind of project?', '2023-02-17'),
(4, 3, 4, 'Going to the beach!', '2023-01-17'),
(5, 3, 5, 'Movie night with friends', '2023-01-17'),
(6, 4, 6, 'So adorable!', '2023-04-18'),
(7, 4, 7, 'What breed is Max?', '2023-04-19'),
(8, 5, 8, 'Which book are you reading?', '2023-01-19'),
(9, 6, 9, 'That looks delicious!', '2023-01-20'),
(10, 7, 10, 'Hawaii is my dream destination!', '2023-02-21');

INSERT INTO likes (like_id, post_id, user_id, like_date) VALUES
(1, 1, 2, '2023-01-15'),
(2, 1, 3, '2023-01-15'),
(3, 1, 4, '2023-01-15'),
(4, 2, 1, '2023-02-16'),
(5, 2, 5, '2023-02-17'),
(6, 3, 6, '2023-01-17'),
(7, 3, 7, '2023-01-17'),
(8, 4, 8, '2023-04-18'),
(9, 4, 9, '2023-04-18'),
(10, 5, 10, '2023-01-19'),
(11, 6, 1, '2023-01-20'),
(12, 6, 2, '2023-01-20'),
(13, 7, 3, '2023-02-21'),
(14, 7, 4, '2023-02-22'),
(15, 8, 5, '2023-02-22');

INSERT INTO follows (follower_id, following_id, follow_date) VALUES
(1, 2, '2023-01-01'),
(1, 3, '2023-01-02'),
(2, 1, '2023-02-03'),
(2, 4, '2023-02-04'),
(3, 1, '2023-01-05'),
(3, 5, '2023-01-06'),
(4, 2, '2023-01-07'),
(4, 6, '2023-01-08'),
(5, 3, '2023-01-09'),
(5, 7, '2023-01-10'),
(6, 4, '2023-04-11'),
(6, 8, '2023-01-12'),
(7, 5, '2023-01-13'),
(7, 9, '2023-04-14'),
(8, 6, '2023-01-15'),
(8, 10, '2023-01-16'),
(9, 7, '2023-01-17'),
(9, 1, '2023-03-18'),
(10, 8, '2023-03-19'),
(10, 2, '2023-03-20');

INSERT INTO messages (message_id, sender_id, receiver_id, message_text, message_date, is_read) VALUES
(1, 1, 2, 'Hey Jane, how are you?', '2023-01-10', TRUE),
(2, 2, 1, 'Hi John, I''m good thanks! How about you?', '2023-01-11', TRUE),
(3, 1, 2, 'Doing well! Just wanted to check in.', '2023-01-11', TRUE),
(4, 3, 4, 'Sarah, did you see my last post?', '2023-02-11', FALSE),
(5, 5, 6, 'Emily, are we still meeting tomorrow?', '2023-02-12', TRUE),
(6, 6, 5, 'Yes, same time and place!', '2023-02-12', FALSE),
(7, 7, 8, 'Lisa, can you send me that recipe?', '2023-01-13', TRUE),
(8, 8, 7, 'Sure Robert, I''ll send it later today.', '2023-01-13', FALSE),
(9, 9, 10, 'Olivia, thanks for the book recommendation!', '2023-01-14', TRUE),
(10, 10, 9, 'You''re welcome William! Did you like it?', '2023-01-14', FALSE);

INSERT INTO notifications (notification_id, user_id, notification_text, notification_date, is_read) VALUES
(1, 1, 'Jane Smith liked your post', '2023-01-15', TRUE),
(2, 1, 'Mike Jones commented on your post', '2023-01-15', TRUE),
(3, 2, 'John Doe started following you', '2023-01-03', TRUE),
(4, 3, 'Sarah Wilson replied to your comment', '2023-01-18', FALSE),
(5, 4, 'David Brown liked your post', '2023-01-19', TRUE),
(6, 5, 'Emily Clark sent you a message', '2023-01-12', TRUE),
(7, 6, 'Robert Taylor liked your post', '2023-01-21', FALSE),
(8, 7, 'Lisa Miller replied to your message', '2023-01-13', TRUE),
(9, 8, 'William Lee commented on your post', '2023-01-23', FALSE),
(10, 9, 'Olivia Harris started following you', '2023-01-19', TRUE),
(11, 1, 'Check the latest posts', '2023-01-16', FALSE),
(12, 1, 'Check your newest notifications', '2023-01-20', TRUE);

#3
#Retrieve the posts and activities of a user's timeline. (comments and likes)
select users.username, posts.*, comments.*,likes.*
from users
inner join posts on users.user_id=posts.user_id
left join comments on posts.post_id = comments.post_id and users.user_id=comments.user_id
left join likes on posts.post_id = likes.post_id and users.user_id=likes.user_id
where users.user_id=1
union (
	select users.username, posts.*, comments.*,likes.*
	from users
	inner join comments on users.user_id=comments.user_id
    left join posts on posts.post_id = comments.post_id 
	left join likes on posts.post_id = likes.post_id and users.user_id=likes.user_id
	where users.user_id=1
)
union (
	select users.username, posts.*, comments.*,likes.*
	from users
	inner join likes on users.user_id=likes.user_id
    left join posts on posts.post_id = likes.post_id 
	left join comments on posts.post_id = comments.post_id and users.user_id=comments.user_id
	where users.user_id=1
);

#Retrieve the comments and likes for a specific post.
select posts.*, comments.*, likes.*
from posts
left join comments on posts.post_id = comments.post_id
left join likes on posts.post_id = likes.post_id and comments.user_id=likes.user_id
where posts.post_id=4
union(
	select posts.*, comments.*, likes.*
	from posts
    left join likes on posts.post_id = likes.post_id 
	left join comments on posts.post_id = comments.post_id and comments.user_id=likes.user_id
	where posts.post_id=4
);

#Retrieve the list of followers for a user.
select users.user_id, users.username, users.profile_picture
from users
inner join follows on users.user_id=follows.follower_id
where follows.following_id=2;

#Retrieve unread messages for a user.
select messages.*
from users
inner join messages on users.user_id=receiver_id
where is_read =false and users.user_id=9;

#Retrieve the most liked posts.
select posts.*, count(likes.post_id)
from likes
inner join posts on likes.post_id=posts.post_id
group by posts.post_id
order by count(likes.post_id) desc
limit 1;

#Retrieve the latest notifications for a user.
select notifications.*
from users
inner join notifications on users.user_id=notifications.user_id
where users.user_id=1
order by notifications.notification_date desc
limit 3;

#Add a new post to the platform.
INSERT INTO posts (post_id, user_id, post_text, post_date, media_url)
VALUES (
    11,  
    3,                                  
    'Hello    .....',                  
    CURRENT_DATE,                   
    NULL                             
);

#Comment on a post
INSERT INTO comments (comment_id, post_id, user_id, comment_text, comment_date) 
VALUES (11, 4, 5, 'Hi', CURRENT_DATE);

#Update user profile information.
UPDATE users SET username = 'JohnDoe' WHERE user_id = 1;     

#Remove a like from a post.
DELETE FROM likes WHERE post_id = 6 AND user_id = 2;

#5
#Identify users with the most followers.
select users.user_id, users.username, users.profile_picture, count(follows.following_id)
from users
inner join follows on users.user_id=follows.following_id
group by follows.following_id
order by count(follows.following_id) desc
limit 1;

#Find the most active users based on post count and interaction.
select aux.usersC, count(aux.usersC)
from (select users.username as usersC
from users
inner join posts on users.user_id=posts.user_id
union all(
	select users.username
	from users
	inner join comments on users.user_id=comments.user_id
)
union all(
	select users.username
	from users
	inner join likes on users.user_id=likes.user_id)) as aux
group by aux.usersC
order by count(aux.usersC) desc
limit 1;

#Calculate the average number of comments per post.
select avg(a.sumC)
from (select count(comments.comment_id) as sumC
from posts
inner join comments on posts.post_id=comments.post_id
group by posts.post_id) as a;

#TEST send notification
SELECT * FROM INFORMATION_SCHEMA.TRIGGERS;

INSERT INTO messages (message_id, sender_id, receiver_id, message_text, message_date, is_read) VALUES
(11, 1, 5, 'Hey, hello', CURRENT_DATE, FALSE);

select notifications.*
from notifications
where notifications.user_id = 5;

#Update post counts and follower counts for users.
create table usersAnalytics (
	user_id integer primary key,
    postCount integer default 0,
    followerCount integer default 0,
    foreign key (user_id) references users (user_id)
);

INSERT INTO posts (post_id, user_id, post_text, post_date, media_url) VALUES
(12, 1, 'Testing count', CURRENT_DATE, NULL);

INSERT INTO follows (follower_id, following_id, follow_date) VALUES
(8, 1, CURRENT_DATE);

select * from usersAnalytics where user_id=1;


#Generate personalized recommendations for users to follow.
create table recommendations(
	recommendations_id integer primary key auto_increment,
	user_id integer,
    recommended_id integer,
    foreign key (user_id) references users(user_id),
    foreign key (recommended_id) references users(user_id)
);

#Test    
SELECT DISTINCT 1, f1.following_id
FROM follows f1
JOIN follows f2 ON f1.follower_id = f2.following_id
WHERE f2.follower_id = 1
  AND f1.following_id != 1
  AND f1.following_id NOT IN (
      SELECT f3.following_id
      FROM follows f3
      WHERE f3.follower_id = 1
  );
  
CALL FollowRecommendations(2);

select * from recommendations;