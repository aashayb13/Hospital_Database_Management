------DML File----------
------Insertion of Data in Doctor File-----
INSERT INTO Doctor (Doc_id, Doc_Name, Doc_Specialisation, Doc_Shift, Doc_Professional_Experience) VALUES
(1, 'Dr. Smith', 'Cardiologist', '2023-11-09', 11),
(2, 'Dr. Johnson', 'Paediatrician', '2023-11-10', 12),
(3, 'Dr. Davis', 'Dermatologist', '2023-11-11', 5),
(4, 'Dr. Wilson', 'Neurologist', '2023-11-12', 6),
(5, 'Dr. Miller', 'Gastroenterologist', '2023-11-13', 3),
(6, 'Dr. Harris', 'Ophthalmologist', '2023-11-14', 7),
(7, 'Dr. Robinson', 'ENT Specialist', '2023-11-15', 8),
(8, 'Dr. Lee', 'Psychiatrist', '2023-11-16',10),
(9, 'Dr. Turner', 'Obstetrician', '2023-11-17', 4),
(10, 'Dr. Martinez', 'Orthopaedic Surgeon', '2023-11-18', 3),
(11, 'Dr. Baker', 'Urologist', '2023-11-19', 5),
(12, 'Dr. Carter', 'Rheumatologist', '2023-11-20', 7);

-------Insertion of Data into Patient Table-----
INSERT INTO Patient (P_ID, P_Name, P_Gender, P_Address, P_Phone) VALUES
(1, 'John Doe', 'Male', '123 Main St', 555-1234),
(2, 'Jane Smith', 'Female', '456 Oak St', 555-5678),
(3, 'David Johnson', 'Male', '789 Pine St', 555-9012),
(4, 'Emily Davis', 'Female', '101 Elm St', 555-3456),
(5, 'Daniel Wilson', 'Male', '202 Maple St', 555-7890),
(6, 'Olivia Miller', 'Female', '303 Birch St', 555-1234),
(7, 'William Harris', 'Male', '404 Cedar St', 555-5678),
(8, 'Sophia Robinson', 'Female', '505 Spruce St', 555-9012),
(9, 'Ethan Lee', 'Male', '606 Pine St', 555-3456),
(10, 'Ava Turner', 'Female', '707 Oak St', 555-7890),
(11, 'Mia Martinez', 'Female', '808 Maple St', 555-1234),
(12, 'Noah Baker', 'Male', '909 Elm St', 555-5678);

---------Insert Data into Appointment Table----
INSERT INTO Appointment (Apt_ID, Doc_id, P_ID, Apt_Date, Apt_Time, Apt_Type, Apt_Room) VALUES
(101, 1,1, '2023-11-09', '10:00:00', ' Cardiologist Consultation', 101),
(102, 2, 2,'2023-11-10', '11:30:00', 'Paediatrician Consultation', 102),
(103, 3, 3, '2023-11-11', '14:00:00', 'Dermatology Appointment', 103),
(104, 4,  4,'2023-11-12', '15:30:00', 'Neurology Consultation', 104),
(105, 5, 5, '2023-11-13', '17:00:00', 'Gastroenterology Appointment', 105),
(106, 6, 6,'2023-11-14', '09:30:00', 'Ophthalmology Consultation', 106),
(107, 7, 7, '2023-11-15', '13:00:00', 'ENT Appointment', 107),
(108, 8, 8, '2023-11-16', '16:30:00', 'Psychiatry Consultation', 108),
(109, 9, 9, '2023-11-17', '18:00:00', 'Obstetrics Appointment', 109),
(110, 10, 10, '2023-11-18', '10:30:00', 'Orthopaedic Consultation', 110),
(111, 11, 11, '2023-11-19', '12:00:00', 'Urology Appointment', 111),
(112, 12, 12, '2023-11-20', '14:30:00', 'Rheumatology Consultation', 112);

---------Insert Data into Prescription Table----
INSERT INTO Prescription (Pres_ID, Doc_ID, P_ID, Pres_Date, Pres_Validity) VALUES
(1, 1, 1, '2023-11-09', '2023-12-09'),
(2, 2, 2, '2023-11-10', '2023-12-10'),
(3, 3, 3, '2023-11-11', '2023-12-11'),
(4, 4, 4, '2023-11-12', '2023-12-12'),
(5, 5, 5, '2023-11-13', '2023-12-13'),
(6, 6, 6, '2023-11-14', '2023-12-14'),
(7, 7, 7, '2023-11-15', '2023-12-15'),
(8, 8, 8, '2023-11-16', '2023-12-16'),
(9, 9, 9, '2023-11-17', '2023-12-17'),
(10, 10, 10, '2023-11-18', '2023-12-18'),
(11, 11, 11, '2023-11-19', '2023-12-19'),
(12, 12, 12, '2023-11-20', '2023-12-20');

---------Insert Data into Bill Table----
INSERT INTO Bill (Bill_Id, P_ID, Bill_Date, Bill_Amt, Bill_Status) VALUES
(1, 1, '2023-11-09', 100, 'Paid'),
(2, 2, '2023-11-10', 150, 'Unpaid'),
(3, 3, '2023-11-11', 120, 'Paid'),
(4, 4, '2023-11-12', 80, 'Unpaid'),
(5, 5, '2023-11-13', 200, 'Paid'),
(6, 6, '2023-11-14', 90, 'Unpaid'),
(7, 7, '2023-11-15', 110, 'Paid'),
(8, 8, '2023-11-16', 130, 'Unpaid'),
(9, 9, '2023-11-17', 180, 'Paid'),
(10, 10, '2023-11-18', 160, 'Unpaid'),
(11, 11, '2023-11-19', 140, 'Paid'),
(12, 12, '2023-11-20', 170, 'Unpaid');

-- Create a trigger to automatically set doc_id before insert
CREATE OR REPLACE FUNCTION set_doc_id()
RETURNS TRIGGER AS $$
BEGIN
- If doc_id is not provided, set it to the next value from the sequence
    IF NEW.doc_id IS NULL THEN
        NEW.doc_id := nextval('doc_id_seq');
    END IF;
    RETURN NEW;
END;
-- Attach the trigger to the doctors table
CREATE TRIGGER set_doc_id_trigger
    BEFORE INSERT ON doctors
    FOR EACH ROW
    EXECUTE FUNCTION set_doc_id();
