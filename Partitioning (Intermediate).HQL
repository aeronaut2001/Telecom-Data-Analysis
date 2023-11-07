a. Create a partitioned table by Contract and load the data from the
original table.


CREATE TABLE telecom_data_partition (
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
PaperlessBilling STRING,
PaymentMethod STRING,
MonthlyCharges FLOAT,
TotalCharges FLOAT,
Churn STRING
)
PARTITIONED BY (Contract string);


set hive.exec.dynamic.partition.mode=nonstrict


(((
note : we use this because we are doing dynamic partition 
)))

insert overwrite table telecom_data_partition partition(Contract) select*from telecom_data;
----------------

b. Write a HiveQL query to find the number of customers who have
churned in each Contract type using the partitioned table.

select Contract,count(Churn)
from telecom_data_partition
where Churn = 'Yes'
group by Contract;

--------------
c. Find the average MonthlyCharges for each type of Contract using the
partitioned table.

select Contract,avg(MonthlyCharges)
from telecom_data
group by Contract;

--------------
d. Determine the maximum tenure in each Contract type partition.

select Contract,max(tenure) as max_tenure
from telecom_data_partition
group by Contract;


