
use ArtVault

create table USER_ART(
UserName VARCHAR(12) PRIMARY KEY
, NameUser VARCHAR (30) NOT NULL
, Surnames VARCHAR (100) NOT NULL
, Password CHAR (8) NOT NULL
, Email VARCHAR (100) NOT NULL
, Curator BIT NOT NULL
, CHECK (Email like ('_%@_%._%')) 
)

create table EXHIBITION(
IdExh INT IDENTITY PRIMARY KEY
, Title VARCHAR (50) NOT NULL
, DateExh DATE NOT NULL
, OpTime TIME NOT NULL ---REVISAR
, CloTime TIME NOT NULL
, TargetAud VARCHAR (13) NOT NULL
, Category VARCHAR (20) DEFAULT 'Painting'
, MaxVis VARCHAR (50) NOT NULL
, DescripExh VARCHAR (100) NOT NULL
, Room VARCHAR (30) NOT NULL
, Curator VARCHAR(12) NOT NULL
, FOREIGN KEY (Curator) REFERENCES USER_ART (UserName)
, CHECK (Category IN ('Painting', 'Photography', 'Digital Illustration' ))
, CHECK (TargetAud IN ('General', 'Art Students ', ' Professionals' ))
, CHECK (MaxVis >50)
)

create table REGISTER(
UserName VARCHAR(12) NOT NULL
, IdExh INT NOT NULL
, DateReg DATE NOT NULL
, PRIMARY KEY (UserName, IdExh, DateReg)
, FOREIGN KEY(IdExh) REFERENCES EXHIBITION (IdExh)
, FOREIGN KEY(UserName) REFERENCES USER_ART (UserName)
)

create table REVIEW(
UserName VARCHAR(12) NOT NULL
, IdExh INT NOT NULL
, TextReview VARCHAR (255)NOT NULL
, DatePost DATE NOT NULL
, PRIMARY KEY (UserName, IdExh, DatePost)
, FOREIGN KEY(IdExh) REFERENCES EXHIBITION (IdExh)
, FOREIGN KEY(UserName) REFERENCES USER_ART (UserName)
)
create table ARTWORK(
id_artwok INT IDENTITY PRIMARY KEY
, tittle VARCHAR (60)
, artist VARCHAR (60)
, IdExh INT NOT NULL
, FOREIGN KEY(IdExh) REFERENCES EXHIBITION (IdExh)

)
create table TICKET(
id_ticket INT IDENTITY PRIMARY KEY
, date_sell DATE NOT NULL
, price SMALLMONEY NOT NULL
, usurname VARCHAR(12) NOT NULL
, IdExh INT NOT NULL
, FOREIGN KEY(IdExh) REFERENCES EXHIBITION (IdExh)
)
