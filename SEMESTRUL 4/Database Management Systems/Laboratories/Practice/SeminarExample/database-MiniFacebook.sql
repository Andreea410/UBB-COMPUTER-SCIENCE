Use Practice;

DROP TABLE  IF Exists Comments;
DROP TABLE  IF Exists Posts;
DROP TABLE  IF Exists Users;
DROP TABLE  IF Exists Likes;
DROP TABLE  IF Exists Categories;
DROP TABLE  IF Exists Pages;


CREATE TABLE Users(
	id int PRIMARY KEY,
	userName varchar(50),
	city varchar(50),
	birthday DATE
);

CREATE TABLE Categories(
	id int PRIMARY KEY,
	categoryName varchar(50),
	categoryDescription varchar(50)
);

CREATE TABLE Pages(
	id int PRIMARY KEY,
	pageName varchar(50),
	category_id int,
	FOREIGN KEY(category_id) REFERENCES Categories(id)
);

CREATE TABLE Likes(
	pageId int,
	userId int,
	date_of_liking DATE,
	PRIMARY KEY(pageId, userId),
	FOREIGN KEY(pageId) REFERENCES Pages(id),
	FOREIGN KEY(userId) REFERENCES Users(id)
);

CREATE TABLE Posts(
	id int PRIMARY KEY,
	userId int,
	date_of_post DATE,
	post_text varchar(max),
	number_shares int,
	FOREIGN KEY(userId) REFERENCES Users(id)
);

CREATE TABLE Comments(
	id int PRIMARY KEY,
	postId int,
	date_of_comment DATE,
	isTopComment BIT
)
	
