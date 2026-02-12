USE CRISIS_AID_MANAGEMENT

-- DISASTERS
INSERT INTO DISASTER (type_disaster, location_disaster, severity, start_date_dis, end_date)
VALUES
 ('Earthquake', 'Lorca, Murcia', 'Severe', '2024-02-15', '2024-02-20')
,('Hurricane', 'Toledo, Castilla-La Mancha', 'Moderate', '2024-09-01', '2024-09-05')
,('Flood', 'Valencia, C. Valenciana', 'Critical', '2024-12-10', NULL)

-- RESOURCES
INSERT INTO RESOURCES (name_resources, type_resources, stock_level, measurement_unit)
VALUES
 ('Bandages', 'Medical Supplies', 50.25, 'kgs')
,('Canned Food', 'Food and Beverages', 1500.00, 'units')
,('Water Bottles', 'Food and Beverages', 5000.00, 'units')
,('Medical Masks', 'Medical Supplies', 3000.00, 'units')
,('Blankets', 'Clothing and Textiles', 205.70, 'kgs')

-- TRAINING COURSES 
INSERT INTO TRAINING_COURSE (name_course, start_date_course, end_date, type_course, hours_per_day)
VALUES
 ('Basic First Aid', '2024-02-10', '2024-02-10', 'First Aid', 6)
,('Disaster Leadership', '2024-03-01', '2024-03-01', 'Leadership', 8)

-- VOLUNTEERS
INSERT INTO VOLUNTEER (name_volunteer, email, skills, driving_license)
VALUES
 ('Alice Johnson', 'alice@mail.com', 'First Aid', 1)
,('Brian Carter', 'brian@mail.com', 'Rescue', 0)
,('Catherine Lee', 'cathy@mail.com', 'Nav', 1)
,('David Miller', 'david@mail.com', 'Medical', 1)
,('Emma Davis', 'emma@mail.com', 'Logistics', 0)
,('Franklin Moore', 'frank@mail.com', 'Heavy Op', 1)

-- ASIGNACIÓN DE CURSOS 
INSERT INTO VOLUN_COURSE (num_volunteer, num_course)
VALUES 
 (1,1), (1,2) 
,(2,2)         
,(3,1)        
,(4,2)         
,(5,1)         
,(6,1), (6,2) 

-- BENEFICIARIES
INSERT INTO BENEFICIARY (name_beneficiary, date_of_birth, phone_number, id_disaster)
VALUES
 ('Carlos García', '1989-04-18', '679543210', 3)
,('Emily Davis', '1978-11-03', '645789123', 3)
,('John Smith', '1985-01-03', '612345678', 1)
,('María López', '1992-07-22', '678901234', 1)
,('Michael Johnson', '1990-06-10', '601234567', 2)

-- DISTRIBUTIONS
INSERT INTO DISTR_BENEF_RESOUR (id_resources, id_beneficiary, distribution_date, quantity_distributed)
VALUES
 (2, 1, '2024-12-11', 25.00) 
,(2, 2, '2024-12-11', 15.00) 
,(5, 2, '2024-12-12', 2.00)  
,(2, 3, '2024-02-16', 25.00) 
,(2, 4, '2024-02-16', 10.00) 
,(5, 4, '2024-02-17', 2.00)  
,(2, 5, '2024-09-02', 15.00) 