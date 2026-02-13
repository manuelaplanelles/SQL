use EXAMPLE1
create table EMPLOYEE (
idemployee smallint primary key
, NameEmployee varchar(50) not null
, Age tinyint not null
, AddressEmployee varchar (100) not null
, Salary smallmoney not null
)

create table PROJECT (
ipproyect smallint primary key
,title varchar (70) not null
, date date not null
, amount money not null
, idemployee smallint not null
foreign key (idemployee) references EMPLOYEE (idemployee)
)