a. Load the demographics dataset into another Hive table.

CREATE TABLE  demographic_data (
    customerID STRING,
    City STRING,
    Lat DECIMAL(9, 6),
    Long DECIMAL(9, 6),
    country STRING,
    iso2 STRING,
    State STRING
);

load data local inpath 'file:///home/aeronautbhushan/CustomerDemographics.csv' into table demographic_data;


b. Write HiveQL queries to join the customer churn table and the
demographics table on customerID using different types of joins -
common join, map join, bucket map join, and sorted merge bucket join.



-- Common Join
SELECT *
FROM telecom_data AS td
JOIN  demographic_data AS d
ON td.customerID = d.customerID;


-- map Join :
Map join is an optimization technique in Hive where one of the tables is loaded into memory as a hashmap and the other table is streamed through to perform the join. Map join is automatically enabled by Hive when the smaller table can fit in memory.

SET hive.auto.convert.join = true;
SET hive.mapjoin.smalltable.filesize = 25000000; -- Specify the threshold for small tables


SELECT *
FROM telecom_data AS td
JOIN demographic_data AS d
ON td.customerID = d.customerID;

(((
note:
bigger table should be 1st then smaller once
)))


--bucket map join:
Map join is an optimization technique in Hive where one of the tables is loaded into memory as a hashmap and the other table is streamed through to perform the join. Map join is automatically enabled by Hive when the smaller table can fit in memory.



(((note: for bucketed join both table should be bucketed)))

step 1 : make both table bucketed


--telecom_data bucket table


CREATE TABLE telecom_data_bucketed_1 (
customerID STRING,
gender STRING,
SeniorCitizen INT,
Partner STRING,
Dependents STRING,
tenure INT,
PhoneService STRING,
MultipleLines STRING,
InternetService STRING,
OnlineSecurity STRING,
OnlineBackup STRING,
DeviceProtection STRING,
TechSupport STRING,
StreamingTV STRING,
StreamingMovies STRING,
Contract STRING,
PaperlessBilling STRING,
PaymentMethod STRING,
MonthlyCharges FLOAT,
TotalCharges FLOAT,
Churn STRING
)
clustered by (customerID) into 4 buckets;


Load the data from the original table into the bucketed table.

insert overwrite table telecom_data_bucketed_1 select* from telecom_data


--demographic_data


CREATE TABLE  demographic_data_bucketed (
    customerID STRING,
    City STRING,
    Lat DECIMAL(9, 6),
    Long DECIMAL(9, 6),
    country STRING,
    iso2 STRING,
    State STRING
)
clustered by (customerID) into 4 buckets;

Load the data from the original table into the bucketed table.

insert overwrite table demographic_data_bucketed select* from demographic_data


step 2:
join both table

-- Enable bucket map join optimization :
SET hive.auto.convert.join = true;


SELECT  *
FROM telecom_data_bucketed_1 AS td
JOIN demographic_data_bucketed AS dd
ON td.customerID = dd.customerID;


--Sorted Merge Bucket Join:
Sorted merge bucket join is another optimization technique that requires both tables to be bucketed and sorted on the join column. This type of join can be very efficient for certain scenarios.


step 1 : make both table bucketed


--telecom_data bucket table


CREATE TABLE telecom_data_bucketed_2 (
customerID STRING,
gender STRING,
SeniorCitizen INT,
Partner STRING,
Dependents STRING,
tenure INT,
PhoneService STRING,
MultipleLines STRING,
InternetService STRING,
OnlineSecurity STRING,
OnlineBackup STRING,
DeviceProtection STRING,
TechSupport STRING,
StreamingTV STRING,
StreamingMovies STRING,
Contract STRING,
PaperlessBilling STRING,
PaymentMethod STRING,
MonthlyCharges FLOAT,
TotalCharges FLOAT,
Churn STRING
)
clustered by (customerID) SORTED BY (customerID) into 4 buckets;


Load the data from the original table into the bucketed table.

insert overwrite table telecom_data_bucketed_2 select* from telecom_data


--demographic_data


CREATE TABLE  demographic_data_bucketed_2 (
    customerID STRING,
    City STRING,
    Lat DECIMAL(9, 6),
    Long DECIMAL(9, 6),
    country STRING,
    iso2 STRING,
    State STRING
)
clustered by (customerID) SORTED BY (customerID) into 4 buckets;

Load the data from the original table into the bucketed table.

insert overwrite table demographic_data_bucketed_2 select* from demographic_data;


step 2:
join both table

-- Enable sorted merge bucket join optimization
SET hive.auto.convert.join = true;


SELECT  *
FROM telecom_data_bucketed_2 AS td
JOIN demographic_data_bucketed_2 AS dd
ON td.customerID = dd.customerID;
