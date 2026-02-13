create database PURE_GYM
use PURE_GYM

create table GYM(
IDGym smallint identity primary key
,NameGym varchar (10) not null
,AddressGym varchar (30) not null
)

create table EMPLOYEE(
IDEmployee smallint identity primary key
,NameEmployee varchar (30) not null
,Phone char (9) unique not null
,BaseSalary smallmoney default 1.500
,Position varchar (12) not null
,HireDate date not null
,WorkShift time not null
,IDGym smallint not null
,foreign key (IDGym) references GYM (IDGym)
,check (Phone like ('[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'))
,check (Position in ('Trainer', 'Receptionist', 'Manager', 'Cleaner'))
,check (WorkShift == 06:00 and 14:00, WorkShift == 14:00 and 22:00, WorkShift == 10:00 and 19:00 )
)

create table SALARY_EMPLOYEE(
IDEmployee smallint not null
,MonthSalary date 
,YearSalary date 
,TotalSalary smallmoney not null
,primary key (IDEmployee,MonthSalary,YearSalary)
,foreign key (IDEmployee) references EMPLOYEE (IDEmployee)
)

create table MEMBERGYM(
IDMember smallint identity primary key
,NameMemeber varchar (30) not null
,Email varchar (100) unique not null
,Phone char (9) not null
,BanckAccount char (24) not null
,check (Phone like ('[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'))
,check (Email in ('_%@_%._%'))
,check (BanckAccount like ('[A-Z][A-Z][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'))
)

create table PROMOTION(
IDPromotion int identity primary key
,NamePromotion varchar (50) unique not null
,Price smallmoney not null
)

create table MEMBERSHIP(
NumContraction int identity primary key
,DateSign date not null
,DateStart date not null
,DateFinish date
,IDGym smallint not null
,IDMember smallint not null
,IDPromotion int not null
,foreign key (IDGym) references GYM (IDGym)
,foreign key (IDMember) references MEMBERGYM (IDMember)
,foreign key (IDPromotion) references PROMOTION (IDPromotion)
)

create table BOOK_P_TRAINER(
IDEmployee smallint not null
,IDMember smallint not null
,DayBook date not null
,TimeBook time not null
,primary key (IDEmployee,IDMember,DayBook,TimeBook)
,foreign key (IDEmployee) references EMPLOYEE (IDEmployee)
,foreign key (IDMember) references MEMBERGYM (IDMember)
)

create table CLASS(
IDClass smallint identity primary key
,NameClass varchar (30) not null
,NumPlaces smallint not null
)

create table DAYSGYM(
IDDays primary key
,WeekDays
,DateDay
)

create table SCHEDULE(
IDGym
,IDDays
,TimeSch
,IDClass
,IDEmployee1
,IDEmployee2
,NumPlacesAvailable
,primary key (IDGym,IDDays,TimeSch)
,foreign key (IDGym) references GYM (IDGym)
,foreign key (IDDays) references DAYSGYM (IDDays)
,foreign key (IDClass) references CLASS (IDClass)
,foreign key (IDEmployee1) references EMPLOYEE (IDEmployee)
,foreign key (IDEmployee2) references EMPLOYEE (IDEmployee)
)

create table BOOK_CLASS(
IDGym
,IDDays
,TimeSch
,IDMember
,primary key (IDGym,IDDays,TimeSch,IDMember)
,foreign key (IDMember) references MEMBERGYM (IDMember)
,foreign key (IDGym,IDDays,TimeSch) references SCHEDULE (IDGym,IDDays,TimeSch)
)

alter table TRANING_PROGRAM(
ParentPlan primary key
)

create table TRAINING_PLAN(
IDPlan primary key
,NamePlan
,DescPlan
,StartDate
,EndDate
,IsActive
,ParentPlan
,IDMember
,foreign key (IDMember) references MEMBERGYM (IDMember)
,foreign key (ParentPlan) references TRANING_PROGRAM (ParentPlan)
)