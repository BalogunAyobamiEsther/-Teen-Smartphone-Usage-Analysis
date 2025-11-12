# -Teen-Smartphone-Usage-Analysis
A MySQL-based analysis exploring how smartphone usage affects teenagers’ academic performance, mental health, and daily habits. The project models data into related tables to uncover patterns in addiction, sleep, and social media behavior.

🎯 Project Goal

The Teen Smartphone Usage Analysis project investigates how teenagers’ smartphone habits relate to their academic performance, mental health, and daily routines.
It aims to uncover behavioral patterns such as:

The effect of long screen time on sleep and school performance

The link between social media usage and self-esteem

How gender influences smartphone addiction levels

🗂️ Database Design
Database Name

Teensmartphone_Usage

Tables and Relationships
Teenagers

Contains basic demographic and school information.

Primary Key: ID

Usage_Stats

Tracks daily smartphone activities.

Foreign Key: ID references Teenagers(ID)

Time_Distribution

Stores how time is divided among social media, gaming, and education.

Foreign Key: ID references Teenagers(ID)

Health_Profile

Includes sleep hours, exercise, anxiety, and depression metrics.

Foreign Key: ID references Teenagers(ID)

Performance_Profile

Contains academic scores, social interactions, parental control, and addiction levels.

Foreign Key: ID references Teenagers(ID)

Entity Relationship (ERD) Overview

All supporting tables (Usage_Stats, Time_Distribution, Health_Profile, Performance_Profile) are connected to the main table Teenagers through one-to-one relationships using the ID field.

🧠 Example Queries and Insights
1️⃣ Average Addiction Level by Gender
SELECT Gender, AVG(Addiction_Level) AS Avg_Addiction
FROM Teenagers 
JOIN Performance_Profile ON Teenagers.ID = Performance_Profile.ID
GROUP BY Gender;


Insight: Female teenagers have a higher average addiction level (≈ 8.95).

2️⃣ Relationship Between Daily Usage and Academic Performance
SELECT Usage_Stats.Daily_Usage_Hours, Performance_Profile.Academic_Performance
FROM Usage_Stats
JOIN Performance_Profile ON Usage_Stats.ID = Performance_Profile.ID
ORDER BY Usage_Stats.Daily_Usage_Hours DESC;


Insight: Teenagers with >10 hours of daily phone usage tend to have moderate academic scores (55–75).

3️⃣ Comparison: Social Media vs Education Time
SELECT Teenagers.Teen_Name, Time_Distribution.Time_on_Social_Media, Time_Distribution.Time_on_Education
FROM Teenagers
JOIN Time_Distribution ON Teenagers.ID = Time_Distribution.ID;


Insight: Most teens spend more time on social media than educational apps.

4️⃣ Top 5 Teens by Addiction Level
SELECT Teenagers.Teen_Name, Performance_Profile.Addiction_Level
FROM Teenagers
JOIN Performance_Profile ON Teenagers.ID = Performance_Profile.ID
ORDER BY Performance_Profile.Addiction_Level DESC
LIMIT 5;


Insight: The top 5 teens scored a perfect 10 on the addiction scale — indicating strong dependence.

5️⃣ Sleep Hours vs Academic Performance
SELECT Sleep_Hours, ROUND(AVG(Academic_Performance), 2) AS Avg_Academic_Score
FROM Health_Profile
JOIN Performance_Profile USING (ID)
GROUP BY Sleep_Hours
ORDER BY Sleep_Hours;


Insight: More sleep generally correlates with higher academic performance.

⚙️ Tool Used:

MySQL Workbench — database creation, querying, and ERD.
