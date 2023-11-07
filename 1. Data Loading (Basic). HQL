a. Download the dataset and load it into a Hive table.

CREATE TABLE telecom_data (
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
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
STORED AS TEXTFILE;



load data from local to table:

load data local inpath "file:///home/aeronautbhushan/Telecom_customer_churn_data.csv" into table telecom_data;



b. Write a query to display the top 10 rows of the table.

select * from telecom_data 
limit 10;
