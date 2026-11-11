USE sales;
DROP TABLE IF EXISTS ProductDetail_1NF;
CREATE TABLE ProductDetail_1NF (
    OrderID INT,
    CustomerName VARCHAR(100),
    Product VARCHAR(100),
    PRIMARY KEY (OrderID, Product)
);
INSERT INTO ProductDetail_1NF (OrderID, CustomerName, Product) VALUES
(101, 'John Doe', 'Laptop'),
(101, 'John Doe', 'Mouse'),
(102, 'Jane Smith', 'Tablet'),
(102, 'Jane Smith', 'Keyboard'),
(102, 'Jane Smith', 'Mouse'),
(103, 'Emily Clark', 'Phone');
SELECT * FROM ProductDetail_1NF;

-- ============================================================================
-- Question 2: Achieving Second Normal Form (2NF) - FIXED COLLISION
-- ============================================================================

-- 1. Drop existing assignment tables in the correct order to avoid constraint errors
DROP TABLE IF EXISTS Assignment_OrderItems;
DROP TABLE IF EXISTS Assignment_Orders;

-- 2. Create the unique Orders table for the assignment
CREATE TABLE Assignment_Orders (
    OrderID INT PRIMARY KEY,
    CustomerName VARCHAR(100) NOT NULL
);

-- 3. Create the OrderItems table for the assignment
CREATE TABLE Assignment_OrderItems (
    OrderID INT,
    Product VARCHAR(100),
    Quantity INT NOT NULL,
    PRIMARY KEY (OrderID, Product),
    FOREIGN KEY (OrderID) REFERENCES Assignment_Orders(OrderID) ON DELETE CASCADE
);

-- 4. Insert the normalized records into the Orders table
INSERT INTO Assignment_Orders (OrderID, CustomerName) VALUES
(101, 'John Doe'),
(102, 'Jane Smith'),
(103, 'Emily Clark');

-- 5. Insert the normalized records into the OrderItems table
INSERT INTO Assignment_OrderItems (OrderID, Product, Quantity) VALUES
(101, 'Laptop', 2),
(101, 'Mouse', 1),
(102, 'Tablet', 3),
(102, 'Keyboard', 1),
(102, 'Mouse', 2),
(103, 'Phone', 1);

-- 6. Verify using a JOIN statement
SELECT 
    o.OrderID, 
    o.CustomerName, 
    oi.Product, 
    oi.Quantity
FROM Assignment_Orders o
JOIN Assignment_OrderItems oi ON o.OrderID = oi.OrderID;
