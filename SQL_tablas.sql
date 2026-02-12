use CRISIS_AID_MANAGEMENT

create table DISASTER (
id_disaster INT IDENTITY PRIMARY KEY
,type_disaster VARCHAR(10) NOT NULL 
,location_disaster VARCHAR(100) NOT NULL
,severity VARCHAR(8) NOT NULL
,start_date_dis DATE NOT NULL
,end_date DATE 
,CHECK (type_disaster IN ('Earthquake', 'Flood', 'Hurricane', 'Wildfire', 'Tsunami', 'Other'))
,CHECK (severity IN ('Low', 'Moderate', 'Severe', 'Critical'))
)

create table BENEFICIARY(
id_beneficiary INT IDENTITY PRIMARY KEY
,name_beneficiary VARCHAR(100) NOT NULL
,date_of_birth DATE NOT NULL
,phone_number CHAR(9) NOT NULL
,id_disaster INT NOT NULL
,FOREIGN KEY (id_disaster) REFERENCES DISASTER (id_disaster)
,CHECK (phone_number like '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]')
)

create table RESOURCES (
id_resources INT IDENTITY PRIMARY KEY
,name_resources VARCHAR(100) NOT NULL
,type_resources VARCHAR(50) NOT NULL
,stock_level DECIMAL(10,2) NOT NULL 
,measurement_unit VARCHAR(5) NOT NULL
,CHECK (stock_level >= 0)
,CHECK (measurement_unit IN ('kgs', 'units'))
)

create table DISTR_BENEF_RESOUR (
id_resources INT NOT NULL
,id_beneficiary INT NOT NULL
,distribution_date DATE NOT NULL
,quantity_distributed DECIMAL(10,2) NOT NULL
,PRIMARY KEY (id_resources, id_beneficiary, distribution_date)
,FOREIGN KEY (id_resources) REFERENCES RESOURCES (id_resources)
,FOREIGN KEY (id_beneficiary) REFERENCES BENEFICIARY (id_beneficiary)
,CHECK (quantity_distributed >= 0)
)

create table RELIEF_CENTER (
id_center INT IDENTITY PRIMARY KEY
,name_center VARCHAR(100) NOT NULL
,location_center VARCHAR(100) NOT NULL
,year_established CHAR (4) NOT NULL 
,CHECK (year_established like '[1-2][0-9][0-9][0-9]')
)

create table DONAT_RES_CENT (
id_center INT NOT NULL
,id_resources INT NOT NULL
,donation_date DATE NOT NULL
,quantity_donated DECIMAL(10,2) NOT NULL 
,PRIMARY KEY (id_center, id_resources, donation_date)
,FOREIGN KEY (id_center) REFERENCES RELIEF_CENTER(id_center)
,FOREIGN KEY (id_resources) REFERENCES RESOURCES(id_resources)
,CHECK (quantity_donated >= 0)
)

create table TEAM (
id_team INT IDENTITY PRIMARY KEY
,name_team VARCHAR(100) NOT NULL
,specialization VARCHAR(17) NOT NULL 
,num_volunteer_in_charge INT 
,CHECK (specialization IN ('Medical', 'Logistics', 'Rescue', 'Technical Support'))
)

create table PERFORM_DISAS_TEAM (
id_disaster INT NOT NULL
,id_team INT NOT NULL
,start_date_perf DATE NOT NULL
,end_date DATE 
,description VARCHAR(300) NOT NULL
,PRIMARY KEY (id_disaster, id_team, start_date_perf)
,FOREIGN KEY (id_disaster) REFERENCES DISASTER(id_disaster)
,FOREIGN KEY (id_team) REFERENCES TEAM(id_team)
)

create table VOLUNTEER (
num_volunteer INT IDENTITY PRIMARY KEY
,name_volunteer VARCHAR(100) NOT NULL
,email VARCHAR(100) NOT NULL UNIQUE
,skills VARCHAR(200) NOT NULL
,driving_license BIT NOT NULL
,id_team INT NOT NULL
,FOREIGN KEY (id_team) REFERENCES TEAM(id_team)
,CHECK (email like ('_%@_%._%'))
)

ALTER TABLE TEAM 
ADD CONSTRAINT FK_Leader FOREIGN KEY (num_volunteer_in_charge) REFERENCES VOLUNTEER(num_volunteer);

create table TRAINING_COURSE (
num_course INT IDENTITY PRIMARY KEY
,name_course VARCHAR(100) NOT NULL
,start_date_course DATE NOT NULL
,end_date DATE NOT NULL
,type_course VARCHAR(30) NOT NULL 
,hours_per_day TINYINT NOT NULL 
,CHECK (type_course IN ('First Aid', 'Safety and Survival', 'Leadership and Decision Making', 'Technical Skills'))
,CHECK (hours_per_day >= 0)
,CHECK (end_date >= start_date_course)
)

create table VOLUN_COURSE (
num_volunteer INT NOT NULL
,num_course INT NOT NULL
,PRIMARY KEY (num_volunteer, num_course)
,FOREIGN KEY (num_volunteer) REFERENCES VOLUNTEER(num_volunteer)
,FOREIGN KEY (num_course) REFERENCES TRAINING_COURSE(num_course)
)