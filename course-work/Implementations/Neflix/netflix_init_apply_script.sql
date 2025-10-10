CREATE DATABASE Netflix

GO

USE Netflix

GO

CREATE TABLE Genre (
	GenreID INT PRIMARY KEY,
	GenreName NVARCHAR(50) CHECK (GenreName IN ('Action', 'Anime', 'Comedy', 'Crime', 'Drama', 'Experimental', 'Fantasy', 'Historical', 'Horror', 'Romance', 'Science Fiction', 'Thriller', 'Western', 'Musical', 'War')) NOT NULL 
)

CREATE TABLE Movie (
	MovieID INT PRIMARY KEY,
	Title NVARCHAR(150) NOT NULL,
	GenreID INT FOREIGN KEY REFERENCES Genre(GenreID) NOT NULL,
	ReleaseYear DATETIME NOT NULL,
	Duration INT NOT NULL,
	[Language] NVARCHAR(30) NOT NULL
)

CREATE TABLE Actor (
	ActorID INT PRIMARY KEY,
	FirstName NVARCHAR(50) NOT NULL,
	LastName NVARCHAR(50) NOT NULL,
	Gender NVARCHAR(50) CHECK (Gender IN ('Male', 'Female', 'Other')) NOT NULL,
	BirthDate DATETIME NOT NULL
)

CREATE TABLE MovieActor (
	ActorID INT FOREIGN KEY REFERENCES Actor(ActorID) NOT NULL,
	MovieID INT FOREIGN KEY REFERENCES Movie(MovieID) NOT NULL,
	PRIMARY KEY (ActorID, MovieID)
)

CREATE TABLE Subscription (
	SubscriptionID INT PRIMARY KEY,
	[Name] NVARCHAR(100) NOT NULL,
	Price MONEY NOT NULL,
	Duration INT NOT NULL
)

CREATE TABLE [User] (
	UserID INT PRIMARY KEY,
	Username NVARCHAR(50) NOT NULL UNIQUE,
	Email NVARCHAR(100) NOT NULL,
	[Password] NVARCHAR(200) NOT NULL,
	JoinDate DATETIME NOT NULL,
	SubscriptionID INT FOREIGN KEY REFERENCES Subscription(SubscriptionID) NOT NULL
)

CREATE TABLE UserProfile (
	ProfileID INT PRIMARY KEY,
	UserID INT FOREIGN KEY REFERENCES [User](UserID) NOT NULL,
	ProfileName NVARCHAR(100) NOT NULL UNIQUE
)

CREATE TABLE Rating (
	RatingID INT PRIMARY KEY,
	RatingGrade INT CHECK (RatingGrade BETWEEN 1 AND 10) NOT NULL,
	RatingDate DATETIME NOT NULL,
	ProfileID INT FOREIGN KEY REFERENCES UserProfile(ProfileID) NOT NULL,
	MovieID INT FOREIGN KEY REFERENCES Movie(MovieID) NOT NULL
)

CREATE TABLE Watchlist (
	ProfileID INT FOREIGN KEY REFERENCES UserProfile(ProfileID) NOT NULL,
	MovieID INT FOREIGN KEY REFERENCES Movie(MovieID) NOT NULL,
	PRIMARY KEY (ProfileID, MovieID)
)

CREATE TABLE Comment (
	CommentID INT PRIMARY KEY,
	ProfileID INT FOREIGN KEY REFERENCES UserProfile(ProfileID) NOT NULL,
	CommentMessage NVARCHAR(200) NOT NULL,
	CommentDate DATETIME NOT NULL,
	MovieID INT FOREIGN KEY REFERENCES Movie(MovieID) NOT NULL
)

GO

-- Insert into Genre
INSERT INTO Genre (GenreID, GenreName) VALUES 
(1, 'Action'),
(2, 'Comedy'),
(3, 'Drama'),
(4, 'Horror'),
(5, 'Science Fiction')

-- Insert into Movie
INSERT INTO Movie (MovieID, Title, GenreID, ReleaseYear, Duration, [Language]) VALUES 
(1, 'The Fast Saga', 1, '2001-06-22', 120, 'English'),
(2, 'The Big Comedy', 2, '2015-08-12', 90, 'English'),
(3, 'A Dramatic Life', 3, '2018-12-15', 110, 'French'),
(4, 'Night of Terror', 4, '2020-10-31', 105, 'English'),
(5, 'Star Explorers', 5, '2022-03-10', 135, 'Spanish'),
(6, 'Star Wars', 1, '2020-10-31', 105, 'English'),
(7, 'The Hero Returns', 1, '2005-06-15', 130, 'English'),
(8, 'Mystery at Midnight', 2, '2010-11-05', 95, 'French'),
(9, 'The Epic Journey', 3, '2019-03-17', 145, 'Spanish'),
(10, 'Bloodline Chronicles', 4, '2018-07-22', 110, 'English'),
(11, 'Dreamworld Adventures', 5, '2021-06-09', 140, 'Italian'),
(12, 'The Witching Hour', 4, '2020-12-01', 120, 'English'),
(13, 'The Last Frontier', 1, '2022-09-12', 125, 'English'),
(14, 'Laughter and Tears', 2, '2016-02-19', 95, 'English'),
(15, 'Unseen Forces', 3, '2023-01-23', 115, 'German'),
(16, 'The Maze of Secrets', 4, '2017-08-15', 110, 'English'),
(17, 'Guardians of the Realm', 1, '2024-05-25', 140, 'English'),
(18, 'Romantic Days', 5, '2021-12-14', 110, 'Spanish'),
(19, 'The Reckoning', 2, '2020-03-22', 100, 'English'),
(20, 'The Inferno', 1, '2016-11-10', 130, 'English'),
(21, 'The Hidden Truth', 2, '2017-06-29', 98, 'French'),
(22, 'Whispers in the Dark', 3, '2022-04-18', 125, 'Japanese'),
(23, 'The Killing Game', 4, '2021-02-01', 105, 'English'),
(24, 'Time Portal', 5, '2020-07-11', 130, 'Italian'),
(25, 'Echoes of the Past', 4, '2019-10-08', 115, 'English'),
(26, 'The Lost Kingdom', 1, '2023-09-15', 145, 'Spanish'),
(27, 'The Codebreaker', 2, '2021-07-05', 100, 'English'),
(28, 'Silent Shadows', 3, '2018-05-18', 115, 'French'),
(29, 'Undercover Justice', 4, '2019-11-03', 120, 'English'),
(30, 'Distant Stars', 5, '2022-01-20', 135, 'German'),
(31, 'The Dark Hunt', 1, '2024-03-28', 140, 'English'),
(32, 'Survival of the Fittest', 1, '2020-09-17', 130, 'English'),
(33, 'Love’s Labyrinth', 5, '2023-06-19', 105, 'Spanish'),
(34, 'Mind Games', 5, '2022-10-05', 125, 'English'),
(35, 'Fury of the Dragon', 1, '2019-04-11', 110, 'English'),
(36, 'Echo of the Fallen', 2, '2021-08-13', 120, 'Italian'),
(37, 'A Tale of Two Worlds', 3, '2020-02-27', 125, 'German'),
(38, 'The Demon’s Curse', 4, '2024-06-30', 115, 'English'),
(39, 'City of Flames', 5, '2018-12-01', 130, 'English'),
(40, 'The Silent Witness', 1, '2023-07-14', 115, 'Spanish');

-- Insert into Actor
INSERT INTO Actor (ActorID, FirstName, LastName, Gender, BirthDate) VALUES 
(1, 'John', 'Doe', 'Male', '1985-04-12'),
(2, 'Jane', 'Smith', 'Female', '1990-07-22'),
(3, 'Sam', 'Wilson', 'Male', '1978-09-11'),
(4, 'Emily', 'Brown', 'Female', '1992-03-05'),
(5, 'Alex', 'Johnson', 'Other', '1983-11-30')

-- Insert into MovieActor
INSERT INTO MovieActor (ActorID, MovieID) VALUES 
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5)

-- Insert into Subscription
INSERT INTO Subscription (SubscriptionID, [Name], Price, Duration) VALUES 
(1, 'Basic', 9.99, 30),
(2, 'Standard', 14.99, 30),
(3, 'Premium', 19.99, 30),
(4, 'Student', 7.99, 30),
(5, 'Family', 24.99, 30)


-- Insert into [User]
INSERT INTO [User] (UserID, Username, Email, [Password], JoinDate, SubscriptionID) VALUES 
(1, 'jdoe', 'jdoe@example.com', 'password123', '2020-01-01', 1),
(2, 'jsmith', 'jsmith@example.com', 'password456', '2021-02-15', 2),
(3, 'swilson', 'swilson@example.com', 'password789', '2022-05-10', 3),
(4, 'ebrown', 'ebrown@example.com', 'password101', '2019-07-23', 4),
(5, 'ajohnson', 'ajohnson@example.com', 'password202', '2018-09-18', 5),
(6, 'bclark', 'bclark@example.com', 'password303', '2021-11-01', 1),
(7, 'lmartin', 'lmartin@example.com', 'password404', '2022-01-17', 2),
(8, 'pallen', 'pallen@example.com', 'password505', '2023-03-05', 3),
(9, 'mthomas', 'mthomas@example.com', 'password606', '2020-08-12', 4),
(10, 'kjackson', 'kjackson@example.com', 'password707', '2017-10-24', 5),
(11, 'cwhite', 'cwhite@example.com', 'password808', '2019-11-05', 1),
(12, 'dgreen', 'dgreen@example.com', 'password909', '2022-07-30', 2),
(13, 'njones', 'njones@example.com', 'password010', '2020-04-17', 1),
(14, 'tgarcia', 'tgarcia@example.com', 'password111', '2021-05-06', 2),
(15, 'vlee', 'vlee@example.com', 'password212', '2021-12-15', 5),
(16, 'kwilson', 'kwilson@example.com', 'password313', '2022-10-22', 1),
(17, 'hwalker', 'hwalker@example.com', 'password414', '2023-02-01', 2),
(18, 'jmartinez', 'jmartinez@example.com', 'password515', '2018-06-03', 3),
(19, 'rmoore', 'rmoore@example.com', 'password616', '2019-03-09', 2),
(20, 'sclark', 'sclark@example.com', 'password717', '2022-11-20', 2),
(21, 'sgarcia', 'sgarcia@example.com', 'password818', '2021-08-14', 1),
(22, 'adavis', 'adavis@example.com', 'password919', '2020-02-26', 2),
(23, 'jjames', 'jjames@example.com', 'password020', '2023-06-18', 3),
(24, 'jwhite', 'jwhite@example.com', 'password121', '2022-04-10', 4),
(25, 'kbaker', 'kbaker@example.com', 'password222', '2021-07-27', 5),
(26, 'lhernandez', 'lhernandez@example.com', 'password323', '2023-04-04', 1),
(27, 'mking', 'mking@example.com', 'password424', '2022-09-29', 2),
(28, 'dtaylor', 'dtaylor@example.com', 'password525', '2021-10-11', 3),
(29, 'vwhite', 'vwhite@example.com', 'password626', '2020-12-14', 4),
(30, 'rgarcia', 'rgarcia@example.com', 'password727', '2019-05-23', 2),
(31, 'jrodriguez', 'jrodriguez@example.com', 'password828', '2022-12-19', 1),
(32, 'jmartin', 'jmartin@example.com', 'password929', '2021-06-21', 2),
(33, 'candrews', 'candrews@example.com', 'password030', '2020-09-02', 3),
(34, 'rwilliams', 'rwilliams@example.com', 'password131', '2022-08-10', 4),
(35, 'bgarcia', 'bgarcia@example.com', 'password232', '2023-05-12', 2),
(36, 'pwalker', 'pwalker@example.com', 'password333', '2021-04-22', 1),
(37, 'ktaylor', 'ktaylor@example.com', 'password434', '2020-01-10', 2),
(38, 'mjackson', 'mjackson@example.com', 'password535', '2022-03-16', 2),
(39, 'lmorris', 'lmorris@example.com', 'password636', '2023-07-13', 2),
(40, 'pjohnson', 'pjohnson@example.com', 'password737', '2021-09-09', 5);


-- Insert into UserProfile
INSERT INTO UserProfile (ProfileID, UserID, ProfileName) VALUES 
(1, 1, 'JohnDoeProfile'),
(2, 2, 'JaneSmithProfile'),
(3, 3, 'SamWilsonProfile'),
(4, 4, 'EmilyBrownProfile'),
(5, 5, 'AlexJohnsonProfile'),
(6, 6, 'BenClarkProfile'),
(7, 7, 'LauraMartinProfile'),
(8, 8, 'PaulAllenProfile'),
(9, 9, 'MichaelThomasProfile'),
(10, 10, 'KennyJacksonProfile'),
(11, 11, 'CharlieWhiteProfile'),
(12, 12, 'DavidGreenProfile'),
(13, 13, 'NickJonesProfile'),
(14, 14, 'TomGarciaProfile'),
(15, 15, 'VictorLeeProfile'),
(16, 16, 'KevinWilsonProfile'),
(17, 17, 'HannahWalkerProfile'),
(18, 18, 'JuanMartinezProfile'),
(19, 19, 'RandyMooreProfile'),
(20, 20, 'SteveClarkProfile'),
(21, 21, 'SophiaGarciaProfile'),
(22, 22, 'AdamDavisProfile'),
(23, 23, 'JamesJamesProfile'),
(24, 24, 'JackWhiteProfile'),
(25, 25, 'KylieBakerProfile'),
(26, 26, 'LiamHernandezProfile'),
(27, 27, 'MarkKingProfile'),
(28, 28, 'DanielleTaylorProfile'),
(29, 29, 'VictorWhiteProfile'),
(30, 30, 'RosaGarciaProfile'),
(31, 31, 'JavierRodriguezProfile'),
(32, 32, 'JamesMartinProfile'),
(33, 33, 'CatherineAndrewsProfile'),
(34, 34, 'RandyWilliamsProfile'),
(35, 35, 'BrianGarciaProfile'),
(36, 36, 'PeterWalkerProfile'),
(37, 37, 'KennyTaylorProfile'),
(38, 38, 'MichaelJacksonProfile'),
(39, 39, 'LiamMorrisProfile'),
(40, 40, 'PaulJohnsonProfile'),

-- Multiple profiles for users
(41, 1, 'JohnDoeAlternateProfile'),
(42, 2, 'JaneSmithSecondaryProfile'),
(43, 3, 'SamWilsonExtraProfile'),
(44, 5, 'AlexJohnsonWorkProfile'),
(45, 7, 'LauraMartinPrivateProfile'),
(46, 8, 'PaulAllenCasualProfile'),
(47, 9, 'MichaelThomasVIPProfile'),
(48, 10, 'KennyJacksonAdventureProfile'),
(49, 11, 'CharlieWhiteSchoolProfile'),
(50, 13, 'NickJonesSecondaryProfile'),
(51, 14, 'TomGarciaPremiumProfile'),
(52, 16, 'KevinWilsonFamilyProfile'),
(53, 17, 'HannahWalkerFitnessProfile'),
(54, 18, 'JuanMartinezTechProfile'),
(55, 20, 'SteveClarkHolidayProfile'),
(56, 22, 'AdamDavisExplorerProfile'),
(57, 23, 'JamesJamesWorkProfile'),
(58, 25, 'KylieBakerArtProfile'),
(59, 27, 'MarkKingFitnessProfile'),
(60, 29, 'VictorWhiteMusicProfile'),
(61, 30, 'RosaGarciaPersonalProfile'),
(62, 32, 'JamesMartinSpecialProfile'),
(63, 33, 'CatherineAndrewsTravelProfile'),
(64, 34, 'RandyWilliamsVIPProfile'),
(65, 35, 'BrianGarciaGamingProfile'),
(66, 36, 'PeterWalkerMusicProfile'),
(67, 38, 'MichaelJacksonExclusiveProfile'),
(68, 39, 'LiamMorrisSocialProfile');

-- Insert into Rating
INSERT INTO Rating (RatingID, RatingGrade, RatingDate, ProfileID, MovieID) VALUES 
(1, 8, '2023-01-05', 1, 1),
(2, 7, '2023-02-10', 2, 2),
(3, 9, '2023-03-15', 3, 3),
(4, 6, '2023-04-20', 4, 4),
(5, 10, '2023-05-25', 5, 5),
(6, 7, '2023-06-01', 1, 1),
(7, 8, '2023-06-05', 2, 2),
(8, 9, '2023-06-10', 3, 3),
(9, 6, '2023-06-15', 4, 4),
(10, 8, '2023-06-20', 5, 5),
(11, 7, '2023-07-01', 1, 6),
(12, 9, '2023-07-05', 2, 7),
(13, 8, '2023-07-10', 3, 8),
(14, 6, '2023-07-15', 4, 9),
(15, 7, '2023-07-20', 5, 10),
(16, 5, '2023-08-01', 1, 11),
(17, 9, '2023-08-05', 2, 12),
(18, 10, '2023-08-10', 3, 13),
(19, 7, '2023-08-15', 4, 14),
(20, 8, '2023-08-20', 5, 15),
(21, 6, '2023-09-01', 1, 16),
(22, 8, '2023-09-05', 2, 17),
(23, 9, '2023-09-10', 3, 18),
(24, 7, '2023-09-15', 4, 19),
(25, 10, '2023-09-20', 5, 20),
(26, 7, '2023-10-01', 1, 21),
(27, 8, '2023-10-05', 2, 22),
(28, 6, '2023-10-10', 3, 23),
(29, 9, '2023-10-15', 4, 24),
(30, 7, '2023-10-20', 5, 25),
(31, 10, '2023-11-01', 1, 26),
(32, 6, '2023-11-05', 2, 27),
(33, 8, '2023-11-10', 3, 28),
(34, 7, '2023-11-15', 4, 29),
(35, 9, '2023-11-20', 5, 30),
(36, 5, '2023-12-01', 1, 31),
(37, 9, '2023-12-05', 2, 32),
(38, 7, '2023-12-10', 3, 33),
(39, 6, '2023-12-15', 4, 34),
(40, 10, '2023-12-20', 5, 35);


-- Insert into Watchlist
INSERT INTO Watchlist (ProfileID, MovieID) VALUES
(1, 1),
(1, 2),
(1, 5),
(2, 6),
(2, 10),
(2, 12),
(3, 7),
(3, 9),
(3, 11),
(4, 8),
(4, 13),
(4, 16),
(5, 14),
(5, 18),
(5, 20),
(6, 3),
(6, 4),
(6, 7),
(7, 15),
(7, 19),
(7, 22),
(8, 17),
(8, 23),
(8, 25),
(9, 26),
(9, 27),
(9, 30),
(10, 28),
(10, 31),
(10, 35),
(11, 36),
(11, 37),
(11, 40),
(12, 2),
(12, 4),
(12, 6),
(13, 5),
(13, 7),
(13, 8),
(14, 9),
(14, 10),
(14, 12),
(15, 11),
(15, 13),
(15, 14),
(16, 15),
(16, 16),
(16, 18),
(17, 17),
(17, 19),
(17, 20),
(18, 21),
(18, 23),
(18, 24),
(19, 22),
(19, 25),
(19, 27),
(20, 28),
(20, 29),
(20, 31),
(21, 30),
(21, 32),
(21, 34),
(22, 3),
(22, 4),
(22, 5),
(23, 6),
(23, 7),
(23, 8),
(24, 9),
(24, 10),
(24, 12),
(25, 13),
(25, 15),
(25, 18),
(26, 16),
(26, 17),
(26, 19),
(27, 20),
(27, 21),
(27, 23),
(28, 24),
(28, 26),
(28, 29),
(29, 27),
(29, 28),
(29, 30),
(30, 31),
(30, 32),
(30, 33),
(31, 34),
(31, 36),
(31, 37),
(32, 38),
(32, 39),
(32, 40),
(33, 5),
(33, 6),
(33, 7),
(34, 8),
(34, 9),
(34, 10),
(35, 11),
(35, 12),
(35, 13),
(36, 14),
(36, 15),
(36, 16),
(37, 17),
(37, 18),
(37, 19),
(38, 20),
(38, 21),
(38, 22),
(39, 23),
(39, 24),
(39, 25),
(40, 26),
(40, 27),
(40, 28),
(1, 29),
(1, 30),
(1, 32),
(2, 33),
(2, 34),
(2, 35),
(3, 36),
(3, 37),
(3, 38),
(4, 39),
(4, 40),
(4, 5),
(5, 6),
(5, 7),
(5, 8),
(6, 9),
(6, 10),
(6, 11),
(7, 12),
(7, 13),
(7, 14),
(8, 15),
(8, 16),
(9, 18),
(9, 19),
(9, 20),
(10, 21),
(10, 22),
(10, 23),
(11, 24),
(11, 25),
(11, 26),
(12, 27),
(12, 28),
(12, 29),
(13, 30),
(13, 31),
(13, 32),
(14, 33),
(14, 34),
(14, 35),
(15, 36),
(15, 37),
(15, 38),
(16, 39),
(16, 40),
(16, 5),
(17, 6),
(17, 7),
(17, 8),
(18, 9),
(18, 10),
(18, 11),
(19, 12),
(19, 13),
(19, 14),
(20, 15),
(20, 16),
(20, 17),
(21, 18),
(21, 19),
(21, 20),
(22, 21),
(22, 22),
(22, 23),
(23, 24),
(23, 25),
(23, 26),
(24, 27),
(24, 28),
(24, 29),
(25, 30),
(25, 31),
(25, 32),
(26, 33),
(26, 34),
(26, 35),
(27, 36),
(27, 37),
(27, 38),
(28, 39),
(28, 40),
(28, 5),
(29, 6),
(29, 7),
(29, 8),
(30, 9),
(30, 10),
(30, 11),
(31, 12),
(31, 13),
(31, 14),
(32, 15),
(32, 16),
(32, 17),
(33, 18),
(33, 19),
(33, 20),
(34, 21),
(34, 22),
(34, 23),
(35, 24),
(35, 25),
(35, 26),
(36, 27),
(36, 28),
(36, 29),
(37, 30),
(37, 31),
(37, 32),
(38, 33),
(38, 34),
(38, 35),
(39, 36),
(39, 37),
(39, 38),
(40, 39);

-- Insert into Comment
INSERT INTO Comment (CommentID, ProfileID, CommentMessage, CommentDate, MovieID) VALUES 
(1, 1, 'Great movie!', '2023-01-10', 1),
(2, 2, 'Very funny!', '2023-02-15', 2),
(3, 3, 'Deep story.', '2023-03-20', 3),
(4, 4, 'Scary stuff!', '2023-04-25', 4),
(5, 5, 'Loved the visuals!', '2023-05-30', 5)

------------------------Stored Procedures------------------------
--1
--Get all movies by a given genre
CREATE PROCEDURE GetMoviesByGenre (@GenreID INT)
AS
BEGIN
    SELECT 
        m.MovieID,
        m.Title,
        m.ReleaseYear,
        m.Duration,
        m.[Language],
        g.GenreName
    FROM Movie AS m
    INNER JOIN Genre AS g
        ON m.GenreID = g.GenreID
    WHERE m.GenreID = @GenreID
    ORDER BY m.ReleaseYear DESC;
END
GO

--Execution:
EXEC GetMoviesByGenre @GenreID = 1;
GO

--2
--Get a user watchlist by his ID
CREATE PROCEDURE GetUserWatchlist
    (@UserID INT)
AS
BEGIN
    SELECT 
        up.ProfileName,
        m.Title,
        m.ReleaseYear,
        m.Duration,
        m.[Language],
        g.GenreName
    FROM Watchlist AS w
    INNER JOIN UserProfile AS up
        ON w.ProfileID = up.ProfileID
    INNER JOIN Movie AS m
        ON w.MovieID = m.MovieID
    INNER JOIN Genre AS g
        ON m.GenreID = g.GenreID
    WHERE up.UserID = @UserID
    ORDER BY m.ReleaseYear DESC;
END
GO

--Execution:
EXEC GetUserWatchlist @UserID = 1;
GO

------------------------Functions------------------------
--1
--Get a movie's duration in hours and minutes
CREATE FUNCTION dbo.F_GetMovieDurationByMovieID (@iMovieID INT)
RETURNS NVARCHAR(50)
AS
BEGIN
    DECLARE @Duration INT;
    DECLARE @Hours INT;
    DECLARE @Minutes INT;
    DECLARE @FormattedDuration NVARCHAR(50);

    SELECT @Duration = Duration FROM Movie WHERE MovieID = @iMovieID;

    SET @Hours = @Duration / 60;
    SET @Minutes = @Duration % 60;

    SET @FormattedDuration = 
        CASE 
            WHEN @Hours > 0 THEN CAST(@Hours AS NVARCHAR(10)) + ' hours ' 
            ELSE '' 
        END + 
        CASE 
            WHEN @Minutes > 0 THEN CAST(@Minutes AS NVARCHAR(10)) + ' minutes'
            ELSE '' 
        END;

    RETURN @FormattedDuration;
END
GO

--Execute:
SELECT m.Title + ' (' + dbo.F_GetMovieDurationByMovieID(m.MovieID) + ')' AS MovieTitleWithDuration
FROM Movie m
WHERE m.MovieID = 3;
GO

--2
--Get the user's full name
CREATE FUNCTION dbo.F_GetUserFullName (@iUserID INT)
RETURNS NVARCHAR(100)
AS
BEGIN
    DECLARE @FullName NVARCHAR(100);

    SELECT @FullName = a.FirstName + ' ' + a.LastName
    FROM [UserProfile] AS up
    INNER JOIN [User] AS u ON up.UserID = u.UserID
    INNER JOIN Actor AS a ON a.ActorID = u.UserID
    WHERE up.UserID = @iUserID;

    RETURN @FullName;
END
GO

--Execute:
SELECT dbo.F_GetUserFullName(1) AS UserFullName;
GO

------------------------Triggers------------------------
--1
--Set the RatingDate to be the current date and time when a new rating is added
CREATE TRIGGER trg_UpdateRatingDate ON Rating AFTER INSERT
AS
BEGIN
    UPDATE r
    SET RatingDate = GETDATE()
    FROM Rating r
    INNER JOIN inserted i ON r.RatingID = i.RatingID;
END
GO

--2
--Check if a movie has a rating before deleting it and if it has raise an error
CREATE TRIGGER trg_PreventMovieDeletion ON Movie INSTEAD OF DELETE
AS
BEGIN
    IF EXISTS (SELECT 1 FROM Rating WHERE MovieID IN (SELECT MovieID FROM deleted))
    BEGIN
        RAISERROR('Cannot delete movie with existing ratings.', 16, 1);
        ROLLBACK TRANSACTION;
    END
    ELSE
    BEGIN
        DELETE FROM Movie
        WHERE MovieID IN (SELECT MovieID FROM deleted);
    END
END
GO

