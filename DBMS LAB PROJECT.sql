CREATE DATABASE HospitalManagementSystem;

USE HospitalManagementSystem;

CREATE TABLE Patients (
    patient_id INT IDENTITY(1,1) PRIMARY KEY,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    dob DATE NOT NULL,
    gender VARCHAR(10) NOT NULL,
    contact_number VARCHAR(15) NOT NULL,
    address VARCHAR(255) NOT NULL,
    email VARCHAR(100) NOT NULL,
    medical_history TEXT
);

CREATE TABLE Staff (
    staff_id INT IDENTITY(1,1) PRIMARY KEY,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    role VARCHAR(50) NOT NULL,
    specialty VARCHAR(100),
    contact_number VARCHAR(15) NOT NULL,
    email VARCHAR(100) NOT NULL,
    department VARCHAR(100) NOT NULL
);

CREATE TABLE Appointments (
    appointment_id INT IDENTITY(1,1) PRIMARY KEY,
    patient_id INT NOT NULL,
    doctor_id INT NOT NULL,
    appointment_date DATETIME NOT NULL,
    status VARCHAR(50) NOT NULL,
    FOREIGN KEY (patient_id) REFERENCES Patients(patient_id),
    FOREIGN KEY (doctor_id) REFERENCES Staff(staff_id)
);

CREATE TABLE Inpatients (
    inpatient_id INT IDENTITY(1,1) PRIMARY KEY,
    patient_id INT NOT NULL,
    admission_date DATETIME NOT NULL,
    discharge_date DATETIME,
    ward VARCHAR(100) NOT NULL,
    bed_number INT NOT NULL,
    attending_doctor_id INT NOT NULL,
    FOREIGN KEY (patient_id) REFERENCES Patients(patient_id),
    FOREIGN KEY (attending_doctor_id) REFERENCES Staff(staff_id)
);

CREATE TABLE LabTests (
    test_id INT IDENTITY(1,1) PRIMARY KEY,
    patient_id INT NOT NULL,
    test_name VARCHAR(100) NOT NULL,
    test_date DATETIME NOT NULL,
    results TEXT,
    ordered_by INT NOT NULL,
    FOREIGN KEY (patient_id) REFERENCES Patients(patient_id),
    FOREIGN KEY (ordered_by) REFERENCES Staff(staff_id)
);

CREATE TABLE Medications (
    medication_id INT IDENTITY(1,1) PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    stock_quantity INT NOT NULL,
    expiry_date DATE NOT NULL,
    reorder_level INT NOT NULL
);

CREATE TABLE Prescriptions (
    prescription_id INT IDENTITY(1,1) PRIMARY KEY,
    patient_id INT NOT NULL,
    doctor_id INT NOT NULL,
    medication_id INT NOT NULL,
    prescription_date DATETIME NOT NULL,
    dosage VARCHAR(50) NOT NULL,
    quantity INT NOT NULL,
    FOREIGN KEY (patient_id) REFERENCES Patients(patient_id),
    FOREIGN KEY (doctor_id) REFERENCES Staff(staff_id),
    FOREIGN KEY (medication_id) REFERENCES Medications(medication_id)
);

CREATE TABLE Billing (
    billing_id INT IDENTITY(1,1) PRIMARY KEY,
    patient_id INT NOT NULL,
    amount DECIMAL(10, 2) NOT NULL,
    billing_date DATETIME NOT NULL,
    status VARCHAR(50) NOT NULL,
    FOREIGN KEY (patient_id) REFERENCES Patients(patient_id)
);

CREATE TABLE Payments (
    payment_id INT IDENTITY(1,1) PRIMARY KEY,
    billing_id INT NOT NULL,
    amount_paid DECIMAL(10, 2) NOT NULL,
    payment_date DATETIME NOT NULL,
    payment_method VARCHAR(50) NOT NULL,
    FOREIGN KEY (billing_id) REFERENCES Billing(billing_id)
);

INSERT INTO Patients (first_name, last_name, dob, gender, contact_number, address, email, medical_history) VALUES
('Ahmed', 'Khan', '1985-05-20', 'Male', '03001234567', '123 Main Street, Karachi', 'ahmed.khan@example.com', 'Diabetes'),
('Sara', 'kazi', '1992-08-15', 'Female', '03017654321', '456 Market Road, Lahore', 'sara.bano@example.com', 'Hypertension'),
('Ali', 'Raza', '1978-11-30', 'Male', '03009876543', '789 Cantonment Area, Islamabad', 'ali.raza@example.com', 'Asthma');

-- Insert sample data into Staff table
INSERT INTO Staff (first_name, last_name, role, specialty, contact_number, email, department) VALUES
('Dr. Ayesha', 'Malik', 'Doctor', 'Cardiology', '03004561234', 'ayesha.malik@example.com', 'Cardiology'),
('Dr. Imran', 'Siddiqui', 'Doctor', 'Orthopedics', '03006549876', 'imran.siddiqui@example.com', 'Orthopedics'),
('Fatima', 'Nurse', 'Nurse', 'General', '03007894561', 'fatima.nurse@example.com', 'General Ward'),
('Ali', 'Shah', 'Admin', 'HR', '03008912345', 'ali.shah@example.com', 'Human Resources');

-- Insert sample data into Appointments table
INSERT INTO Appointments (patient_id, doctor_id, appointment_date, status) VALUES
(1, 1, '2024-07-01 10:00:00', 'Scheduled'),
(2, 2, '2024-07-02 11:00:00', 'Scheduled'),
(3, 1, '2024-07-03 09:30:00', 'Cancelled');

-- Insert sample data into Inpatients table
INSERT INTO Inpatients (patient_id, admission_date, discharge_date, ward, bed_number, attending_doctor_id) VALUES
(1, '2024-06-20 14:00:00', '2024-06-25 10:00:00', 'Cardiology', 101, 1),
(2, '2024-06-22 16:00:00', '2024-06-28 09:00:00', 'Orthopedics', 202, 2);

-- Insert sample data into LabTests table
INSERT INTO LabTests (patient_id, test_name, test_date, results, ordered_by) VALUES
(1, 'Blood Test', '2024-06-21 08:00:00', 'Normal', 1),
(2, 'X-Ray', '2024-06-23 11:00:00', 'Fracture in left leg', 2);

-- Insert sample data into Medications table
INSERT INTO Medications (name, stock_quantity, expiry_date, reorder_level) VALUES
('Paracetamol', 500, '2025-12-31', 100),
('Ibuprofen', 300, '2024-11-30', 50);

-- Insert sample data into Prescriptions table
INSERT INTO Prescriptions (patient_id, doctor_id, medication_id, prescription_date, dosage, quantity) VALUES
(1, 1, 1, '2024-06-20 14:30:00', '500mg', 30),
(2, 2, 2, '2024-06-22 16:30:00', '200mg', 15);

-- Insert sample data into Billing table
INSERT INTO Billing (patient_id, amount, billing_date, status) VALUES
(1, 1500.00, '2024-06-25 11:00:00', 'Paid'),
(2, 2500.00, '2024-06-28 10:00:00', 'Unpaid');

-- Insert sample data into Payments table
INSERT INTO Payments (billing_id, amount_paid, payment_date, payment_method) VALUES
(1, 1500.00, '2024-06-25 11:30:00', 'Credit Card'),
(2, 1000.00, '2024-06-29 12:00:00', 'Cash');


--Check Patients Data
SELECT * FROM Patients;

--Check Staff Data
SELECT * FROM Staff;

--Check Appointments Data
SELECT * FROM Appointments;

--Check Inpatients Data
SELECT * FROM Inpatients;

--Check Lab Tests Data
SELECT * FROM LabTests;

-- Check Medications Data
SELECT * FROM Medications;

--Check Prescriptions Data
SELECT * FROM Prescriptions;

--Check Billing Data
SELECT * FROM Billing;

-- Check Payments Data
SELECT * FROM Payments;

--Check Data Relationships
SELECT p.first_name, p.last_name, a.appointment_date, a.status
FROM Patients p
JOIN Appointments a ON p.patient_id = a.patient_id;

--Verify Doctor-Appointments Relationship
SELECT s.first_name AS doctor_first_name, s.last_name AS doctor_last_name, a.appointment_date, a.status
FROM Staff s
JOIN Appointments a ON s.staff_id = a.doctor_id
WHERE s.role = 'Doctor';

--Verify Inpatient-Attending Doctor Relationship
SELECT p.first_name AS patient_first_name, p.last_name AS patient_last_name, s.first_name AS doctor_first_name, s.last_name AS doctor_last_name, i.admission_date, i.discharge_date
FROM Inpatients i
JOIN Patients p ON i.patient_id = p.patient_id
JOIN Staff s ON i.attending_doctor_id = s.staff_id;


--Verify Lab Test-Patient Relationship
SELECT p.first_name AS patient_first_name, p.last_name AS patient_last_name, l.test_name, l.test_date, l.results
FROM LabTests l
JOIN Patients p ON l.patient_id = p.patient_id;


--Verify Prescription-Patient Relationship
SELECT p.first_name AS patient_first_name, p.last_name AS patient_last_name, m.name AS medication_name, pr.dosage, pr.quantity
FROM Prescriptions pr
JOIN Patients p ON pr.patient_id = p.patient_id
JOIN Medications m ON pr.medication_id = m.medication_id;


--Verify Billing-Payment Relationship
SELECT b.patient_id, b.amount, b.billing_date, b.status, p.amount_paid, p.payment_date, p.payment_method
FROM Billing b
JOIN Payments p ON b.billing_id = p.billing_id;



