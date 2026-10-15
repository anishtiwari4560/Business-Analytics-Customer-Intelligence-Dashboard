-- =====================================================
-- Create Cleaned View
-- =====================================================

CREATE OR REPLACE VIEW cleaned_churn_data AS

WITH cleaned_data AS (

    SELECT
        customerID,
        TRIM(gender) AS gender,
        SeniorCitizen,
        TRIM(Partner) AS Partner,
        TRIM(Dependents) AS Dependents,
        tenure,
        TRIM(PhoneService) AS PhoneService,
        TRIM(MultipleLines) AS MultipleLines,
        TRIM(InternetService) AS InternetService,
        TRIM(OnlineSecurity) AS OnlineSecurity,
        TRIM(OnlineBackup) AS OnlineBackup,
        TRIM(DeviceProtection) AS DeviceProtection,
        TRIM(TechSupport) AS TechSupport,
        TRIM(StreamingTV) AS StreamingTV,
        TRIM(StreamingMovies) AS StreamingMovies,
        TRIM(Contract) AS Contract,
        TRIM(PaperlessBilling) AS PaperlessBilling,
        TRIM(PaymentMethod) AS PaymentMethod,
        MonthlyCharges,
        CAST(
            COALESCE(
                NULLIF(TRIM(TotalCharges), ''),
                '0'
            ) AS DECIMAL(10,2)
        ) AS TotalCharges,
        case( when seniorcitizen = 1 then 'Yes' else 'NO' END) as senipr_citize
		
		,
        TRIM(Churn) AS Churn
    FROM churn_data
)

SELECT *
FROM cleaned_data; -- Fixed: References the CTE alias above

-- Verify the view output
SELECT * FROM cleaned_churn_data;
