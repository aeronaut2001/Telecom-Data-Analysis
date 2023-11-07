a. Find the distribution of PaymentMethod among churned customers.

select PaymentMethod , count(Churn) from telecom_data
where churn = 'Yes'
group by PaymentMethod ;


b. Calculate the churn rate (percentage of customers who left) for each
InternetService category.

SELECT
    InternetService,
    COUNT(churn) * 100.0 / (SELECT COUNT(churn) FROM telecom_data WHERE Churn = 'Yes') AS churn_rate
FROM
    telecom_data
WHERE
    Churn = 'Yes'
GROUP BY
    InternetService;


c. Find the number of customers who have no dependents and have
churned, grouped by Contract type.

select Contract,count(customerID) as count
from telecom_data
where Dependents = 'No'
and Churn = 'Yes'
group by Contract


d. Find the top 5 tenure lengths that have the highest churn rates.

select tenure,count(Churn)*100/(select count(churn)from telecom_data where churn ="Yes") as churn_rate
from telecom_data
where churn ='Yes'
group by tenure
order by churn_rate desc
limit 5;


e. Calculate the average MonthlyCharges for customers who have
PhoneService and have churned, grouped by Contract type.

select Contract,avg(MonthlyCharges) as avg_charge
from telecom_data
where PhoneService = "Yes" and churn = "Yes"
group by Contract;


f. Identify which InternetService type is most associated with churned
customers.

select InternetService, count(churn) as associate from 
telecom_data
where churn = "Yes"
group by InternetService
order by associate desc
limit 1;


g. Determine if customers with a partner have a lower churn rate
compared to those without.

select 
(count(case when churn = "Yes" then 1 else Null end )*100)/count(churn) as churn_rate_p
from telecom_data
where partner = "Yes"
union all
select 
(count(case when churn = "Yes" then 1 else Null end )*100)/count(churn) as churn_rate_nop
from telecom_data
where partner = "No"


h. Analyze the relationship between MultipleLines and churn rate


select MultipleLines,(count(case when churn = "Yes" then 1 else Null end)*100)/count(churn) as churn_rate
from telecom_data
group by MultipleLines
