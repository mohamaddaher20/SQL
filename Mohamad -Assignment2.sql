#CREATE OR REPLACE DATABASE A1_Products_DDL;

# Name: Mohamad Taha Daher
# W#: 0459521
# Description: Assignment 2 - DDL

USE A1_Products_DDL;

#Drop Tables Comment
DROP TABLE IF EXISTS ProductCategory;
DROP TABLE IF EXISTS ProductSize;
DROP TABLE IF EXISTS ProductColour;
DROP TABLE IF EXISTS Product;
DROP TABLE IF EXISTS Supplier;
DROP TABLE IF EXISTS ClothingCategory;
DROP TABLE IF EXISTS Colour;
DROP TABLE IF EXISTS ClothingSize;

# Creation of Product Table with datatype and constraints
CREATE TABLE Product (
    ProductID Integer PRIMARY KEY AUTO_INCREMENT,
    ProductCode Char(8) NOT NULL UNIQUE,
    ProductName Varchar(50) NOT NULL,
    ProdDescription Varchar(100), #I had to change the column name because I think Description is an object. I forgot the exact word for it.
    RetailPrice Double NOT NULL CHECK (RetailPrice >0),
    SalePrice Double CHECK (RetailPrice >0),
    ProductRating Integer NOT NULL CHECK (ProductRating =1 OR ProductRating =2 OR ProductRating=3 OR ProductRating=4 OR ProductRating=5),
    NumberInStock Integer NOT NULL DEFAULT 0,
    IsActive Bit NOT NULL DEFAULT 1,
    IsDiscontinued Bit NOT NULL DEFAULT 1
);
# Creation of Supplier Table with datatype and constraints
CREATE TABLE Supplier (
    SupplierID Integer PRIMARY KEY AUTO_INCREMENT,
    SupplierName Varchar(100) NOT NULL,
    Address Varchar(255) NOT NULL,
    ContactName Varchar(100),
    ContactPhone Varchar(20),
    ContactEmail varchar(50),
    IsActive Bit NOT NULL DEFAULT 1
);

# Creation of ClothingCategory Table with datatype and constraints
CREATE TABLE ClothingCategory (
    CategoryID integer PRIMARY KEY AUTO_INCREMENT,
    CategoryName Varchar(50) NOT NULL,
    IsActive Bit NOT NULL DEFAULT 1
);

# Creation of ClothingSize Table with datatype and constraints
CREATE TABLE ClothingSize (
    SizeID Integer PRIMARY KEY AUTO_INCREMENT,
    SizeName Varchar(50) NOT NULL,
    SizeAbbreviation Varchar(3) NOT NULL CHECK (SizeAbbreviation ='XS' OR SizeAbbreviation ='S' OR SizeAbbreviation = 'M' OR
    SizeAbbreviation = 'L' OR SizeAbbreviation = 'XL' OR SizeAbbreviation = 'XXL'),
    IsActive Bit NOT NULL DEFAULT 1
);

# Creation of Colour Table with datatype and constraints
CREATE TABLE Colour (
    ColourID Integer PRIMARY KEY AUTO_INCREMENT,
    ColourName Varchar(50) NOT NULL,
    ColourCode Char(3) NOT NULL UNIQUE,
    IsActive Bit NOT NULL DEFAULT 1
);

# Alter statement for product table to add the FK column
ALTER TABLE Product ADD column SupplierID integer;
ALTER TABLE Product ADD FOREIGN KEY (SupplierID) REFERENCES Supplier(SupplierID);

# Junction Tables with constraints
CREATE TABLE ProductCategory (
    ProductID Integer NOT NULL,
    CategoryID Integer NOT NULL,
    CONSTRAINT PRIMARY KEY (ProductID, CategoryID), #Compound primary key
    CONSTRAINT FOREIGN key (ProductID) REFERENCES Product(ProductID),
    CONSTRAINT FOREIGN KEY (CategoryID) REFERENCES ClothingCategory(CategoryID)
);

CREATE TABLE ProductSize (
    ProductID Integer NOT NULL,
    SizeID Integer NOT NULL,
    CONSTRAINT PRIMARY KEY (ProductID, SizeID), #Compound primary key
    CONSTRAINT FOREIGN KEY (ProductID) REFERENCES Product(ProductID),
    CONSTRAINT FOREIGN KEY (SizeID) REFERENCES ClothingSize(SizeID)
);

CREATE TABLE ProductColour (
    ProductID Integer NOT NULL,
    ColourID Integer NOT NULL,
    CONSTRAINT PRIMARY KEY (ProductID, ColourID), #Compound primary key
    CONSTRAINT FOREIGN KEY (ProductID) REFERENCES Product(ProductID),
    CONSTRAINT FOREIGN KEY (ColourID) REFERENCES Colour(ColourID)
);

