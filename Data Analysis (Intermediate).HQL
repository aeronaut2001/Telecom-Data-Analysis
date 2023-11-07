a. Write a HiveQL query to find the number of customers who have churned, grouped by their Contract type.

select Contract,count(customerID) from  telecom_data
where Churn = 'Yes'
group by Contract;


b. Write a HiveQL query to find the average MonthlyCharges for customers who have churned vs those who have not.

select churn,avg(MonthlyCharges) as avg_month_charge
from telecom_data 
group by churn;


c. Determine the maximum, minimum, and average tenure of the
customers.

select max(tenure) as max_tenure,min(tenure) as min_tenure,avg(tenure) as avg_tenure from telecom_data


d. Find out which PaymentMethod is most popular among customers.

select PaymentMethod , count(PaymentMethod) as least_popular from telecom_data
group by PaymentMethod 
order by least_popular desc 
limit 1 ;


e. Analyze the relationship between PaperlessBilling and churn rate.

select PaperlessBilling,count(churn) as churn_rate
from telecom_data
where churn = 'Yes'
group by paperlessbilling;
