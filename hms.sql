create database hosmansys

use hosmansys

CREATE TABLE patients (
    patient_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    age INT NOT NULL,
    gender VARCHAR(10),
    contact VARCHAR(15)
);

CREATE TABLE doctors (
    doctor_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    specialization VARCHAR(50),
    phone VARCHAR(15)
);

CREATE TABLE appointments (
    appointment_id INT AUTO_INCREMENT PRIMARY KEY,
    patient_id INT NOT NULL,
    doctor_id INT NOT NULL,
    appointment_date DATE NOT NULL,
    status VARCHAR(20),
    FOREIGN KEY (patient_id) REFERENCES patients(patient_id),
    FOREIGN KEY (doctor_id) REFERENCES doctors(doctor_id)
);

INSERT INTO patients (name, age, gender, contact) VALUES
('Tamizhanban', 30, 'Male', '9876543210'),
('Raghul', 25, 'Female', '9876541234'),
('Sar', 45, 'Female', '9123456789');


INSERT INTO doctors (name, specialization, phone) VALUES
('Dr.lokesh', 'Cardiology', '9001234567'),
('Dr.rock', 'Orthopedics', '9007654321'),
('Dr.prakash', 'General Medicine', '9001122334');


INSERT INTO appointments (patient_id, doctor_id, appointment_date, status) VALUES
(1, 1, '2024-12-26', 'Confirmed'),
(2, 2, '2024-12-27', 'Pending'),
(3, 3, '2024-12-28', 'Completed');

/*-------------------------------------------------------*/
CREATE TABLE billing (
    bill_id INT AUTO_INCREMENT PRIMARY KEY,
    patient_id INT NOT NULL,
    total_amount DECIMAL(10, 2),
    paid_status VARCHAR(10) CHECK (paid_status IN ('Paid', 'Unpaid')),
    bill_date DATE NOT NULL,
    FOREIGN KEY (patient_id) REFERENCES patients(patient_id)
);

INSERT INTO billing (patient_id, total_amount, paid_status, bill_date) VALUES
(1, 5000.00, 'Paid', CURDATE()),
(2, 3000.00, 'Unpaid', CURDATE()),
(3, 7000.00, 'Paid', CURDATE());

/*--------------------------------------------------------*/


SELECT * FROM patients;

SELECT * FROM doctors;

SELECT * FROM appointments;

SELECT * from billing;

SELECT * 
FROM patients
 WHERE gender = 'male';

update patients
set gender="male"
where patient_id=2;

SELECT a.appointment_id, p.name AS patient_name, d.name AS doctor_name, 
       a.appointment_date, a.status
FROM appointments a
JOIN patients p
 ON a.patient_id = p.patient_id
JOIN doctors d 
ON a.doctor_id = d.doctor_id;

SELECT COUNT(*) AS total_patients
 FROM patients;

SELECT AVG(age) AS average_age 
FROM patients;

SELECT d.name AS doctor_name, COUNT(a.appointment_id) AS total_appointments
FROM doctors d
LEFT JOIN appointments a
 ON d.doctor_id = a.doctor_id
GROUP BY d.doctor_id;

/*--List patients who visited doctors specializing in 'Cardiology':--*/

SELECT DISTINCT p.name AS patient_name
FROM patients p
JOIN appointments a 
ON p.patient_id = a.patient_id
JOIN doctors d 
ON a.doctor_id = d.doctor_id
WHERE d.specialization = 'Cardiology';








