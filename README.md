# Cyclistic BikeShare Data Analysis
#### Author: Mohammed Amja
#### Date: 23/06/2021

*Note: Please refer to the files in this repository to find all of the data/code/graphs/tables found in this report and much more.*
___

## Introduction
 
 Cyclistic is a Bike-Sharing coompany based in Chicago that possess more than 5,800 bicycles and 600 docking stations. Cyclistic users are more likely to use their bikes for leisure, but about 30% use them to commute for work each day. Until now, Cyclistic’s marketing strategy relied on building general awareness and appealing to broad consumer segments. The company offers single day passes, full day passes for a price for casual users, and provie an annual subscription fee for its members. Customers who purchase single-ride or full-day passes are referred to as casual riders. Customers who purchase annual memberships are Cyclistic members. 


Cyclistic has concluded that annual members are much more profitable than casual riders. Therefore, maximizing the number of annual members will be key to future growth. Rather than creating a marketing campaign that targets all-new customers, they believe creating a marketing campaign solely focused on casual users would help convert casual users into members. The company has set a clear goal of designing marketing strategies aimed at converting casual users into members. In order to do so they need to better understand the difference between how casual users differ from subscribed members and interest in analyzing the historical bike data trip to help identify trends.

___

## Problem Statements

The Company's analysts have inferred that annual members are much more profitable for the company than casual users, so they believe that the key of the company's future is depended upon maximizing the number of annual memberships. 

The business-related problem statements that could be asked to improve the company's growth rate and success is shared below:
 1. How do casual users and annual subcribed members use Cyclistic Bikes differently?
 2. How can we design new marketing strategies to help convert casual members into annual members?

___

## Preparing Data for Analysis

For this project, I've used the 13 trip-data datasets dated from April 2020 to April 2021. Click on this [link](https://divvy-tripdata.s3.amazonaws.com/index.html) to access the website and download the datasets provided as .zip files. The data provided in this website is made available to access to the public.

Or you could access and download the data from this repository named as "Raw Data".

I am using Microsoft SQL Server Management Studio in this part of the project to help process and analyze the datasets.

First make sure to import all of the dataset as a .csv file to the database server.
Check and verify if the data types of each of the columns in each dataset is same to merge them all together.

**Note: The start_station_id column of dataset from Dec 2020 to April 2020 contains string values**

```TSQL
-- Creating a table to merge 13 datasets into one table for better usability


CREATE TABLE all_data_202004_202104 (
ride_id nvarchar(255),
rideable_type nvarchar(50),
started_at datetime2,
ended_at datetime2,
start_lat float,
start_lng float,
end_lat float,
end_lng float,
member_casual nvarchar(50) )
```

```TSQL
  -- Insert the information from 13 tables to one table using UNION


INSERT INTO [dbo].[all_data_202004_202104] (ride_id, rideable_type, started_at, ended_at, start_lat,
 start_lng, end_lat, end_lng, member_casual)
(Select ride_id, rideable_type, started_at, ended_at, start_lat, start_lng, end_lat, end_lng, member_casual
From CaseStudyBikeShare.dbo.[202004-divvy-tripdata]) 
UNION ALL
(Select ride_id, rideable_type, started_at, ended_at, start_lat, start_lng, end_lat, end_lng, member_casual
From CaseStudyBikeShare.dbo.[202005-divvy-tripdata]) 
UNION ALL
(Select ride_id, rideable_type, started_at, ended_at, start_lat, start_lng, end_lat, end_lng, member_casual
From CaseStudyBikeShare.dbo.[202006-divvy-tripdata]) 
UNION ALL
(Select ride_id, rideable_type, started_at, ended_at, start_lat, start_lng, end_lat, end_lng, member_casual
From CaseStudyBikeShare.dbo.[202007-divvy-tripdata]) 
UNION ALL
(Select ride_id, rideable_type, started_at, ended_at, start_lat, start_lng, end_lat, end_lng, member_casual
From CaseStudyBikeShare.dbo.[202008-divvy-tripdata]) 
UNION ALL
(Select ride_id, rideable_type, started_at, ended_at, start_lat, start_lng, end_lat, end_lng, member_casual
From CaseStudyBikeShare.dbo.[202009-divvy-tripdata])
UNION ALL
(Select ride_id, rideable_type, started_at, ended_at, start_lat, start_lng, end_lat, end_lng, member_casual
From CaseStudyBikeShare.dbo.[202010-divvy-tripdata]) 
UNION ALL
(Select ride_id, rideable_type, started_at, ended_at, start_lat, start_lng, end_lat, end_lng, member_casual
From CaseStudyBikeShare.dbo.[202011-divvy-tripdata]) 
UNION ALL
(Select ride_id, rideable_type, started_at, ended_at, start_lat, start_lng, end_lat, end_lng, member_casual
From CaseStudyBikeShare.dbo.[202012-divvy-tripdata])
UNION ALL
(Select ride_id, rideable_type, started_at, ended_at, start_lat, start_lng, end_lat, end_lng, member_casual
From CaseStudyBikeShare.dbo.[202101-divvy-tripdata]) 
UNION ALL
(Select ride_id, rideable_type, started_at, ended_at, start_lat, start_lng, end_lat, end_lng, member_casual
From CaseStudyBikeShare.dbo.[202102-divvy-tripdata])
UNION ALL
(Select ride_id, rideable_type, started_at, ended_at, start_lat, start_lng, end_lat, end_lng, member_casual
From CaseStudyBikeShare.dbo.[202103-divvy-tripdata]) 
UNION ALL
(Select ride_id, rideable_type, started_at, ended_at, start_lat, start_lng, end_lat, end_lng, member_casual
From CaseStudyBikeShare.dbo.[202104-divvy-tripdata])
```

```TSQL
 /* Forgot to include station names, So added a new column and used JOIN to include the station names,
    using ride_id as key */


ALTER TABLE [dbo].[all_data_202004_202104]
ADD start_station_name nvarchar(100)

UPDATE [dbo].[all_data_202004_202104]
SET start_station_name = one.start_station_name 
From [CaseStudyBikeShare].[dbo].[202004-divvy-tripdata] one
INNER JOIN [dbo].[all_data_202004_202104] org ON org.ride_id = one.ride_id

UPDATE [dbo].[all_data_202004_202104]
SET start_station_name = two.start_station_name 
From [CaseStudyBikeShare].[dbo].[202005-divvy-tripdata] two 
INNER JOIN [dbo].[all_data_202004_202104] org ON org.ride_id = two.ride_id

UPDATE [dbo].[all_data_202004_202104]
SET start_station_name = three.start_station_name 
From [CaseStudyBikeShare].[dbo].[202006-divvy-tripdata] three 
INNER JOIN [dbo].[all_data_202004_202104] org ON org.ride_id = three.ride_id

UPDATE [dbo].[all_data_202004_202104]
SET start_station_name = four.start_station_name 
From [CaseStudyBikeShare].[dbo].[202007-divvy-tripdata] four 
INNER JOIN [dbo].[all_data_202004_202104] org ON org.ride_id = four.ride_id

UPDATE [dbo].[all_data_202004_202104]
SET start_station_name = five.start_station_name 
From [CaseStudyBikeShare].[dbo].[202008-divvy-tripdata] five 
INNER JOIN [dbo].[all_data_202004_202104] org ON org.ride_id = five.ride_id

UPDATE [dbo].[all_data_202004_202104]
SET start_station_name = six.start_station_name 
From [CaseStudyBikeShare].[dbo].[202009-divvy-tripdata] six 
INNER JOIN [dbo].[all_data_202004_202104] org ON org.ride_id = six.ride_id

UPDATE [dbo].[all_data_202004_202104]
SET start_station_name = seven.start_station_name 
From [CaseStudyBikeShare].[dbo].[202010-divvy-tripdata] seven 
INNER JOIN [dbo].[all_data_202004_202104] org ON org.ride_id = seven.ride_id

UPDATE [dbo].[all_data_202004_202104]
SET start_station_name = eight.start_station_name 
From [CaseStudyBikeShare].[dbo].[202011-divvy-tripdata] eight 
INNER JOIN [dbo].[all_data_202004_202104] org ON org.ride_id = eight.ride_id

UPDATE [dbo].[all_data_202004_202104]
SET start_station_name = nine.start_station_name 
From [CaseStudyBikeShare].[dbo].[202012-divvy-tripdata] nine 
INNER JOIN [dbo].[all_data_202004_202104] org ON org.ride_id = nine.ride_id

UPDATE [dbo].[all_data_202004_202104]
SET start_station_name = ten.start_station_name 
From [CaseStudyBikeShare].[dbo].[202101-divvy-tripdata] ten 
INNER JOIN [dbo].[all_data_202004_202104] org ON org.ride_id = ten.ride_id

UPDATE [dbo].[all_data_202004_202104]
SET start_station_name = ele.start_station_name 
From [CaseStudyBikeShare].[dbo].[202102-divvy-tripdata] ele 
INNER JOIN [dbo].[all_data_202004_202104] org ON org.ride_id = ele.ride_id

UPDATE [dbo].[all_data_202004_202104]
SET start_station_name = twe.start_station_name 
From [CaseStudyBikeShare].[dbo].[202103-divvy-tripdata] twe 
INNER JOIN [dbo].[all_data_202004_202104] org ON org.ride_id = twe.ride_id

UPDATE [dbo].[all_data_202004_202104]
SET start_station_name = thr.start_station_name 
From [CaseStudyBikeShare].[dbo].[202104-divvy-tripdata] thr 
INNER JOIN [dbo].[all_data_202004_202104] org ON org.ride_id = thr.ride_id

```

___


## Processing of Data

Here, I will be transforming and organizing data by adding new columns, extracting information and removing bad data and duplicates.

```TSQL
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
```



**In order to get accurate analysis, validate and make sure the dataset does not include any bias, incorrect data, and duplicates.**



```TSQL

/* Deleted rows where (NULL values), (ride length = 0), (ride length < 0), (ride_length > 1440 mins)
   for accurate analysis */


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

```

___




```TSQL
/* Calculating Number of Riders Each Day by User Type and Creating View to store date
   for Further Visualization */


Create View users_per_day AS
Select 
Count(case when member_casual = 'member' then 1 else NULL END) AS num_of_members,
Count(case when member_casual = 'casual' then 1 else NULL END) AS num_of_casual,
Count(*) AS num_of_users,
day_of_week
From [dbo].[all_data_202004_202104]
Group BY day_of_week

```
Result:

| num_of_member | num_of_casuals | num_of_users | day_of_week |
|---------------|----------------|--------------|-------------|
| 314340        | 161531         | 475871       | Wednesday   |
| 331709        | 349163         | 680872       | Saturday    |
| 279841        | 158675         | 438516       | Monday      |
| 275506        | 276480         | 551986       | Sunday      |
| 324555        | 220179         | 544734       | Friday      |
| 312168        | 169581         | 481749       | Thursday    |
| 299961        | 156905         | 456866       | Tuesday     |



```TSQL

/* Calculating Average Ride Length for Each User Type and Creating View to store data 
   for further Data Visualization */


Create View avg_ride_length AS
SELECT member_casual AS user_type, AVG(ride_length)AS avg_ride_length
From [dbo].[all_data_202004_202104]
Group BY member_casual
```

Result:
| user_type | avg_ride_length|
|-----------|-------------|
| member    | 15.61073206 |
| casual    | 36.572335   |

```TSQL

-- Creating temporary tables exclusively for Casual Users and Members


CREATE TABLE #member_table (
ride_id nvarchar(50),
rideable_type nvarchar(50),
member_casual nvarchar(50),
ride_length int,
day_of_week nvarchar(50),
month_m nvarchar(50),
year_y int )

INSERT INTO #member_table (ride_id, rideable_type, member_casual, ride_length,
 day_of_week, month_m, year_y)

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

INSERT INTO #casual_table (ride_id, rideable_type, member_casual, ride_length, day_of_week,
 month_m, year_y)

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
```

Result:
| Month_Num | Month_Name | Year_y | num_of_members | num_of_casuals | total_num_of_users |
|-----------|------------|------|---------------|---------------|-----------|
| 4         | April      | 2020 | 60522         | 23403         | 83925     |
| 5         | May        | 2020 | 112027        | 86203         | 198230    |
| 6         | June       | 2020 | 185999        | 153314        | 339313    |
| 7         | July       | 2020 | 277761        | 266506        | 544267    |
| 8         | August     | 2020 | 322695        | 281742        | 604437    |
| 9         | September  | 2020 | 286276        | 219083        | 505359    |
| 10        | October    | 2020 | 221721        | 129676        | 351397    |
| 11        | November   | 2020 | 154489        | 77904         | 232393    |
| 12        | December   | 2020 | 92279         | 26266         | 118545    |
| 1         | January    | 2021 | 71659         | 15794         | 87453     |
| 2         | February   | 2021 | 35763         | 9059          | 44822     |
| 3         | March      | 2021 | 133645        | 78316         | 211961    |
| 4         | April      | 2021 | 183244        | 125248        | 308492    |


```TSQL
-- Calculating Daily Traffic Since Startup 


Select 
Count(case when member_casual = 'member' then 1 else NULL END) AS num_of_members,
Count(case when member_casual = 'casual' then 1 else NULL END) AS num_of_casual,
Count(*) AS num_of_users,
date_yyyy_mm_dd AS date_d
From [dbo].[all_data_202004_202104]
Group BY date_yyyy_mm_dd
ORDER BY date_yyyy_mm_dd

```

```TSQL
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
```

Result:
| Hour_of_day | num_of_members | num_of_casuals | num_of_users |
|-------------|----------------|----------------|-----------|
| 0           | 12656          | 23645          | 36301     |
| 1           | 7144           | 14733          | 21877     |
| 2           | 3679           | 7842           | 11521     |
| 3           | 2305           | 4159           | 6464      |
| 4           | 3745           | 3438           | 7183      |
| 5           | 18302          | 5496           | 23798     |
| 6           | 59197          | 13207          | 72404     |
| 7           | 99943          | 23661          | 123604    |
| 8           | 108092         | 32693          | 140785    |
| 9           | 90665          | 41789          | 132454    |
| 10          | 95594          | 60333          | 155927    |
| 11          | 119169         | 83513          | 202682    |
| 12          | 140760         | 102388         | 243148    |
| 13          | 139621         | 111509         | 251130    |
| 14          | 139825         | 117972         | 257797    |
| 15          | 155960         | 124557         | 280517    |
| 16          | 187856         | 132564         | 320420    |
| 17          | 227149         | 148776         | 375925    |
| 18          | 197734         | 134120         | 331854    |
| 19          | 136824         | 101926         | 238750    |
| 20          | 82888          | 70519          | 153407    |
| 21          | 49895          | 51397          | 101292    |
| 22          | 35195          | 45692          | 80887     |
| 23          | 23882          | 36585          | 60467     |


```TSQL
--Calculating Most Popular Stations for Casual Users, (limiting results to top 20 station)


Select
TOP 20 start_station_name AS Station_name,
Count(case when member_casual = 'casual' then 1 else NULL END) AS num_of_casual
From [dbo].[all_data_202004_202104]
Group By start_station_name
Order By num_of_casual DESC

```

Result: 
| station_name                 | num_of_casuals |
|------------------------------|---------------|
| Streeter Dr & Grand Ave      | 28344         |
| Lake Shore Dr & Monroe St    | 23381         |
| Millennium Park              | 21444         |
| Theater on the Lake          | 16151         |
| Michigan Ave & Oak St        | 15222         |
| Indiana Ave & Roosevelt Rd   | 14708         |
| Lake Shore Dr & North Blvd   | 14483         |
| Clark St & Elm St            | 12828         |
| Michigan Ave & Lake St       | 12760         |
| Michigan Ave & Washington St | 11657         |
| Shedd Aquarium               | 11148         |
| Clark St & Lincoln Ave       | 11092         |
| Buckingham Fountain          | 10989         |
| Wells St & Concord Ln        | 10927         |
| Clark St & Armitage Ave      | 10687         |
| Wabash Ave & Grand Ave       | 10610         |
| Michigan Ave & 8th St        | 10504         |
| Columbus Dr & Randolph St    | 10338         |
| Wells St & Elm St            | 10067         |
| Fairbanks Ct & Grand Ave     | 9675          |

___


## Visualizing Data

In this phase, we will be visualizing the data analyzed and tables created using Tableau Public.

For the interactive version, [Click here](https://public.tableau.com/app/profile/mohammed.amja5151/viz/BikeShareAnalysisVisualized/BikeShareAnalysisVisualized)

**Average Ride Duration:**


From inferring to the figure shown below. We can conclude that casual members on average tend to ride bikes for a longer duration of time than annual members.


![Avg Ride Duration](https://user-images.githubusercontent.com/83900526/123244664-c31be180-d501-11eb-9e92-9929671ecc17.png)

**Users Per Day Of the Week:**

The data suggests that casual users are more inclined to use the bikes on a weekend, while members tend to use them more on weekdays.

![Users Per Day of Week](https://user-images.githubusercontent.com/83900526/123246014-fe6ae000-d502-11eb-891e-30aa892b178f.png)


**Hourly Traffic Analysis of Users**

Although both groups seem to prefer evening rides, from **3:00PM - 7:00PM**, annual members also seem to have higher usage in the morning from **6:00AM - 9:00AM**.

![Hourly Traffic](https://user-images.githubusercontent.com/83900526/123246956-ff504180-d503-11eb-8dac-58be3478bf38.png)


**Monthly User Traffic**

The graph depicts that irrespective of the user type, the usage of their bikes are highest in the months **June - October**. While lowest traffic occurs from **November - March**.

![Monthly Traffic](https://user-images.githubusercontent.com/83900526/123247143-3161a380-d504-11eb-8cb9-d4e69a71b35a.png)


**Most Popular Stations for Casual Users**

Top 20 most popular stations for casual users.

![Most Popular Stations for Casuals](https://user-images.githubusercontent.com/83900526/123248777-f1032500-d505-11eb-92d8-8ed2f784613e.png)

**Tableau Dashboard**

Visualizations built in a dashboard. 

![BikeShare Analysis Dashboard](https://user-images.githubusercontent.com/83900526/123249276-6969e600-d506-11eb-8ecd-9619fb564647.png)

___

## Conclusion

After performing the collection, transformation, cleaning, organisation and analysis of the given 13 datasets, we have enough factual evidence to suggest answers to the business-related questions that were asked.

We can infer that casual users are more likely to use their bikes for a longer duration of time. Casual users are also more inclined to ride during evening hours of **3:00PM - 7PM** and weekends is when most of the casual users prefer to ride. While user traffic for both groups are highest during the months of summer, the months of winter is when user traffic significantly drops for both user types.

In order to design new marketing strategies to better focus on and suit the casual users to help convert them into buying annual memberships, we have to refer to the analysis provided above and keep those facts in mind. The recommendations I would provide to help solve this business-related scenario is shown below.

#### Top Recommendations to Marketing Strategists:

* Implement advertising annual memberships prices more using billboards/posters near the top 20 most popular stations for casual users.
* Provide a limited discount on annual memberships purchased during the months of lowest traffic to increase rider usage in these months.
* Have frequent advertisements on social media and television during peak hours and peak months, since that is when most people have a thought about riding bikes.
* Start provide free ride minutes for every minute passed after 30 minutes of usage, where the free minutes can **ONLY** be redeemed on weekdays to help promote rider usage during weekdays. 




