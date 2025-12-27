-- Create Table: customers
CREATE TABLE customers (
    customerID VARCHAR(50) PRIMARY KEY,
    gender VARCHAR(10),
    SeniorCitizen INT,
    Partner VARCHAR(5),
    Dependents VARCHAR(5),
    tenure INT,
    PhoneService VARCHAR(5),
    MultipleLines VARCHAR(20),
    InternetService VARCHAR(20),
    OnlineSecurity VARCHAR(5),
    OnlineBackup VARCHAR(5),
    DeviceProtection VARCHAR(5),
    TechSupport VARCHAR(5),
    StreamingTV VARCHAR(5),
    StreamingMovies VARCHAR(5),
    Contract VARCHAR(50),
    PaperlessBilling VARCHAR(5),
    PaymentMethod VARCHAR(50),
    MonthlyCharges NUMERIC(10,2),
    TotalCharges NUMERIC(10,2),
    Churn INT
);

--  Import Cleaned Data
-- Replace path with your CSV location
\copy customers FROM 'C:\Users\Admin\Desktop\sql\Telco-Customer-Churn_cleaned.csv' CSV HEADER;


--  Verify Table & Data
SELECT * FROM customers LIMIT 10;
SELECT COUNT(*) AS total_customers FROM customers;

--  Overall Churn Rate
SELECT ROUND(100.0 * SUM(Churn) / COUNT(*), 2) AS churn_rate_percent
FROM customers;

--  Churned vs Retained
SELECT 
    CASE 
        WHEN Churn = 1 THEN 'Churned'
        ELSE 'Retained'
    END AS status,
    COUNT(*) AS total_customers
FROM customers
GROUP BY status;


--  Churn by Gender
SELECT gender, COUNT(*) AS churned_customers
FROM customers
WHERE Churn = 1
GROUP BY gender;


-- Churn by SeniorCitizen
SELECT SeniorCitizen, COUNT(*) AS churned_customers
FROM customers
WHERE Churn = 1
GROUP BY SeniorCitizen;


--  Churn by Contract Type

SELECT Contract, COUNT(*) AS churned_customers
FROM customers
WHERE Churn = 1
GROUP BY Contract
ORDER BY churned_customers DESC;


-- Churn by Payment Method

SELECT PaymentMethod, COUNT(*) AS churned_customers
FROM customers
WHERE Churn = 1
GROUP BY PaymentMethod
ORDER BY churned_customers DESC;

-- Churn by Tenure Groups

SELECT 
    CASE
        WHEN tenure < 12 THEN '0-1 Year'
        WHEN tenure BETWEEN 12 AND 24 THEN '1-2 Years'
        ELSE '2+ Years'
    END AS tenure_group,
    COUNT(*) AS churned_customers
FROM customers
WHERE Churn = 1
GROUP BY tenure_group;


-- 11️⃣ Average Monthly Charges for Churned vs Retained

SELECT Churn, ROUND(AVG(MonthlyCharges), 2) AS avg_monthly_charge
FROM customers
GROUP BY Churn;


-- High-risk Customers (Tenure < 12 & High Charges)

SELECT customerID, tenure, MonthlyCharges, Contract, PaymentMethod
FROM customers
WHERE Churn = 1
AND tenure < 12
AND MonthlyCharges > 70;


-- Churn Percentage by Contract

SELECT 
    Contract,
    ROUND(100.0 * SUM(Churn) / COUNT(*), 2) AS churn_rate_percent
FROM customers
GROUP BY Contract
ORDER BY churn_rate_percent DESC;


