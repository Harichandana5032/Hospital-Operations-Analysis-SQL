CREATE DATABASE Hospital_Operation_Analysis;
USE Hospital_Operation_Analysis;

CREATE TABLE patients(
patient_id VARCHAR(20) PRIMARY KEY,
patient_name VARCHAR(100),
age INT,
gender VARCHAR(10),
city VARCHAR(50),
patient_type VARCHAR(20),
preferred_time_slot	VARCHAR(20),
registration_date DATE);

CREATE TABLE doctors(
doctor_id	VARCHAR(10) PRIMARY KEY,
doctor_name	VARCHAR(100),
specialty	VARCHAR(50),
hire_date	DATE,
rating	DECIMAL(3,2),
employment_type	VARCHAR(20),
is_active VARCHAR(3) NOT NULL
);

CREATE TABLE appointments(
appointment_id VARCHAR(20) PRIMARY KEY,
patient_id VARCHAR(20),
appointment_date	DATE,
doctor_id	VARCHAR(10),
service_type	VARCHAR(30),
priority	VARCHAR(10),
estimated_cost	DECIMAL(10,2),
booking_channel VARCHAR(20),
FOREIGN KEY(patient_id) REFERENCES patients(patient_id),
FOREIGN KEY(doctor_id) REFERENCES doctors(doctor_id)
);

CREATE TABLE rooms(
room_id	VARCHAR(10) PRIMARY KEY,
room_type	VARCHAR(30),
floor	INT,
equipment_type	VARCHAR(10),
capacity	INT,
last_maintenance_date	DATE NOT NULL,
is_available VARCHAR(10) NOT NULL);

CREATE TABLE treatments(
treatment_id VARCHAR(20) PRIMARY KEY,
appointment_id	VARCHAR(20),
doctor_id	VARCHAR(10),
room_id	VARCHAR(10),
actual_treatment_date	DATE,
status	VARCHAR(20),
treatment_attempt	INT,
treatment_duration_min	INT,
waiting_time_min INT,
treatment_cost DECIMAL(10,2),
FOREIGN KEY(appointment_id) REFERENCES appointments(appointment_id),
FOREIGN KEY(doctor_id) REFERENCES doctors(doctor_id),
FOREIGN KEY(room_id) REFERENCES rooms(room_id)
);

-- Sprint 3: Basic Analysis / Data Exploration
-- 1. What is the total number of patients?
SELECT DISTINCT COUNT(*) FROM patients;

-- 2. What is the total number of appointments?
SELECT DISTINCT COUNT(*) FROM appointments;

-- 3. What is the total number of treatment records?
SELECT DISTINCT COUNT(*) FROM treatments;

-- 4.What are the different medical service types?
SELECT DISTINCT service_type FROM appointments;

-- 5. How many doctors are currently active?
SELECT DISTINCT COUNT(*) as Active_Doctors FROM doctors WHERE is_active = 'Yes';

-- 6. What are the different room types?
SELECT DISTINCT room_type FROM rooms;

-- 7.What is the total estimated appointment value?
SELECT SUM(estimated_cost) FROM appointments;
-- SELECT * FROM
-- 8. What is the average treatment duration?
SELECT AVG(treatment_duration_min) FROM treatments;

-- Sprint 4: Objective-Based Analysis

-- 4.1 Understand Patient and Appointment Demand
-- what are the total number of appointments booked in each city?
SELECT p.city,COUNT(*) No_of_appointments FROM appointments a JOIN patients p on a.patient_id = p.patient_id GROUP BY p.city;

-- Which type of service is most commonly provided to patients?
SELECT service_type, COUNT(*) as Count FROM appointments GROUP BY service_type ORDER BY Count DESC LIMIT 1;

-- How many urgent cases are there in total? 
SELECT priority,count(*) FROM appointments WHERE priority = 'urgent';

-- What is the average waiting time for patients grouped by priority level?
-- SELECT a.priority, AVG(t.waiting_time_min) as Average_waiting_time_in_min FROM treatments t JOIN appointments a ON t.appointment_id = a.appointment_id GROUP BY priority;

-- Which preferred time slots have the highest number of appointments?
SELECT p.preferred_time_slot,COUNT(a.appointment_id) as highest_count FROM appointments a JOIN patients p ON a.patient_id = p.patient_id GROUP BY p.preferred_time_slot ORDER BY highest_count DESC LIMIT 1;

-- What is the total estimated cost of appointments grouped by patient type?
SELECT p.patient_type, SUM(a.estimated_cost) Total_estimated_cost  FROM appointments a JOIN patients p ON a.patient_id = p.patient_id GROUP BY p.patient_type;


-- Where do patients book from, and which source is the biggest driver of appointment volume?
SELECT booking_channel, COUNT(*) FROM appointments GROUP BY booking_channel;

-- Understand Patient Appointment Behaviour
-- Who are the most frequent patients, and which 3 patients have the fewest appointments?
SELECT p.patient_id, p.patient_name, COUNT(a.appointment_id)  Most_frequent_patient FROM appointments a JOIN patients p ON a.patient_id = p.patient_id  GROUP BY p.patient_id, p.patient_name ORDER BY Most_frequent_patient DESC LIMIT 1 ;
SELECT p.patient_id, p.patient_name, COUNT(a.appointment_id)  least_frequent_patient FROM appointments a JOIN patients p ON a.patient_id = p.patient_id  GROUP BY p.patient_id, p.patient_name ORDER BY least_frequent_patient LIMIT 3 ;

-- Which top 10 patients, when you add up the estimated cost of all their appointments, have the highest total value?
SELECT p.patient_id, p.patient_name, SUM(a.estimated_cost) Cummulative_Estimated_cost FROM appointments a JOIN patients p ON a.patient_id = p.patient_id  GROUP BY p.patient_id, p.patient_name ORDER BY Cummulative_Estimated_cost DESC LIMIT 10 ;

-- How many patients are registered in each city?
SELECT city, COUNT(*) Total_patients  FROM patients GROUP BY city;

-- What is the average estimated cost of appointments for each patient type (General, Corporate, Insurance)?
SELECT p.patient_type,AVG(a.estimated_cost) Average_Estimated_Cost FROM appointments a JOIN patients p ON a.patient_id = p.patient_id GROUP BY p.patient_type;

-- Which month has the highest number of appointments?
SELECT MONTHNAME(appointment_date) Month , COUNT(*) Count FROM appointments GROUP BY Month ORDER BY Count DESC LIMIT 1;

-- 4.3 Evaluate Treatment Performance

-- How many treatments were performed in each city?
SELECT p.city, COUNT(*) No_of_treatments FROM treatments t JOIN appointments a ON t.appointment_id = a.appointment_id JOIN patients p ON a.patient_id = p.patient_id GROUP BY p.city;


-- What is the average treatment duration and average waiting time?
SELECT AVG(treatment_duration_min) AVG_treatment_duration,AVG(waiting_time_min) AVG_waiting_time FROM treatments;

-- How many appointments have a waiting time exceeding 50 minutes and a status of 'Cancelled'?
SELECT status, COUNT(*) AS cnt FROM treatments WHERE status = 'Cancelled' and waiting_time_min > 50 GROUP BY status;  

-- Which area has the highest no-show rate?
SELECT p.city, ROUND(100.0 * SUM(t.status = 'No-Show')/COUNT(*),2) as No_show_rate FROM treatments t JOIN appointments a ON t.appointment_id = a.appointment_id JOIN patients p ON a.patient_id = p.patient_id GROUP BY p.city;

-- How many patients spent more time waiting than actually getting treated?
SELECT COUNT(*) More_wait_time_less_treatment_time FROM treatments WHERE waiting_time_min > treatment_duration_min;

-- 4.4 Understand Doctor and Room Performance

-- How many treatments has each doctor completed so far?
SELECT d.doctor_id,d.doctor_name, COUNT(*) No_of_treatments FROM treatments t JOIN doctors d ON t.doctor_id = d.doctor_id GROUP BY d.doctor_id,d.doctor_name;

-- Which doctor has the highest no-show rate?
SELECT d.doctor_id,d.doctor_name, ROUND(100.0 * SUM(t.status = 'No-Show')/COUNT(*),2) as No_show_rate  FROM treatments t JOIN doctors d ON t.doctor_id = d.doctor_id GROUP BY d.doctor_id,d.doctor_name ORDER BY No_show_rate DESC LIMIT 1;

-- What is the average treatment duration per doctor so far?
SELECT d.doctor_id,d.doctor_name, AVG(t.treatment_duration_min) Avg_treatment_duration FROM treatments t JOIN doctors d ON t.doctor_id = d.doctor_id GROUP BY d.doctor_id,d.doctor_name ORDER BY Avg_treatment_duration;

-- Which equipment type is used the most, and in which room type does it appear most often?
SELECT room_type, equipment_type, COUNT(*) AS sessions FROM rooms GROUP BY room_type, equipment_type ORDER BY sessions DESC;   

-- what is the average treatment duration and completion rate per room type.
SELECT r.room_type,ROUND(AVG(t.treatment_duration_min), 1) AS avg_duration, ROUND(SUM(t.status = 'Completed') * 100.0 / COUNT(*), 1) AS completion_pct FROM rooms r JOIN treatments t ON r.room_id = t.room_id GROUP BY room_type ORDER BY completion_pct ASC;   

-- 4.5 Identify Treatment and Appointment Problems

-- How many appointments were rescheduled at least twice before being completed?
SELECT a.appointment_id, COUNT(*) AS reschedule_count FROM appointments a JOIN treatments t ON a.appointment_id = t.appointment_id WHERE t.status = 'Rescheduled'  GROUP BY a.appointment_id HAVING COUNT(*) >= 2;   

-- Which problem status is the most common, and in which room type does it show up the most?
SELECT t.status, r.room_type, COUNT(*) Most_common FROM treatments t JOIN rooms r ON t.room_id = r.room_id WHERE status IN('No-Show','Rescheduled','Cancelled') GROUP BY t.status, r.room_type  ORDER BY Most_common DESC LIMIT 1;

-- What is the average waiting time for appointments that were rescheduled at least once, compared to those that were never rescheduled?
SELECT CASE WHEN status = 'Rescheduled' THEN 'Was rescheduled'
       ELSE 'Never rescheduled' END AS grp,
ROUND(AVG(waiting_time_min), 1) AS avg_wait, COUNT(*) AS cnt FROM treatments GROUP BY 1;   

-- Which service type has the highest total count of cancellations, no-shows, and reschedules combined?
SELECT a.service_type ,COUNT(*) as Highest_count FROM treatments t JOIN appointments a  ON t.appointment_id = a.appointment_id WHERE status IN('No-Show','Cancelled','Rescheduled') GROUP BY a.service_type ORDER BY Highest_count DESC LIMIT 1 ;

-- What is the average waiting time for each priority level, and does the lowest priority wait the longest?
SELECT a.priority,AVG(t.waiting_time_min) as AVG_waiting_time_min FROM treatments t JOIN appointments a ON t.appointment_id = a.appointment_id GROUP BY a.priority ORDER BY AVG_waiting_time_min;














