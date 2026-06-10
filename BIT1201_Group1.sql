-- Create Database
CREATE DATABASE public_health_clinic_records ;

-- Patient Table
CREATE TABLE Patient (
    PatientID INT AUTO_INCREMENT PRIMARY KEY,
    FullName VARCHAR(100) NOT NULL,
    DateOfBirth DATE NOT NULL,
    Gender VARCHAR(10) NOT NULL CHECK (Gender IN ('Male','Female')),
    Phone VARCHAR(15) UNIQUE,
    Address VARCHAR(150)
);

-- HealthWorker Table
CREATE TABLE HealthWorker (
    HealthWorkerID INT AUTO_INCREMENT PRIMARY KEY,
    FullName VARCHAR(100) NOT NULL,
    Role VARCHAR(50) NOT NULL,
    Phone VARCHAR(15) UNIQUE
);

-- Appointment Table
CREATE TABLE Appointment (
    AppointmentID INT AUTO_INCREMENT PRIMARY KEY,
    PatientID INT NOT NULL,
    AppointmentDate DATE NOT NULL,
    AppointmentTime TIME NOT NULL,
    Status VARCHAR(20) NOT NULL DEFAULT 'Scheduled',
    FOREIGN KEY (PatientID) REFERENCES Patient(PatientID)
);

-- Visit Table
CREATE TABLE Visit (
    VisitID INT AUTO_INCREMENT PRIMARY KEY,
    PatientID INT NOT NULL,
    HealthWorkerID INT NOT NULL,
    VisitDate DATE NOT NULL,
    Reason TEXT,
    FOREIGN KEY (PatientID) REFERENCES Patient(PatientID),
    FOREIGN KEY (HealthWorkerID) REFERENCES HealthWorker(HealthWorkerID)
);

-- Diagnosis Table
CREATE TABLE Diagnosis (
    DiagnosisID INT AUTO_INCREMENT PRIMARY KEY,
    VisitID INT NOT NULL,
    Description TEXT NOT NULL,
    DiagnosisDate DATE NOT NULL,
    FOREIGN KEY (VisitID) REFERENCES Visit(VisitID)
);

-- Treatment Table
CREATE TABLE Treatment (
    TreatmentID INT AUTO_INCREMENT PRIMARY KEY,
    DiagnosisID INT NOT NULL,
    Description TEXT NOT NULL,
    Medication VARCHAR(100),
    TreatmentDate DATE NOT NULL,
    FOREIGN KEY (DiagnosisID) REFERENCES Diagnosis(DiagnosisID)
);
-- Insert Patients
INSERT INTO Patient (FullName, DateOfBirth, Gender, Phone, Address)
VALUES ('John Kamara', '1990-05-12', 'Male', '23279123456', 'Freetown'),
       ('Fatmata Sesay', '1985-09-20', 'Female', '23276123457', 'Bo'),
       ('Maybel Sesay', '1989-09-27', 'Female', '23276268533', 'Grafton'),
       ('John Conteh', '1990-05-10', 'male', '23276567864', 'Kissy'),
       ('Philp Kanu', '2000-02-19', 'male', '23277654323', 'Calaba Town')

-- Insert Health Workers
INSERT INTO HealthWorker (FullName, Role, Phone)
VALUES ('Dr. Mariatu Conteh', 'Doctor', '23276123458'),
       ('Nurse Abdul Koroma', 'Nurse', '23276123459'),
       ('Nurse Alphina Conteh', 'Nurse', '23278765432'),
       ('Dr. Esther Kargbo', 'Doctor', '23279876543'),
       ('Dr. Zainiel Smart', 'Doctor', '23273445432')

-- Insert Appointment
INSERT INTO Appointment (PatientID, AppointmentDate, AppointmentTime)
VALUES (1, '2026-06-10', '09:00:00'),
       (2, '2026-06-11', '08:35:00'),
       (3, '2026-07-21', '10:45:00'),
       (4, '2026-08-19', '02:00:00'),
       (5, '2026-08-25', '12:50:00')

-- Insert Visit
INSERT INTO Visit (PatientID, HealthWorkerID, VisitDate, Reason)
VALUES (1, 1, '2026-06-10', 'Routine Checkup'),
       (2, 2, '2026-06-11', 'Fever and headache'),
       (3, 3, '2026-07-21', 'Fever '),
       (4, 4, '2026-08-19', 'Stomach pain'),
       (5, 5, '2026-08-25', 'Toothache')

-- Insert Diagnosis
INSERT INTO Diagnosis (VisitID, Description, DiagnosisDate)
VALUES (1, 'Normal health condition', '2026-06-10'),
       (2, 'Malaria detected', '2026-06-11'),
       (3, 'Malaria detected', '2026-07-21'),
       (4, 'Typhoid detected', '2026-08-19'),
       (5, 'Cold detected', '2026-08-25')

-- Insert Treatment
INSERT INTO Treatment (DiagnosisID, Description, Medication, TreatmentDate)
VALUES (2, 'Antimalarial treatment', 'Coartem', '2026-06-11'),
       (2, 'Antimalarial treatment', 'Coartem', '2026-07-21'),
       (2, 'Typhoid treatment', 'Coartem', '2026-08-19'),
       (2, 'Cold treatment', 'Coartem', '2026-08-25')

-- Demonstration of Update statement and Delete Statement
UPDATE Patient
SET Phone='079123456'
WHERE PatientID=1;

DELETE FROM Appointment
WHERE AppointmentID=2;


-- SQL Queries
SELECT * FROM Patient;


-- Filtering Using WHERE
SELECT * FROM Patient
WHERE Gender='Female';


-- Sorting Using ORDER BY
SELECT * FROM Appointment
ORDER BY AppointmentDate ASC;

-- Aggregate Functions
-- COUNT
SELECT COUNT(*) AS TotalPatients
FROM Patient;


-- AVG
SELECT AVG(TIMESTAMPDIFF(YEAR, DateOfBirth, CURDATE()))
AS AverageAge
FROM Patient;

-- Limit Clause
SELECT * FROM Visit
LIMIT 5;


-- Real-Life Healthcare Scenario Query
SELECT
P.FullName,
D.Description AS Diagnosis,
T.Medication
FROM Patient P
JOIN Visit V ON P.PatientID = V.PatientID
JOIN Diagnosis D ON V.VisitID = D.VisitID
JOIN Treatment T ON D.DiagnosisID = T.DiagnosisID;

-- USER MANAGEMENT
-- Creation of Users
CREATE USER 'Esther'@'localhost'
IDENTIFIED BY '905005763';
CREATE USER 'Mamadu'@'localhost'
IDENTIFIED BY ' 905005082';
CREATE USER 'Amadu'@'localhost'
IDENTIFIED BY '905005800';

-- Granting Privileges
GRANT ALL PRIVILEGES
ON public_health_clinic_records.*
TO 'Esther'@'localhost';
GRANT ALL PRIVILEGES
ON public_health_clinic_records.*
TO 'Mamdu'@'localhost';
GRANT ALL PRIVILEGES
ON public_health_clinic_record*
TO 'Amadu'@'localhost';
