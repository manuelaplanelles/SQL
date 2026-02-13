--EXERCISE 1
SELECT Season, DoctorName as Doctor, 
	CAST ( AVG (ViewerRating) AS decimal (4,2)) AS VIEWER_RATING, 
	CAST (AVG (CriticRating) AS decimal (4,2)) AS CRITIC_RATING
FROM RATING, EPISODE, DOCTOR
WHERE RATING.EpisodeId = EPISODE.EpisodeId 
	and EPISODE.DoctorId = DOCTOR.DoctorId
GROUP BY DoctorName, Season
HAVING AVG (ViewerRating) <= AVG (CriticRating)

--EXERCISE 2
SELECT DoctorName AS DOCTOR, 
	DATEDIFF (DAY, BirthDate, FirstEpisodeDate)/365 AS AGE, COUNT (*) AS NUM_EPISODES, 
	DATEDIFF (YEAR, YEAR (FirstEpisodeDate), YEAR (LastEpisodeDate)) as YEAR_WORKING
FROM EPISODE, DOCTOR
WHERE EPISODE.DoctorId=DOCTOR.DoctorId
	AND DATEDIFF (DAY, BirthDate, FirstEpisodeDate)>25
GROUP BY DoctorName, 
	DATEDIFF (DAY, BirthDate, FirstEpisodeDate),
	DATEDIFF (YEAR FirstEpisodeDate, LastEpisodeDate) 
HAVING COUNT (*) > 30

--EXERCISE 3
SELECT 
FROM WRITER, EPISODE, AWARD
WHERE WRITER.WriterId=EPISODE.EpisodeId 
AND 
