PRAGMA foreign_keys = ON

CREATE TABLE Organizer(
    OrganizerID INTEGER PRIMARY KEY,
    Name TEXT NOT NULL,
    PhoneNumber TEXT,
    Email TEXT
);

CREATE TABLE Festival(
    FestivalID INTEGER PRIMARY KEY,
    OrganizerID INTEGER NOT NULL,
    Name TEXT NOT NULL,
    Location TEXT,
    StartDate DATE,
    EndDate DATE,
    Capacity INTEGER,

    FOREIGN KEY (OrganizerID)
        REFERENCES Organizer(OrganizerID)
);

CREATE TABLE Client(
    CCNumber INTEGER PRIMARY KEY,
    Name TEXT,
    IBAN INTEGER,
    NIF INTEGER,
    BirthDate DATE,
    Address TEXT,
    PhoneNumber TEXT,
    Email TEXT
);

CREATE TABLE Sponsor(
    Name TEXT PRIMARY KEY,
    PhoneNumber TEXT,
    Email TEXT
);

CREATE TABLE Sponsorship(
    FestivalID INTEGER,
    SponsorName TEXT,
    ContributionType TEXT,
    ContributionValue FLOAT,
    ContributionDescription TEXT,

    PRIMARY KEY(FestivalID, SponsorName),
    FOREIGN KEY (FestivalID)
        REFERENCES Festival(FestivalID),
    FOREIGN KEY (SponsorName)
        REFERENCES Sponsor(Name)
);

CREATE TABLE TicketType(
    TicketTypeID INTEGER PRIMARY KEY,
    FestivalID INTEGER NOT NULL,
    Name TEXT,
    PRICE FLOAT,

    FOREIGN KEY (FestivalID)
        REFERENCES Festival(FestivalID)
);

CREATE TABLE FestivalDay(
    DayID INTEGER PRIMARY KEY,
    FestivalID INTEGER,
    Day DATE,

    FOREIGN KEY (FestivalID)
        REFERENCES Festival(FestivalID)
);

CREATE TABLE ValidFor(
    TicketTypeID INTEGER,
    DayID INTEGER,

    PRIMARY KEY (TicketTypeID, DayID),
    FOREIGN KEY (TicketTypeID)
        REFERENCES TicketType(TicketTypeID),
    FOREIGN KEY (DayID)
        REFERENCES FestivalDay(DayID)
);

CREATE TABLE Stage(
    StageID INTEGER PRIMARY KEY,
    Name TEXT,
    Capacity INTEGER
);

CREATE TABLE Concert(
    ConcertID INTEGER PRIMARY KEY,
    DayID INTEGER NOT NULL,
    StageID INTEGER NOT NULL,
    StartTime TIME,
    EndTime TIME,

    FOREIGN KEY (DayID)
        REFERENCES FestivalDay(DayID),
    FOREIGN KEY (StageID)
        REFERENCES Stage(StageID)
);

CREATE TABLE StaffAssignment(
    AssignmentID INTEGER PRIMARY KEY,
    FestivalID INTEGER NOT NULL,
    StageID INTEGER,
    Role TEXT,
    Area TEXT,

    FOREIGN KEY (FestivalID)
        REFERENCES Festival(FestivalID),
    FOREIGN KEY (StageID)
        REFERENCES Stage(StageID)
);

CREATE TABLE StaffMember(
    StaffID INTEGER PRIMARY KEY,
    Name TEXT,
    PhoneNumber TEXT,
    Email TEXT
);

CREATE TABLE Receives(
    StaffID INTEGER,
    AssignmentID INTEGER,

    PRIMARY KEY (StaffID, AssignmentID),
    FOREIGN KEY(StaffID)
        REFERENCES StaffMember(StaffID),
    FOREIGN KEY(AssignmentID)
        REFERENCES StaffAssignment(AssignmentID)
);

CREATE TABLE Task(
    TaskID INTEGER PRIMARY KEY,
    Name TEXT
);

CREATE TABLE Operates(
    TaskID INTEGER,
    AssignmentID INTEGER,

    PRIMARY KEY(TaskID, AssignmentID),
    FOREIGN KEY(TaskID)
        REFERENCES Task(TaskID),
    FOREIGN KEY(AssignmentID)
        REFERENCES StaffAssignment(AssignmentID)
);

CREATE TABLE Artist(
    ArtistID INTEGER PRIMARY KEY,
    DebutDate DATE,
    Name TEXT
);

CREATE TABLE Performs(
    ConcertID INTEGER,
    ArtistID INTEGER,

    PRIMARY KEY (ConcertID, ArtistID),
    FOREIGN KEY (ConcertID)
        REFERENCES Concert(ConcertID),
    FOREIGN KEY (ArtistID)
        REFERENCES Artist(ArtistID)
);

CREATE TABLE Genre(
    GenreID INTEGER PRIMARY KEY,
    Name TEXT
);

CREATE TABLE ClassifiedAs(
    ArtistID INTEGER,
    GenreID INTEGER,

    PRIMARY KEY (ArtistID, GenreID),
    FOREIGN KEY (ArtistID)
        REFERENCES Artist(ArtistID),
    FOREIGN KEY (GenreID)
        REFERENCES Genre(GenreID)
);

CREATE TABLE Member(
    MemberID INTEGER PRIMARY KEY,
    ArtisticName TEXT,
    RealName TEXT,
    BirthDate DATE,
    Instrument TEXT
);

CREATE TABLE ConsistsOf(
    ArtistID INTEGER,
    MemberID INTEGER,

    PRIMARY KEY (ArtistID, MemberID),
    FOREIGN KEY ArtistID
        REFERENCES Artist(ArtistID),
    FOREIGN KEY MemberID
        REFERENCES Member(MemberID)
);

CREATE TABLE TicketPurchase(
    PurchaseID INTEGER PRIMARY KEY,
    CCNumber INTEGER NOT NULL,
    Day DATE,
    Value FLOAT,
    PaymentMethod TEXT,

    FOREIGN KEY (CCNumber)
        REFERENCES Client(CCNumber)
);

CREATE TABLE Ticket(
    TicketID INTEGER PRIMARY KEY,
    PurchaseID INTEGER NOT NULL,
    TicketTypeID INTEGER NOT NULL,

    FOREIGN KEY PurchaseID
        REFERENCES TicketPurchase(PurchaseID),
    FOREIGN KEY TicketTypeID
        REFERENCES TicketType(TicketTypeID)
)