-------DDL File------
---------Doctor Table ----
CREATE TABLE Doctor (
Doc_id integer PRIMARY KEY,
Doc_Name varchar, 
Doc_Specialisation varchar, 
Doc_Shift Date,
Doc_Professional_Experience Integer
 );
 
----------Patient Table-----
CREATE TABLE Patient (
P_ID integer PRIMARY KEY, 
P_Name varchar, 
P_Gender varchar, 
P_Address varchar, 
P_Phone integer 
);

------Appointment Table------
CREATE TABLE Appointment (
 Apt_ID integer PRIMARY KEY ,
P_ID integer ,
Doc_id integer ,
Apt_Date Date ,
Apt_Time Time ,
Apt_Type varchar, 
Apt_Room integer ,
FOREIGN KEY (P_ID) REFERENCES Patient(P_ID),
FOREIGN KEY (Doc_id) REFERENCES Doctor(Doc_id)
);

------Prescription Table-----
CREATE TABLE Prescription (
Pres_ID integer PRIMARY KEY, 
Doc_ID integer, 
P_ID integer, 
Pres_Date Date, 
Pres_Validity Date, 
FOREIGN KEY (P_ID) REFERENCES Patient(P_ID),
FOREIGN KEY (Doc_ID) REFERENCES Doctor(Doc_ID)
);

-------Bill Table------
CREATE TABLE Bill (
Bill_Id integer PRIMARY KEY,
P_ID integer ,
Bill_Date Date,  
Bill_Amt integer, 
Bill_Status varchar, 
FOREIGN KEY (P_ID) REFERENCES Patient(P_ID));