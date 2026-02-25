
/*
==========================================================++
             DDL - DATA Definition Language
===========================================================
*/
/*
==============================================================
                      CREATE TABLE
=============================================================
*/
/*

----Syntax----

CREATE TABLE table_name (
    column1_name data_type CONSTRAINT_1,
    column2_name data_type CONSTRAINT_2,
    column3_name data_type,
    
    -- Table Level Constraints
    CONSTRAINT constraint_name PRIMARY KEY (column_name),
    CONSTRAINT constraint_name FOREIGN KEY (column_name) REFERENCES parent_table(parent_column),
    CONSTRAINT constraint_name UNIQUE (column_name),
    CONSTRAINT constraint_name CHECK (logical_condition)
);
*/
--Example:

---CREATE A new table called persons with column : id, person_name, birth_date, and phone

CREATE TABLE PERSONS (
Id INT NOT NULL,
Person_name VARCHAR(50),
Birth_Date DATE,
Phone INT,
CONSTRAINT pk_persons Primary Key (id)
);

/*
=============================================================
                       ALTER
=============================================================
*/

/*
----Syntax--Column Modifications

1.ADD Column
```sql
ALTER TABLE table_name 
ADD column_name data_type constraint;
```

2.DROP Column
```sql
ALTER TABLE table_name 
DROP COLUMN column_name;
```

3.RENAME Column
```sql
ALTER TABLE table_name 
RENAME COLUMN old_name TO new_name;
```

4.MODIFY/ALTER Column (Change Data Type)
* **MySQL:**
    ALTER TABLE table_name MODIFY COLUMN column_name new_data_type;`
* **SQL Server:**
    ALTER TABLE table_name ALTER COLUMN column_name new_data_type;`
* **Postgres:**
    ALTER TABLE table_name ALTER COLUMN column_name TYPE new_data_type;`


~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

---Syntax--- Constraint Management**

1. ADD Primary Key
```sql
ALTER TABLE table_name 
ADD PRIMARY KEY (column_name);
```

2. ADD Foreign Key
```sql
ALTER TABLE table_name 
ADD CONSTRAINT constraint_name 
FOREIGN KEY (column_name) REFERENCES parent_table(parent_column);
```

3. ADD Check Constraint
```sql
ALTER TABLE table_name 
ADD CONSTRAINT constraint_name CHECK (condition);
```

4. ADD Unique Constraint
```sql
ALTER TABLE table_name 
ADD CONSTRAINT constraint_name UNIQUE (column_name);
```

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

--- Syntax--Dropping Constraints

1. DROP Primary Key
ALTER TABLE table_name DROP PRIMARY KEY;`


2. DROP Foreign Key / Constraint
* **MySQL:**  
    ALTER TABLE table_name DROP FOREIGN KEY constraint_name;`
* **SQL Server/Postgres:**
    ALTER TABLE table_name DROP CONSTRAINT constraint_name;`
---
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

----Syntax--Table-Level Actions

1. RENAME Table
```sql
ALTER TABLE table_name 
RENAME TO new_table_name;
```

2. SET DEFAULT Value
```sql
ALTER TABLE table_name 
ALTER COLUMN column_name SET DEFAULT value;
```
*/

----Add a new column called email to the persons table

ALTER TABLE Persons
ADD email VARCHAR(50);

---Remove the column phone from the persons table

ALTER TABLE PERSONS
DROP COLUMN PHONE;

---Change the column name from the persons table

ALTER TABLE PERSONS
RENAME COLUMN PHONE TO  MOBILE_NUMBER;



/*
=============================================================
                  DROP
=============================================================
*/

/*
---Syntax---
TRUNCATE TABLE table_name;

(OR)

DROP TABLE table_name;
*/

---Delete the table persons from the Database

DROP TABLE PERSONS;

/*
==========================================================+
                DML- DATA manupulation Language
===========================================================
*/

/*
==========================================================
                        INSERT
===========================================================
*/

/*
--Syntax---
INSERT INTO table_name (column1, column2, column3)
VALUES (value1, value2, value3);
*/

/*
==========================================================
                         UPDATE
===========================================================
*/
/*
---Syntax----
UPDATE table_name
SET column_name = CASE 
    WHEN condition1 THEN value1
    WHEN condition2 THEN value2
    ELSE default_value -- Optional
END
WHERE condition; -- Optional, but keeps the query efficient



--(OR)--

UPDATE table_name
SET column_name = 'New Value'
WHERE condition;

*/
/*
==========================================================
                         DELETE
===========================================================
*/
/*
---Syntax---
DELETE FROM table_name
WHERE condition;
*/




























/*
==========================================================
                         WHERE CLUASE
===========================================================
*/

-- Retrieve customer with a score not equal to 0

SELECT *
FROM CUSTOMERS
WHERE SCORE <> 0;

--Retrieve customer from Germany

SELECT *
FROM CUSTOMERS
WHERE COUNTRY = 'Germany';

/*
=============================================================
ORDER BY 
=============================================================
*/

-- Retrieve all customers and sort by the highest score first

SELECT*
FROM CUSTOMERS
ORDER BY SCORE DESC;

-- Retrieve all customers and sort by the LOWEST score first

SELECT*
FROM CUSTOMERS
ORDER BY SCORE ASC;

/*
=============================================================
NESTED SORTING --- Is used when the column data is repeated more then once
=============================================================
*/
/*
-- Retrieve all customers and sort the results by the country and then by the highest score
*/

SELECT*
FROM CUSTOMERS
ORDER BY 
  COUNTRY ASC,
  SCORE DESC;

/*
==============================================================
GROUP BY -- Aggregates a column or add same name column together in one column
=============================================================
*/

--Find the total score for each country

SELECT
  COUNTRY,
  SUM(SCORE) AS total_score
FROM CUSTOMERS
GROUP BY COUNTRY;


-- find the total score and total number of customers for each country.


SELECT
  COUNTRY,
  COUNT(CUSTOMERID) AS TOTAL_CUSTOMER,
  SUM(SCORE) AS TOTAL_SCORE
FROM CUSTOMERS
GROUP BY COUNTRY;


/*
================================================================
HAVING
================================================================
*/
 --Find the average score for each country considering only customers with a score not eqyal to 0 and return only those cuontries with an average score greater than 430.


 SELECT
  COUNTRY,
  AVG(SCORE) AS avg_score
 FROM CUSTOMERS
 WHERE SCORE <> 0
 GROUP BY COUNTRY
 HAVING
     AVG(SCORE) > 430;


/*
=========================================================
Disinct
========================================================
*/

--Return Unique List of All countries

SELECT DISTINCT
  COUNTRY
FROM CUSTOMERS;

/*
===============================
TOP
==============================
*/

--Retrieve only 3 customers

SELECT TOP 3
*
FROM CUSTOMERS;

--Retrieve only 3 customers with highest score

SELECT TOP 3
*
FROM CUSTOMERS
ORDER BY SCORE DESC;

---Retrieve only 3 customers lowest score

SELECT TOP 3
*
FROM CUSTOMERS
ORDER BY SCORE ASC;

--Get the two most recent orders

SELECT TOP 2
*
FROM ORDERS
ORDER BY ORDERDATE DESC;































































































--Find the total sales for each product

SELECT
  PRODUCTID,
  SUM(SALES) AS total_sales
FROM ORDERS
GROUP BY PRODUCTID;

--Find the total sales for each product Additionally provide details such order id and order date

SELECT
  PRODUCTID,
  ORDERID,
  ORDERDATE,
  SALES,
  SUM(SALES) OVER(PARTITION BY PRODUCTID) AS total_sales
FROM ORDERS;
