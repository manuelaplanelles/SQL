create database URBAN_MOBILITY
use URBAN_MOBILITY

create table CITY(
IdCity tinyint primary key
,NameCity varchar (30) not null
,Country varchar (4) not null
,TimeZone smallint not null
,Active bit not null
)


create table DISTRICT(
IdDistrict tinyint primary key
,NameStation varchar (50) not null 
,Area varchar (50) not null 
,IdDistDepend tinyint not null
,IdCity tinyint not null
,foreign key (IdCity) references CITY (IdCity)
)
alter table DISTRICT add foreign key (IdDistDepend) references DISTRICT (IdDistrict)

create table STATION(
NumStation varchar (50) not null
,IdDistrict tinyint not null
,LatLong -- duda
,TotalCap --duda
,NumActives --duda
,primary key (NumStation,IdDistrict)
,foreign key (IdDistrict) references DISTRICT (IdDistrict)
,check (NumStation between 20 and 50) 
)

create table FARE(
NamaFare tinyint primary key
,Base decimal (4,2) not null
,PriceMins decimal (4,2) not null
,IdCity tinyint not null
,foreign key (IdCity) references CITY (IdCity)
)

create table TYPE_VEHICLE(
CodVeh smallint primary key
,MinAge --duda
,MaxSpeed --duda
)

create table MODEL(
Manufacturer varchar (30) not null
,NameModel varchar (30) not null
,BatCap varchar (6) not null
,Codveh smallint not null
,primary key (Manufacturer, NameModel)
,foreign key (Codveh) references TYPE_VEHICLE (Codveh)
)

create table VEHICLE(
NumSerial tinyint primary key
,YearMan varchar (4) not null
,StatusVeh varchar (17) --puede tener o no
,NumStation varchar (50) not null
,IdDistrict tinyint not null
,NumTrips tinyint not null
,TotalKm smallint not null
,Manufacturer varchar (30) not null
,Model varchar (30) not null
,foreign key (NumStation,IdDistrict) references STATION (NumStation,IdDistrict)
,foreign key (Manufacturer,Model) references MODEL (Manufacturer,NameModel)
,check (StatusVeh in ('available', 'in use', 'under maintenance', 'lost', 'or retired'))
)

create table USER_MOBILITY(
IdUser smallint identity primary key
,NameUser varchar (100) not null
,Email varchar (100) not null
,DateOfB date not null
,StatusUser varchar (9) not null
,TypeUser varchar (3) not null
,check (TypeUser)
,check (Email)
)
create table TRIP(
)
create table PAYMENT(
)