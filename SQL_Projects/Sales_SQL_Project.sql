-- Generation of tables for the Data base. 

USE Sales

--2. DATA BASE CREATION

CREATE TABLE CLIENT (
    id varchar(50), 
    name varchar(50), 
    address varchar(50), 
    idLoc varchar(50), 
    idSeller varchar(50), 
    balance decimal(10,2)
);

CREATE TABLE SELLER (
    idSeller varchar(50), 
    sellerName varchar(50)
);

CREATE TABLE LOCATION (
    idLoc varchar(50), 
    locName varchar(50), 
    idState varchar(50)
);

CREATE TABLE STATE (
    idState varchar(50), 
    stateName varchar(50)
);

-- 3. DATA INSERTION

INSERT INTO CLIENT (id, name, address, idLoc, idSeller, balance) 
VALUES 
('1', 'John Smith', '742 Evergreen Terrace', '100', '10', 0),
('2', 'Emma Johnson', '123 Elm Street', '200', '20', 300.75),
('3', 'Michael Brown', '1600 Pennsylvania Ave NW', '300', '10', 125.00),
('4', 'Olivia Davis', '221B Baker Street', '400', '30', 400.00),
('5', 'Sophia Wilson', '10 Downing Street', '500', '40', 500.20),
('6', 'William Martinez', '456 Maple Street', '600', '10', 0),
('7', 'Mia Clark', '789 Broadway', '700', '20', 275.30),
('8', 'Noah Rodriguez', '102 Sunset Blvd', '800', '30', 180.75),
('9', 'Liam Lewis', '303 Wall Street', '900', '40', 125.50),
('10', 'Ava Hall', NULL, NULL, '10', 420.00),
('11', 'James Young', '212 Willow Avenue', '100', '10', 305.40),
('12', 'Isabella King', '678 Birch Road', '200', '20', 210.20),
('13', 'Lucas Wright', NULL, NULL, '30', 500.50),
('14', 'Charlotte Lee', '1240 Lakeview Drive', '400', '40', 320.00),
('15', 'Ethan Walker', '907 Pine Street', '500', '10', 0),
('16', 'Amelia Scott', NULL, NULL, '20', 315.80),
('17', 'Alexander Adams', '443 Elm Circle', '700', '30', 180.00),
('18', 'Ella Carter', '890 Garden Road', '800', '40', 290.10),
('19', 'Benjamin Baker', '202 River Road', '900', '10', 395.75),
('20', 'Harper Gonzalez', '789 Lincoln Street', '1000', '20', 120.50);

INSERT INTO SELLER (idSeller, sellerName) 
VALUES 
('10', 'James Miller'),
('20', 'Charlotte Anderson'),
('30', 'Benjamin Thomas'),
('40', 'Amelia Moore');

INSERT INTO LOCATION (idLoc, locName, idState) 
VALUES 
('100', 'Springfield', 'IL'),
('200', 'Austin', 'TX'),
('300', 'New York', 'NY'),
('400', 'Los Angeles', 'CA'),
('500', 'Chicago', 'IL'),
('600', 'Houston', 'TX'),
('700', 'Phoenix', 'AZ'),
('800', 'Philadelphia', 'PA'),
('900', 'San Antonio', 'TX'),
('1000', 'San Diego', 'CA');

INSERT INTO STATE (idState, stateName) 
VALUES 
('IL', 'Illinois'),
('TX', 'Texas'),
('NY', 'New York'),
('CA', 'California'),
('AZ', 'Arizona'),
('PA', 'Pennsylvania');

--4. DATA CLEANING

-- a) Exploration of CLIENT TABLE:

SELECT * FROM CLIENT

--b) Elimination of NULL Balance values:

DELETE FROM CLIENT WHERE (balance = 0);

UPDATE CLIENT 
SET address = COALESCE(address, 'Unknown'), 
    idLoc = COALESCE(idLoc, 'Unknown')
WHERE address IS NULL OR idLoc IS NULL;

SELECT * FROM CLIENT

--5.  Queries:
-- a) Client ID, name, address, city name, and state name.
SELECT CLIENT.id AS Id, CLIENT.name AS Name, 
	   CLIENT.address AS address, 
	   LOCATION.locName AS Location, 
	   STATE.stateName AS State
FROM CLIENT 
INNER JOIN LOCATION ON CLIENT.idLoc = LOCATION.idLoc 
INNER JOIN STATE ON LOCATION.idState = STATE.idState;


-- b) Ranking of clients by seller (seller id, seler name, quantity of clients ordered by quantity of clients).

SELECT   TOP (100) PERCENT SELLER.idSeller AS Seller_Id, 
         SELLER.sellerName AS Seller_name, 
		 COUNT(dbo.CLIENT.id) AS Client_quantity
FROM      CLIENT INNER JOIN SELLER 
                ON CLIENT.idSeller = SELLER.idSeller
GROUP BY SELLER.sellerName, SELLER.idSeller
ORDER BY Client_quantity

-- c) Locations without customers.

SELECT idLoc AS Location_Id, locName AS Location_name, stateName AS State_Name 
FROM LOCATION INNER JOIN 
				 STATE ON STATE.idState = LOCATION.idState
ORDER BY idLoc

-- d) Name of the seller who has the most clients.

SELECT TOP 1 sellerName,
       COUNT(CLIENT.id) AS Client_quantity 
FROM SELLER 
INNER JOIN CLIENT ON CLIENT.idSeller = SELLER.idSeller
GROUP BY sellerName
ORDER BY Client_quantity DESC

-- e) Sum of balances per promoter.
SELECT SELLER.sellerName AS Seller_name,
	   SUM(CLIENT.balance) AS Balance
FROM SELLER INNER JOIN CLIENT
ON   SELLER.idSelLer = CLIENT.idSelLer
GROUP BY SELLER.sellerName

--f) Name of clients whose balance is greater than 100.

SELECT CLIENT.name AS Client_name,
	   CLIENT.balance AS Balance
FROM CLIENT
WHERE CLIENT.balance > 100
ORDER BY CLIENT.balance DESC
