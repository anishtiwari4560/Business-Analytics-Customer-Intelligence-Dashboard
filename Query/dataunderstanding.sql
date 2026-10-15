
/* ==========================================================
   TELCO CUSTOMER CHURN DATASET
   DATA QUALITY ASSESSMENT REPORT
   ==========================================================

   Objective:
   Perform initial data quality checks on the churn_data table
   before conducting exploratory data analysis and modeling.

   ========================================================== */


/* 1. Preview Dataset */

SELECT *
FROM churn_data
LIMIT 5;

/* Result:
   Dataset structure and sample records verified successfully.
*/


/* 2. Missing Value Analysis */

SELECT
    SUM(CASE WHEN customerID IS NULL OR customerID = '' THEN 1 ELSE 0 END) AS customerID_nulls,
    SUM(CASE WHEN gender IS NULL OR gender = '' THEN 1 ELSE 0 END) AS gender_nulls,
    SUM(CASE WHEN tenure IS NULL THEN 1 ELSE 0 END) AS tenure_nulls,
    SUM(CASE WHEN MonthlyCharges IS NULL THEN 1 ELSE 0 END) AS monthlycharges_nulls,
    SUM(CASE WHEN TotalCharges IS NULL OR TRIM(TotalCharges) = '' THEN 1 ELSE 0 END) AS totalcharges_nulls,
    SUM(CASE WHEN Churn IS NULL OR Churn = '' THEN 1 ELSE 0 END) AS churn_nulls
FROM churn_data;

/* Result:
   customerID     : 0 missing values
   gender         : 0 missing values
   tenure         : 0 missing values
   MonthlyCharges : 0 missing values
   TotalCharges   : 11 blank values
   Churn          : 0 missing values

   Observation:
   TotalCharges is the only column requiring data cleaning.
*/


/* 3. Column-wise Missing Value Verification */

SELECT 'customerID' AS column_name,
       COUNT(*) AS missing_count
FROM churn_data
WHERE customerID IS NULL OR customerID = ''

UNION ALL

SELECT 'gender',
       COUNT(*)
FROM churn_data
WHERE gender IS NULL OR gender = ''

UNION ALL

SELECT 'TotalCharges',
       COUNT(*)
FROM churn_data
WHERE TotalCharges IS NULL
   OR TRIM(TotalCharges) = '';

/* Result:
   Confirms that only TotalCharges contains missing values.
*/


/* 4. Duplicate Customer ID Check */

SELECT
    customerID,
    COUNT(*) AS duplicate_count
FROM churn_data
GROUP BY customerID
HAVING COUNT(*) > 1;

/* Result:
   No rows returned.

   Observation:
   Customer IDs are unique.
*/


/* 5. Duplicate Record Count */

SELECT
    COUNT(*) - COUNT(DISTINCT customerID) AS duplicate_rows
FROM churn_data;

/* Result:
   duplicate_rows = 0

   Observation:
   No duplicate customer records found.
*/


/* 6. Identify Invalid TotalCharges Records */

SELECT *
FROM churn_data
WHERE TRIM(TotalCharges) = '';

/* Result:
   11 records identified with blank TotalCharges values.

   Observation:
   These records require further investigation and cleaning.
*/


/* 7. Validate Gender Values */

SELECT DISTINCT gender
FROM churn_data;

/* Result:
   Male
   Female

   Observation:
   No invalid or inconsistent gender categories detected.
*/


/* 8. Validate Churn Values */

SELECT DISTINCT Churn
FROM churn_data;

/* Result:
   Yes
   No

   Observation:
   Target variable is clean and consistent.
*/


/* 9. Check for Invalid Monthly Charges */

SELECT *
FROM churn_data
WHERE MonthlyCharges < 0;

/* Result:
   No rows returned.

   Observation:
   All MonthlyCharges values are valid.
*/


/* ==========================================================
   FINAL DATA QUALITY CONCLUSION
   ==========================================================

   Summary of Findings:
   - Dataset successfully loaded and verified.
   - No missing values found in customerID, gender,
     tenure, MonthlyCharges, or Churn columns.
   - TotalCharges contains 11 blank values.
   - No duplicate customer IDs detected.
   - No duplicate customer records detected.
   - Gender values are valid (Male, Female).
   - Churn values are valid (Yes, No).
   - No negative MonthlyCharges values found.
   - Dataset is largely clean and ready for analysis.

   ✓ No missing customer identifiers.
   ✓ No duplicate customer records.
   ✓ No invalid categorical values.
   ✓ No negative monetary values.
   ✓ Churn target variable is clean.

   Issue Identified:
   - TotalCharges contains 11 blank values.

   Recommendation:
   Investigate and handle blank TotalCharges values before
   performing EDA or predictive modeling.

   Overall Assessment:
   Dataset quality is high and suitable for further analysis
   after addressing the TotalCharges issue.

   ========================================================== */



   