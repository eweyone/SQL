-- Создание таблицы doctors
create table doctors(doctor_id INTEGER PRIMARY KEY, first_name VARCHAR(30), last_name VARCHAR(30), specialty VARCHAR(25));
-- Добавление данных в таблицу doctors
INSERT INTO doctors(doctor_id, first_name, last_name, specialty) VALUES (1, 'Nikita', 'Piatash', 'QA Engineer'),
																		(2, 'Gennadii', 'Bukin', 'Salesman'),
                                                                        (3, 'Saul', 'Goodman', 'Lawyer');
-- Создание таблицы patients
CREATE TABLE patients(patient_id INTEGER PRIMARY KEY, first_name VARCHAR(30), last_name VARCHAR(30), gender CHAR(1), birth_date DATE, 
				      city VARCHAR(30), province_id CHAR(2), allergies VARCHAR(80), height DECIMAL(3,0), weight DECIMAL(4,0));
-- Добавление данных в тублицу patients    
INSERT INTO patients(patient_id, first_name, last_name, gender, birth_date, 
                     city, province_id, allergies, height, weight) values (1, 'Denis', 'Sadovnikov', 'M', '2000-01-01', 
                                                                           'Kaliningrad', 12, 'anesthesia', 175, 90),
                                                                          (3, 'Elena', 'Bukina', 'F', '2005-09-11', 
                                                                          'Ekatirenburg', 14, 'none', 160, 45),
                                                                          (10, 'Edward', 'Cullen', 'M', '1901-06-20', 
                                                                          'Chicago', 99, 'sunshine', 188, 88),
                                                                          (99, 'Thomas', 'Shelby', 'M', '1992-05-25', 
                                                                           'Los-Santos', 77, 'none', 190, 83);
-- Создание таблицы province_names
CREATE TABLE province_names(province_id CHAR(2) PRIMARY KEY, province_name VARCHAR(30));
-- Внесение данных в тублицу province_names
INSERT INTO province_names(province_id, province_name) VALUES (1, 'Test 1'),
															  (2, 'Test 2'),
                                                              (3, 'Test 3'),
                                                              (12, 'Test 12'),
                                                              (14, 'Test 14'),
                                                              (99, 'Test 99'),
                                                              (77, 'Test 77');
-- Создание таблицы admissions
CREAte table admissions(patient_id INTEGER, admission_date DATE, discharge_date DATE, diagnosis VARCHAR(50), attending_doctor_id INTEGER,
                        FOREIGN KEY(patient_id) REFERENCES patients(patient_id), 
                        FOREIGN KEY(attending_doctor_id) REFERENCES doctors(doctor_id));
-- Заполнение таблицы admissions
INSERT INTO admissions(patient_id, admission_date, discharge_date, diagnosis, 
                       attending_doctor_id) VALUES (1, '2025-09-01', '2025-09-05', 'Test 1', 1),
                       							   (3, '2024-12-12', '2024-12-13', 'Test 2', 2),
                                                   (10, '2015-10-13', '2015-10-15', 'Test 3', 3),
                                                   (99, '2024-05-05', '2024-05-05', 'Test 4', 1),
                                                   (1, '2024-09-01', '2024-09-05', 'Test 5', 2),
                       							   (3, '2023-10-12', '2023-10-13', 'Test 6', 1),
                                                   (10, '2025-11-13', '2025-11-15', 'Test 7', 2),
                                                   (99, '2022-06-05', '2022-06-05', 'Test 8', 2),
                                                   (1, '2015-02-01', '2025-02-05', 'Test 2', 3),
                       							   (3, '2025-01-12', '2024-02-13', 'Test 8', 2),
                                                   (10, '2019-12-13', '2015-12-15', 'Test 5', 3),
                                                   (99, '2020-10-05', '2024-10-05', 'Test 3', 3);
-- Составление SQL запроса, который выведет имя, фамилию и количество посещений у каждого доктора. Все пациенты были осмотрены докторами.
SELECT patients.first_name, patients.last_name, doctors.doctor_id, doctors.first_name, doctors.last_name, 
COUNT(admissions.admission_date) as visit_count   
from patients
INNER join admissions ON patients.patient_id = admissions.patient_id
inner join doctors on admissions.attending_doctor_id = doctors.doctor_id
GROUP BY patients.first_name, patients.last_name, doctors.doctor_id, doctors.first_name, doctors.last_name
ORDER BY visit_count DESC;