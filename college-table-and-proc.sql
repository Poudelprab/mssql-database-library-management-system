







CREATE PROC [dbo].[usp_I_CollegeA] 
  @College_Name NVARCHAR(200),
  @College_Code NVARCHAR(500),
  @College_address NVARCHAR(200)

AS
BEGIN



  INSERT INTO CollegeA(College_Name, College_Code, College_address)
  VALUES (@College_Name, @College_Code, @College_address);
END;


drop proc usp_I_CollegeA



drop proc usp_u_CollegeA

--stored procedure to update records in gridview



-- Table to login into clz library system
create table libadmin(
librarianid int primary key identity(1,1) not null,
 
Name nvarchar(100),
phoneno  bigint ,
College_Code nvarchar(500) ,
password1 nvarchar(200)
 );
select * from libadmin
 alter table libadmin
 drop column password1;

 alter table libadmin
add  DOB date;
 

 

 -- Stored proc to insert login details for college admin
 create proc [dbo].[usp_I_libadmin]
 @Name nvarchar(100),
@phoneno int,
@address nvarchar(500),
 @email nvarchar(200),
 @DOB date
 AS 
 BEGIN 
 Insert into libadmin (Name,phoneno,address,email,DOB)
 values ( @Name,@phoneno,@address,@email,@DOB)
 END;


 -- Stored proc to update login details for college login
 ALTER proc [dbo].[usp_u_libadmin]
  @CollegeId int,
 @librarianid int,
  @Name nvarchar(100),
 @phoneno int,
  @College_Code nvarchar(500),
 @password1 nvarchar(200)
 AS 
 BEGIN 
 update libadmin set
 Name=@Name,Phoneno=@phoneno, College_Code=@College_Code,password1=@password1
 where CollegeId=@CollegeId and librarianid=@librarianid
 END
  -- Stored proc to delete login details for college login
 
  create proc [dbo].[usp_d_libadmin]
   @CollegeId int,
    @Name nvarchar(100),
	 @phoneno int,
   @College_Code nvarchar(500),
 @password1 nvarchar(200)
 AS 
 BEGIN 
 delete from libadmin
 where CollegeId=@CollegeId and Name=@Name and Phoneno=@phoneno and College_Code=@College_Code and  password1=@password1;
 END
drop proc usp_d_libadmin
 --Stored proc to search for libadmin

 

create table adminlogin(
userid int primary key identity(1,1) not null,
username nvarchar(200) not null,
password nvarchar(200) not null,
)
insert into adminlogin values('admin','pass','1')
select * from adminlogin
 alter table adminlogin
add   librarianid int,
 foreign key (librarianid) references libadmin(librarianid);


create proc [dbo].[usp_I_InsertUser]
	@librarianid int,
  @username nvarchar(200),
  @password nvarchar(200)
  as
  begin
	INSERT INTO adminlogin (librarianid,username, password)
	VALUES (@librarianid,@username, @password)

  END



  CREATE PROC [dbo].[usp_u_InsertUser]
	@librarianid INT,
	@username NVARCHAR(200),
	@password NVARCHAR(200)
AS
BEGIN
		UPDATE adminlogin
		SET username = @username,
			password = @password
		WHERE librarianid = @librarianid
	END
 

 
CREATE PROCEDURE [dbo].[ValidateUser]
	
	@username nvarchar (200),
	@password nvarchar (200),
	@result int output

AS
BEGIN

	SET NOCOUNT ON;

	 if exists(select * from adminlogin where username like @username and password like @password)
	 set @result=1
 else 
 set @result=0

 return @result 
end 
GO


