DROP DATABASE PROJECT2;
CREATE DATABASE Project2;
USE Project2;

Drop table Books;
SELECT * FROM project2.books; 				-- Books Table 
SELECT * FROM project2.customers;			-- Customer Table
SELECT * FROM project2.orders;				-- Order Table

-- Note: Book_ID is primary key of Books. Customer_ID primary key of Customers. Order_ID is primary key of Order.

ALTER TABLE project2.books ADD PRIMARY KEY (Book_id); 		 -- Making Book_id as Primary key
ALTER TABLE project2.orders ADD CONSTRAINT book_id			 -- Making Book_id as the Foreign key
FOREIGN KEY (Book_ID) REFERENCES project2.books(Book_ID);

ALTER TABLE project2.customers ADD PRIMARY KEY (Customer_ID);	-- Making Customer_ID as Primary key
ALTER TABLE project2.orders ADD CONSTRAINT customer_id			-- Making Customer_ID as the Foreign key
FOREIGN KEY (Customer_ID) REFERENCES project2.customers(Customer_ID);


-- ************* PROBLEM SOLVING **************
-- 1) Retrieve all books in the "Fiction" genre:
SELECT * FROM PROJECT2.BOOKS
WHERE GENRE='FICTION';


-- 2) Find books published after the year 1950:
SELECT * FROM PROJECT2.BOOKS
WHERE PUBLISHED_YEAR > '1950' 
ORDER BY PUBLISHED_YEAR;


-- 3) List all customers from the Canada:
SELECT * FROM PROJECT2.CUSTOMERS 
WHERE COUNTRY='CANADA';


-- 4) Show orders placed in November 2023:
SELECT * FROM PROJECT2.ORDERS 
WHERE ORDER_DATE BETWEEN '2023-11-01' AND '2023-11-30';


-- 5) Retrieve the total stock of books available:
SELECT SUM(STOCK) FROM PROJECT2.BOOKS;


-- 6) Find the details of the most expensive book:
SELECT MAX(PRICE) FROM PROJECT2.BOOKS;


-- 7) Show all customers who ordered more than 1 quantity of a book:
SELECT CUSTOMER_ID FROM PROJECT2.orders
WHERE QUANTITY > '1';


-- 8) Retrieve all orders where the total amount exceeds $20:
SELECT * FROM PROJECT2.ORDERS 
WHERE TOTAL_AMOUNT>'20';


-- 9) List all genres available in the Books table:
SELECT GENRE FROM PROJECT2.BOOKS;


SELECT GENRE FROM PROJECT2.BOOKS GROUP BY GENRE;			--  OPTIMIZED ANSWER


-- 10) Find the book with the lowest stock:				

SELECT BOOK_ID,TITLE,STOCK AS LOWEST_STOCK FROM PROJECT2.BOOKS		-- GOOD AND EFFICIENT
WHERE STOCK = (SELECT MIN(STOCK) FROM PROJECT2.BOOKS);

SELECT BOOK_ID, TITLE, STOCK 				 -- MOST EFFICIENT,SUITABLE ON LARGE DATASET AS WELL
FROM PROJECT2.BOOKS 
ORDER BY STOCK ASC 
LIMIT 1;


-- 11) Calculate the total revenue generated from all orders:
SELECT SUM(TOTAL_AMOUNT) FROM PROJECT2.ORDERS;


-- Advance Questions : 
-- 1) Retrieve the total number of books sold for each genre:
SELECT B.GENRE, SUM(O.QUANTITY) AS TOTAL_BOOK_SOLD, SUM(O.TOTAL_AMOUNT) AS AMOUNT
FROM PROJECT2.BOOKS B JOIN PROJECT2.ORDERS O ON B.BOOK_ID = O.BOOK_ID GROUP BY B.GENRE;


-- 2) Find the average price of books in the "Fantasy" genre:
SELECT AVG(PRICE) FROM PROJECT2.BOOKS WHERE GENRE = 'FANTASY';


-- 3) List customers who have placed at least 2 orders:
SELECT CUSTOMER_ID,COUNT(ORDER_ID) FROM PROJECT2.ORDERS GROUP BY CUSTOMER_ID HAVING COUNT(*)>=2;		-- 'HAVING' CLAUSE IS USED AS 'WHERE' CLAUSE WHEN WE ARE USING GROUP BY.

-- 4) Find the most frequently ordered book:
SELECT BOOK_ID, COUNT(BOOK_ID) AS ORDERED_QUANTITY 
FROM PROJECT2.ORDERS 
GROUP BY BOOK_ID ORDER BY ORDERED_QUANTITY DESC LIMIT 1;


-- 5) Show the top 3 most expensive books of 'Fantasy' Genre :
SELECT TITLE,MAX(PRICE) AS PRICE FROM PROJECT2.BOOKS 
GROUP BY TITLE ORDER BY PRICE DESC LIMIT 3; 

-- 6) Retrieve the total quantity of books sold by each author:
SELECT * FROM PROJECT2.BOOKS;
SELECT * FROM PROJECT2.ORDERS;

SELECT B.AUTHOR,SUM(O.QUANTITY) AS QUANTITY FROM PROJECT2.BOOKS B
JOIN PROJECT2.ORDERS O ON B.BOOK_ID = O.BOOK_ID GROUP BY B.AUTHOR ORDER BY QUANTITY DESC;

-- 7) List the cities where customers who spent over $30 are located:		-- Spent over 30 means more than 30 
SELECT DISTINCT C.CITY,O.TOTAL_AMOUNT 
FROM PROJECT2.CUSTOMERS C 
JOIN PROJECT2.ORDERS O 
ON C.CUSTOMER_ID = O.ORDER_ID 
WHERE TOTAL_AMOUNT > 30;

-- 8) Find the customer who spent the most on orders:
SELECT C.NAME, SUM(O.TOTAL_AMOUNT) AS TotalSpent				-- This will return the Name of customer whose Net spent is highest.
FROM PROJECT2.CUSTOMERS C
JOIN PROJECT2.ORDERS O ON C.CUSTOMER_ID = O.CUSTOMER_ID
GROUP BY C.CUSTOMER_ID, C.NAME
ORDER BY TotalSpent DESC
LIMIT 1;

SELECT CUSTOMER_ID					 -- This will return the Customer id whose Net spent is highest.
FROM PROJECT2.ORDERS 
GROUP BY CUSTOMER_ID 
ORDER BY SUM(TOTAL_AMOUNT) DESC 
LIMIT 1;



-- 9) Calculate the stock remaining after fulfilling all orders: 
SELECT B.BOOK_ID,B.TITLE, B.STOCK, COALESCE(SUM(QUANTITY),0) AS ORDERED_STOCK, 
B.STOCK - COALESCE(SUM(QUANTITY),0) AS REMAINING_STOCK
FROM PROJECT2.BOOKS B LEFT JOIN PROJECT2.ORDERS O 
ON B.BOOK_ID = O.BOOK_ID GROUP BY B.BOOK_ID ORDER BY B.BOOK_ID;


SELECT * FROM project2.books; 				-- Books Table 
SELECT * FROM project2.customers;			-- Customer Table
SELECT * FROM project2.orders;				-- Order Table