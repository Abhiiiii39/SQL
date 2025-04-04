create database supplychain
use supplychain

-- Create Suppliers Table
create table Suppliers (Supplier_ID INT PRIMARY KEY AUTO_INCREMENT,Supplier_Name VARCHAR(255) NOT NULL,Contact_Name VARCHAR(255),Contact_Email VARCHAR(255),Contact_Phone VARCHAR(50),Address TEXT,Country VARCHAR(100),Status ENUM("Active", "Inactive") DEFAULT "Active")

-- Create Warehouse Table
create table Warehouse (Warehouse_ID INT PRIMARY KEY AUTO_INCREMENT,Warehouse_Name VARCHAR(255) NOT NULL,Location TEXT,Capacity INT,Manager_Name VARCHAR(255),Manager_Contact VARCHAR(100))

-- Create Products Table
create table Products (Product_ID INT PRIMARY KEY AUTO_INCREMENT,Product_Name VARCHAR(255) NOT NULL,Category VARCHAR(100),Unit_Price DECIMAL(10, 2),Supplier_ID INT,Description TEXT,FOREIGN KEY (Supplier_ID) REFERENCES Suppliers(Supplier_ID))

-- Create Shipments Table
create table Shipments (Shipment_ID INT PRIMARY KEY AUTO_INCREMENT,Supplier_ID INT,Warehouse_ID INT,Shipment_Date DATE,Arrival_Date DATE,Status ENUM('Pending', 'In-Transit', 'Delivered') DEFAULT 'Pending',Shipment_Cost DECIMAL(10, 2),Tracking_Number VARCHAR(255),FOREIGN KEY (Supplier_ID) REFERENCES Suppliers(Supplier_ID),FOREIGN KEY (Warehouse_ID) REFERENCES Warehouse(Warehouse_ID))

-- Create Inventory Table
create table Inventory (Inventory_ID INT PRIMARY KEY AUTO_INCREMENT,Warehouse_ID INT,Product_ID INT,Quantity_Available INT,Reorder_Level INT,Last_Updated TIMESTAMP DEFAULT CURRENT_TIMESTAMP,FOREIGN KEY (Warehouse_ID) REFERENCES Warehouse(Warehouse_ID),FOREIGN KEY (Product_ID) REFERENCES Products(Product_ID))

-- Create Orders Table
create table Orders (Order_ID INT PRIMARY KEY AUTO_INCREMENT,Customer_Name VARCHAR(255) NOT NULL,Order_Date DATE,Delivery_Date DATE,Order_Status ENUM('Pending', 'Shipped', 'Delivered') DEFAULT 'Pending',Total_Amount DECIMAL(10, 2),Payment_Status ENUM('Paid', 'Unpaid') DEFAULT 'Unpaid',Shipping_Address TEXT)

-- Create Order_Details Table (Many-to-Many Relationship Between Orders and Products)
create table Order_Details (Order_Detail_ID INT PRIMARY KEY AUTO_INCREMENT,Order_ID INT,Product_ID INT,Quantity INT,Unit_Price DECIMAL(10, 2),FOREIGN KEY (Order_ID) REFERENCES Orders(Order_ID),FOREIGN KEY (Product_ID) REFERENCES Products(Product_ID))

-- Insert Values into Suppliers Table
insert into Suppliers (Supplier_Name, Contact_Name, Contact_Email, Contact_Phone, Address, Country, Status)
values
('Global Electronics', 'John Smith', 'john.smith@globelec.com', '555-1234', '123 Tech Lane, Silicon Valley', 'USA', 'Active'),
('ABC Furniture', 'Alice Johnson', 'alice.johnson@abcfurn.com', '555-5678', '456 Wood St, New York', 'USA', 'Active'),
('TechWorld', 'David Brown', 'david.brown@techworld.com', '555-8765', '789 Circuit Rd, San Francisco', 'USA', 'Active'),
('Fresh Foods', 'Maria Lee', 'maria.lee@freshfoods.com', '555-4321', '101 Green St, Chicago', 'USA', 'Inactive'),
('Super Home Goods', 'Paul Walker', 'paul.walker@superhome.com', '555-9087', '102 Oak Rd, Boston', 'USA', 'Active'),
('Prime Electronics', 'Sarah Williams', 'sarah.williams@primeelec.com', '555-3421', '1105 Power St, Austin', 'USA', 'Active'),
('Fashion Factory', 'Emily Taylor', 'emily.taylor@fashionfactory.com', '555-1243', '200 Fashion Ave, Los Angeles', 'USA', 'Inactive'),
('Best Kitchen Supplies', 'Michael Green', 'michael.green@bestkitchen.com', '555-7654', '350 Cooking Blvd, Miami', 'USA', 'Active'),
('Toys Paradise', 'Natalie White', 'natalie.white@toysparadise.com', '555-4567', '100 Toy Lane, Orlando', 'USA', 'Active'),
('Office Supplies Co.', 'Steve Martin', 'steve.martin@officesupplies.com', '555-8912', '600 Paper Ave, Seattle', 'USA', 'Inactive'),
('TechGears', 'Rachel Adams', 'rachel.adams@techgears.com', '555-1011', '12 Innovation St, Silicon Valley', 'USA', 'Active'),
('HomeSafe Appliances', 'Tom Davis', 'tom.davis@homesafe.com', '555-2123', '23 Safe Rd, Dallas', 'USA', 'Inactive'),
('Sunshine Furniture', 'Karen Clark', 'karen.clark@sunshinefurn.com', '555-3134', '34 Bright Ave, Orlando', 'USA', 'Active'),
('Outdoor Adventures', 'Luke Harris', 'luke.harris@outdooradv.com', '555-4145', '45 Wild Rd, Denver', 'USA', 'Inactive'),
('FashionWear', 'Isabella Scott', 'isabella.scott@fashionwear.com', '555-5156', '56 Fashion St, New York', 'USA', 'Active');

-- Insert Values into Warehouse Table
insert into Warehouse (Warehouse_Name, Location, Capacity, Manager_Name, Manager_Contact)
values
('Central Warehouse', '123 Warehouse Rd, Dallas, TX', 10000, 'Robert King', '555-1001'),
('West Coast Warehouse', '456 Coastline St, Los Angeles, CA', 12000, 'Patricia Clark', '555-2002'),
('East Coast Warehouse', '789 Seaside Ave, Miami, FL', 8000, 'Daniel Smith', '555-3003'),
('Northern Storage Facility', '234 Mountain Dr, Denver, CO', 7000, 'Linda Brown', '555-4004'),
('Southern Hub', '1000 South St, Atlanta, GA', 15000, 'James Johnson', '555-5005'),
('Midwest Depot', '303 Plains Rd, Chicago, IL', 11000, 'Elizabeth Davis', '555-6006'),
('Southwest Logistics', '8900 Desert Rd, Phoenix, AZ', 8500, 'Nina White', '555-7007'),
('Great Lakes Warehouse', '4500 Lakeview Blvd, Detroit, MI', 9000, 'Mark Lee', '555-8008'),
('Mountain Peak Storage', '6700 Summit Rd, Denver, CO', 7000, 'Sophia Green', '555-9009'),
('Atlantic Depot', '1150 Ocean Blvd, Miami, FL', 6000, 'Chris Johnson', '555-1010'),
('Global Supply Hub', '2300 Central Rd, Seattle, WA', 9500, 'Peter Harris', '555-2020'),
('Pacific Bay Warehouse', '7800 Pacific Rd, Los Angeles, CA', 13000, 'Olivia Martin', '555-3030'),
('Capital Logistics', '1540 Capital Dr, Washington, D.C.', 11500, 'William Young', '555-4040'),
('North Star Facility', '2700 Glacier Ave, Minneapolis, MN', 10000, 'Jason King', '555-5050'),
('Blue Sky Storage', '2200 Horizon Rd, Dallas, TX', 12000, 'Charlotte Wood', '555-6060');

-- Insert Values into Products Table
insert into Products (Product_Name, Category, Unit_Price, Supplier_ID, Description)
values
('Laptop X200', 'Electronics', 799.99, 1, 'High-performance laptop for gaming and work'),
('Wooden Chair', 'Furniture', 49.99, 2, 'Ergonomically designed wooden chair for home or office use'),
('Smartphone Z', 'Electronics', 699.99, 3, 'Latest smartphone with OLED screen and 5G support'),
('Couch Comfort', 'Furniture', 499.99, 2, 'Modern couch with memory foam cushions'),
('Blender Pro', 'Home Appliances', 89.99, 5, 'High-power blender for smoothies and soups'),
('LED TV 50"', 'Electronics', 349.99, 3, 'Smart LED TV with 4K resolution'),
('Dining Table', 'Furniture', 249.99, 2, 'Wooden dining table with seating for 6'),
('Electric Kettle', 'Home Appliances', 29.99, 5, 'Fast boiling electric kettle with auto shutoff'),
('Toy Train Set', 'Toys', 59.99, 9, 'Battery-operated toy train for kids'),
('Office Desk', 'Furniture', 129.99, 10, 'Adjustable office desk with storage'),
('Wireless Headphones', 'Electronics', 199.99, 1, 'Noise-cancelling wireless headphones'),
('Kids Bicycle', 'Toys', 120.99, 9, 'Bicycle for kids aged 5-10'),
('Pressure Cooker', 'Home Appliances', 49.99, 5, 'Durable pressure cooker for fast cooking'),
('Smart Watch', 'Electronics', 159.99, 3, 'Smartwatch with fitness tracking and notifications'),
('Wooden Bookshelf', 'Furniture', 129.99, 2, 'Wooden bookshelf with adjustable shelves'),
('Tablet S5', 'Electronics', 249.99, 1, 'Tablet with high-resolution screen and fast performance'),
('Folding Chair', 'Furniture', 39.99, 2, 'Portable folding chair for outdoor use'),
('Coffee Maker', 'Home Appliances', 59.99, 5, 'Coffee maker with programmable timer'),
('PlayStation 5', 'Electronics', 499.99, 1, 'Next-gen gaming console with 4K support'),
('Shampoo Set', 'Beauty', 15.99, 8, 'Shampoo and conditioner set for all hair types');

-- Insert Values into Shipments Table
insert into Shipments (Supplier_ID, Warehouse_ID, Shipment_Date, Arrival_Date, Status, Shipment_Cost, Tracking_Number)
values
(1, 1, '2025-03-01', '2025-03-03', 'Delivered', 150.00, 'TRACK12345'),
(2, 2, '2025-03-02', '2025-03-05', 'In-Transit', 100.00, 'TRACK23456'),
(3, 3, '2025-03-03', '2025-03-06', 'Delivered', 200.00, 'TRACK34567'),
(5, 4, '2025-03-04', '2025-03-07', 'Pending', 50.00, 'TRACK45678'),
(6, 5, '2025-03-05', '2025-03-08', 'Delivered', 120.00, 'TRACK56789'),
(9, 6, '2025-03-06', '2025-03-09', 'Delivered', 80.00, 'TRACK67890'),
(3, 7, '2025-03-07', '2025-03-10', 'In-Transit', 180.00, 'TRACK78901'),
(2, 8, '2025-03-08', '2025-03-11', 'Pending', 150.00, 'TRACK89012'),
(4, 9, '2025-03-09', '2025-03-12', 'Delivered', 90.00, 'TRACK90123'),
(1, 10, '2025-03-10', '2025-03-13', 'In-Transit', 110.00, 'TRACK01234');

-- Insert Values into Inventory Table
insert into Inventory (Warehouse_ID, Product_ID, Quantity_Available, Reorder_Level)
values
(1, 1, 100, 20),
(1, 2, 200, 30),
(2, 3, 150, 25),
(2, 4, 100, 15),
(3, 5, 80, 10),
(3, 6, 60, 10),
(4, 7, 50, 15),
(4, 8, 120, 20),
(5, 9, 70, 10),
(6, 10, 150, 40),
(7, 11, 60, 15),
(8, 12, 50, 10),
(9, 13, 200, 30),
(10, 14, 80, 25),
(1, 15, 150, 20),
(2, 16, 180, 15),
(3, 17, 75, 10),
(4, 18, 50, 30),
(5, 19, 100, 15),
(6, 20, 60, 10);

-- Insert Values into Orders Table
insert into Orders (Customer_Name, Order_Date, Delivery_Date, Order_Status, Total_Amount, Payment_Status, Shipping_Address)
values
('Michael Scott', '2025-03-01', '2025-03-05', 'Shipped', 599.99, 'Paid', '123 Office Rd, Scranton, PA'),
('Pam Beesly', '2025-03-02', '2025-03-06', 'Delivered', 299.99, 'Paid', '456 Paper Ave, Scranton, PA'),
('Dwight Schrute', '2025-03-03', '2025-03-07', 'Pending', 450.00, 'Unpaid', '789 Beet Farm Rd, Scranton, PA'),
('Jim Halpert', '2025-03-04', '2025-03-08', 'Shipped', 199.99, 'Paid', '100 Scranton St, Scranton, PA'),
('Angela Martin', '2025-03-05', '2025-03-09', 'Delivered', 129.99, 'Paid', '200 Cat Rd, Scranton, PA'),
('Ryan Howard', '2025-03-06', '2025-03-10', 'Pending', 300.00, 'Unpaid', '300 Business Park, Scranton, PA'),
('Kelly Kapoor', '2025-03-07', '2025-03-11', 'Shipped', 420.00, 'Paid', '400 Office Blvd, Scranton, PA'),
('Stanley Hudson', '2025-03-08', '2025-03-12', 'Delivered', 215.00, 'Paid', '500 Maple Ave, Scranton, PA'),
('Oscar Martinez', '2025-03-09', '2025-03-13', 'Shipped', 850.00, 'Paid', '600 Pine Rd, Scranton, PA'),
('Toby Flenderson', '2025-03-10', '2025-03-14', 'Delivered', 100.00, 'Paid', '700 Oak St, Scranton, PA');

-- Insert Values into Order_Details Table
insert into Order_Details (Order_ID, Product_ID, Quantity, Unit_Price)
values
(1, 1, 2, 799.99),
(2, 3, 1, 699.99),
(3, 6, 1, 349.99),
(4, 5, 1, 89.99),
(5, 7, 2, 249.99),
(6, 9, 1, 59.99),
(7, 10, 3, 129.99),
(8, 11, 2, 49.99),
(9, 12, 1, 199.99),
(10, 13, 4, 50.00);

-- 1. View All Suppliers
SELECT * FROM Suppliers;

-- 2. View All Products from a Specific Supplier
SELECT Product_Name, Category, Unit_Price FROM Products WHERE Supplier_ID = 1;

-- 3. Get Inventory Levels in All Warehouses
SELECT w.Warehouse_Name, p.Product_Name, i.Quantity_Available FROM Inventory i JOIN Warehouse w ON i.Warehouse_ID = w.Warehouse_ID JOIN Products p ON i.Product_ID = p.Product_ID;

-- 4. Check Low Inventory (Products Below Reorder Level)
SELECT p.Product_Name, i.Quantity_Available, i.Reorder_Level FROM Inventory i JOIN Products p ON i.Product_ID = p.Product_ID WHERE i.Quantity_Available <= i.Reorder_Level;

-- 5. View Orders by Customer
SELECT o.Order_ID, o.Customer_Name, o.Order_Date, o.Total_Amount, o.Order_Status FROM Orders o WHERE o.Customer_Name = 'Michael Scott';

-- 6. View Products in a Specific Order
SELECT od.Order_ID, p.Product_Name, od.Quantity, od.Unit_Price FROM Order_Details od JOIN Products p ON od.Product_ID = p.Product_ID WHERE od.Order_ID = 1;

-- 7. Get Total Sales for a Specific Product
SELECT SUM(od.Quantity * od.Unit_Price) AS Total_Sales FROM Order_Details od WHERE od.Product_ID = 1;

-- 8. Find Orders in Pending Status
SELECT * FROM Orders WHERE Order_Status = 'Pending';

-- 9. Update Order Status to Delivered
UPDATE Orders SET Order_Status = 'Delivered' WHERE Order_ID = 5;

-- 10. Insert New Supplier
INSERT INTO Suppliers (Supplier_Name, Contact_Name, Contact_Email, Contact_Phone, Address, Country, Status) VALUES ('New Supplier', 'John Doe', 'john.doe@newsupplier.com', '555-1234', '123 Supplier St, City', 'USA', 'Active');

-- 11. Update Product Price
UPDATE Products SET Unit_Price = 799.99 WHERE Product_ID = 3;

-- 12. Delete an Out-of-Stock Product
DELETE FROM Products WHERE Product_ID = 15 AND Product_ID NOT IN (SELECT Product_ID FROM Inventory WHERE Quantity_Available > 0);

-- 13. Get the Total Revenue of a Customer
SELECT o.Customer_Name, SUM(o.Total_Amount) AS Total_Revenue FROM Orders o WHERE o.Customer_Name = 'Michael Scott'  GROUP BY o.Customer_Name;

-- 14. View Shipments for a Specific Supplier
SELECT s.Shipment_Date, s.Arrival_Date, s.Status, s.Shipment_Cost, w.Warehouse_Name FROM Shipments s JOIN Warehouse w ON s.Warehouse_ID = w.Warehouse_ID WHERE s.Supplier_ID = 2;

-- 15. Get Total Cost of All Shipments
SELECT SUM(Shipment_Cost) AS Total_Shipment_Cost FROM Shipments;

-- 16. Track Inventory Levels by Warehouse
SELECT w.Warehouse_Name, SUM(i.Quantity_Available) AS Total_Inventory FROM Inventory i JOIN Warehouse w ON i.Warehouse_ID = w.Warehouse_ID GROUP BY w.Warehouse_Name;

-- 17. View Order Details for Delivered Orders
SELECT od.Order_ID, p.Product_Name, od.Quantity, od.Unit_Price FROM Order_Details od JOIN Products p ON od.Product_ID = p.Product_ID JOIN Orders o ON od.Order_ID = o.Order_ID WHERE o.Order_Status = 'Delivered';

-- 18. Get All Products in a Specific Category
SELECT Product_Name, Unit_Price FROM Products WHERE Category = 'Electronics';

-- 19. Check for Unpaid Orders
SELECT o.Order_ID, o.Customer_Name, o.Total_Amount FROM Orders o WHERE o.Payment_Status = 'Unpaid';

-- 20. Get the Total Quantity of a Product in All Warehouses
SELECT p.Product_Name, SUM(i.Quantity_Available) AS Total_Quantity FROM Inventory i JOIN Products p ON i.Product_ID = p.Product_ID WHERE p.Product_ID = 1 GROUP BY p.Product_Name;

-- 21. Get Orders Between Two Dates
SELECT * FROM Orders WHERE Order_Date BETWEEN '2025-03-01' AND '2025-03-10';

-- 22. Find Product Availability in a Specific Warehouse
SELECT p.Product_Name, i.Quantity_Available FROM Inventory i JOIN Products p ON i.Product_ID = p.Product_ID WHERE i.Warehouse_ID = 1;

-- 23. Get List of Orders with Products in Stock
SELECT o.Order_ID, o.Customer_Name, p.Product_Name, od.Quantity FROM Orders o JOIN Order_Details od ON o.Order_ID = od.Order_ID JOIN Products p ON od.Product_ID = p.Product_ID JOIN Inventory i ON p.Product_ID = i.Product_ID WHERE i.Quantity_Available > 0;

-- 24. Increase Product Quantity in Inventory
UPDATE Inventory SET Quantity_Available = Quantity_Available + 50 WHERE Product_ID = 3 AND Warehouse_ID = 2;

-- 25. Get Shipments for a Specific Warehouse
SELECT s.Shipment_Date, s.Arrival_Date, s.Status, s.Shipment_Cost FROM Shipments s WHERE s.Warehouse_ID = 1;

-- 26. Count Products in Inventory Below Reorder Level
SELECT COUNT(*) AS Low_Stock_Count FROM Inventory i WHERE i.Quantity_Available < i.Reorder_Level;

-- 27. Get Total Revenue from Orders in a Specific Month
SELECT SUM(o.Total_Amount) AS Total_Revenue FROM Orders o WHERE MONTH(o.Order_Date) = 3 AND YEAR(o.Order_Date) = 2025;

-- 28. Update Product Reorder Level
UPDATE Inventory SET Reorder_Level = 100 WHERE Product_ID = 10 AND Warehouse_ID = 1;

-- 29. Get the Most Expensive Product Sold
SELECT p.Product_Name, MAX(od.Unit_Price) AS Max_Price FROM Order_Details od JOIN Products p ON od.Product_ID = p.Product_ID GROUP BY p.Product_Name ORDER BY Max_Price DESC LIMIT 1;

-- 30. Delete a Specific Shipment
DELETE FROM Shipments WHERE Shipment_ID = 10;

-- 31. Get Products That Have Never Been Ordered
SELECT p.Product_Name FROM Products p LEFT JOIN Order_Details od ON p.Product_ID = od.Product_ID WHERE od.Order_ID IS NULL;

-- 32. Get the Total Number of Orders in a Specific Month
SELECT COUNT(*) AS Total_Orders FROM Orders WHERE MONTH(Order_Date) = 3 AND YEAR(Order_Date) = 2025;  -- Replace with desired month/year

-- 33. Get Shipments Pending Arrival
SELECT s.Shipment_ID, s.Shipment_Date, s.Arrival_Date, s.Status, s.Tracking_Number FROM Shipments s WHERE s.Arrival_Date > CURDATE() AND s.Status != 'Delivered';

-- 34. Get the Average Product Price Across All Products

-- 35. Get the Orders with Most Expensive Products
SELECT o.Order_ID, o.Customer_Name, p.Product_Name, od.Quantity, od.Unit_Price FROM Orders o JOIN Order_Details od ON o.Order_ID = od.Order_ID JOIN Products p ON od.Product_ID = p.Product_ID WHERE od.Unit_Price = (SELECT MAX(Unit_Price) FROM Order_Details);
