
/*                                                                         Bike Share Data Analysis

                                    Skills Used: Union, Joins, Temp Tables, Aggregate Functions, Converting Data Types, Extracting Date and Time
                                                            Update, Alter Table, Create Table, Insert Into                                                       
*/


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


                                                 -- Insert the information from 13 tables to one table using UNION


INSERT INTO [dbo].[all_data_202004_202104] (ride_id, rideable_type, started_at, ended_at, start_lat, start_lng, end_lat, end_lng, member_casual)
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


                             -- Forgot to include station names, So added a new column and used JOIN to include the station names, using ride_id as key


ALTER TABLE [dbo].[all_data_202004_202104]
ADD start_station_name nvarchar(100)

UPDATE [dbo].[all_data_202004_202104]
SET start_station_name = one.start_station_name 
From [CaseStudyBikeShare].[dbo].[202004-divvy-tripdata] one INNER JOIN [dbo].[all_data_202004_202104] org ON org.ride_id = one.ride_id

UPDATE [dbo].[all_data_202004_202104]
SET start_station_name = two.start_station_name 
From [CaseStudyBikeShare].[dbo].[202005-divvy-tripdata] two INNER JOIN [dbo].[all_data_202004_202104] org ON org.ride_id = two.ride_id

UPDATE [dbo].[all_data_202004_202104]
SET start_station_name = three.start_station_name 
From [CaseStudyBikeShare].[dbo].[202006-divvy-tripdata] three INNER JOIN [dbo].[all_data_202004_202104] org ON org.ride_id = three.ride_id

UPDATE [dbo].[all_data_202004_202104]
SET start_station_name = four.start_station_name 
From [CaseStudyBikeShare].[dbo].[202007-divvy-tripdata] four INNER JOIN [dbo].[all_data_202004_202104] org ON org.ride_id = four.ride_id

UPDATE [dbo].[all_data_202004_202104]
SET start_station_name = five.start_station_name 
From [CaseStudyBikeShare].[dbo].[202008-divvy-tripdata] five INNER JOIN [dbo].[all_data_202004_202104] org ON org.ride_id = five.ride_id

UPDATE [dbo].[all_data_202004_202104]
SET start_station_name = six.start_station_name 
From [CaseStudyBikeShare].[dbo].[202009-divvy-tripdata] six INNER JOIN [dbo].[all_data_202004_202104] org ON org.ride_id = six.ride_id

UPDATE [dbo].[all_data_202004_202104]
SET start_station_name = seven.start_station_name 
From [CaseStudyBikeShare].[dbo].[202010-divvy-tripdata] seven INNER JOIN [dbo].[all_data_202004_202104] org ON org.ride_id = seven.ride_id

UPDATE [dbo].[all_data_202004_202104]
SET start_station_name = eight.start_station_name 
From [CaseStudyBikeShare].[dbo].[202011-divvy-tripdata] eight INNER JOIN [dbo].[all_data_202004_202104] org ON org.ride_id = eight.ride_id

UPDATE [dbo].[all_data_202004_202104]
SET start_station_name = nine.start_station_name 
From [CaseStudyBikeShare].[dbo].[202012-divvy-tripdata] nine INNER JOIN [dbo].[all_data_202004_202104] org ON org.ride_id = nine.ride_id

UPDATE [dbo].[all_data_202004_202104]
SET start_station_name = ten.start_station_name 
From [CaseStudyBikeShare].[dbo].[202101-divvy-tripdata] ten INNER JOIN [dbo].[all_data_202004_202104] org ON org.ride_id = ten.ride_id

UPDATE [dbo].[all_data_202004_202104]
SET start_station_name = ele.start_station_name 
From [CaseStudyBikeShare].[dbo].[202102-divvy-tripdata] ele INNER JOIN [dbo].[all_data_202004_202104] org ON org.ride_id = ele.ride_id

UPDATE [dbo].[all_data_202004_202104]
SET start_station_name = twe.start_station_name 
From [CaseStudyBikeShare].[dbo].[202103-divvy-tripdata] twe INNER JOIN [dbo].[all_data_202004_202104] org ON org.ride_id = twe.ride_id

UPDATE [dbo].[all_data_202004_202104]
SET start_station_name = thr.start_station_name 
From [CaseStudyBikeShare].[dbo].[202104-divvy-tripdata] thr INNER JOIN [dbo].[all_data_202004_202104] org ON org.ride_id = thr.ride_id


