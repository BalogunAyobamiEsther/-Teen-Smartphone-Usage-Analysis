CREATE DATABASE Teensmartphone_Usage;
USE Teensmartphone_Usage;

SELECT * FROM teen_phone_addiction_dataset;

CREATE TABLE Teenagers (
    ID INT PRIMARY KEY,
    Teen_Name VARCHAR(100),
    Age INT,
    Gender VARCHAR(10),
    Location VARCHAR(100),
    School_Grade VARCHAR(10)
	);

CREATE TABLE Usage_Stats (
    Usage_ID INT PRIMARY KEY AUTO_INCREMENT,
    ID INT,
    Daily_Usage_Hours FLOAT,
    Phone_Checks_Per_Day INT,
    Apps_Used_Daily INT,
    Phone_Usage_Purpose VARCHAR(50),
    Weekend_Usage_Hours FLOAT,
    Screen_Time_Before_Bed FLOAT,
    FOREIGN KEY (ID) REFERENCES Teenagers(ID)
	);

CREATE TABLE Time_Distribution (
    Time_ID INT PRIMARY KEY AUTO_INCREMENT,
    ID INT,
    Time_on_Social_Media DECIMAL(10,2),
    Time_on_Gaming DECIMAL(10,2),
    Time_on_Education DECIMAL(10,2),
    FOREIGN KEY (ID) REFERENCES Teenagers(ID)
	);

CREATE TABLE Health_Profile (
    Health_ID INT PRIMARY KEY AUTO_INCREMENT,
    ID INT,
    Sleep_Hours DECIMAL(10,2),
    Exercise_Hours DECIMAL(10,2),
    Anxiety_Level DECIMAL(10,2),
    Depression_Level DECIMAL(10,2),
    Self_Esteem DECIMAL(10,2),
    FOREIGN KEY (ID) REFERENCES Teenagers(ID)
	);

CREATE TABLE Performance_Profile (
    Performance_ID INT PRIMARY KEY AUTO_INCREMENT,
    ID INT,
    Academic_Performance INT,
    Social_Interactions INT,
    Family_Communication INT,
    Parental_Control DECIMAL(10,2),
    Addiction_Level DECIMAL(10,2),
    FOREIGN KEY (ID) REFERENCES Teenagers(ID)
	);

INSERT INTO Teenagers (ID, teen_Name, Age, Gender, Location, School_Grade)
SELECT ID, Name, Age, Gender, Location, School_Grade
FROM teen_phone_addiction_dataset;

INSERT INTO Usage_Stats (ID, Daily_Usage_Hours, Phone_Checks_Per_Day, Apps_Used_Daily, Phone_Usage_Purpose, Weekend_Usage_Hours, Screen_Time_Before_Bed)
SELECT ID, Daily_Usage_Hours, Phone_Checks_Per_Day, Apps_Used_Daily, Phone_Usage_Purpose, Weekend_Usage_Hours, Screen_Time_Before_Bed
FROM teen_phone_addiction_dataset;

INSERT INTO Time_Distribution (ID, Time_on_Social_Media, Time_on_Gaming, Time_on_Education)
SELECT ID, Time_on_Social_Media, Time_on_Gaming, Time_on_Education
FROM teen_phone_addiction_dataset;

INSERT INTO Health_Profile (ID, Sleep_Hours, Exercise_Hours, Anxiety_Level, Depression_Level, Self_Esteem)
SELECT ID, Sleep_Hours, Exercise_Hours, Anxiety_Level, Depression_Level, Self_Esteem
FROM teen_phone_addiction_dataset;

INSERT INTO Performance_Profile (ID, Academic_Performance, Social_Interactions, Family_Communication, Parental_Control, Addiction_Level)
SELECT ID, Academic_Performance, Social_Interactions, Family_Communication, Parental_Control, Addiction_Level
FROM teen_phone_addiction_dataset;

SELECT * FROM Teenagers;
SELECT * FROM Time_distribution;
SELECT * FROM Health_profile;
SELECT * FROM Performance_profile;
SELECT * FROM Usage_stats;


-- Average Addiction level by gender
SELECT Gender, AVG(Addiction_Level) AS Avg_Addiction
FROM Teenagers 
JOIN Performance_Profile ON Teenagers.ID = Performance_Profile.ID
GROUP BY Gender;

-- The result shows that the female gender has the highest addiction level(8.950645) based on average 


-- Does high phone usage have relationship with poor academic performance?
SELECT usage_stats.Daily_Usage_Hours, performance_profile.Academic_Performance
FROM Usage_Stats
JOIN Performance_Profile ON Usage_Stats.ID = Performance_Profile.ID
ORDER BY Usage_Stats.Daily_Usage_Hours DESC;

/*Looking at teenagers with the highest daily phone usage (10+ hours/day), the majority had academic scores between 55–75.
Interestingly, only a few outliers scored above 90 (probably their phone usage is educational based like surfing the internet for educational materials or they are basically genius).*/


-- Comparison of time spent on social media to time spent on education.
SELECT teenagers.teen_Name, time_distribution.Time_on_Social_Media, time_distribution.Time_on_Education
FROM Teenagers 
JOIN Time_Distribution ON teenagers.ID = Time_Distribution.ID;

/*Result shows that many teenagers appear to prioritize social media engagement over educational activities,
 and this could indicate potential distractions, reduced study time, or shifting attention spans
 in the digital era.*/
 
 
 -- What is the Addiction Levels of Top 5 Teens with the highest addiction level?
 SELECT teenagers.teen_Name, performance_profile.Addiction_Level
FROM Teenagers 
JOIN Performance_Profile  ON teenagers.ID = Performance_Profile.ID
ORDER BY Performance_Profile.Addiction_Level DESC
LIMIT 5;

/* Based on the given dataset the top 5 teens all scored a perfect 10 on the addiction scale 
which imply a sign of intense smartphone dependence.*/

SELECT 
    sleep_hours,
    ROUND(AVG(academic_performance), 2) AS avg_academic_score,
    COUNT(*) AS num_teenagers
FROM health_profile
JOIN performance_profile USING (id)
GROUP BY sleep_hours
ORDER BY sleep_hours;

-- Teenagers with sleep_hours = 4+ perform  and sleep_hours = 8 with higher scores, you can conclude:
/*On average, more sleep tends to correlate with better performance.
However, there are outliers — teenagers who perform well despite poor sleep. These outliers may be 
influenced by other factors: natural ability, strong study habits, short-term sleep deprivation, 
or external help (e.g., tutoring).*/