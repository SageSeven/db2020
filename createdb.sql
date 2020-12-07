CREATE DATABASE IF NOT EXISTS baronhill CHARACTER SET UTF8;
USE baronhill;

DROP TABLE IF EXISTS signin;
DROP TABLE IF EXISTS `leave`;
DROP TABLE IF EXISTS attendance;
DROP TABLE IF EXISTS payroll;
DROP TABLE IF EXISTS department;
DROP TABLE IF EXISTS employee;

CREATE TABLE employee
(
    employeeID INT PRIMARY KEY,
    `name` VARCHAR(20),
    birthday DATE,
    socialID CHAR(18),
    hiredate DATE,
    username VARCHAR(20), /*入职时候加的*/
    `password` VARCHAR(20),
    gender CHAR(5), /*值是男和女*/
    deptID INT,/* FOREIGN KEY REFERENCES department(deptID),*/
    telephone VARCHAR(13),
    email VARCHAR(30),
    `level` CHAR, /*"E(employee), M(manager), A(admin)"*/
    leaveCount INT,
    lateCount INT
);

CREATE TABLE department
(
    deptID INT PRIMARY KEY,
    deptname VARCHAR(20),
    managerID INT,
    `description` VARCHAR(100),
    FOREIGN KEY (managerID) REFERENCES employee(employeeID)
);

CREATE TABLE payroll
(
    salaryNo INT PRIMARY KEY,
    employeeID INT,
    basicSalary NUMERIC(10, 2),
    deduction NUMERIC(10, 2),
    realSalary NUMERIC(10, 2),
    workTime CHAR(6), /*"201912"*/
    payTime DATE,
    verifierID INT,
    `type` CHAR, /*"E(employee), M(manager)"*/
    FOREIGN KEY (employeeID) REFERENCES employee(employeeID),
    FOREIGN KEY (verifierID) REFERENCES employee(employeeID)
);

CREATE TABLE attendance
(
    attendanceNo INT PRIMARY KEY,
    employeeID INT,
    `time` TIME,
    isLate INT,
    `date` DATE,
    FOREIGN KEY (employeeID) REFERENCES employee(employeeID)
);

CREATE TABLE `leave`
(
    leaveNo INT PRIMARY KEY,
    employeeID INT,
    leaveReason VARCHAR(30),
    applyDay DATE,
    leaveBegin DATE,
    leaveEnd DATE,
    `type` CHAR, /*E,M*/
    reviewerID INT,
    `status` CHAR, /*N(not viewed),Y(viewed)*/
    FOREIGN KEY (employeeID) REFERENCES employee(employeeID),
    FOREIGN KEY (reviewerID) REFERENCES employee(employeeID)
);

/*signin session table*/
CREATE TABLE signin
(
    employeeID INT PRIMARY KEY,
    sessionKey INT,
    FOREIGN KEY (employeeID) REFERENCES employee(employeeID)
);

