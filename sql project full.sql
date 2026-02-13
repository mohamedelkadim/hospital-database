create database Hospital_DB;
use Hospital_DB;
use medical_center_bd;
/*
PRIMARY KEY : 1. Not null , unique
*/
-- Patients Table
CREATE TABLE patients (
patient_id VARCHAR(50) PRIMARY KEY ,
first_name VARCHAR(100) NOT NULL,
last_name VARCHAR(100) NOT NULL,
date_of_birth DATE NOT NULL, -- '2025 - 8 - 24'
gender VARCHAR(10) check (gender in ('Male' , 'Female')),
address VARCHAR(255),
phone VARCHAR(20) unique,
email VARCHAR(100) unique,
emergency_contact VARCHAR(100),
blood_type VARCHAR(5),
allergies VARCHAR(255)
);

-- Departments Table
CREATE TABLE departments (
department_id VARCHAR(50) PRIMARY KEY,
name VARCHAR(100) NOT NULL,
location VARCHAR(100),
phone VARCHAR(20)
);
-- Medicines Table
CREATE TABLE medicines (
medicines_id VARCHAR(50) PRIMARY KEY,
name VARCHAR(100) NOT NULL,
description TEXT,
stock_quantity INT DEFAULT 0,
unit_price DECIMAL(10,2), 
expiry_date DATE
);
-- Lab Tests Table
CREATE TABLE lab_tests (
lab_tests_id VARCHAR(50) PRIMARY KEY,
name VARCHAR(100) NOT NULL,
description TEXT,
cost DECIMAL(10,2) check (cost > 50)
);
-- Doctors Table
CREATE TABLE doctors (
doctor_id VARCHAR(50) PRIMARY KEY,
department_id VARCHAR(50),
first_name VARCHAR(100) NOT NULL,
last_name VARCHAR(100) NOT NULL,
specialization VARCHAR(100),
phone VARCHAR(20),
email VARCHAR(100),
FOREIGN KEY (department_id) 
REFERENCES 
departments(department_id)
);

-- Appointments Table
CREATE TABLE appointments (
appointments_id VARCHAR(50) PRIMARY KEY,

appointment_date DATE NOT NULL,
appointment_time TIME NOT NULL,
status VARCHAR(50),
reason VARCHAR(255),
notes TEXT,
department_id VARCHAR(50),
doctor_id VARCHAR(50),
patient_id VARCHAR(50),
FOREIGN KEY (patient_id) REFERENCES patients(patient_id),
FOREIGN KEY (department_id) REFERENCES departments(department_id),
FOREIGN KEY (doctor_id) REFERENCES doctors(doctor_id)
);

CREATE TABLE medical_records (
medical_records_id VARCHAR(50) PRIMARY KEY,
patient_id VARCHAR(50),
appointment_id VARCHAR(50),
diagnosis TEXT,
treatment TEXT,
record_date DATE,
notes TEXT,
doctor_id VARCHAR(50),
FOREIGN KEY (patient_id) REFERENCES patients(patient_id),
FOREIGN KEY (appointment_id) REFERENCES appointments(appointments_id),
FOREIGN KEY (doctor_id) REFERENCES doctors(doctor_id)
);

-- Prescriptions Table
CREATE TABLE prescriptions (
prescriptions_id VARCHAR(50) PRIMARY KEY,
patient_id VARCHAR(50),
medical_record_id VARCHAR(50),
prescription_date DATE,
notes TEXT,
doctor_id VARCHAR(50),
FOREIGN KEY (patient_id) REFERENCES patients(patient_id),
FOREIGN KEY (medical_record_id) REFERENCES medical_records(medical_records_id),
FOREIGN KEY (doctor_id) REFERENCES doctors(doctor_id)
);


-- Prescription_Medicines Table
CREATE TABLE prescription_medicines (

prescription_medicines_id VARCHAR(50) PRIMARY KEY,
prescription_id VARCHAR(50),
medicine_id VARCHAR(50),
dosage VARCHAR(100),
frequency VARCHAR(100),
duration VARCHAR(100),
FOREIGN KEY (prescription_id) REFERENCES prescriptions(prescriptions_id),
FOREIGN KEY (medicine_id) REFERENCES medicines(medicines_id)
);

-- Lab Results Table
CREATE TABLE lab_results (
lab_results_id VARCHAR(50) PRIMARY KEY,
patient_id VARCHAR(50),
appointment_id VARCHAR(50),
lab_test_id VARCHAR(50),
result TEXT,
result_date DATE,
notes TEXT,
FOREIGN KEY (patient_id) REFERENCES patients(patient_id),
FOREIGN KEY (appointment_id) REFERENCES appointments(appointments_id),
FOREIGN KEY (lab_test_id) REFERENCES lab_tests(lab_tests_id)
);
-- Bills Table
CREATE TABLE bills (
bills_id VARCHAR(50) PRIMARY KEY ,
total_amount DECIMAL(10,2) NOT NULL,
paid_amount DECIMAL(10,2) DEFAULT 0,
payment_status VARCHAR(50),
billing_date DATE,
payment_method VARCHAR(50),
patient_id VARCHAR(50),
appointment_id VARCHAR(50),
FOREIGN KEY (patient_id) REFERENCES patients(patient_id),
FOREIGN KEY (appointment_id) REFERENCES appointments(appointments_id)
);






-------

USE medical_center_bd;

-- DEPARTMENTS
INSERT INTO departments (department_id, name, location, phone) VALUES
('DEPT001','Cardiology','Floor 1, Wing A','555-1001'),
('DEPT002','Neurology','Floor 1, Wing B','555-1002'),
('DEPT003','Pediatrics','Floor 2, Wing A','555-1003'),
('DEPT004','Orthopedics','Floor 2, Wing B','555-1004'),
('DEPT005','Oncology','Floor 3, Wing A','555-1005'),
('DEPT006','Emergency','Ground Floor','555-1006'),
('DEPT007','Surgery','Floor 3, Wing B','555-1007'),
('DEPT008','Radiology','Basement Floor','555-1008'),
('DEPT009','Psychiatry','Floor 4, Wing A','555-1009'),
('DEPT010','Dermatology','Floor 4, Wing B','555-1010');

-- DOCTORS
INSERT INTO doctors (doctors_id, department_id, first_name, last_name, specialization, phone, email) VALUES
('DOC001','DEPT001','John','Smith','Cardiologist','555-2001','john.smith@hospital.com'),
('DOC002','DEPT001','Sarah','Johnson','Cardiologist','555-2002','sarah.johnson@hospital.com'),
('DOC003','DEPT002','Michael','Brown','Neurologist','555-2003','michael.brown@hospital.com'),
('DOC004','DEPT002','Emily','Davis','Neurosurgeon','555-2004','emily.davis@hospital.com'),
('DOC005','DEPT003','Robert','Wilson','Pediatrician','555-2005','robert.wilson@hospital.com'),
('DOC006','DEPT003','Jennifer','Taylor','Pediatric Specialist','555-2006','jennifer.taylor@hospital.com'),
('DOC007','DEPT004','David','Anderson','Orthopedic Surgeon','555-2007','david.anderson@hospital.com'),
('DOC008','DEPT004','Lisa','Thomas','Orthopedic Specialist','555-2008','lisa.thomas@hospital.com'),
('DOC009','DEPT005','James','Jackson','Oncologist','555-2009','james.jackson@hospital.com'),
('DOC010','DEPT005','Patricia','White','Radiation Oncologist','555-2010','patricia.white@hospital.com'),
('DOC011','DEPT006','Daniel','Harris','Emergency Physician','555-2011','daniel.harris@hospital.com'),
('DOC012','DEPT006','Susan','Martin','ER Specialist','555-2012','susan.martin@hospital.com'),
('DOC013','DEPT007','Paul','Thompson','General Surgeon','555-2013','paul.thompson@hospital.com'),
('DOC014','DEPT007','Karen','Garcia','Surgical Specialist','555-2014','karen.garcia@hospital.com'),
('DOC015','DEPT008','Mark','Martinez','Radiologist','555-2015','mark.martinez@hospital.com'),
('DOC016','DEPT008','Nancy','Robinson','MRI Specialist','555-2016','nancy.robinson@hospital.com'),
('DOC017','DEPT009','Steven','Clark','Psychiatrist','555-2017','steven.clark@hospital.com'),
('DOC018','DEPT009','Betty','Rodriguez','Clinical Psychologist','555-2018','betty.rodriguez@hospital.com'),
('DOC019','DEPT010','Andrew','Lewis','Dermatologist','555-2019','andrew.lewis@hospital.com'),
('DOC020','DEPT010','Jessica','Lee','Cosmetic Dermatologist','555-2020','jessica.lee@hospital.com');

 
-- PATIENTS (first 30)
INSERT INTO patient (patient_id, first_name, last_name, date_of_birth, gendar, adress, phone, email, emergancy_contact, blood_type, allergies) VALUES
('PAT001','John','Doe','1985-03-15','Male','123 Main St, Cityville','555-3001','john.doe@email.com','Jane Doe-555-0001','A+','Penicillin'),
('PAT002','Jane','Smith','1990-07-22','Female','456 Oak Ave, Townsville','555-3002','jane.smith@email.com','John Smith-555-0002','O-','None'),
('PAT003','Michael','Johnson','1978-11-30','Male','789 Pine Rd, Villageton','555-3003','michael.j@email.com','Sarah Johnson-555-0003','B+','Shellfish'),
('PAT004','Emily','Williams','1995-05-14','Female','321 Elm St, Hamletville','555-3004','emily.w@email.com','David Williams-555-0004','AB+','Peanuts'),
('PAT005','David','Brown','1982-09-08','Male','654 Maple Dr, Boroughburg','555-3005','david.b@email.com','Lisa Brown-555-0005','O+','Dust'),
('PAT006','Sarah','Jones','1988-12-25','Female','987 Cedar Ln, Municipality','555-3006','sarah.j@email.com','Mike Jones-555-0006','A-','Latex'),
('PAT007','Robert','Garcia','1975-06-18','Male','159 Birch St, Settlement','555-3007','robert.g@email.com','Maria Garcia-555-0007','B-','Aspirin'),
('PAT008','Lisa','Miller','1992-02-11','Female','753 Walnut Ave, District','555-3008','lisa.m@email.com','Chris Miller-555-0008','O+','None'),
('PAT009','Christopher','Davis','1980-08-03','Male','426 Spruce Rd, Precinct','555-3009','chris.d@email.com','Amy Davis-555-0009','A+','Bee Stings'),
('PAT010','Amanda','Rodriguez','1998-04-27','Female','864 Fir St, Township','555-3010','amanda.r@email.com','Carlos Rodriguez-555-0010','AB-','Soy'),
('PAT011','James','Martinez','1972-10-19','Male','297 Willow Ln, Borough','555-3011','james.m@email.com','Elena Martinez-555-0011','O-','None'),
('PAT012','Jennifer','Hernandez','1987-01-23','Female','531 Poplar Dr, Village','555-3012','jennifer.h@email.com','Miguel Hernandez-555-0012','B+','Eggs'),
('PAT013','Matthew','Lopez','1993-07-07','Male','963 Magnolia Ave, City','555-3013','matthew.l@email.com','Sofia Lopez-555-0013','A-','Pollen'),
('PAT014','Jessica','Gonzalez','1984-03-31','Female','741 Oakwood St, Town','555-3014','jessica.g@email.com','Juan Gonzalez-555-0014','O+','None'),
('PAT015','Daniel','Wilson','1979-11-12','Male','852 Pinecrest Rd, Hamlet','555-3015','daniel.w@email.com','Karen Wilson-555-0015','AB+','Milk'),
('PAT016','Michelle','Anderson','1996-05-05','Female','369 Elmwood Dr, Borough','555-3016','michelle.a@email.com','Thomas Anderson-555-0016','B-','None'),
('PAT017','Andrew','Thomas','1983-09-28','Male','147 Maplewood Ave, District','555-3017','andrew.t@email.com','Nancy Thomas-555-0017','A+','Sulfa Drugs'),
('PAT018','Elizabeth','Taylor','1991-02-14','Female','258 Cedarhurst Ln, Precinct','555-3018','elizabeth.t@email.com','Richard Taylor-555-0018','O-','None'),
('PAT019','Joshua','Moore','1976-08-09','Male','639 Birchwood St, Township','555-3019','joshua.m@email.com','Susan Moore-555-0019','B+','Cat Dander'),
('PAT020','Megan','Jackson','1994-04-02','Female','951 Walnutwood Ave, Settlement','555-3020','megan.j@email.com','Brian Jackson-555-0020','A-','None'),
('PAT021','Kevin','Martin','1981-10-26','Male','762 Sprucewood Rd, Municipality','555-3021','kevin.m@email.com','Lisa Martin-555-0021','O+','Shellfish'),
('PAT022','Stephanie','Lee','1997-06-19','Female','384 Firwood St, Village','555-3022','stephanie.l@email.com','Andrew Lee-555-0022','AB-','None'),
('PAT023','Brian','Perez','1974-12-13','Male','573 Willowwood Ln, City','555-3023','brian.p@email.com','Maria Perez-555-0023','B-','Penicillin'),
('PAT024','Nicole','Thompson','1989-08-06','Female','192 Poplarwood Dr, Town','555-3024','nicole.t@email.com','Mark Thompson-555-0024','A+','None'),
('PAT025','Jonathan','White','1995-03-30','Male','819 Magnoliawood Ave, Hamlet','555-3025','jonathan.w@email.com','Sarah White-555-0025','O-','Peanuts'),
('PAT026','Rebecca','Harris','1980-11-22','Female','456 Oakwood St, Borough','555-3026','rebecca.h@email.com','Michael Harris-555-0026','B+','None'),
('PAT027','Justin','Clark','1977-07-15','Male','273 Pinecrestwood Rd, District','555-3027','justin.c@email.com','Jennifer Clark-555-0027','A-','Dust Mites'),
('PAT028','Samantha','Lewis','1993-02-08','Female','634 Elmwood Dr, Precinct','555-3028','samantha.l@email.com','David Lewis-555-0028','O+','None'),
('PAT029','Nicholas','Robinson','1988-09-01','Male','927 Maplewood Ave, Township','555-3029','nicholas.r@email.com','Amy Robinson-555-0029','AB+','Soy'),
('PAT030','Christina','Walker','1973-04-25','Female','518 Cedarhurst Ln, Settlement','555-3030','christina.w@email.com','Robert Walker-555-0030','B-','None');

-- PATIENTS (additional 20)
INSERT INTO patient (patient_id, first_name, last_name, date_of_birth, gendar, adress, phone, email, emergancy_contact, blood_type, allergies) VALUES
('PAT031','Mohammed','Al-Fayed','1980-03-15','Male','123 King Fahd Road, Riyadh','966-500-1001','m.alfayed@email.com','Fatima Al-Fayed-966-500-0001','O+','None'),
('PAT032','Fatima','Khan','1992-07-22','Female','456 Corniche Street, Dubai','971-500-1002','f.khan@email.com','Ali Khan-971-500-0002','A-','Penicillin'),
('PAT033','Ahmed','Hassan','1975-11-30','Male','789 Sheikh Zayed Road, Abu Dhabi','971-500-1003','a.hassan@email.com','Layla Hassan-971-500-0003','B+','Shellfish'),
('PAT034','Aisha','Abdullah','1988-05-14','Female','321 Al-Safa Street, Jeddah','966-500-1004','a.abdullah@email.com','Omar Abdullah-966-500-0004','AB+','Peanuts'),
('PAT035','Omar','Ibrahim','1983-09-08','Male','654 Al-Maktoum Road, Dubai','971-500-1005','o.ibrahim@email.com','Sarah Ibrahim-971-500-0005','O+','Dust'),
('PAT036','Layla','Mohammed','1990-12-25','Female','987 Khalifa Street, Abu Dhabi','971-500-1006','l.mohammed@email.com','Khalid Mohammed-971-500-0006','A-','Latex'),
('PAT037','Khalid','Al-Rashid','1978-06-18','Male','159 Al-Murabba District, Riyadh','966-500-1007','k.alrashid@email.com','Noura Al-Rashid-966-500-0007','B-','Aspirin'),
('PAT038','Noura','Salem','1995-02-11','Female','753 Diplomatic Area, Manama','973-500-1008','n.salem@email.com','Hassan Salem-973-500-0008','O+','None'),
('PAT039','Yousef','Farah','1982-08-03','Male','426 Seef District, Manama','973-500-1009','y.farah@email.com','Mariam Farah-973-500-0009','A+','Bee Stings'),
('PAT040','Mariam','Al-Khalifa','1997-04-27','Female','864 Juffair, Manama','973-500-1010','m.alkhalifa@email.com','Tariq Al-Khalifa-973-500-0010','AB-','Soy'),
('PAT041','Tariq','Hussein','1973-10-19','Male','297 Al-Qusais, Dubai','971-500-1011','t.hussein@email.com','Rana Hussein-971-500-0011','O-','None'),
('PAT042','Rana','Mahmoud','1989-01-23','Female','531 Al-Barsha, Dubai','971-500-1012','r.mahmoud@email.com','Samir Mahmoud-971-500-0012','B+','Eggs'),
('PAT043','Samir','Naser','1994-07-07','Male','963 Al-Nakheel, Riyadh','966-500-1013','s.naser@email.com','Hala Naser-966-500-0013','A-','Pollen'),
('PAT044','Hala','Ismail','1986-03-31','Female','741 Al-Malaz, Riyadh','966-500-1014','h.ismail@email.com','Adel Ismail-966-500-0014','O+','None'),
('PAT045','Adel','Zayed','1981-11-12','Male','852 Al-Khobar, Dammam','966-500-1015','a.zayed@email.com','Nadia Zayed-966-500-0015','AB+','Milk'),
('PAT046','Nadia','Rashid','1998-05-05','Female','369 Al-Ahsa, Hofuf','966-500-1016','n.rashid@email.com','Faisal Rashid-966-500-0016','B-','None'),
('PAT047','Faisal','Malik','1985-09-28','Male','147 Al-Sadd, Doha','974-500-1017','f.malik@email.com','Leila Malik-974-500-0017','A+','Sulfa Drugs'),
('PAT048','Leila','Qasim','1993-02-14','Female','258 West Bay, Doha','974-500-1018','l.qasim@email.com','Jamal Qasim-974-500-0018','O-','None'),
('PAT049','Jamal','Abbas','1977-08-09','Male','639 Al-Rayyan, Doha','974-500-1019','j.abbas@email.com','Sana Abbas-974-500-0019','B+','Cat Dander'),
('PAT050','Sana','Jamil','1996-04-02','Female','951 Al-Wakrah, Doha','974-500-1020','s.jamil@email.com','Bassam Jamil-974-500-0020','A-','None');

-- APPOINTMENTS (correct column order)
INSERT INTO appointments
(appointments_id, appointment_date, appointment_time, status, reason, notes, department_id, doctors_id, patient_id) VALUES
('APT001','2024-01-15','09:00:00','Completed','Routine checkup','Annual physical examination','DEPT001','DOC001','PAT001'),
('APT002','2024-01-16','10:30:00','Completed','Headache','Persistent headaches for 2 weeks','DEPT002','DOC003','PAT002'),
('APT003','2024-01-17','14:00:00','Completed','Child vaccination','Routine immunization','DEPT003','DOC005','PAT003'),
('APT004','2024-01-18','11:15:00','Completed','Knee pain','Sports injury','DEPT004','DOC007','PAT004'),
('APT005','2024-01-19','15:45:00','Completed','Follow-up consultation','Post-treatment check','DEPT005','DOC009','PAT005'),
('APT006','2024-01-22','08:30:00','Completed','Emergency visit','Severe abdominal pain','DEPT006','DOC011','PAT006'),
('APT007','2024-01-23','13:20:00','Completed','Surgical consultation','Appendectomy discussion','DEPT007','DOC013','PAT007'),
('APT008','2024-01-24','16:00:00','Completed','X-ray appointment','Chest X-ray required','DEPT008','DOC015','PAT008'),
('APT009','2024-01-25','09:45:00','Completed','Therapy session','Weekly counseling','DEPT009','DOC017','PAT009'),
('APT010','2024-01-26','14:30:00','Completed','Skin rash','Allergic reaction examination','DEPT010','DOC019','PAT010'),
('APT011','2024-01-29','10:00:00','Scheduled','Cardiac follow-up','Post-surgery check','DEPT001','DOC002','PAT011'),
('APT012','2024-01-30','11:30:00','Scheduled','Neurological exam','MRI results discussion','DEPT002','DOC004','PAT012'),
('APT013','2024-01-31','15:15:00','Scheduled','Pediatric consultation','Child development assessment','DEPT003','DOC006','PAT013'),
('APT014','2024-02-01','08:45:00','Scheduled','Fracture check','Cast removal','DEPT004','DOC008','PAT014'),
('APT015','2024-02-02','13:00:00','Scheduled','Chemotherapy','Third session','DEPT005','DOC010','PAT015'),
('APT016','2024-02-05','16:30:00','Scheduled','Emergency follow-up','Post-emergency check','DEPT006','DOC012','PAT016'),
('APT017','2024-02-06','09:20:00','Scheduled','Pre-surgery prep','Surgery preparation','DEPT007','DOC014','PAT017'),
('APT018','2024-02-07','14:45:00','Scheduled','CT Scan','Abdominal CT scan','DEPT008','DOC016','PAT018'),
('APT019','2024-02-08','10:15:00','Scheduled','Psychological evaluation','Initial assessment','DEPT009','DOC018','PAT019'),
('APT020','2024-02-09','15:30:00','Scheduled','Acne treatment','Follow-up on medication','DEPT010','DOC020','PAT020'),
('APT021','2024-02-12','09:30:00','Scheduled','Cardiac screening','Family history of heart disease','DEPT001','DOC001','PAT031'),
('APT022','2024-02-13','11:00:00','Scheduled','Migraine treatment','Chronic migraines','DEPT002','DOC004','PAT032'),
('APT023','2024-02-14','14:30:00','Scheduled','Child wellness check','Annual pediatric exam','DEPT003','DOC006','PAT033'),
('APT024','2024-02-15','10:45:00','Scheduled','Sports physical','School sports requirement','DEPT004','DOC008','PAT034'),
('APT025','2024-02-16','16:15:00','Scheduled','Oncology follow-up','Post-treatment monitoring','DEPT005','DOC010','PAT035'),
('APT026','2024-02-19','08:00:00','Scheduled','Emergency follow-up','Post-ER visit check','DEPT006','DOC012','PAT036'),
('APT027','2024-02-20','13:45:00','Scheduled','Surgical consultation','Gallbladder issues','DEPT007','DOC014','PAT037'),
('APT028','2024-02-21','15:30:00','Scheduled','MRI scan','Knee injury assessment','DEPT008','DOC016','PAT038'),
('APT029','2024-02-22','10:15:00','Scheduled','Therapy session','Anxiety management','DEPT009','DOC018','PAT039'),
('APT030','2024-02-23','14:00:00','Scheduled','Skin allergy test','Unknown allergen identification','DEPT010','DOC020','PAT040'),
('APT031','2024-02-26','09:00:00','Scheduled','Hypertension management','Blood pressure control','DEPT001','DOC002','PAT041'),
('APT032','2024-02-27','11:30:00','Scheduled','Neurological assessment','Tingling in extremities','DEPT002','DOC003','PAT042'),
('APT033','2024-02-28','15:00:00','Scheduled','Vaccination','Tetanus booster','DEPT003','DOC005','PAT043'),
('APT034','2024-02-29','08:45:00','Scheduled','Joint pain evaluation','Hip pain assessment','DEPT004','DOC007','PAT044'),
('APT035','2024-03-01','13:20:00','Scheduled','Cancer screening','Routine screening','DEPT005','DOC009','PAT045'),
('APT036','2024-03-04','16:45:00','Scheduled','Emergency consultation','Severe allergic reaction','DEPT006','DOC011','PAT046'),
('APT037','2024-03-05','09:15:00','Scheduled','Pre-operative assessment','Knee surgery preparation','DEPT007','DOC013','PAT047'),
('APT038','2024-03-06','14:30:00','Scheduled','X-ray examination','Wrist injury','DEPT008','DOC015','PAT048'),
('APT039','2024-03-07','10:00:00','Scheduled','Psychological evaluation','Depression screening','DEPT009','DOC017','PAT049'),
('APT040','2024-03-08','15:45:00','Scheduled','Acne treatment','Severe acne consultation','DEPT010','DOC019','PAT050');

-- MEDICAL_RECORDS
INSERT INTO medical_records (medical_records_id, patients_id, appointments_id, diagnosis, treatment, record_date, notes, doctors_id) VALUES
('MR001','PAT001','APT001','Hypertension stage 1','Prescribed medication and lifestyle changes','2024-01-15','Patient needs to monitor BP daily','DOC001'),
('MR002','PAT002','APT002','Migraine','Prescribed pain relief medication','2024-01-16','Follow up in 2 weeks if symptoms persist','DOC003'),
('MR003','PAT003','APT003','Healthy child','Routine vaccination completed','2024-01-17','Next vaccination due in 6 months','DOC005'),
('MR004','PAT004','APT004','ACL tear','Physical therapy recommended','2024-01-18','Surgery may be required if no improvement','DOC007'),
('MR005','PAT005','APT005','Cancer in remission','Continue monitoring','2024-01-19','Next scan in 3 months','DOC009'),
('MR006','PAT006','APT006','Appendicitis','Emergency appendectomy performed','2024-01-22','Patient recovering well','DOC011'),
('MR007','PAT007','APT007','Appendicitis confirmed','Surgery scheduled for next week','2024-01-23','Pre-surgery tests completed','DOC013'),
('MR008','PAT008','APT008','Pneumonia','Antibiotics prescribed','2024-01-24','Chest X-ray shows improvement','DOC015'),
('MR009','PAT009','APT009','Anxiety disorder','Therapy session conducted','2024-01-25','Patient showing progress','DOC017'),
('MR010','PAT010','APT010','Contact dermatitis','Topical cream prescribed','2024-01-26','Avoid known allergens','DOC019'),
('MR011','PAT011','APT011','Post-cardiac surgery','Healing well','2024-01-29','Continue current medication','DOC002'),
('MR012','PAT012','APT012','Normal MRI results','No neurological issues found','2024-01-30','Schedule follow-up in 6 months','DOC004'),
('MR013','PAT013','APT013','Healthy development','No concerns noted','2024-01-31','Continue regular checkups','DOC006'),
('MR014','PAT014','APT014','Fracture healed','Cast removed successfully','2024-02-01','Physical therapy recommended','DOC008'),
('MR015','PAT015','APT015','Chemotherapy session','Tolerating treatment well','2024-02-02','Next session in 3 weeks','DOC010'),
('MR016','PAT031','APT021','Elevated cholesterol','Prescribed statins and dietary changes','2024-02-12','Follow up in 3 months','DOC001'),
('MR017','PAT032','APT022','Chronic migraine','Prescribed preventive medication','2024-02-13','Track migraine frequency','DOC004'),
('MR018','PAT033','APT023','Healthy child','Routine checkup completed','2024-02-14','Next visit in 1 year','DOC006'),
('MR019','PAT034','APT024','Cleared for sports','No physical limitations','2024-02-15','Annual physical required','DOC008'),
('MR020','PAT035','APT025','Stable condition','Continue current treatment plan','2024-02-16','Next scan in 6 months','DOC010'),
('MR021','PAT036','APT026','Allergic reaction resolved','Prescribed epinephrine auto-injector','2024-02-19','Carry epinephrine at all times','DOC012'),
('MR022','PAT037','APT027','Gallstones confirmed','Surgery scheduled','2024-02-20','Pre-op tests completed','DOC014'),
('MR023','PAT038','APT028','Torn meniscus','Physical therapy recommended','2024-02-21','Consider surgery if no improvement','DOC016'),
('MR024','PAT039','APT029','Generalized anxiety disorder','Therapy and medication prescribed','2024-02-22','Weekly sessions scheduled','DOC018'),
('MR025','PAT040','APT030','Contact dermatitis','Identified nickel allergy','2024-02-23','Avoid nickel-containing products','DOC020'),
('MR026','PAT041','APT031','Hypertension controlled','Medication dosage adjusted','2024-02-26','Monitor BP twice weekly','DOC002'),
('MR027','PAT042','APT032','Carpal tunnel syndrome','Wrist splint prescribed','2024-02-27','Consider surgery if symptoms persist','DOC003'),
('MR028','PAT043','APT033','Tetanus booster administered','Vaccination up to date','2024-02-28','Next booster in 10 years','DOC005'),
('MR029','PAT044','APT034','Arthritis diagnosis','Anti-inflammatory medication prescribed','2024-02-29','Physical therapy recommended','DOC007'),
('MR030','PAT045','APT035','Clear screening','No abnormalities detected','2024-03-01','Next screening in 1 year','DOC009');

-- PRESCRIPTIONS
INSERT INTO prescriptions (prescriptions_id, patients_id, medical_records_id, prescription_date, notes,doctors_id ) VALUES
('PRES001','PAT001','MR001','2024-01-15','Take with food','DOC001'),
('PRES002','PAT002','MR002','2024-01-16','Avoid driving after taking','DOC003'),
('PRES003','PAT004','MR004','2024-01-18','Apply twice daily','DOC007'),
('PRES004','PAT005','MR005','2024-01-19','Continue as directed','DOC009'),
('PRES005','PAT006','MR006','2024-01-22','Complete full course','DOC011'),
('PRES006','PAT008','MR008','2024-01-24','Take with plenty of water','DOC015'),
('PRES007','PAT010','MR010','2024-01-26','Apply thin layer','DOC019'),
('PRES008','PAT011','MR011','2024-01-29','Do not skip doses','DOC002'),
('PRES009','PAT014','MR014','2024-02-01','As needed for pain','DOC008'),
('PRES010','PAT015','MR015','2024-02-02','Take with anti-nausea medication','DOC010'),
('PRES011','PAT031','MR016','2024-02-12','Take at bedtime','DOC001'),
('PRES012','PAT032','MR017','2024-02-13','Take with food','DOC004'),
('PRES013','PAT036','MR021','2024-02-19','Carry at all times','DOC012'),
('PRES014','PAT037','MR022','2024-02-20','Pre-operative medication','DOC014'),
('PRES015','PAT038','MR023','2024-02-21','Take as needed for pain','DOC016'),
('PRES016','PAT039','MR024','2024-02-22','Take in the morning','DOC018'),
('PRES017','PAT040','MR025','2024-02-23','Apply to affected areas','DOC020'),
('PRES018','PAT041','MR026','2024-02-26','Do not skip doses','DOC002'),
('PRES019','PAT044','MR029','2024-02-29','Take with food','DOC007'),
('PRES020','PAT045','MR030','2024-03-01','Continue as directed','DOC009');


-- MEDICINES
INSERT INTO medicines (medicines_id, name, description, stock_quantity, unit_price, expiry_data) VALUES
('MED001','Amoxicillin','Antibiotic',1000,15.99,'2025-12-31'),
('MED002','Lisinopril','Blood pressure medication',500,12.50,'2025-06-30'),
('MED003','Atorvastatin','Cholesterol medication',750,18.75,'2025-09-15'),
('MED004','Metformin','Diabetes medication',1200,9.99,'2025-11-30'),
('MED005','Ibuprofen','Pain reliever',2000,5.25,'2026-03-31'),
('MED006','Omeprazole','Acid reducer',800,14.99,'2025-08-31'),
('MED007','Amlodipine','Calcium channel blocker',600,11.25,'2025-10-15'),
('MED008','Hydrochlorothiazide','Diuretic',450,8.75,'2025-07-31'),
('MED009','Sertraline','Antidepressant',550,22.99,'2025-12-15'),
('MED010','Albuterol','Bronchodilator',300,27.50,'2025-05-31'),
('MED011','Levothyroxine','Thyroid medication',900,13.25,'2025-11-15'),
('MED012','Gabapentin','Nerve pain medication',350,19.99,'2025-09-30'),
('MED013','Metoprolol','Beta blocker',700,10.50,'2025-08-15'),
('MED014','Pantoprazole','Proton pump inhibitor',400,16.75,'2025-10-31'),
('MED015','Tramadol','Pain medication',250,24.99,'2025-07-15');

-- PRESCRIPTION_MEDICINES
INSERT INTO prescription_medicines (prescription_medicines_id, prescriptions_id, medicines_id, dosage, frequency, duration) VALUES
('PM001','PRES001','MED002','10mg','Once daily','30 days'),
('PM002','PRES002','MED005','400mg','Every 6 hours as needed','7 days'),
('PM003','PRES003','MED015','50mg','Twice daily','14 days'),
('PM004','PRES004','MED009','50mg','Once daily','90 days'),
('PM005','PRES005','MED001','500mg','Three times daily','10 days'),
('PM006','PRES006','MED006','20mg','Once daily','30 days'),
('PM007','PRES007','MED012','300mg','Three times daily','60 days'),
('PM008','PRES008','MED013','25mg','Twice daily','30 days'),
('PM009','PRES009','MED005','200mg','Every 4-6 hours as needed','14 days'),
('PM010','PRES010','MED004','500mg','Twice daily','30 days'),
('PM011','PRES011','MED003','20mg','Once daily','90 days'),
('PM012','PRES012','MED012','100mg','Twice daily','30 days'),
('PM013','PRES013','MED010','90mcg','As needed','1 year'),
('PM014','PRES014','MED001','500mg','Three times daily','7 days'),
('PM015','PRES015','MED005','400mg','Every 6 hours as needed','14 days'),
('PM016','PRES016','MED009','25mg','Once daily','60 days'),
('PM017','PRES017','MED012','300mg','Apply twice daily','30 days'),
('PM018','PRES018','MED002','5mg','Once daily','30 days'),
('PM019','PRES019','MED005','600mg','Three times daily','10 days'),
('PM020','PRES020','MED007','5mg','Once daily','90 days');

-- LAB_TESTS (LAB007 cost fixed to satisfy CHECK > 50)
INSERT INTO lab_tests (lab_tests_id, name, description, cost) VALUES
('LAB001','Complete Blood Count','Measures various components of blood',75.00),
('LAB002','Lipid Panel','Measures cholesterol and triglycerides',95.00),
('LAB003','Basic Metabolic Panel','Measures glucose, electrolytes, and kidney function',85.00),
('LAB004','Liver Function Test','Measures liver enzymes and proteins',110.00),
('LAB005','Thyroid Stimulating Hormone','Measures thyroid function',65.00),
('LAB006','Hemoglobin A1C','Measures average blood sugar levels',70.00),
('LAB007','Urinalysis','Analyzes urine for various substances',55.00),
('LAB008','COVID-19 PCR Test','Detects COVID-19 virus',125.00),
('LAB009','Vitamin D Test','Measures vitamin D levels',89.00),
('LAB010','Prothrombin Time','Measures blood clotting time',78.00);

-- LAB_RESULTS
INSERT INTO lab_results (lab_results_id, patients_id, appointments_id, lab_tests_id, result, result_date, notes) VALUES
('LRES001','PAT001','APT001','LAB001','Normal range','2024-01-15','All values within normal limits'),
('LRES002','PAT001','APT001','LAB002','Elevated LDL','2024-01-15','Recommend dietary changes'),
('LRES003','PAT002','APT002','LAB003','Normal results','2024-01-16','No abnormalities detected'),
('LRES004','PAT005','APT005','LAB004','Slightly elevated ALT','2024-01-19','Monitor liver function'),
('LRES005','PAT008','APT008','LAB005','Normal TSH levels','2024-01-24','Thyroid function normal'),
('LRES006','PAT010','APT010','LAB006','Elevated A1C','2024-01-26','Prediabetes range - recommend lifestyle changes'),
('LRES007','PAT012','APT012','LAB007','Normal urinalysis','2024-01-30','No infection detected'),
('LRES008','PAT015','APT015','LAB008','Negative','2024-02-02','No COVID-19 detected'),
('LRES009','PAT018','APT018','LAB009','Vitamin D deficient','2024-02-07','Recommend supplementation'),
('LRES010','PAT020','APT020','LAB010','Normal clotting time','2024-02-09','Within therapeutic range'),
('LRES011','PAT031','APT021','LAB002','High LDL cholesterol','2024-02-12','Recommend dietary changes and medication'),
('LRES012','PAT032','APT022','LAB003','Normal results','2024-02-13','No metabolic issues detected'),
('LRES013','PAT036','APT026','LAB007','Elevated white blood cells','2024-02-19','Consistent with allergic reaction'),
('LRES014','PAT037','APT027','LAB004','Elevated liver enzymes','2024-02-20','Related to gallstone condition'),
('LRES015','PAT038','APT028','LAB001','Normal blood count','2024-02-21','All values within normal range'),
('LRES016','PAT039','APT029','LAB009','Vitamin D deficiency','2024-02-22','Recommend supplementation'),
('LRES017','PAT040','APT030','LAB010','Normal clotting time','2024-02-23','Within normal parameters'),
('LRES018','PAT041','APT031','LAB006','Controlled blood sugar','2024-02-26','A1C within target range'),
('LRES019','PAT044','APT034','LAB008','Negative for COVID-19','2024-02-29','No infection detected'),
('LRES020','PAT045','APT035','LAB005','Normal thyroid function','2024-03-01','TSH levels optimal');

-- BILLS
INSERT INTO bills (bills_id, total_amount, paid_amount, payment_status, billing_date, payment_method, patients_id, appointments_id) VALUES
('BILL001',250.00,250.00,'Paid','2024-01-15','Credit Card','PAT001','APT001'),
('BILL002',185.00,100.00,'Partial','2024-01-16','Insurance','PAT002','APT002'),
('BILL003',120.00,120.00,'Paid','2024-01-17','Cash','PAT003','APT003'),
('BILL004',350.00,0.00,'Pending','2024-01-18',NULL,'PAT004','APT004'),
('BILL005',500.00,500.00,'Paid','2024-01-19','Debit Card','PAT005','APT005'),
('BILL006',1200.00,800.00,'Partial','2024-01-22','Insurance','PAT006','APT006'),
('BILL007',275.00,275.00,'Paid','2024-01-23','Credit Card','PAT007','APT007'),
('BILL008',195.00,195.00,'Paid','2024-01-24','Cash','PAT008','APT008'),
('BILL009',180.00,0.00,'Pending','2024-01-25',NULL,'PAT009','APT009'),
('BILL010',225.00,225.00,'Paid','2024-01-26','Debit Card','PAT010','APT010'),
('BILL011',300.00,150.00,'Partial','2024-02-12','Insurance','PAT031','APT021'),
('BILL012',225.00,225.00,'Paid','2024-02-13','Credit Card','PAT032','APT022'),
('BILL013',150.00,0.00,'Pending','2024-02-14',NULL,'PAT033','APT023'),
('BILL014',275.00,275.00,'Paid','2024-02-15','Cash','PAT034','APT024'),
('BILL015',450.00,450.00,'Paid','2024-02-16','Debit Card','PAT035','APT025'),
('BILL016',325.00,200.00,'Partial','2024-02-19','Insurance','PAT036','APT026'),
('BILL017',500.00,0.00,'Pending','2024-02-20',NULL,'PAT037','APT027'),
('BILL018',275.00,275.00,'Paid','2024-02-21','Credit Card','PAT038','APT028'),
('BILL019',200.00,200.00,'Paid','2024-02-22','Cash','PAT039','APT029'),
('BILL020',350.00,350.00,'Paid','2024-02-23','Debit Card','PAT040','APT030'),
('BILL021',225.00,225.00,'Paid','2024-02-26','Credit Card','PAT041','APT031'),
('BILL022',300.00,150.00,'Partial','2024-02-27','Insurance','PAT042','APT032'),
('BILL023',175.00,0.00,'Pending','2024-02-28',NULL,'PAT043','APT033'),
('BILL024',400.00,400.00,'Paid','2024-02-29','Debit Card','PAT044','APT034'),
('BILL025',325.00,325.00,'Paid','2024-03-01','Credit Card','PAT045','APT035');



------
create database hospital_backup_bd

drop database hospital_backup_bd

alter database [hospital_bd ]
modify name = [medical_center_bd]

select db_name  () ; 

create table #temp_patient_vitals (
temp_id int ,
patient_id varchar ,
blood_pressure varchar (10) ,
tempreture decimal (4 ,2) ,
heart_rate int 
);



create table staff (
staff_id varchar (50) primary key ,
first_name varchar (50) ,
last_name varchar (100) ,
position varchar (100) ,
department_id varchar (50) ,
hire_date date ,
salary decimal (10 ,2) 
) ;

drop table staff
-------
use medical_center_bd
 --exec sp_rename 'patient' , 'clientsss'
 --exec sp_rename 'clientsss' , 'patient'
truncate table lab_results

select * into [doctors_backup] from doctors

select * from patient
SELECT *
FROM patient
WHERE patient_id = 'PAT015';

select first_name ,last_name ,phone from patient where last_name = 'Al-Fayed';

select * from doctors where department_id =  'DEPT001';

select * from appointments where appointment_date = '2024-02-15';

select * from patient where date_of_birth between '1990-01-01' and '1995-12-31' ;

Insert into patient  VALUES ('PAT051', 'Ali','Hassan','1988-11-03', 'Male','123 Palm Street, Dubai','971-
555-0123','ali.hassan@email.com','Fatima Hassan-971-555-0124', 'B+','None');

Insert INTO medicines VALUES
 ('MED016', 'Paracetamol', 'Pain reliever', 1500, 7.50, '2026-05-31') ,
 ('MED017', 'Amoxicillin-Clavulanate', 'Antibiotic', 800, 22.75, '2025-10-15') ,
 ('MED018', 'Metoprolol Succinate', 'Beta blocker', 600, 18.25, '2025-11-30');

INSERT INTO appointments 
(appointments_id, appointment_date, appointment_time, status, reason, notes, department_id, doctors_id, patient_id)
VALUES 
('APT041', '2024-03-10', '10:30:00', 'Scheduled', 'Regular checkup', 'First visit with doctor', 'DEPT001', 'DOC003', 'PAT025');


INSERT INTO departments VALUES ('DEPT011' ,'Physical Therapy' ,'Floor 5, Wing A ', '555-1011');

INSERT INTO lab_tests VALUES ('LAB011' , 'HIV Test' ,'Test for HIV antibodies' ,150.00) ,
('LAB012' , 'Hepatitis Panel' ,'’Test for Hepatitis A, B, and C' ,225.00);

UPDATE patient SET phone = '966-500-2007' WHERE patient_id = 'PAT007' ;

UPDATE appointments SET status ='Completed' WHERE appointments_id = 'APT012' ;

UPDATE medicines SET stock_quantity = 2500 WHERE medicines_id = 'MED005' ;

UPDATE doctors SET email = 'lisa.thomas@medicalcenter.com' WHERE doctors_id = 'DOC008';

UPDATE bills SET payment_status = 'Paid' , paid_amount = 350.00 WHERE bills_id = 'BILL004' ;

-------
delete from patient where patient_id = 'PAT042'

delete from appointments where appointment_date < '2020-01-01'

delete from patient where patient_id not in (
select min(patient_id) from patient 
group by first_name , last_name , date_of_birth 
);

delete from medicines where expiry_data < cast(getdate()as date) ;

delete from lab_results where patients_id = 'PAT018';

select * from patient where gendar = 'female' and date_of_birth > '1985-01-01'

SELECT * FROM patient WHERE blood_type = 'O+' AND allergies IS NULL;

SELECT * FROM appointments WHERE doctors_id ='DOC005' AND status = 'COMPLATED';

SELECT * FROM bills WHERE total_amount = 300 AND payment_status = 'PENDING';

SELECT * FROM medicines WHERE stock_quantity > 100 AND unit_price > 15 ;


SELECT DEPARTMENT_ID , COUNT (*) AS DOCTORS_COUNT FROM doctors 
GROUP BY department_id HAVING COUNT (*) > 3;

SELECT DOCTORS_ID , COUNT(*) AS APPOINTMENT_COUNT FROM appointments
GROUP BY doctors_id HAVING COUNT(*) > 5 ;

SELECT PATIENT_ID , COUNT(*) AS PATIENT_APPOINTMENT_COUNT FROM appointments
GROUP BY patient_iD HAVING  COUNT(*)> 2 ;
SELECT * FROM medicines

SELECT medicines_id ,AVG(UNIT_PRICE) AS AVG_PRICE  FROM medicines
GROUP BY medicines_id HAVING AVG(UNIT_PRICE) > 20 ;
----
SELECT department_id, 
       AVG(duration_minutes) AS avg_duration
FROM (
    SELECT department_id,
           DATEDIFF(MINUTE, appointment_time,
                    LEAD(appointment_time) OVER (PARTITION BY department_id ORDER BY appointment_time)) AS duration_minutes
    FROM Appointments
) AS t
WHERE duration_minutes IS NOT NULL
GROUP BY department_id
HAVING AVG(duration_minutes) > 30;
----

select * from patient ORDER by last_name ASC;

SELECT * FROM appointments ORDER BY appointment_date DESC , appointment_time ASC ;

ALTER TABLE MEDICINES ALTER COLUMN NAME VARCHAR (200) ;

SELECT * FROM medicines ORDER BY unit_price DESC , name ASC ;

ALTER TABLE DOCTORS ALTER COLUMN SPECIALIZATION  VARCHAR (200);

ALTER TABLE DOCTORS ALTER COLUMN LAST_NAME  VARCHAR (200);

SELECT * FROM doctors ORDER BY specialization ASC , last_name DESC ;

SELECT * FROM bills ORDER BY total_amount DESC , billing_date ASC ;

-------
select gendar ,count(*) as patient_count from patient group by gendar ;

select status , count(*) as appointment_count from appointments group by status ;

select payment_status , count (*) as total_amount from bills group by payment_status ;

select blood_type , count(*) as patient_count from patient group by blood_type ;

select department_id ,avg(datediff(minute , appointment_time , next_time )) as avg_duration 
from(
select department_id ,
appointment_time,
lead(appointment_time ) over (partition by department_id order by appointment_time ) as next_time 
from appointments
)t
where next_time is not null 
group by department_id ;
-------
select top (5) * from patient order by date_of_birth asc ;

select top(10) * from medicines order by unit_price desc ;

select top (5) * from appointments order by appointment_time desc ;

select top (3) doctors_id ,count(appointments_id) as appointment_count 
from appointments
group by doctors_id order by count (appointments_id)desc ;

select top(5) * from bills order by total_amount desc ;

-------

select distinct specialization from doctors ;

select distinct blood_type from patient ;

select distinct status from appointments ;

select distinct payment_method from bills ;

alter table patient alter column allergies varchar (200) ;

select distinct allergies from patient ;

select * from patient 
order by date_of_birth desc 
offset 0 rows fetch next 10 rows only ;

select * from appointments 
order by appointment_date 
offset 10 rows fetch next 5 rows only ;

select * from medicines 
order by unit_price 
offset 0 rows fetch next 3 rows only ;

select * from bills 
order by total_amount 
offset 0 rows fetch next 5 rows only ;

select * from doctors 
order by last_name asc
offset 0 rows fetch next 10 rows only ;

------
select first_name+' ' +last_name as [full_name] from patient ;

select appointment_date as[visit_date ] , appointment_time as[visit_time]
from appointments;

select first_name+' '+last_name as [physian_name ] ,specialization as specialty
from doctors;

select total_amount as[total_charge] ,paid_amount as [amunt_paid ]
from bills;

select name as [medicine_name ] , unit_price as [price_per_unit ]
from medicines;

-----
select * from patient where gendar = 'female' and blood_type = 'A+' and allergies is null ;

alter table appointments alter column appointment_date varchar (200);

select * from appointments where department_id= 'DEPT001' and status = 'completed' and appointment_date >= '2024-01-01'
and appointment_date < '2024-02-01' ;

select * from bills 
where total_amount > 500 and payment_status = 'pending' and billing_date >= DATEADD( day ,-30 ,cast (getDATE () AS DATE )) ;


SELECT * FROM doctors WHERE department_id = 'DEPT007' AND last_name LIKE 'S%' AND specialization LIKE 'SERGEON' ;

SELECT * FROM patient WHERE date_of_birth BETWEEN '1980-01-01' AND '1990-12-31' AND allergies IS NULL AND blood_type LIKE 'O%' ;

--------
SELECT PATIENT_ID , FIRST_NAME , LAST_NAME , BLOOD_TYPE FROM PATIENT
WHERE blood_type = 'O+' OR blood_type = 'O-' ;

select * from appointments where department_id = 'DEPT001' or department_id ='DEPT002' ;

select * from bills where payment_status = 'paid' or payment_status = 'partial';

select * from doctors where specialization ='Cardiologist' or specialization = 'Neurologist' ;

select * from patient where allergies = 'Penicillin' or allergies = 'Aspirin';

------
select * from patient where gendar <> 'male' ;

select * from appointments where status <> 'completed' ;

select * from bills where paid_amount < total_amount ;

select * from medicines where expiry_data > GETDATE();

select * from doctors where department_id <> 'DEPT007' ;

-----
select * from patient where last_name like 'al%' ;

select * from doctors where first_name like '%a' ;

select * from medicines where name like '%cin%';

select * from departments where location like '%floor1%';

select * from patient where email like '%gmail.com';

alter table patient alter column adress varchar (200) ;
select * from patient where adress in ('Riyadh' ,'dubai' , 'doha' ) ;

select * from doctors where specialization in ('Cardiologist', 'Neurologist', 'Pediatrician');

select * from appointments where status in ('Scheduled', 'Completed', 'Cancelled');

select * from medicines where unit_price between 10 and 50 ;
alter table bills alter column payment_method varchar (200) ;

select * from bills where payment_method in ('Credit Card', 'Debit Card', 'Cash');

select * from patient where adress not like '%Riyadh%' ;

select * from doctors where department_id != 'DEPT001' ;

select * from appointments where month (appointment_date) != month(getdate()) 
or  year(appointment_date) != year(getdate());

select * from medicines where unit_price not between 10 and 50 ;

select * from bills where payment_method != 'insurance' ;

------
select * from patient where emergancy_contact is null ;

select * from appointments where doctors_id is null ;

select * from bills where payment_method is null ;

select * from medical_records where diagnosis is null ;

select * from patient where allergies is null ;

-----
select first_name from patient 
union all
select first_name from doctors ;

select last_name from patient
union all 
select last_name from doctors ;

select patient_id from patient
except 
select patient_id from appointments ;

select patient_id as person_id , first_name , last_name ,'patient' as person_type from patient
union 
select doctors_id as person_id ,first_name ,last_name , 'doctor' as person_type from doctors ;

select medicines_id from medicines 
except 
select medicines_id from prescription_medicines; 

select * from appointments where appointment_date between '2024-03-01' and '2024-03-07' ;

select * from patient where date_of_birth between '1980-01-01' and '1990-01-01' ;

select * from bills where billing_date between '2024-02-01' and '2024-02-29' 
and total_amount between 200 and 500 ;

select * from medicines where unit_price between 10 and 25 ;

select * from lab_tests where cost between 50 and 100 ;

select * from patient where date_of_birth < all (
select date_of_birth from patient where adress = 'dubai'
);

SELECT doctors_id, COUNT(*) AS appointment_count
FROM Appointments
GROUP BY doctors_id
HAVING COUNT(*) > (
    SELECT MAX(appt_count)
    FROM (
        SELECT COUNT(*) AS appt_count
        FROM Appointments
        JOIN Doctors ON Appointments.doctors_id = Doctors.doctors_id
        WHERE Doctors.department_id = 'DEPT002'
        GROUP BY Appointments.doctors_id
    ) AS sub
);

alter table medicines alter column description varchar (200) ;
select * from medicines where  unit_price > all (select unit_price from medicines where description ='Pain Reliever'
);

select * from bills where total_amount > all (select total_amount from bills where payment_method = 'Insurance' 
);

SELECT appointments_id, appointment_date, appointment_time
FROM Appointments
WHERE appointment_time < ALL (
    SELECT appointment_time
    FROM Appointments
    WHERE patient_id = 'PAT001'
);

select * from doctors  where EXISTS  (select 1 from appointments where appointments.doctors_id = doctors.doctors_id and  status = 'Completed') ;

select * from patient where exists (
select 1 from bills where bills.patients_id = patient.patient_id and bills.payment_status ='Unpaid') ;

select * from medicines m where exists (
select 1 from prescriptions pr where pr.medical_records_id = m.medicines_id );

select * from departments d where not exists (
select 1 from doctors doc where doc.department_id = d.department_id);

select * from patient p where not exists (
select 1 from appointments app where p.patient_id = app.patient_id);

-------
select count(*) as male_count from patient where gendar = 'male' ;

select sum (total_amount - paid_amount ) as outstanding_balance from bills ;

select min(unit_price) as sheapest_medicine from medicines ;

select max(total_amount) as highest_bill_amount from bills ;

select AVG(cost) as average_cost_of_lab_test from lab_tests;

------
select * from appointments  a inner join patient p on p.patient_id = a.patient_id
inner join doctors d on  d.doctors_id = a.doctors_id ;

select * from patient left join appointments on patient.patient_id= appointments.patient_id ;

select * from appointments a right join doctors d on a.doctors_id = d.doctors_id ;

select * from patient p 
full join appointments a on p.patient_id = a.patient_id 
full join doctors d on d.doctors_id = a.doctors_id ;

select * from appointments a
inner join patient p on a.patient_id = p.patient_id 
inner join doctors d on d.doctors_id = a.doctors_id 
inner join departments dep on dep.department_id = a.department_id
inner join bills b on b.appointments_id =a.appointments_id 
where a.appointments_id ='APT005' ;

-------
select patient_id , first_name ,year(date_of_birth) as year_of_birth
from patient ;

select patient_id , first_name , DATEDIFF(year ,date_of_birth , GETDATE()) as age
from patient;

select * from appointments where DATENAME(WEEKDAY ,appointment_date) ='monday';

select bills_id ,billing_date ,dateadd( day , 30 ,billing_date ) as due_date 
from bills;

select appointments_id ,appointment_date ,DATEDIFF( day ,GETDATE() , appointment_date ) as days_untill_appointment
from appointments
where appointment_date > getdate();

-------
select patient_id ,UPPER(last_name) as upper_last_name 
from patient;

select doctors_id,concat(first_name,' ',last_name) as doctors_full_name 
from doctors;

select patient_id , blood_type ,SUBSTRING(blood_type ,1 ,3) as blood_type_prefix 
from patient;

select patient_id , LTRIM(rtrim(adress)) as cleaned_adress 
from patient;

select patient_id ,REPLACE(allergies ,'none' , 'no know allergy' ) as updated_allergy
from patient;
------
create view patient_appointments as
select p.first_name, a.appointment_date, d.last_name
from appointments a
inner join patient p on p.patient_id = a.patient_id 
inner join doctors d on d.doctors_id = a.doctors_id;

select * from patient_appointments;
select * from patient

insert into patient values('pat070', 'ahmed' , 'ali' ,'1985-02-05', 'male' , 'dubai' ,'555-3621','ahmed.ali@gmail.com', 
'555-5602' , 'a-','none');

EXEC sp_rename 'patient_appointments', 'vPatientVisits';

drop view vPatientVisits;


CREATE VIEW vDailyRevenue AS
SELECT CAST(billing_date AS DATE) AS revenue_date,
       SUM(paid_amount) AS total_revenue
FROM bills
GROUP BY CAST(billing_date AS DATE);


create view vdailyrevenue as 
select cast(billing_date as date ) as revenue_date ,
sum (paid_amount )as total_revenue 
from bills
group by CAST(billing_date as date );

-
--select d.first_name from doctors d 
--where d.salary = select(max(salary)from doctors);

select p.first_name from patient p 
where patient_id in  ( select a.patient_id from appointments a 
inner join doctors d on d.doctors_id = a.doctors_id 
where d.department_id ='DEPT001' );

select * from medicines m1 
where unit_price >(select avg(m2.unit_price ) from medicines m2 
where m2.stock_quantity = stock_quantity);

SELECT a.appointments_id,
       a.appointment_date,
       (SELECT COUNT(*) 
        FROM appointments a2 
        WHERE a2.patient_id = a.patient_id) AS total_patient_appointments
FROM appointments a;

select d.department_id 
from departments d 
where exists (
select 1 
from doctors doc 
where doc.department_id =d.department_id
and doc.specialization like '%Surgeon%'
);

select * from patient p
where not exists (
select 1 
from bills b 
where b.patients_id = p.patient_id 
and b.payment_status = 'pending' 
);

SELECT d.last_name,
       COUNT(a.appointments_id ) AS total_appointments
FROM doctors d
LEFT JOIN appointments a
       ON d.doctors_id = a.doctors_id
GROUP BY d.last_name
HAVING COUNT(a.appointments_id) > (
    SELECT AVG(doc_count)
    FROM (
        SELECT COUNT(*) AS doc_count
        FROM appointments
        GROUP BY doctors_id
    ) AS sub
);

  select distinct m.name
  from medicines m , prescription_medicines pm ,prescriptions p
  where m.medicines_id = pm.medicines_id
  and pm.prescriptions_id = p.prescriptions_id
  and p.patients_id = 'PAT001' ;


update medicines
set stock_quantity = stock_quantity +50 
where medicines_id in (
select pm.medicines_id from prescription_medicines pm 
inner join prescriptions p on pm.prescriptions_id = p.prescriptions_id
where p.prescription_date >= dateadd(month , -1 , getdate())
group by pm.medicines_id 
having count(*) > 10
);

delete from lab_tests
where lab_tests_id not in (
select distinct l.lab_results_id
from lab_results l );
---------

     backup database [medical_center_bd ]
     to disk = 'c:\Hospital DB Full.bak'
     with format ,
     init,
     name = 'hospital db full backup' ,
     skip, 
     stats = 10 ;

   
     restore database [medical_center_bd ]
     from disk = 'c:\Hospital DB Full.bak'
     with replace ,
     stats = 10 ;

     -----------------------------------------------------------------------------------------------------
   


