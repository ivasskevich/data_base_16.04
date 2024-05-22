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
  (1, 11000.00, 1, 'Департамент 1'),
  (2, 16000.00, 2, 'Департамент 2'),
  (3, 13000.00, 1, 'Департамент 3'),
  (4, 21000.00, 3, 'Департамент 4'),
  (5, 19000.00, 2, 'Департамент 5');
GO

INSERT INTO DIseases (Name, Severity)
VALUES 
  ('Хвороба 1', 1),
  ('Хвороба 2', 2),
  ('Хвороба 3', 3),
  ('Хвороба 4', 4),
  ('Хвороба 5', 5);
GO

INSERT INTO DOctors (Name, Phone, Premium, Salary, Surname)
VALUES 
  ('Доктор 1', '1111111111', 6000.00, 21000.00, 'Прізвище 1'),
  ('Доктор 2', '2222222222', 4000.00, 19000.00, 'Прізвище 2'),
  ('Доктор 3', '3333333333', 7000.00, 26000.00, 'Прізвище 3'),
  ('Доктор 4', '4444444444', 5000.00, 23000.00, 'Прізвище 4'),
  ('Доктор 5', NULL, 4500.00, 20000.00, 'Прізвище 5');
GO

INSERT INTO Examinations (DayOfWeek, EndTime, Name, StartTime)
VALUES 
  (1, '12:30', 'Огляд 1', '10:30'),
  (3, '14:30', 'Огляд 2', '12:30'),
  (5, '16:30', 'Огляд 3', '14:30'),
  (2, '11:30', 'Огляд 4', '09:30'),
  (4, '15:30', 'Огляд 5', '13:30');
GO

INSERT INTO Wards (Building, Floor, Name)
VALUES 
  (1, 1, '164'),
  (2, 2, '276'),
  (3, 1, '334'),
  (4, 3, '423'),
  (5, 2, '590');
GO

--1. Вывести содержимое таблицы палат.
SELECT *
FROM WArds

--2. Вывести фамилии и телефоны всех врачей.
SELECT Surname, Phone
FROM DOctors

--3. Вывести все этажи без повторений, на которых располагаются палаты.
SELECT DISTINCT Floor
FROM WArds

--4. Вывести названия заболеваний под именем “Name of Disease” и степень их тяжести под именем “Severity of Disease”.
SELECT Name AS 'Name of Disease', Severity AS 'Severity of Disease'
FROM DIseases

--5. Использовать выражение FROM для любых трех таблиц базы данных, используя для них псевдонимы.
SELECT *
FROM DEpartments AS D, 
DIseases AS Ds,
DOctors AS Drs

--6. Вывести названия отделений, расположенных в корпусе 5 и имеющих фонд финансирования менее 30000.
SELECT Name
FROM DEpartments
WHERE Building = 5 AND Financing < 30000

--7. Вывести названия отделений, расположенных в 3-м корпусе с фондом финансирования в диапазоне от 12000 до 15000.
SELECT Name
FROM DEpartments
WHERE Building = 3 AND Financing BETWEEN 12000 AND 15000

--8. Вывести названия палат, расположенных в корпусах 4 и 5 на 1-м этаже.
SELECT Name
FROM WArds
WHERE Building IN (4, 5) AND Floor = 1

--9. Вывести названия, корпуса и фонды финансирования отделений, расположенных в корпусах 3 или 6 и имеющих фонд финансирования меньше 11000 или больше 25000.
SELECT Name, Building, Financing
FROM DEpartments
WHERE Building IN (3, 6) AND (Financing < 11000 OR Financing > 25000)

--10. Вывести фамилии врачей, чья зарплата (сумма ставки и надбавки) превышает 1500.
SELECT Surname
FROM DOctors
WHERE Salary + Premium > 1500

--11. Вывести фамилии врачей, у которых половина зарплаты превышает троекратную надбавку.
SELECT Surname
FROM DOctors
WHERE Salary / 2 > 3 * Premium

--12. Вывести названия обследований без повторений, проводимых в первые три дня недели с 12:00 до 15:00.
SELECT DISTINCT Name
FROM EXaminations
WHERE DayOfWeek IN (1, 2, 3) AND StartTime >= '12:00' AND EndTime <= '15:00'

--13. Вывести названия и номера корпусов отделений, расположенных в корпусах 1, 3, 8 или 10.
SELECT Name AS DepartmentName, Building AS WardBuilding
FROM DEpartments
WHERE Building IN (1, 3, 8, 10);

--14. Вывести названия заболеваний всех степеней тяжести, кроме 1-й и 2-й.
SELECT Name
FROM DIseases
WHERE Severity NOT IN (1, 2)

--15. Вывести названия отделений, которые не располагаются в 1-м или 3-м корпусе.
SELECT Name
FROM DEpartments
WHERE Building NOT IN (1, 3)

--16. Вывести названия отделений, которые располагаются в 1-м или 3-м корпусе.
SELECT Name
FROM DEpartments
WHERE Building IN (1, 3)

--17. Вывести фамилии врачей, начинающиеся на букву “N”.
SELECT Surname
FROM DOctors
WHERE Surname LIKE 'N%'