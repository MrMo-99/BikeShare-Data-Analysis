# Cyclistic BikeShare Data Analysis
#### Author: Mohammed Amja
#### Date: 23/06/2021

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
 -- Forgot to include station names, So added a new column and used JOIN to include the station names, using ride_id as key


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




