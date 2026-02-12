--Querie 1
SELECT type_disaster, location_disaster, start_date_dis, DISASTER.end_date, severity,COUNT(id_team) AS Total_Teams
FROM DISASTER, PERFORM_DISAS_TEAM
WHERE DISASTER.id_disaster = PERFORM_DISAS_TEAM.id_disaster
AND DISASTER.end_date IS NOT NULL
GROUP BY type_disaster, location_disaster, severity, start_date_dis, DISASTER.end_date

--Querie 2
SELECT type_disaster, location_disaster, start_date_dis, DISASTER.end_date, severity, name_team, description, PERFORM_DISAS_TEAM.start_date_perf, PERFORM_DISAS_TEAM.end_date
FROM DISASTER, PERFORM_DISAS_TEAM, TEAM
WHERE DISASTER.id_disaster = PERFORM_DISAS_TEAM.id_disaster
AND PERFORM_DISAS_TEAM.id_team = TEAM.id_team
AND DISASTER.end_date IS NULL

--Querie 3
SELECT type_disaster, location_disaster, name_team, specialization, name_volunteer, description, PERFORM_DISAS_TEAM.start_date_perf, PERFORM_DISAS_TEAM.end_date
FROM DISASTER, PERFORM_DISAS_TEAM, TEAM, VOLUNTEER
WHERE DISASTER.id_disaster = PERFORM_DISAS_TEAM.id_disaster
AND PERFORM_DISAS_TEAM.id_team = TEAM.id_team
AND TEAM.num_volunteer_in_charge = VOLUNTEER.num_volunteer
AND DISASTER.end_date IS NOT NULL

--Querie 4
SELECT name_volunteer, email, skills, driving_license, name_team
FROM TEAM, VOLUNTEER
WHERE TEAM.id_team = VOLUNTEER.id_team

--Querie 5
SELECT name_team, specialization, name_volunteer 
FROM TEAM, VOLUNTEER
WHERE TEAM.id_team = VOLUNTEER.id_team
AND TEAM.num_volunteer_in_charge = VOLUNTEER.num_volunteer

--Querie 6
SELECT name_course, start_date_course, end_date, type_course, hours_per_day, COUNT (num_volunteer) AS [Tot Volunteer]
FROM TRAINING_COURSE, VOLUN_COURSE
WHERE VOLUN_COURSE.num_course=TRAINING_COURSE.num_course
GROUP BY name_course, start_date_course, end_date, type_course, hours_per_day


--Querie 7
SELECT name_volunteer, 
       SUM(hours_per_day * (DATEDIFF(day, start_date_course, end_date) + 1)) AS Total_Hours,
       SUM(hours_per_day * (DATEDIFF(day, start_date_course, end_date) + 1)) * 30 AS Total_Points
FROM VOLUNTEER, VOLUN_COURSE, TRAINING_COURSE
WHERE VOLUNTEER.num_volunteer = VOLUN_COURSE.num_volunteer
  AND VOLUN_COURSE.num_course = TRAINING_COURSE.num_course
GROUP BY name_volunteer

--Querie 8
SELECT name_volunteer, name_course
FROM VOLUNTEER, VOLUN_COURSE, TRAINING_COURSE
WHERE VOLUNTEER.num_volunteer = VOLUN_COURSE.num_volunteer
AND VOLUN_COURSE.num_course = TRAINING_COURSE.num_course

--Querie 9
SELECT B.name_beneficiary AS [Name Beneficiario], B.date_of_birth AS [Date Birth], DATEDIFF(year, B.date_of_birth, GETDATE()) AS Age
, B.phone_number AS Phone, D.type_disaster AS [Type Disaster]
, CAST(SUM(DBR.quantity_distributed) AS VARCHAR) + ' ' + R.measurement_unit AS Total
FROM BENEFICIARY B, DISASTER D, DISTR_BENEF_RESOUR DBR, RESOURCES R
WHERE B.id_disaster = D.id_disaster
  AND B.id_beneficiary = DBR.id_beneficiary
  AND DBR.id_resources = R.id_resources
GROUP BY B.name_beneficiary, B.date_of_birth, B.phone_number, D.type_disaster, R.measurement_unit

--Querie 10
SELECT name_resources, type_resources, stock_level, measurement_unit,
CASE 
WHEN measurement_unit = 'units' AND stock_level < 2000 THEN 'REPLENISH'
WHEN measurement_unit = 'kgs' AND stock_level < 60 THEN 'REPLENISH'
ELSE 'OK'
END AS Check_Level
FROM RESOURCES

--Querie 11
SELECT name_resources, type_resources, stock_level, measurement_unit, name_beneficiary, distribution_date, quantity_distributed, measurement_unit
FROM RESOURCES, DISTR_BENEF_RESOUR, BENEFICIARY
WHERE RESOURCES.id_resources = DISTR_BENEF_RESOUR.id_resources
AND DISTR_BENEF_RESOUR.id_beneficiary = BENEFICIARY.id_beneficiary
AND YEAR(distribution_date) = 2024;

--Querie 12
SELECT name_center, donation_date, name_resources, quantity_donated, measurement_unit
FROM RELIEF_CENTER, DONAT_RES_CENT, RESOURCES
WHERE RELIEF_CENTER.id_center = DONAT_RES_CENT.id_center
  AND DONAT_RES_CENT.id_resources = RESOURCES.id_resources
  AND donation_date >= '2024-01-01'
  AND donation_date <= '2024-02-29'
ORDER BY donation_date;