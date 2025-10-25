USE Netflix;

--Functions
SELECT dbo.F_GetMovieDurationByMovieID(5) AS 'Movie Duration';
SELECT dbo.F_GetUserFullName(5) AS "User's Full Name";

--Stored Procedures
EXEC dbo.GetMoviesByGenre @GenreID = 5;
EXEC dbo.GetUserWatchlist @UserID = 5;
