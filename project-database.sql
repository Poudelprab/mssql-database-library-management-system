create database LibraryManagement

Create table student(
studentid int primary key identity(1,1) not null,
Name nvarchar(100),
Department nvarchar(100),
semester int,
rollno int,
phoneno bigint,
DOB date
);
select * from student
--drop table student
-- stored proc to insert into table student
delete from student where studentid=9
create proc [dbo].[usp_I_student]
(
	@Name nvarchar(100),
@Department nvarchar(100),
@semester int,
@rollno int,
@phoneno bigint,
@DOB date)

as
Begin
insert into student(Name,Department,semester,rollno,phoneno,DOB)
VALUES(@Name,@Department,@semester,@rollno,@phoneno,@DOB);
END

--stored proc to update table student
create proc[dbo].[usp_u_student]
@studentid int,
@Name nvarchar(100),
@Department nvarchar(100),
@semester int,
@rollno int,
@phoneno bigint,
@DOB date

as
begin
update student set
Name=@Name,Department=@Department,semester=@semester,rollno=@rollno,phoneno=@phoneno,DOB=@DOB
where studentid=@studentid
END

CREATE PROCEDURE [dbo].[usp_u_semester]
    @Department NVARCHAR(100),
    @CurrentSemester INT
AS
BEGIN
    UPDATE student
    SET semester = semester + 1
    WHERE Department = @Department
        AND semester = @CurrentSemester;
END


--stored proc to delete table student values
create proc[dbo].[usp_d_student]

@Name nvarchar(100),
@Department nvarchar(100),
@semester int,
@rollno int,
@phoneno bigint,
@DOB date

as
begin
delete from student
where
Name=@Name and Department=@Department and semester=@semester and rollno=@rollno and phoneno=@phoneno and DOB=@DOB
END


create table book(
bookid int primary key identity(1,1) not null,
bookname nvarchar(200),
Author nvarchar(200),
Publisher nvarchar(200),
price int,
quantity int
);
select * from book
truncate table book

---stored proc to insert books
create proc [dbo].[usp_I_book]
(
	@bookname nvarchar(100),
@Author nvarchar(100),
@Publisher nvarchar(200),
@price int,
@quantity bigint
)

as
Begin
insert into book(bookname,Author,Publisher,price,quantity)
VALUES(@bookname,@Author,@Publisher,@price,@quantity);
END


--stored proc to update book records

create proc[dbo].[usp_u_book]
	@bookid int,
	@bookname nvarchar(100),
    @Author nvarchar(100),
	@Publisher nvarchar(200),
	@price int,
	@quantity bigint
as
begin
update book set
bookname=@bookname,Author=@Author,Publisher=@Publisher,price=@price,quantity=@quantity
where bookid=@bookid
END


--stored proc to delete book records
create proc[dbo].[usp_d_book]

	@bookname nvarchar(100),
@Author nvarchar(100),
@Publisher nvarchar(200),
@price int,
@quantity bigint

as
begin
delete from book
where
bookname=@bookname and Author=@Author and Publisher=@Publisher and price=@price and quantity=@quantity 
END


create table issue(
issueid int primary key identity(1,1) not null,
studentid int,
Name nvarchar(100),
bookid int,
bookname nvarchar(200),
issuedate date
foreign key(studentid) references student(studentid),
foreign key(bookid) references book(bookid)
);
delete from issue where studentid=9
--stored proc to insert issue details
alter proc [dbo].[usp_I_issue]
@studentid int,
@Name nvarchar(100),
@bookid int,
@bookname nvarchar(200),
@issuedate date
as 
begin 
insert into issue(studentid,Name,bookid,bookname,issuedate)
values(@studentid,@Name,@bookid,@bookname,@issuedate);
END

--stored proc to update issue details
create proc [dbo].[usp_u_issue]
@studentid int,
@Name nvarchar(100),
@bookid int,
@bookname nvarchar(200),
@issuedate date
as begin 
update issue set
Name=@Name,bookname=@bookid,issuedate=@issuedate
where studentid=@studentid and bookid=@bookid
end;

CREATE PROCEDURE [dbo].[usp_GetIssuedBooksCount]
    @studentid int
AS
BEGIN
    SELECT COUNT(*) FROM issue WHERE studentId = @studentid
END

create table breturn(
returnid int primary key identity(1,1) not null,
studentid int,
name nvarchar(200),
bookid int,
bookname nvarchar(200),
issuedate date,
returndate date,
fine int
foreign key(studentid) references student(studentid),
foreign key(bookid) references book(bookid)
);

create proc [dbo].[usp_I_breturn]
@studentid int,
@Name nvarchar(200),
@bookid int,
@bookname nvarchar(200),
@issuedate date,
@returndate date,
@fine int
as 
begin 
insert into breturn(studentid,Name,bookid,bookname,issuedate,returndate,fine)
values(@studentid,@Name,@bookid,@bookname,@issuedate,@returndate,@fine);
END

create proc [dbo].[usp_u_breturn]
@studentid int,
@Name nvarchar(100),
@bookid int,
@bookname nvarchar(200),
@issuedate date,
@returndate date,
@fine int
as begin 
update breturn set
Name=@Name,bookname=@bookid,issuedate=@issuedate,returndate=@returndate,fine=@fine
where studentid=@studentid and bookid=@bookid
end;
create proc [dbo].[usp_d_breturn]
@studentid int,
@Name nvarchar(200),
@bookid int,
@bookname nvarchar(200)

as 
begin 
delete from  breturn where studentid=@studentid and Name=@Name AND bookid=@bookid and bookname=@bookname

END


 create table LibrarySettings(
 MaxBooksAllowed int
 );


 INSERT INTO LibrarySettings (MaxBooksAllowed) VALUES (3);

 select * from LibrarySettings

 CREATE TABLE stock (
    stockid INT PRIMARY KEY IDENTITY(1, 1) NOT NULL,
    bookid INT,
    quantity INT,
    FOREIGN KEY (bookid) REFERENCES book(bookid)
);
select * from stock
CREATE TRIGGER tr_insert_book_stock
ON book
AFTER INSERT
AS
BEGIN
    -- Insert new records into the stock table based on the inserted book records
    INSERT INTO stock (bookid, quantity)
    SELECT bookid, quantity
    FROM inserted;
END;
INSERT INTO stock (bookid, quantity)
SELECT bookid, quantity
FROM book;
