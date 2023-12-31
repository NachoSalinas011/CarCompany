CREATE DATABASE IF NOT EXISTS CarCompany;
USE CarCompany;


DROP TABLE IF EXISTS Task_Supplie;
DROP TABLE IF EXISTS Purchase_supplie;
DROP TABLE IF EXISTS Car_Workstation;
DROP TABLE IF EXISTS Workstation;
DROP TABLE IF EXISTS Task;
DROP TABLE IF EXISTS Supplie;
DROP TABLE IF EXISTS Purchase;
DROP TABLE IF EXISTS Supplier;
DROP TABLE IF EXISTS Car;
DROP TABLE IF EXISTS AssemblyLine;
DROP TABLE IF EXISTS Order_detail;
DROP TABLE IF EXISTS `Order`;
DROP TABLE IF EXISTS Model;
DROP TABLE IF EXISTS Dealership;


CREATE TABLE IF NOT EXISTS Model(
    id INT PRIMARY KEY,
    `name` VARCHAR(255)
);

CREATE TABLE Dealership
(
    Id INT NOT NULL,
    Nombre VARCHAR(25),
    PhoneNumber VARCHAR(25),
    Address VARCHAR(25),
    PRIMARY KEY(Id)
);

CREATE TABLE `Order`
(
    Id INT NOT NULL,
    DealershipId INT NOT NULL,
    fecha DATETIME,
    PRIMARY KEY(Id),
    FOREIGN KEY (DealershipId) REFERENCES Dealership(Id)
);

CREATE TABLE Order_Detail (
    Id INT NOT NULL,
    OrderId INT NOT NULL,
    ModelId INT NOT NULL,
    PRIMARY KEY(Id),
    FOREIGN KEY (OrderId) REFERENCES `Order`(Id),
    FOREIGN KEY (ModelId) REFERENCES Model(id)
);

CREATE TABLE IF NOT EXISTS Supplier (
    Id INT PRIMARY KEY,
    Name VARCHAR(255),
    Adrress VARCHAR(255),
    PhoneNumber VARCHAR(255)
);

CREATE TABLE IF NOT EXISTS Purchase (
    Id INT PRIMARY KEY,
    SupplierId INT,
    Date DATETIME,
    FOREIGN KEY (SupplierId) REFERENCES Supplier(Id)
);
CREATE TABLE IF NOT EXISTS Supplie(
	Id INT PRIMARY KEY,
	Nombre VARCHAR(45),
    Price DECIMAL
);

CREATE TABLE IF NOT EXISTS Purchase_Supplie (
    Id INT PRIMARY KEY,
    PurchaseId INT,
    SupplieId INT,
    Cant INT,
    Price DECIMAL,
    FOREIGN KEY (PurchaseId) REFERENCES Purchase(Id),
    FOREIGN KEY (SupplieId) REFERENCES Supplie(Id)
);

CREATE TABLE IF NOT EXISTS Task(
	Id INT PRIMARY KEY,
    `Name` VARCHAR(45)
);

CREATE TABLE IF NOT EXISTS Task_Supplie (
	Id INT PRIMARY KEY,
    TaskId INT,
    SupplieId INT,
    Cant INT,
    
    FOREIGN KEY (TaskId) REFERENCES Task(Id),
    FOREIGN KEY (SupplieId) REFERENCES Supplie(Id)
);

CREATE TABLE IF NOT EXISTS AssemblyLine(
    Id INT PRIMARY KEY,
    ModelId INT,
    FOREIGN KEY (ModelId) REFERENCES Model(id)
);

CREATE TABLE IF NOT EXISTS Workstation (
    id INT PRIMARY KEY,
    assemblyLineId INT,
    taskId INT,
    orden INT,
    FOREIGN KEY (assemblyLineId) REFERENCES AssemblyLine(Id),
    FOREIGN KEY (taskId) REFERENCES Task(id)
);

CREATE TABLE IF NOT EXISTS Car (
    Id INT PRIMARY KEY,
    Patent VARCHAR(45),
    ModelId INT,
    OrderId INT,
    FinishDate DATETIME,
    FOREIGN KEY (ModelId) REFERENCES Model(id),
    FOREIGN KEY (OrderId) REFERENCES `Order`(Id)
);

CREATE TABLE IF NOT EXISTS Car_Workstation(
    Id INT PRIMARY KEY,
    CarId INT,
    WorkstationId INT,
    StartDate DATETIME,
    FinishDate DATETIME,
    FOREIGN KEY (CarId) REFERENCES Car(Id),
    FOREIGN KEY (WorkstationId) REFERENCES Workstation(id)
);


