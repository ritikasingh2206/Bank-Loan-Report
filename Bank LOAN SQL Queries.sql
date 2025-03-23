use BankLoanDB;

select * from BankLoanData;

-- Total Loan Application
SELECt COUNT(id) AS Total_Loan_Application FROM BankLoanData; 

-- Total Loan Application for MTD
SELECt COUNT(id) AS MTD_Total_Loan_Application FROM BankLoanData
WHERE MONTH(issue_date) = 12;

-- Total Loan Application for PMTD
SELECt COUNT(id) AS PMTD_Total_Loan_Application FROM BankLoanData
WHERE MONTH(issue_date) = 11;

--Total Funded Amount 
SELECT SUM(loan_amount) AS Total_Funded_Amount FROM BankLoanData;

--Total Funded Amount for MTD
SELECT SUM(loan_amount) AS MTD_Total_Funded_Amount FROM BankLoanData
WHERE MONTH(issue_date) = 12;

--Total Funded Amount for PMTD
SELECT SUM(loan_amount) AS PMTD_Total_Funded_Amount FROM BankLoanData
WHERE MONTH(issue_date) = 11;

--Total Amount Received
SELECT SUM(total_payment) AS Total_Amount_Received FROM BankLoanData;

--Total Amount Received for MTD
SELECT SUM(total_payment) AS MTD_Total_Amount_Received FROM BankLoanData
WHERE MONTH(issue_date) = 12;

--Total Amount Received for PMTD
SELECT SUM(total_payment) AS PMTD_Total_Amount_Received FROM BankLoanData
WHERE MONTH(issue_date) = 11;

-- Average Interest Rate
SELECT ROUND(AVG(int_rate)*100,2) AS Average_Int_Rate FROM BankLoanData;

-- Average Interest Rate for MTD
SELECT ROUND(AVG(int_rate)*100,2) AS MTD_Average_Int_Rate FROM BankLoanData
WHERE MONTH(issue_date) = 12;

-- Average Interest Rate for PMTD
SELECT ROUND(AVG(int_rate)*100,2) AS PMTD_Average_Int_Rate FROM BankLoanData
WHERE MONTH(issue_date) = 11;

-- Average Debt to Ratio
SELECT ROUND(AVG(dti)*100,2) AS Average_DTI FROM BankLoanData;

-- Average Debt to Ratio for MTD
SELECT ROUND(AVG(dti)*100,2) AS MTD_Average_DTI FROM BankLoanData
WHERE MONTH(issue_date) = 12;

-- Average Debt to Ratio for PMTD
SELECT ROUND(AVG(dti)*100,2) AS PMTD_Average_DTI FROM BankLoanData
WHERE MONTH(issue_date) = 11;

-- Good Loan Percentage
SELECT 
	(COUNT(CASE WHEN loan_status in ('Fully Paid','Current') THEN id END)*100.0)
	/
	COUNT(id) AS Good_Loan_Percentage
FROM BankLoanData;

-- Good Loan Application
SELECT COUNT(id) AS Good_Loan_Application FROM BankLoanData
WHERE loan_status in ('Fully Paid','Current');

-- Good Loan Total Funded Amount
SELECT SUM(loan_amount) AS Good_Loan_Funded_Amount FROM BankLoanData
WHERE loan_status in ('Fully Paid','Current');

-- Good Loan Total Amount Received
SELECT SUM(total_payment) AS Good_Loan_Total_Amount_Received FROM BankLoanData
WHERE loan_status in ('Fully Paid','Current');

-- Bad Loan Percentage
SELECT 
	(COUNT(CASE WHEN loan_status = 'Charged Off' THEN id END)*100.0)
	/
	COUNT(id) AS Bad_Loan_Percentage
FROM BankLoanData;

-- Bad Loan Application
SELECT COUNT(id) AS Bad_Loan_Application FROM BankLoanData
WHERE loan_status = 'Charged Off';

-- Bad Loan Total Funded Amount
SELECT SUM(loan_amount) AS Bad_Loan_Funded_Amount FROM BankLoanData
WHERE loan_status = 'Charged Off';

-- Bad Loan Total Amount Received
SELECT SUM(total_payment) AS Bad_Loan_Total_Amount_Received FROM BankLoanData
WHERE loan_status = 'Charged Off';

-- Grid View
SELECT
	loan_status,
	COUNT(id) AS Total_Loan_Applications,
	SUM(loan_amount) AS Total_Amount_Funded,
	SUM(total_payment) AS Total_Amount_Received,
	ROUND(AVG(int_rate)*100,2) AS Interest_Rate,
	ROUND(AVG(dti)*100,2) AS Debt_to_income_Ratio
FROM 
	BankLoanData
GROUP BY
	loan_status;

-- MTD Amount Received and Funded
SELECT
	loan_status,
	SUM(loan_amount) AS MTD_Total_Amount_Funded,
	SUM(total_payment) AS MTD_Total_Amount_Received
FROM 
	BankLoanData
WHERE 
	MONTH(issue_date) = 12
GROUP BY
	loan_status;

-- Monthly Trends by Issue Date (Line Chart)
SELECT
	MONTH(issue_date) AS Month_No,
	DATENAME(MONTH, issue_date) AS Month_Name,
	COUNT(id) AS Total_Loan_Applications,
	SUM(loan_amount) AS Total_Amount_Funded,
	SUM(total_payment) AS Total_Amount_Received
FROM
	BankLoanData
GROUP BY
	MONTH(issue_date), DATENAME(MONTH, issue_date)
ORDER BY
	MONTH(issue_date);

-- Regional Analysis by State (Filled Map)
SELECT 
	address_state,
	COUNT(id) AS Total_Loan_Applications,
	SUM(loan_amount) AS Total_Amount_Funded,
	SUM(total_payment) AS Total_Amount_Received
FROM
	BankLoanData
GROUP BY
	address_state
ORDER BY
	address_state;

-- Loan Term Analysis (Donut Chart)
SELECT
	term,
	COUNT(id) AS Total_Loan_Applications,
	SUM(loan_amount) AS Total_Amount_Funded,
	SUM(total_payment) AS Total_Amount_Received
FROM
	BankLoanData
GROUP BY
	term
ORDER BY
	term;


-- Employee Length Analysis (Bar Chart): 
SELECT
	emp_length AS Employee_Length,
	COUNT(id) AS Total_Loan_Applications,
	SUM(loan_amount) AS Total_Amount_Funded,
	SUM(total_payment) AS Total_Amount_Received
FROM
	BankLoanData
GROUP BY
	emp_length
ORDER BY
	emp_length;

-- Loan Purpose Breakdown (Bar Chart)
SELECT
	purpose AS Loan_Purpose,
	COUNT(id) AS Total_Loan_Applications,
	SUM(loan_amount) AS Total_Amount_Funded,
	SUM(total_payment) AS Total_Amount_Received
FROM
	BankLoanData
GROUP BY
	purpose
ORDER BY
	count(id) DESC;


--Home Ownership Analysis (Tree Map)
SELECT
	home_ownership,
	COUNT(id) AS Total_Loan_Applications,
	SUM(loan_amount) AS Total_Amount_Funded,
	SUM(total_payment) AS Total_Amount_Received
FROM
	BankLoanData
GROUP BY
	home_ownership
ORDER BY
	count(id) DESC;


select * from BankLoanData;