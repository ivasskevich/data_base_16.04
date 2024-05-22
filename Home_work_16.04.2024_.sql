CREATE DATABASE HOSPITAL;
GO

USE HOSPITAL;
GO

CREATE TABLE DEpartments (
    Id INT PRIMARY KEY IDENTITY,
    Building INT NOT NULL CHECK (Building BETWEEN 1 AND 5),
    Financing MONEY NOT NULL DEFAULT 0,
    Floor INT NOT NULL CHECK (Floor >= 1),
    Name NVARCHAR(100) NOT NULL UNIQUE
);
GO

CREATE TABLE DIseases (
    Id INT PRIMARY KEY IDENTITY,
    Name NVARCHAR(100) NOT NULL UNIQUE,
    Severity INT NOT NULL DEFAULT 1 CHECK (Severity >= 1)
);
GO

CREATE TABLE DOctors (
    Id INT PRIMARY KEY IDENTITY,
    Name NVARCHAR(MAX) NOT NULL,
    Phone CHAR(10) NULL,
    Premium MONEY NOT NULL DEFAULT 0 CHECK (Premium >= 0),
    Salary MONEY NOT NULL CHECK (Salary > 0),
    Surname NVARCHAR(MAX) NOT NULL
);
GO

CREATE TABLE EXaminations (
    Id INT PRIMARY KEY IDENTITY,
    DayOfWeek INT NOT NULL CHECK (DayOfWeek BETWEEN 1 AND 7),
    EndTime TIME NOT NULL,
    Name NVARCHAR(100) NOT NULL UNIQUE,
    StartTime TIME NOT NULL CHECK (StartTime >= '08:00' AND StartTime <= '18:00')
);
GO

CREATE TABLE WArds (
    Id INT PRIMARY KEY IDENTITY,
    Building INT NOT NULL CHECK (Building BETWEEN 1 AND 5),
    Floor INT NOT NULL CHECK (Floor >= 1),
    Name NVARCHAR(20) NOT NULL UNIQUE
);
GO

INSERT INTO DEpartments (Building, Financing, Floor, Name)
VALUES 
  (1, 11000.00, 1, '����������� 1'),
  (2, 16000.00, 2, '����������� 2'),
  (3, 13000.00, 1, '����������� 3'),
  (4, 21000.00, 3, '����������� 4'),
  (5, 19000.00, 2, '����������� 5');
GO

INSERT INTO DIseases (Name, Severity)
VALUES 
  ('������� 1', 1),
  ('������� 2', 2),
  ('������� 3', 3),
  ('������� 4', 4),
  ('������� 5', 5);
GO

INSERT INTO DOctors (Name, Phone, Premium, Salary, Surname)
VALUES 
  ('������ 1', '1111111111', 6000.00, 21000.00, '������� 1'),
  ('������ 2', '2222222222', 4000.00, 19000.00, '������� 2'),
  ('������ 3', '3333333333', 7000.00, 26000.00, '������� 3'),
  ('������ 4', '4444444444', 5000.00, 23000.00, '������� 4'),
  ('������ 5', NULL, 4500.00, 20000.00, '������� 5');
GO

INSERT INTO Examinations (DayOfWeek, EndTime, Name, StartTime)
VALUES 
  (1, '12:30', '����� 1', '10:30'),
  (3, '14:30', '����� 2', '12:30'),
  (5, '16:30', '����� 3', '14:30'),
  (2, '11:30', '����� 4', '09:30'),
  (4, '15:30', '����� 5', '13:30');
GO

INSERT INTO Wards (Building, Floor, Name)
VALUES 
  (1, 1, '164'),
  (2, 2, '276'),
  (3, 1, '334'),
  (4, 3, '423'),
  (5, 2, '590');
GO

--1. ������� ���������� ������� �����.
SELECT *
FROM WArds

--2. ������� ������� � �������� ���� ������.
SELECT Surname, Phone
FROM DOctors

--3. ������� ��� ����� ��� ����������, �� ������� ������������� ������.
SELECT DISTINCT Floor
FROM WArds

--4. ������� �������� ����������� ��� ������ �Name of Disease� � ������� �� ������� ��� ������ �Severity of Disease�.
SELECT Name AS 'Name of Disease', Severity AS 'Severity of Disease'
FROM DIseases

--5. ������������ ��������� FROM ��� ����� ���� ������ ���� ������, ��������� ��� ��� ����������.
SELECT *
FROM DEpartments AS D, 
DIseases AS Ds,
DOctors AS Drs

--6. ������� �������� ���������, ������������� � ������� 5 � ������� ���� �������������� ����� 30000.
SELECT Name
FROM DEpartments
WHERE Building = 5 AND Financing < 30000

--7. ������� �������� ���������, ������������� � 3-� ������� � ������ �������������� � ��������� �� 12000 �� 15000.
SELECT Name
FROM DEpartments
WHERE Building = 3 AND Financing BETWEEN 12000 AND 15000

--8. ������� �������� �����, ������������� � �������� 4 � 5 �� 1-� �����.
SELECT Name
FROM WArds
WHERE Building IN (4, 5) AND Floor = 1

--9. ������� ��������, ������� � ����� �������������� ���������, ������������� � �������� 3 ��� 6 � ������� ���� �������������� ������ 11000 ��� ������ 25000.
SELECT Name, Building, Financing
FROM DEpartments
WHERE Building IN (3, 6) AND (Financing < 11000 OR Financing > 25000)

--10. ������� ������� ������, ��� �������� (����� ������ � ��������) ��������� 1500.
SELECT Surname
FROM DOctors
WHERE Salary + Premium > 1500

--11. ������� ������� ������, � ������� �������� �������� ��������� ����������� ��������.
SELECT Surname
FROM DOctors
WHERE Salary / 2 > 3 * Premium

--12. ������� �������� ������������ ��� ����������, ���������� � ������ ��� ��� ������ � 12:00 �� 15:00.
SELECT DISTINCT Name
FROM EXaminations
WHERE DayOfWeek IN (1, 2, 3) AND StartTime >= '12:00' AND EndTime <= '15:00'

--13. ������� �������� � ������ �������� ���������, ������������� � �������� 1, 3, 8 ��� 10.
SELECT Name AS DepartmentName, Building AS WardBuilding
FROM DEpartments
WHERE Building IN (1, 3, 8, 10);

--14. ������� �������� ����������� ���� �������� �������, ����� 1-� � 2-�.
SELECT Name
FROM DIseases
WHERE Severity NOT IN (1, 2)

--15. ������� �������� ���������, ������� �� ������������� � 1-� ��� 3-� �������.
SELECT Name
FROM DEpartments
WHERE Building NOT IN (1, 3)

--16. ������� �������� ���������, ������� ������������� � 1-� ��� 3-� �������.
SELECT Name
FROM DEpartments
WHERE Building IN (1, 3)

--17. ������� ������� ������, ������������ �� ����� �N�.
SELECT Surname
FROM DOctors
WHERE Surname LIKE 'N%'