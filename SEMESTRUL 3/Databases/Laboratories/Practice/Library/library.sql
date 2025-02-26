


CREATE TABLE Books(
	bid int PRIMARY KEY,
	btitle varchar(50),
	publication_year int,
	genre varchar(1)
);

CREATE TABLE Authors(
	aid int PRIMARY KEY ,
	aname varchar(50),
	birthday DATE NOT NULL,
	nationality varchar(50)
);
 CREATE TABLE BooksAuthors(
	book_id int,
	author_id int,
	PRIMARY KEY(book_id,author_id),
	FOREIGN KEY(book_id) REFERENCES Books(bid), 
	FOREIGN KEY(author_id) REFERENCES Authors(aid)
 );

 CREATE TABLE Members(
	mid int PRIMARY KEY,
	mname varchar(50),
	date_registration DATE
 );

 CREATE TABLE BorrowRecords(
	member_id int,
	book_id int,
	borrow_date DATE,
	return_date DATE,
	status varchar(50),
	PRIMARY KEY(member_id,book_id),
	FOREIGN KEY(member_id) REFERENCES Members(mid), 
	FOREIGN KEY(book_id) REFERENCES Books(bid), 
 );
 GO

 INSERT INTO Books(bid, btitle, publication_year, genre) VALUES
(1, 'To Kill a Mockingbird', 1960, 'F'),
(2, '1984', 1949, 'D'),
(3, 'Moby Dick', 1851, 'A'),
(4, 'The Great Gatsby', 1925, 'F'),
(5, 'War and Peace', 1869, 'H');

INSERT INTO Authors(aid, aname, birthday, nationality) VALUES
(1, 'Harper Lee', '1926-04-28', 'American'),
(2, 'George Orwell', '1903-06-25', 'British'),
(3, 'Herman Melville', '1819-08-01', 'American'),
(4, 'F. Scott Fitzgerald', '1896-09-24', 'American'),
(5, 'Leo Tolstoy', '1828-09-09', 'Russian');

INSERT INTO BooksAuthors(book_id, author_id) VALUES
(1, 1), -- 'To Kill a Mockingbird' by Harper Lee
(2, 2), -- '1984' by George Orwell
(3, 3), -- 'Moby Dick' by Herman Melville
(4, 4), -- 'The Great Gatsby' by F. Scott Fitzgerald
(5, 5); -- 'War and Peace' by Leo Tolstoy

INSERT INTO Members(mid, mname, date_registration) VALUES
(1, 'Alice Johnson', '2024-01-01'),
(2, 'Bob Smith', '2024-01-15'),
(3, 'Catherine Lee', '2024-02-01'),
(4, 'David Brown', '2024-02-15'),
(5, 'Emma Davis', '2024-03-01');

INSERT INTO BorrowRecords(member_id, book_id, borrow_date, return_date, status) VALUES
(1, 1, '2024-04-01', '2024-04-15', 'Returned'),
(2, 2, '2024-04-05', '2024-04-20', 'Returned'),
(3, 3, '2024-04-10', NULL, 'Borrowed'),
(4, 4, '2024-04-12', NULL, 'Borrowed'),
(5, 5, '2024-04-15', NULL, 'Borrowed');
GO

 --IMPLEMENT A STORED PROCEDURE THAT RECEIVES A MEMBER ID , A BOOK ID AND A BORROW DATE AND ADDS A BORROW RECORD.IF THE RECORD ALREADY EXISTS , UPDATE THE BORROW DATE

 CREATE OR ALTER PROCEDURE addBorrowRecord(@member_id int , @book_id int , @borrow_date DATE)
 AS
 BEGIN
	IF EXISTS(
		SELECT 1 FROM BorrowRecords
		WHERE member_id = @member_id AND book_id = @book_id
	)
	BEGIN
		PRINT 'The record already exists'
		UPDATE BorrowRecords
		SET borrow_date = @borrow_date
		WHERE member_id = @member_id AND book_id = @book_id
		RETURN
	END

	INSERT INTO BorrowRecords(member_id,book_id,borrow_date) VALUES (@member_id,@book_id,@borrow_date)
 END

 EXECUTE addBorrowRecord 1 ,2,'2024/12/12' 
 SELECT * FROM BorrowRecords
 GO

 --CREATE A VIEW THAT SHOWS YHE MEMBERS WHO BORROWED THE MOLST BOOKS
 CREATE OR ALTER VIEW memberWhoBorrowedMostBooks
 AS
	SELECT m.mid AS MemberID,m.mname AS MemberName , COUNT(br.book_id) as CountBooks FROM Members m
	INNER JOIN BorrowRecords br ON m.mid = br.member_id
	GROUP BY m.mid,m.mname
	HAVING COUNT(br.book_id) = (SELECT MAX(Book_count) FROM
									(
									SELECT COUNT(book_id) as Book_count FROM BorrowRecords
									GROUP BY member_id
									)AS subq
	)
GO
SELECT * FROM memberWhoBorrowedMostBooks
GO

CREATE OR ALTER FUNCTION getAuthors(@N int)
RETURNS TABLE
AS
RETURN
	SELECT a.aname AS AuthorName,COUNT(ba.book_id) AS BooksWritten FROM Authors a
	INNER JOIN BooksAuthors ba ON a.aid = ba.author_id
	GROUP BY a.aname
	HAVING COUNT(ba.book_id) > @N

GO
SELECT * FROM getAuthors(0)
	
