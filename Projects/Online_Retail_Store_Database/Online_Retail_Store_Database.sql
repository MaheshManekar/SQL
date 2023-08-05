CREATE schema RetailStoreDatabase;

CREATE TABLE Employee (
    Employee_ID CHAR(3) NOT NULL,
    Employee_Name CHAR(20) NOT NULL,
    SSN INT(9) NOT NULL,
    Designation VARCHAR(10) NOT NULL,
    Employee_Type VARCHAR(20) NOT NULL,
    Salary VARCHAR(20) NOT NULL
);

Alter table employee add Primary Key (Employee_ID);

CREATE TABLE ZipCode (
    State VARCHAR(20) NOT NULL,
    Zipcode_ID CHAR(5) NOT NULL,
    City VARCHAR(20) NOT NULL
);

ALTER TABLE zipcode ADD PRIMARY KEY (Zipcode_ID);

CREATE TABLE Address (
    Address_ID CHAR(2) NOT NULL,
    Apartment_Number INT NOT NULL,
    Street VARCHAR(20) NOT NULL,
    Apartment_Name VARCHAR(20) NOT NULL,
    Customer_ID CHAR(5) NOT NULL,
    Zipcode_ID CHAR(5) NOT NULL
);

ALTER TABLE address ADD PRIMARY KEY (Address_ID);

CREATE TABLE Customers (
    Customer_ID CHAR(5) NOT NULL,
    First_Name VARCHAR(20) NOT NULL,
    Last_Name VARCHAR(20) NOT NULL,
    Phone_Number BIGINT(10) NOT NULL,
    Email_Address VARCHAR(20) NOT NULL,
    Customer_Type VARCHAR(20) NOT NULL
);

ALTER TABLE customers ADD PRIMARY KEY (Customer_ID);

CREATE TABLE Payments (
    Payment_ID CHAR(3) NOT NULL,
    Payment_Mode VARCHAR(20) NOT NULL,
    Card_Type VARCHAR(20) NOT NULL,
    Card_Number BIGINT(16) NOT NULL,
    CVV INT(3) NOT NULL,
    Name_On_Card VARCHAR(20) NOT NULL, 
    Customer_ID CHAR(5) NOT NULL,
    Visit_Number INT NOT NULL,
    Employee_ID CHAR(3) NOT NULL
);

ALTER TABLE  Payments ADD PRIMARY KEY (Payment_ID);

CREATE TABLE Reviews (
    Quality_Rating INT(1) NOT NULL,
    Defect_Percentage INT(2) NOT NULL,
    Review_ID VARCHAR(4) NOT NULL,
    Review_Date DATE
);

ALTER TABLE Reviews ADD PRIMARY KEY (Review_ID);

CREATE TABLE Product_Details (
    Product_ID CHAR(5) NOT NULL,
    Weight VARCHAR(20) NOT NULL,
    Width DOUBLE(2 , 2 ) NOT NULL,
    Height DOUBLE(2 , 2 ) NOT NULL,
    Colour VARCHAR(20) NOT NULL
);

ALTER TABLE product_details  ADD PRIMARY KEY (Product_ID); 

CREATE TABLE Product (
    Product_ID CHAR(5) NOT NULL,
    Product_Name VARCHAR(20) NOT NULL,
    Available_Number INT(200),
    Group_ID INT(3) NOT NULL,
    Supplier_ID CHAR(4) NOT NULL,
    Review_ID VARCHAR(4)
);

ALTER TABLE product ADD PRIMARY KEY (Product_ID);

CREATE TABLE Product_Group (
    Group_ID INT(3) NOT NULL,
    Group_Name VARCHAR(20) NOT NULL
);

ALTER TABLE product_group ADD  PRIMARY KEY (Group_ID);

CREATE TABLE Orders (
    Order_ID CHAR(4) NOT NULL,
    Order_Date DATE NOT NULL,
    Status VARCHAR(20),
    Shipment_Duration VARCHAR(20) NOT NULL,
    Payment_ID CHAR(3) NOT NULL
);

ALTER TABLE orders ADD PRIMARY KEY (Order_ID);

CREATE TABLE Bill (
    Billing_ID CHAR(5) NOT NULL,
    Billing_Date DATE NOT NULL,
    Amount_Paid DOUBLE NOT NULL,
    Voucher_ID VARCHAR(2),
    Payment_ID CHAR(3) NOT NULL,
    Order_ID CHAR(4) NOT NULL
);

ALTER TABLE bill ADD PRIMARY KEY (Billing_ID);

CREATE TABLE Voucher (
    Voucher_ID VARCHAR(2) NOT NULL,
    Discount_Percentage INT(2) NOT NULL
);

ALTER TABLE voucher ADD PRIMARY KEY (Voucher_ID);

CREATE TABLE Order_Product (
    Quantity INT(200),
    Product_ID CHAR(5) NOT NULL,
    Order_ID CHAR(4) NOT NULL,
    OrderProduct_ID CHAR(20)  NOT NULL
);

ALTER TABLE order_product ADD PRIMARY KEY (OrderProduct_ID);

CREATE TABLE Supplier (
    Supplier_ID CHAR(4) NOT NULL,
    Supplier_Name VARCHAR(20) NOT NULL,
    Supplier_Quantity VARCHAR(2000) NOT NULL
);

ALTER TABLE supplier ADD PRIMARY KEY (Supplier_ID);



-- ADDING THE CONSTRAINTS IN THE TABLE

ALTER TABLE product ADD foreign key (Group_ID) references product_group (Group_ID) on delete restrict on update restrict;
ALTER TABLE product ADD foreign key (Supplier_ID) references supplier (Supplier_ID) on delete restrict on update restrict;
ALTER TABLE product ADD foreign key (Review_ID) references reviews (Review_ID) on delete restrict on update restrict;
ALTER TABLE bill ADD foreign key (voucher_id) references voucher (voucher_id) on delete restrict on update restrict;
ALTER TABLE bill ADD foreign key (order_id) references orders (order_id) on delete restrict on update restrict;
ALTER TABLE bill ADD foreign key (payment_id) references payments (payment_id) on delete restrict on update restrict;
ALTER TABLE address ADD foreign key (customer_ID) references customers (customer_ID) on delete restrict on update restrict;
ALTER TABLE address ADD foreign key (zipcode_id) references zipcode (zipcode_id) on delete restrict on update restrict;
ALTER TABLE payments ADD foreign key (customer_ID) references customers (customer_ID) on delete restrict on update restrict;
ALTER TABLE payments ADD foreign key (employee_ID) references employee (employee_ID) on delete restrict on update restrict;
ALTER TABLE orders ADD foreign key (payment_Id) references payments (payment_Id) on delete restrict on update restrict;
ALTER TABLE order_product ADD foreign key (product_ID) references product (product_ID) on delete restrict on update restrict;
ALTER TABLE order_product ADD foreign key (order_ID) references orders (order_ID) on delete restrict on update restrict;
