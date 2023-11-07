a. Create a bucketed table by tenure into 6 buckets.


CREATE TABLE telecom_data_bucketed (
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
clustered by (tenure) into 6 buckets;



b. Load the data from the original table into the bucketed table.

insert overwrite table telecom_data_bucketed select* from telecom_data


c. Write a HiveQL query to find the average MonthlyCharges for
customers in each bucket.

select avg(MonthlyCharges)
from telecom_data_bucketed
where tenure between 10 and 70;


d. Find the highest TotalCharges in each tenure bucket.

SELECT 
    CASE 
        WHEN Tenure BETWEEN 0 AND 10 THEN 'bucket 1'
        WHEN Tenure BETWEEN 10 AND 20 THEN 'bucket 2'
        WHEN Tenure BETWEEN 20 AND 30 THEN 'bucket 3'
        WHEN Tenure BETWEEN 30 AND 40 THEN 'bucket 4'
        WHEN Tenure BETWEEN 40 AND 50 THEN 'bucket 5'
        WHEN Tenure BETWEEN 50 AND 60 THEN 'bucket 6'
        ELSE 'Unknown'
    END AS TenureBucket,
    MAX(TotalCharges) AS HighestTotalCharges
FROM telecom_data
GROUP BY
    CASE 
        WHEN Tenure BETWEEN 0 AND 10 THEN 'bucket 1'
        WHEN Tenure BETWEEN 10 AND 20 THEN 'bucket 2'
        WHEN Tenure BETWEEN 20 AND 30 THEN 'bucket 3'
        WHEN Tenure BETWEEN 30 AND 40 THEN 'bucket 4'
        WHEN Tenure BETWEEN 40 AND 50 THEN 'bucket 5'
        WHEN Tenure BETWEEN 50 AND 60 THEN 'bucket 6'
        ELSE 'Unknown'
    END
ORDER BY TenureBucket;


2nd approch :

SELECT 'Bucket 1' AS Bucket, MAX(TotalCharges) as
MaxCharge
FROM telecom_data_bucketed
WHERE tenure BETWEEN 1 AND 10
UNION ALL
SELECT 'Bucket 2' AS Bucket, MAX(TotalCharges) as
MaxCharge
FROM telecom_data_bucketed
WHERE tenure BETWEEN 11 AND 20
UNION ALL
SELECT 'Bucket 3' AS Bucket, MAX(TotalCharges) as
MaxCharge
FROM telecom_data_bucketed
WHERE tenure BETWEEN 21 AND 30
UNION ALL
SELECT 'Bucket 4' AS Bucket, MAX(TotalCharges) as
MaxCharge
FROM telecom_data_bucketed
WHERE tenure BETWEEN 31 AND 40
UNION ALL
SELECT 'Bucket 5' AS Bucket, MAX(TotalCharges) as
MaxCharge
FROM telecom_data_bucketed
WHERE tenure BETWEEN 41 AND 50
UNION ALL
SELECT 'Bucket 6' AS Bucket, MAX(TotalCharges) as
MaxCharge
FROM telecom_data_bucketed
WHERE tenure BETWEEN 51 AND 60;



