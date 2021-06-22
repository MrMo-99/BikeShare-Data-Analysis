
/*                                        Continued..... 
                                      Bike Share Data Analysis

     Skills Used: Union, Joins, Temp Tables, Aggregate Functions, Converting Data Types, Extracting Date and Time
                  Update, Alter Table, Create Table, Insert Into      
				  
*/


-- Adding a new column to calculate the ride length from datetime2

ALTER TABLE [dbo].[all_data_202004_202104]
ADD ride_length int

UPDATE [dbo].[all_data_202004_202104]
SET ride_length = DATEDIFF(MINUTE, started_at, ended_at)


-- Extracting month and year from datetime2 format and adding them as new columns


ALTER TABLE [dbo].[all_data_202004_202104]
ADD day_of_week nvarchar(50),
month_m nvarchar(50),
year_y nvarchar(50)

UPDATE [dbo].[all_data_202004_202104]
SET day_of_week = DATENAME(WEEKDAY, started_at),
month_m = DATENAME(MONTH, started_at),
year_y = year(started_at)


ALTER TABLE [dbo].[all_data_202004_202104]       
ADD month_int int

UPDATE [dbo].[all_data_202004_202104]             -- Extracting month num from datetime2 format
SET month_int = DATEPART(MONTH, started_at)


ALTER TABLE [dbo].[all_data_202004_202104]       
ADD date_yyyy_mm_dd date

UPDATE [dbo].[all_data_202004_202104]             -- Casting datetime2 format to date
SET date_yyyy_mm_dd = CAST(started_at AS date)


-- Deleted rows where (NULL values), (ride length = 0), (ride length < 0), (ride_length > 1440 mins) for accurate analysis


DELETE FROM [dbo].[all_data_202004_202104]
Where ride_id IS NULL OR
start_station_name IS NULL OR
ride_length IS NULL OR
ride_length = 0 OR
ride_length < 0 OR
ride_length > 1440


-- Checking for any duplicates by checking count

Select Count(DISTINCT(ride_id)) AS uniq,
Count(ride_id) AS total
From [dbo].[all_data_202004_202104]


-- Calculating Number of Riders Each Day by User Type and Creating View to store date for Further Visualization 


Create View users_per_day AS
Select 
Count(case when member_casual = 'member' then 1 else NULL END) AS num_of_members,
Count(case when member_casual = 'casual' then 1 else NULL END) AS num_of_casual,
Count(*) AS num_of_users,
day_of_week
From [dbo].[all_data_202004_202104]
Group BY day_of_week


--Calculating Average Ride Length for Each User Type and Creating View to store data for further Data Visualization


Create View avg_ride_length AS
SELECT member_casual AS user_type, AVG(ride_length)AS avg_ride_length
From [dbo].[all_data_202004_202104]
Group BY member_casual


-- Creating temporary tables exclusively for Casual Users and Members


CREATE TABLE #member_table (
ride_id nvarchar(50),
rideable_type nvarchar(50),
member_casual nvarchar(50),
ride_length int,
day_of_week nvarchar(50),
month_m nvarchar(50),
year_y int )

INSERT INTO #member_table (ride_id, rideable_type, member_casual, ride_length, day_of_week, month_m, year_y)
(Select ride_id, rideable_type, member_casual, ride_length, day_of_week, month_m, year_y
From [dbo].[all_data_202004_202104]
Where member_casual = 'member')

CREATE TABLE #casual_table (
ride_id nvarchar(50),
rideable_type nvarchar(50),
member_casual nvarchar(50),
ride_length int,
day_of_week nvarchar(50),
month_m nvarchar(50),
year_y int )

INSERT INTO #casual_table (ride_id, rideable_type, member_casual, ride_length, day_of_week, month_m, year_y)
(Select ride_id, rideable_type, member_casual, ride_length, day_of_week, month_m, year_y
From [dbo].[all_data_202004_202104]
Where member_casual = 'casual')

Select *
From #casual_table

Select *
From #member_table


-- Calculating User Traffic Every Month Since Startup


Select month_int AS Month_Num,
month_m AS Month_Name, 
year_y AS Year_Y,
Count(case when member_casual = 'member' then 1 else NULL END) AS num_of_member,
Count(case when member_casual = 'casual' then 1 else NULL END) AS num_of_casual,
Count(member_casual) AS total_num_of_users
From [dbo].[all_data_202004_202104]
Group BY year_y, month_int, month_m
ORDER BY year_y, month_int, month_m


-- Calculating Daily Traffic Since Startup 


Select 
Count(case when member_casual = 'member' then 1 else NULL END) AS num_of_members,
Count(case when member_casual = 'casual' then 1 else NULL END) AS num_of_casual,
Count(*) AS num_of_users,
date_yyyy_mm_dd AS date_d
From [dbo].[all_data_202004_202104]
Group BY date_yyyy_mm_dd
ORDER BY date_yyyy_mm_dd


-- Calculating User Traffic Hour Wise


Alter Table [dbo].[all_data_202004_202104]
ADD hour_of_day int

UPDATE [dbo].[all_data_202004_202104]
SET hour_of_day = DATEPART(hour, started_at)

Select
hour_of_day AS Hour_of_day,
Count(case when member_casual = 'member' then 1 else NULL END) AS num_of_members,
Count(case when member_casual = 'casual' then 1 else NULL END) AS num_of_casual,
Count(*) AS num_of_users
From [dbo].[all_data_202004_202104]
Group By Hour_Of_Day
Order By Hour_Of_Day


--Calculating Most Popular Stations for Casual Users, (limiting results to top 20 station)


Select
TOP 20 start_station_name AS Station_name,
Count(case when member_casual = 'casual' then 1 else NULL END) AS num_of_casual
From [dbo].[all_data_202004_202104]
Group By start_station_name
Order By num_of_casual DESC



/*
Select * 
From [dbo].[all_data_202004_202104]
*/



