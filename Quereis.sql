Create database bankloanDB;
use bankloanDB;
/*                   Table Structure                */ 
CREATE TABLE financial_loan (
    id MEDIUMINT,
    address_state CHAR(5),
    application_type VARCHAR(20),
    emp_length VARCHAR(20),
    emp_title VARCHAR(50),
    grade CHAR(2),
    home_ownership VARCHAR(20),
    issue_date DATE,
    last_credit_pull_date DATE,
    last_payment_date DATE,
    loan_status VARCHAR(20),
    next_payment_date DATE,
    member_id BIGINT,
    purpose VARCHAR(20),
    sub_grade CHAR(5),
    term VARCHAR(20),
    verification_status VARCHAR(15),
    annual_income DOUBLE(10 , 2 ),
    dti DOUBLE(6 , 4 ),
    installment DOUBLE(10 , 2 ),
    int_rate DOUBLE(6 , 4 ),
    loan_amount INT,
    total_acc INT,
    total_payment INT
);

-- Laod File
LOAD DATA INFILE 'file Path'
INTO TABLE financial_loan
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES;


-- TOTAL lOAN APPLICATIOONS	 

SELECT 
    COUNT(id) AS Total_Loan_applications
FROM
    loan_data;

-- MTD  TOTAL lOAN APPLICATIOONS

SELECT 
    COUNT(id) AS MTD_Total_Loan_applications
FROM
    loan_data
WHERE
    MONTH(issue_date) = 12
        AND YEAR(issue_date) = 2021;


-- PMTD TOTAL lOAN APPLICATIOONS
SELECT 
    COUNT(id) AS PMTD_Total_Loan_applications
FROM
    loan_data
WHERE
    MONTH(issue_date) = 11;

-- Total Loan Amount loan amount
SELECT 
    SUM(loan_amount) AS Total_loan_amount
FROM
    loan_data;

-- MTD Total Loan Amount
SELECT 
    SUM(loan_amount) AS MTD_Total_loan_amount
FROM
    loan_data
WHERE
    MONTH(issue_date) = 12
        AND YEAR(issue_date) = 2021;
 
 -- PMTD  Total Loan Amount
SELECT 
    SUM(loan_amount) AS PMTD_Total_loan_amount
FROM
    loan_data
WHERE
    MONTH(issue_date) = 11
        AND YEAR(issue_date) = 2021;
 
 -- Total Amount Received 
SELECT 
    SUM(total_payment) AS Total_amount_recived
FROM
    loan_data;	 
 
 -- MTD Total Amount Received
SELECT 
    SUM(total_payment) AS MTD_Total_amount_recived
FROM
    loan_data
WHERE
    MONTH(issue_date) = 12
        AND YEAR(issue_date) = 2021;
 
 -- PMTD Total Amount Received
SELECT 
    SUM(total_payment) AS PMTD_Total_amount_recived
FROM
    loan_data
WHERE
    MONTH(issue_date) = 11
        AND YEAR(issue_date) = 2021;
 
 
 -- avg interest rate 
SELECT 
    ROUND(AVG(int_rate) * 100, 2) AS avg_intrest_rate
FROM
    loan_data;  
 
 -- MTD Interest Rate 
SELECT 
    ROUND(AVG(int_rate) * 100, 2) AS MTD_avg_intrest_rate
FROM
    loan_data
WHERE
    MONTH(issue_date) = 12
        AND YEAR(issue_date) = 2021;
        
  -- PMTD Interest Rate 
SELECT 
    ROUND(AVG(int_rate) * 100, 2) AS PMTD_avg_intrest_rate
FROM
    loan_data
WHERE
    MONTH(issue_date) = 11
        AND YEAR(issue_date) = 2021;
  
  
  -- Average dti 
  
SELECT 
    ROUND(AVG(dti) * 100, 2) AS avg_dti
FROM
    loan_data;
  
  -- MTD Average dti
SELECT 
    ROUND(AVG(dti) * 100, 2) AS MTD_avg_dti
FROM
    loan_data
WHERE
    MONTH(issue_date) = 12
        AND YEAR(issue_date) = 2021;
   
   -- PMTD Average dti
SELECT 
    ROUND(AVG(dti) * 100, 2) AS PMTD_avg_dti
FROM
    loan_data
WHERE
    MONTH(issue_date) = 11
        AND YEAR(issue_date) = 2021;
  
 -- Good loan vs Bad loan

-- Good Loan Applications by % 
SELECT 
    (COUNT(CASE
        WHEN
            loan_status = 'Fully paid'
                OR loan_status = 'Current'
        THEN
            id
    END) * 100) / COUNT(id) AS good_loan_application_percentage
FROM
    loan_data;

-- Total Good Loan Applications 
SELECT 
    COUNT(id) AS total_good_loan_application
FROM
    loan_data
WHERE
    loan_status = 'Fully paid'
        OR loan_status = 'Current';

-- Good loan funded amount 
SELECT 
    SUM(loan_amount) AS Good_loan_funded_amount
FROM
    loan_data
WHERE
    loan_status = 'Fully paid'
        OR loan_status = 'Current';

-- Good Loan Received Amount 
SELECT 
    SUM(total_payment) AS Good_loan_funded_amount
FROM
    loan_data
WHERE
    loan_status = 'Fully paid'
        OR loan_status = 'Current';

-- Total bad Loan Applications %

SELECT 
    ((COUNT(CASE
        WHEN loan_status = 'Charged off' THEN id
    END) * 100)) / COUNT(id)
FROM
    loan_data;

-- Total bad Loan Applications 
SELECT 
    COUNT(id) AS total_bad_loan_application
FROM
    loan_data
WHERE
    loan_status = 'Charged Off';

-- Total Funded Amount For Bad Laon
SELECT 
    SUM(loan_amount) AS Bad_Loan_Funded_amount
FROM
    loan_data
WHERE
    loan_status = 'Charged Off';


-- Total Bad Loan Received amount
SELECT 
    SUM(total_payment) AS Bad_Loan_Funded_amount
FROM
    loan_data
WHERE
    loan_status = 'Charged Off';


-- loan status 

SELECT 
    loan_status,
    COUNT(id) AS Total_loan_amount,
    SUM(loan_amount) AS Total_funded_amount,
    SUM(Total_payment) AS Total_Ricived_amount,
    ROUND(AVG(int_rate * 100), 2) AS interest_rate,
    ROUND(AVG(dti * 100), 2) AS Dti
FROM
    loan_data
GROUP BY loan_status;

SELECT 
    loan_status,
    SUM(loan_amount) AS Total_funded_amount,
    SUM(Total_payment) AS Total_Ricived_amount
FROM
    loan_data
WHERE
    MONTH(issue_date) = 12
GROUP BY loan_status;

-- Bank  Loan Report overview 

SELECT 
    MONTH(issue_date) AS month_number,
    MONTHNAME(issue_date) AS month_name,
    COUNT(id) AS Total_Loan_applications,
    SUM(loan_amount) AS Total_amount_funded,
    SUM(total_payment) AS Total_amount_received
FROM
    loan_data
GROUP BY month_number , month_name
ORDER BY month_number ASC;
    


SELECT 
    address_state AS state,
    COUNT(id) AS Total_Loan_applications,
    SUM(loan_amount) AS Total_amount_funded,
    SUM(total_payment) AS Total_amount_received
FROM
    loan_data
GROUP BY state;
    
    
    
SELECT 
    address_state AS state,
    COUNT(id) AS Total_Loan_applications,
    SUM(loan_amount) AS Total_amount_funded,
    SUM(total_payment) AS Total_amount_received
FROM
    loan_data
GROUP BY state
ORDER BY SUM(loan_amount) DESC;
    
  
    
SELECT 
    term AS term,
    COUNT(id) AS Total_Loan_applications,
    SUM(loan_amount) AS Total_amount_funded,
    SUM(total_payment) AS Total_amount_received
FROM
    loan_data
GROUP BY term
ORDER BY term ASC;


-- emplyee length 
SELECT 
    emp_length AS Employee_Length,
    COUNT(id) AS Total_Loan_Applications,
    SUM(loan_amount) AS Total_Funded_Amount,
    SUM(total_payment) AS Total_Amount_Received
FROM
    loan_data
GROUP BY emp_length
ORDER BY emp_length;


-- purpose 
SELECT 
    purpose,
    COUNT(id) AS Total_Loan_Applications,
    SUM(loan_amount) AS Total_Funded_Amount,
    SUM(total_payment) AS Total_Amount_Received
FROM
    loan_data
GROUP BY purpose
ORDER BY purpose;

-- home ownership

SELECT 
    home_ownership AS Home_Ownership,
    COUNT(id) AS Total_Loan_Applications,
    SUM(loan_amount) AS Total_Funded_Amount,
    SUM(total_payment) AS Total_Amount_Received
FROM
    loan_data
GROUP BY home_ownership
ORDER BY home_ownership;


SELECT 
    purpose AS PURPOSE,
    COUNT(id) AS Total_Loan_Applications,
    SUM(loan_amount) AS Total_Funded_Amount,
    SUM(total_payment) AS Total_Amount_Received
FROM
    loan_data
WHERE
    grade = 'A'
GROUP BY purpose
ORDER BY purpose




 
 










