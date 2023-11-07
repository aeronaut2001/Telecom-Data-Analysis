a. Write a HiveQL query to find the total number of customers in thedataset.

select count(customerID) as total_customers from telecom_data ;


b. Write a HiveQL query to find the number of customers who havechurned.

select count(*) from telecom_data
where Churn = 'yes';


c. Analyze the distribution of customers based on gender andSeniorCitizen status.

SELECT gender, SeniorCitizen, COUNT(*)
FROM telecom_data
GROUP BY gender, SeniorCitizen;


d. Determine the total charge to the company due to churned
customers.

select sum(TotalCharges) 
from telecom_data
where Churn = 'Yes';

