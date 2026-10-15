
/*====================================================================
                    CUSTOMER CHURN ANALYSIS PROJECT
======================================================================

Dataset  : cleaned_churn_data
Rows     : 7,043
Objective: Identify key drivers of customer churn and revenue loss.

======================================================================
1. GENERAL OVERVIEW
======================================================================*/

/* Question:
   How many customer records are available in the dataset?
*/

SELECT
    COUNT(*) AS total_records
FROM cleaned_churn_data;

/*
Result:
-------
Total Records = 7,043
*/


/*====================================================================
2. OVERALL CHURN RATE
======================================================================*/

/* Question:
   What is the overall customer churn rate?
*/

SELECT
    COUNT(*) AS total_customers,
    SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS churned_customers,
    ROUND(
        SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) * 100.0 /
        COUNT(*),
        2
    ) AS churn_rate
FROM cleaned_churn_data;

/*
Result:
-------
Total Customers   : 7,043
Churned Customers : 1,869
Churn Rate        : 26.54%
*/


/*====================================================================
3. CHURN BY GENDER
======================================================================*/

/* Question:
   Does churn vary by gender?
*/

SELECT
    gender,
    COUNT(*) AS customers,
    SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS churned_customers,
    ROUND(
        SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) * 100.0 /
        COUNT(*),
        2
    ) AS churn_rate
FROM cleaned_churn_data
GROUP BY gender
ORDER BY churn_rate DESC;

/*
Result:
-------
Female : 3,488 customers | 939 churned | 26.92%
Male   : 3,555 customers | 930 churned | 26.16%

Insight:
Gender has minimal impact on churn.
*/


/*====================================================================
4. CHURN BY SENIOR CITIZEN STATUS
======================================================================*/

/* Question:
   Are senior citizens more likely to churn?
*/

SELECT
    SeniorCitizen,
    COUNT(*) AS customers,
    SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS churned_customers,
    ROUND(
        SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) * 100.0 /
        COUNT(*),
        2
    ) AS churn_rate
FROM cleaned_churn_data
GROUP BY SeniorCitizen;

/*
Result:
-------
No  : 5,901 customers | 1,397 churned | 23.61%
Yes : 1,142 customers |   476 churned | 41.68%

Insight:
Senior citizens churn significantly more than non-senior customers.
*/


/*====================================================================
5. CHURN BY CONTRACT TYPE
======================================================================*/

/* Question:
   Which contract type experiences the highest churn?
*/

SELECT
    Contract,
    COUNT(*) AS customers,
    SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS churned_customers,
    ROUND(
        SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) * 100.0 /
        COUNT(*),
        2
    ) AS churn_rate
FROM cleaned_churn_data
GROUP BY Contract
ORDER BY churn_rate DESC;

/*
Result:
-------
Month-to-month : 3,875 customers | 1,655 churned | 42.71%
One year       : 1,473 customers |   166 churned | 11.27%
Two year       : 1,695 customers |    48 churned |  2.83%

Insight:
Long-term contracts strongly reduce churn risk.
*/


/*====================================================================
6. CHURN BY INTERNET SERVICE
======================================================================*/

SELECT
    InternetService,
    COUNT(*) AS customers,
    SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS churned_customers,
    ROUND(
        SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) * 100.0 /
        COUNT(*),
        2
    ) AS churn_rate
FROM cleaned_churn_data
GROUP BY InternetService
ORDER BY churn_rate DESC;

/*
Result:
-------
Fiber Optic : 3,096 customers | 1,297 churned | 41.89%
DSL         : 2,421 customers |   459 churned | 18.96%
No Service  : 1,526 customers |   113 churned |  7.40%

Insight:
Fiber Optic customers have the highest churn rate.
*/


/*====================================================================
7. CHURN BY PAYMENT METHOD
======================================================================*/

SELECT
    PaymentMethod,
    COUNT(*) AS customers,
    SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS churned_customers,
    ROUND(
        SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) * 100.0 /
        COUNT(*),
        2
    ) AS churn_rate
FROM cleaned_churn_data
GROUP BY PaymentMethod
ORDER BY churn_rate DESC;

/*
Result:
-------
Electronic Check     : 45.29%
Mailed Check         : 19.11%
Bank Transfer Auto   : 16.71%
Credit Card Auto     : 15.24%

Insight:
Electronic check users are most likely to churn.
*/


/*====================================================================
8. MONTHLY CHARGES ANALYSIS
======================================================================*/

SELECT
    Churn,
    ROUND(AVG(MonthlyCharges), 2) AS avg_monthly_charge
FROM cleaned_churn_data
GROUP BY Churn;

/*
Result:
-------
Retained Customers : 61.27
Churned Customers  : 74.44

Insight:
Customers paying higher monthly charges are more likely to churn.
*/


/*====================================================================
9. TOTAL CHARGES ANALYSIS
======================================================================*/

SELECT
    Churn,
    ROUND(AVG(TotalCharges), 2) AS avg_total_charge
FROM cleaned_churn_data
GROUP BY Churn;


/*====================================================================
10. TENURE ANALYSIS
======================================================================*/

SELECT
    Churn,
    ROUND(AVG(tenure), 2) AS avg_tenure
FROM cleaned_churn_data
GROUP BY Churn;

/*
Result:
-------
Retained Customers : 37.57 Months
Churned Customers  : 17.98 Months

Insight:
Customers are leaving relatively early.
*/


/*====================================================================
11. CHURN BY TENURE GROUP
======================================================================*/

SELECT
    CASE
        WHEN tenure <= 12 THEN '0-12 Months'
        WHEN tenure <= 24 THEN '13-24 Months'
        WHEN tenure <= 48 THEN '25-48 Months'
        ELSE '49+ Months'
    END AS tenure_group,
    COUNT(*) AS customers,
    SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS churned_customers,
    ROUND(
        SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) * 100.0 /
        COUNT(*),
        2
    ) AS churn_rate
FROM cleaned_churn_data
GROUP BY tenure_group
ORDER BY churn_rate DESC;

/*
Result:
-------
0-12 Months  : 47.44%
13-24 Months : 28.71%
25-48 Months : 20.39%
49+ Months   :  9.51%

Insight:
Most churn occurs within the first year.
*/


/*====================================================================
12. DASHBOARD KPI SUMMARY
======================================================================*/

SELECT
    COUNT(*) AS total_customers,
    SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS churned_customers,
    ROUND(AVG(MonthlyCharges), 2) AS avg_monthly_charge,
    ROUND(AVG(tenure), 2) AS avg_tenure,
    ROUND(SUM(TotalCharges), 2) AS total_revenue
FROM cleaned_churn_data;

/*
Result:
-------
Total Customers    : 7,043
Churned Customers  : 1,869
Avg Monthly Charge : 64.76
Avg Tenure         : 32.37
Total Revenue      : 16,056,168.70
*/


/*====================================================================
13. REVENUE LOST DUE TO CHURN
======================================================================*/

WITH revenue_summary AS (
    SELECT
        SUM(TotalCharges) AS total_revenue,
        SUM(
            CASE
                WHEN Churn = 'Yes'
                THEN TotalCharges
                ELSE 0
            END
        ) AS churn_revenue
    FROM cleaned_churn_data
)
SELECT
    *,
    ROUND(
        churn_revenue * 100.0 /
        NULLIF(total_revenue, 0),
        2
    ) AS revenue_loss_percentage
FROM revenue_summary;

/*
Result:
-------
Total Revenue      : 16,056,168.70
Revenue Lost       : 2,862,926.90
Revenue Lost %     : 17.83%
*/


/*====================================================================
14. CUSTOMER VALUE SEGMENTATION
======================================================================*/

SELECT
    CASE
        WHEN TotalCharges >= 500 THEN 'High Value'
        WHEN TotalCharges >= 200 THEN 'Medium Value'
        ELSE 'Low Value'
    END AS customer_segment,
    COUNT(*) AS customers,
    ROUND(
        SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) * 100.0 /
        COUNT(*),
        2
    ) AS churn_rate
FROM cleaned_churn_data
GROUP BY customer_segment;

/*
Result:
-------
Low Value    : 48.15%
Medium Value : 31.14%
High Value   : 20.67%

Insight:
Low-value customers have the highest churn rate.
*/


/*====================================================================
15. SERVICE IMPACT ANALYSIS
======================================================================*/

SELECT
    OnlineSecurity,
    ROUND(
        SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) * 100.0 /
        COUNT(*),
        2
    ) AS churn_rate
FROM cleaned_churn_data
GROUP BY OnlineSecurity;

/*
Result:
-------
No                  : 41.77%
Yes                 : 14.61%
No Internet Service : 7.40%

Insight:
Online security is strongly associated with customer retention.
*/


/*====================================================================
16. MULTI-DIMENSIONAL CHURN ANALYSIS
======================================================================*/

SELECT
    Contract,
    OnlineSecurity,
    COUNT(*) AS customers,
    ROUND(
        SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) * 100.0 /
        COUNT(*),
        2
    ) AS churn_rate
FROM cleaned_churn_data
GROUP BY
    Contract,
    OnlineSecurity
ORDER BY churn_rate DESC;

/*
Top Finding:
------------
Month-to-month customers without Online Security
show the highest churn rate (51.05%).
*/


/*====================================================================
17. TOP RISK SEGMENTS
======================================================================*/

WITH segment AS (
    SELECT
        Contract,
        InternetService,
        COUNT(*) AS customers,
        SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS churned_customers
    FROM cleaned_churn_data
    GROUP BY
        Contract,
        InternetService
)
SELECT
    *,
    ROUND(
        churned_customers * 100.0 / customers,
        2
    ) AS churn_rate
FROM segment
ORDER BY churn_rate DESC;

/*
Result:
-------
Month-to-month + Fiber Optic : 54.61%
Month-to-month + DSL         : 32.22%
One Year + Fiber Optic       : 19.29%

Insight:
Month-to-month Fiber Optic customers represent
the highest-risk churn segment.
*/


/*====================================================================
FINAL BUSINESS CONCLUSIONS
======================================================================

1. Overall churn rate is 26.54%.

2. Month-to-month contracts are the strongest churn driver
   with a churn rate of 42.71%.

3. Fiber Optic customers churn at 41.89%.

4. Electronic Check customers churn at 45.29%.

5. Customers within their first 12 months churn at 47.44%.

6. Customers without Online Security churn at 41.77%.

7. Senior Citizens churn at 41.68%.

8. Revenue lost due to churn equals $2.86M (17.83%).

9. Highest-risk segment:
   Month-to-month + Fiber Optic customers.

10. Recommended actions:
    - Encourage long-term contracts.
    - Promote Online Security bundles.
    - Improve onboarding for new customers.
    - Investigate Fiber Optic customer issues.
    - Migrate Electronic Check users to Auto-Pay.

====================================================================*/