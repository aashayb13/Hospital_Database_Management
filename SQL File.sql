--Query 1
SELECT * FROM Doctor;

SELECT * FROM Patient; 

SELECT * FROM Appointment; 

SELECT * FROM Prescription. 

SELECT * FROM Bill;

--Query 2
--2.1
SELECT 
Doc_id,
Doc_Name, 
Doc_Specialisation,
Doc_Shift,
Doc_Professional_Experience  
FROM Doctor;

--2.2
SELECT 
p_id,
p_name, 
p_gender, 
p_address,  
p_phon  
FROM Patient;

--2.3
SELECT 
Apt_ID,
Doc_id, 
P_ID, 
Apt_Date, 
Apt_Time, 
Apt_Type 
FROM Appointment;

--2.4
SELECT 
Pres_ID,
Doc_ID, 
P_ID, 
Pres_Date, 
Pres_Validity 
FROM Prescription;

--2.5
SELECT
Bill_Id, 
P_ID, 
Bill_Date, 
Bill_Amt, 
Bill_Status 
FROM Bill;

--Query 3
CREATE VIEW HealthcareView AS
Select A.Apt_ID, 
A.Doc_id as app_Doc_ID,
A.P_ID as app_P_ID,
A.Apt_Date,
A.Apt_Time,
A.Apt_Type,
A.Apt_Room ,
D.Doc_id,
D.Doc_Name,
D.Doc_Specialisation, 
D.Doc_Shift,
D.Doc_Professional_Experience,
P.P_ID as patient_ID,
P.P_Name, 
P.P_Gender,
P.P_Address,
P.P_Phone ,
PR.Pres_ID,
PR.Doc_ID as Prescription_DOC_ID,
PR.P_ID as prescription_patient_id,
PR.Pres_Date,
PR.Pres_Validity,
B.Bill_Id,
B.P_ID AS bill_Patient_id,
B.Bill_Date,
B.Bill_Amt,
B.Bill_Status
From Appointment A 
JOIN Doctor D on D.doc_id = A.doc_id
JOIN Patient P on P.P_ID = A.P_ID   
JOIN Prescription PR on (PR.doc_id = A.doc_id and PR.p_id = A.doc_id and PR. Pres_Date  = A. Apt_Date)
JOIN bill B on (B. P_ID = A.P_ID AND B.Bill_Date = A. Apt_Date);
SELECT * FROM HealthcareView;

--Query 4
SELECT *
FROM Bill B 
Join 
Patient P 
ON 
P.P_ID = B.P_ID;


--Query 5
SELECT
Doc_id,
Doc_Name,
Doc_Specialisation,
Doc_Shift,
Doc_Professional_Experience
FROM Doctor
ORDER BY Doc_Name ASC;


--Query 6
Select 
A.Apt_ID,
D.Doc_id,
P.P_ID,
A.Apt_Date,
A.Apt_Time
FROM Appointment A
Join doctor D on D.DOC_id = A.doc_id
Join Patient P on P.P_ID = A.P_ID
LIMIT 10;	


--Query 7
SELECT DISTINCT * 
FROM Prescription P
JOIN Doctor D ON D.Doc_ID = P.Doc_ID 
Join Patient PA on PA.P_ID = P.P_ID


--Query 8
SELECT 
D.Doc_ID, 
D.Doc_Name, 
Count(D.Doc_ID)
FROM Doctor D
INNER JOIN Patient P ON P.P_ID = D.Doc_ID
GROUP BY D.Doc_ID, D.Doc_Name
HAVING D.Doc_ID>0
ORDER by D.Doc_ID;


--Query 9
Select *
From Doctor 
Where Doc_ID IN (1,3,5,7,9,11);


--Query 10
Select LENGTH(Doc_ID)
From Doctor;


--Query 11
Select * from bill ;
BEGIN TRANSACTION;
Delete from bill  where bill_ID = 1; 
Rollback; 
Select * from bill;


--Query 12
SELECT * FROM doctor;

-- Start a transaction
BEGIN TRANSACTION;

-- Update the row with Doc_id = 1
UPDATE doctor
SET Doc_Name = 'Dr. Avnish',
    Doc_Specialisation = 'Ophthalmologist',
    Doc_Shift = '2023-11-03', -- Assuming 'Doc_Shift' is a date column
    Doc_Professional_Experience = 3
WHERE Doc_id = 1;

-- Display the state of the "doctor" table after the update
SELECT * FROM doctor;

-- Rollback the changes made during the transaction
ROLLBACK;


--Advanced Query
--1)
--Defining a CTE by the name Patient_List
WITH Patient_list as  
( SELECT 
DISTINCT P.P_ID, 
P.P_Name,
P.P_Gender, 
P.P_Address, 
P.P_Phone 
FROM
appointment A 
JOIN 
patient P 
ON 
P.P_ID = A.P_ID  
JOIN 
doctor D 
ON 
D.Doc_ID = A.Doc_ID  
WHERE Doc_name LIKE 'Dr. M%') 

---List of patient's having appointments with Doctor having first name starting with M

SELECT 
DISTINCT 
b.P_ID, 
PL.P_Name, 
PL.P_Gender, 
PL.P_Address, 
PL.P_Phone, 
SUM( CASE WHEN b.bill_status = 'Paid' 
THEN 
b.Bill_Amt else 0 end ) AS total_paid_amount, 
SUM(CASE WHEN b.bill_status = 'Unpaid' then b.Bill_Amt else 0 end) 
AS total_unpaid_amount 
FROM bill b  
JOIN Patient_list PL ON PL.P_ID = B.P_ID  
GROUP BY 
b.P_ID, 
PL.P_Name, 
PL.P_Gender, 
PL.P_Address, 
PL.P_Phone;


--2)
WITH patient_total_bill as 
(SELECT  
DISTINCT P_ID,  
SUM(bill_amount) as total_bill , 
FROM bill  
Group by P_ID ), 
max_min_bill as  
(SELECT  
MAX(total_bill) as max_bill, 
MIN(total_bill) as min_bill 
FROM patient_total_bill), 
Patient_list AS  
(SELECT 
DISTINCT P_ID 
FROM patient_total__bill  
WHERE (total_bill = (select max_bill from_max_min_bill)  
OR  
(total_bill = (select min_bill from_max_min_bill))) 
SELECT
DISTINCT D.Doc_id,  
D.Doc_Name,  
D.Doc_Specialisation,  
D.Doc_Shift,  
D.Doc_Professional_Experience 
FROM Appointment A  
JOIN Doctor D on D.doc_id = A.doc_id  
WHERE A.P_ID in (select distinct P_ID from patient_list); 
