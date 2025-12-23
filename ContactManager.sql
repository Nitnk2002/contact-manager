create database contactmanager;
create table users(
	fullname varchar(50),
	email varchar(40) primary key,
	password varchar(40),
	phone VARCHAR(20), 
    job_title VARCHAR(40),  
    location VARCHAR(40)
);
insert into user values("nitish" , "nitnkumar@gmail.com","12345678");

CREATE TABLE contacts (
    contact_id INT AUTO_INCREMENT PRIMARY KEY, -- Unique ID for every contact
    user_email VARCHAR(40),                    -- The owner of this contact
    fullname VARCHAR(80),                      -- Matches your HTML 'name' input
    email VARCHAR(40),
    phone VARCHAR(20),                         -- Added phone column
    job_title VARCHAR(40),
    FOREIGN KEY (user_email) REFERENCES users(email)
);