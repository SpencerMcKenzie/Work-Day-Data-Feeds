SELECT 
	*
	,(a.DebitAmount + (a.CreditAmount *-1)) AS 'TotalAmt'
	FROM (

/*Revenue Debit*/
SELECT 
	CONCAT('HST_',CONVERT(VARCHAR(8), GETDATE(), 112),'_44') AS 'JournalKey'
	,'1' AS 'Submit'
	,'1' AS 'AddOnlyJournal'
	,'Company_Reference_ID (WIP)' AS 'CompanyReferenceIDType'
	,44 AS 'CompanyReferenceID'
	,'USD' AS 'Currency'
	,'ACTUALS' AS 'LedgerType'
	-- ,hst.dbo.vHST_ME9003.postdate AS 'AccountingDate'
	,CONCAT(hst.dbo.vHST_ME9003.accountingperiod,'/1/',hst.dbo.vHST_ME9003.accountingyear) AS 'AccountingDate'
	,'FARGLD' as 'JournalSource'
	,CONCAT('HST ',FORMAT(GETDATE(), 'MMM'),' ',YEAR(GETDATE()),' Journal Load') AS 'JournalEntryMemo'
	,'Account_Set_ID' AS 'LedgerAccountReferenceID_ParentIDType'
	,'Workday' AS 'LedgerAccountReferenceID_ParentID'
	,'Revenue' AS 'LedgerAccountReferenceIDType'
	,CASE 
		WHEN hst.dbo.vHST_ME9003.financialclass = 1  THEN '44-1021-10078'
		WHEN hst.dbo.vHST_ME9003.financialclass = 2  THEN '44-1021-10078'
		WHEN hst.dbo.vHST_ME9003.financialclass = 3  THEN '44-1021-10078'
		WHEN hst.dbo.vHST_ME9003.financialclass = 4  THEN '44-1021-10078'
		WHEN hst.dbo.vHST_ME9003.financialclass = 5  THEN '44-1021-10078'
		WHEN hst.dbo.vHST_ME9003.financialclass = 6  THEN '44-1021-10078'
		WHEN hst.dbo.vHST_ME9003.financialclass = 7  THEN '44-1021-10078'
		WHEN hst.dbo.vHST_ME9003.financialclass = 8  THEN '44-1021-10078'
		WHEN hst.dbo.vHST_ME9003.financialclass = 9  THEN '44-1021-10078'
		WHEN hst.dbo.vHST_ME9003.financialclass = 10 THEN '44-1021-10078'
		WHEN hst.dbo.vHST_ME9003.financialclass = 11 THEN '44-1021-10078'
		END AS 'LedgerAccountReferenceID'
	,SUM(hst.dbo.vHST_ME9003.BLTranAmount) AS 'DebitAmount'
	,0 AS 'CreditAmount'
	,'Revenue/Debit' AS 'EntryType'
	,'OutpatientStatLoad' AS 'LineMemo'
	,hst.dbo.vHST_ME9003.FinancialClassDesc AS 'PayorWorktag'
	,hst.dbo.vHST_ME9003.financialclass AS 'FinancialClass'
	,'Need to Find HST Cloumn' AS 'Worktag_Cost_Center_Reference_ID'
    ,'1' AS BP_AutoComplete
    ,'Stats_Integration_Journal_Load' AS 'BP_Comment'

FROM [HST].[dbo].[vHST_ME9003]

GROUP BY hst.dbo.vHST_ME9003.financialclass, hst.dbo.vHST_ME9003.accountingperiod,hst.dbo.vHST_ME9003.accountingyear, hst.dbo.vHST_ME9003.FinancialClassDesc 


UNION ALL 

/*Revenue Credit*/
SELECT
	CONCAT('HST_',CONVERT(VARCHAR(8), GETDATE(), 112),'_44') AS 'JournalKey'
	,'1' AS 'Submit'
	,'1' AS 'AddOnlyJournal'
	,'Company_Reference_ID (WIP)' AS 'CompanyReferenceIDType'
	,44 AS 'CompanyReferenceID'
	,'USD' AS 'Currency'
	,'ACTUALS' AS 'LedgerType'
	-- ,hst.dbo.vHST_ME9003.postdate AS 'AccountingDate'
	,CONCAT(hst.dbo.vHST_ME9003.accountingperiod,'/1/',hst.dbo.vHST_ME9003.accountingyear) AS 'AccountingDate'
	,'FARGLD' as 'JournalSource'
	,CONCAT('HST ',FORMAT(GETDATE(), 'MMM'),' ',YEAR(GETDATE()),' Journal Load') AS 'JournalEntryMemo'
	,'Account_Set_ID' AS 'LedgerAccountReferenceID_ParentIDType'
	,'Workday' AS 'LedgerAccountReferenceID_ParentID'
	,'Revenue' AS 'LedgerAccountReferenceIDType'
	,CASE 
		WHEN hst.dbo.vHST_ME9003.financialclass = 1  THEN '44-4075-43040'
		WHEN hst.dbo.vHST_ME9003.financialclass = 2  THEN '44-4075-43040'
		WHEN hst.dbo.vHST_ME9003.financialclass = 3  THEN '44-4075-41040'
		WHEN hst.dbo.vHST_ME9003.financialclass = 4  THEN '44-4075-44040'
		WHEN hst.dbo.vHST_ME9003.financialclass = 5  THEN '44-4075-42040'
		WHEN hst.dbo.vHST_ME9003.financialclass = 6  THEN '44-4075-44040'
		WHEN hst.dbo.vHST_ME9003.financialclass = 7  THEN '44-4075-44040'
		WHEN hst.dbo.vHST_ME9003.financialclass = 8  THEN '44-4075-44040'
		WHEN hst.dbo.vHST_ME9003.financialclass = 9  THEN '44-4075-44040'
		WHEN hst.dbo.vHST_ME9003.financialclass = 10 THEN '44-4075-47040'
		WHEN hst.dbo.vHST_ME9003.financialclass = 11 THEN '44-4075-47040'
		END AS 'LedgerAccountReferenceID'
	,0 AS 'DebitAmount'
	,SUM(hst.dbo.vHST_ME9003.BLTranAmount) AS 'CreditAmount'
	,'Revenue/Credit' AS 'EntryType'
	,'OutpatientStatLoad' AS 'LineMemo'
	,hst.dbo.vHST_ME9003.FinancialClassDesc AS 'PayorWorktag'
	,hst.dbo.vHST_ME9003.financialclass AS 'FinancialClass'
	,'Need to Find HST Cloumn' AS 'Worktag_Cost_Center_Reference_ID'
    ,'1' AS BP_AutoComplete
    ,'Stats_Integration_Journal_Load' AS 'BP_Comment'

FROM [HST].[dbo].[vHST_ME9003]

GROUP BY hst.dbo.vHST_ME9003.financialclass, hst.dbo.vHST_ME9003.accountingperiod,hst.dbo.vHST_ME9003.accountingyear, hst.dbo.vHST_ME9003.FinancialClassDesc 

UNION ALL 

/*Adjustment Debit*/
SELECT 
	CONCAT('HST_',CONVERT(VARCHAR(8), GETDATE(), 112),'_44') AS 'JournalKey'
	,'1' AS 'Submit'
	,'1' AS 'AddOnlyJournal'
	,'Company_Reference_ID (WIP)' AS 'CompanyReferenceIDType'
	,44 AS 'CompanyReferenceID'
	,'USD' AS 'Currency'
	,'ACTUALS' AS 'LedgerType'
	-- ,hst.dbo.vHST_ME9003.postdate AS 'AccountingDate'
	,CONCAT(hst.dbo.vHST_ME9003.accountingperiod,'/1/',hst.dbo.vHST_ME9003.accountingyear) AS 'AccountingDate'
	,'FARGLD' as 'JournalSource'
	,CONCAT('HST ',FORMAT(GETDATE(), 'MMM'),' ',YEAR(GETDATE()),' Journal Load') AS 'JournalEntryMemo'
	,'Account_Set_ID' AS 'LedgerAccountReferenceID_ParentIDType'
	,'Workday' AS 'LedgerAccountReferenceID_ParentID'
	,'Adjustment' AS 'LedgerAccountReferenceIDType'
	/*
	,CASE 
		WHEN hst.dbo.vHST_ME9003.financialclass = 1  THEN '44-5926-63040' 
		WHEN hst.dbo.vHST_ME9003.financialclass = 2  THEN '44-5926-63040' 
		WHEN hst.dbo.vHST_ME9003.financialclass = 3  THEN '44-5926-61040' 
		WHEN hst.dbo.vHST_ME9003.financialclass = 4  THEN '44-5926-64040' 
		WHEN hst.dbo.vHST_ME9003.financialclass = 5  THEN '44-5926-62040' 
		WHEN hst.dbo.vHST_ME9003.financialclass = 6  THEN '44-5926-65040' 
		WHEN hst.dbo.vHST_ME9003.financialclass = 7  THEN '44-5926-64040' 
		WHEN hst.dbo.vHST_ME9003.financialclass = 8  THEN '44-5926-64040' 
		WHEN hst.dbo.vHST_ME9003.financialclass = 9  THEN '44-5926-64040' 
		WHEN hst.dbo.vHST_ME9003.financialclass = 10 THEN '44-5926-67040'
		WHEN hst.dbo.vHST_ME9003.financialclass = 11 THEN '44-5926-60040'
		END AS 'LedgerAccountReferenceID'
*/		
	
	SELECT '44-5926-61040' AS LedgerAccountReferenceID, 
       -(SUM(CASE WHEN FinancialClassDesc = 'MEDICARE PART B' THEN CWTranAmount ELSE 0 END) 
       + SUM(CASE WHEN FinancialClassDesc = 'MEDICARE PART B' THEN ADTranAmount ELSE 0 END)) AS Amount
FROM [HST].[dbo].[vHST_ME9003]
UNION ALL
SELECT '44-5926-62040', 
       -(SUM(CASE WHEN FinancialClassDesc = 'MEDICAID' THEN CWTranAmount ELSE 0 END) 
       + SUM(CASE WHEN FinancialClassDesc = 'MEDICAID' THEN ADTranAmount ELSE 0 END))
FROM [HST].[dbo].[vHST_ME9003]
UNION ALL
SELECT '44-5926-63040', 
       -(SUM(CASE WHEN FinancialClassDesc IN ('ALL KIDS BLUE CROSS', 'BLUE CROSS BLUE SHIELD') THEN CWTranAmount ELSE 0 END) 
       + SUM(CASE WHEN FinancialClassDesc IN ('ALL KIDS BLUE CROSS', 'BLUE CROSS BLUE SHIELD') THEN ADTranAmount ELSE 0 END))
FROM [HST].[dbo].[vHST_ME9003]
UNION ALL
SELECT '44-5926-64040', 
       -(SUM(CASE WHEN FinancialClassDesc IN ('COMMERCIAL', 'GOVERNMENT', 'PPO', 'WORKERS COMPENSATION') THEN CWTranAmount ELSE 0 END) 
       + SUM(CASE WHEN FinancialClassDesc IN ('COMMERCIAL', 'GOVERNMENT', 'PPO', 'WORKERS COMPENSATION') THEN ADTranAmount ELSE 0 END))
FROM [HST].[dbo].[vHST_ME9003]
UNION ALL
SELECT '44-5926-65040', 
       -(SUM(CASE WHEN FinancialClassDesc = 'TRICARE' THEN CWTranAmount ELSE 0 END) 
       + SUM(CASE WHEN FinancialClassDesc = 'TRICARE' THEN ADTranAmount ELSE 0 END))
FROM [HST].[dbo].[vHST_ME9003]
UNION ALL
SELECT '44-5926-67040', 
       -SUM(CASE WHEN FinancialClassDesc IN ('SELF PAY', 'MEDICAL OUTREACH CHARITY') THEN ADTranAmount ELSE 0 END)
FROM [HST].[dbo].[vHST_ME9003]
UNION ALL
SELECT '44-5926-60040', 
       -(SUM(CASE WHEN FinancialClassDesc = 'SELF PAY' THEN CWTranAmount ELSE 0 END) 
       + SUM(CASE WHEN FinancialClassDesc = 'SELF PAY' THEN BDTranAmount ELSE 0 END))
FROM [HST].[dbo].[vHST_ME9003]
UNION ALL
SELECT '44-1021-10078', 
       SUM(CWTranAmount) + SUM(ADTranAmount) + SUM(BDTranAmount)
FROM [HST].[dbo].[vHST_ME9003];

	-- ,(SUM(hst.dbo.vHST_ME9003.CWTranAmount) + SUM(hst.dbo.vHST_ME9003.ADTranAmount)) * -1 AS 'DebitAmount'
	,CASE 
		WHEN hst.dbo.vHST_ME9003.FinancialClassDesc IN ('MEDICARE PART B', 'MEDICAID', 'ALL KIDS BLUE CROSS', 'BLUE CROSS BLUE SHIELD', 'TRICARE') THEN (SUM(hst.dbo.vHST_ME9003.CWTranAmount) + SUM(hst.dbo.vHST_ME9003.ADTranAmount)) * -1
		WHEN hst.dbo.vHST_ME9003.FinancialClassDesc = 'SELF PAY' THEN (SUM(hst.dbo.vHST_ME9003.CWTranAmount) + SUM(hst.dbo.vHST_ME9003.BDTranAmount)) * -1
	END AS 'DebitAmount'

	,0 AS 'CreditAmount'
	,'Adjustment/Debit' AS 'EntryType'
	,'OutpatientStatLoad' AS 'LineMemo'
	,hst.dbo.vHST_ME9003.FinancialClassDesc AS 'PayorWorktag'
	,hst.dbo.vHST_ME9003.financialclass AS 'FinancialClass'
	,'Need to Find HST Cloumn' AS 'Worktag_Cost_Center_Reference_ID'
    ,'1' AS BP_AutoComplete
    ,'Stats_Integration_Journal_Load' AS 'BP_Comment'


FROM [HST].[dbo].[vHST_ME9003]
GROUP BY hst.dbo.vHST_ME9003.financialclass, hst.dbo.vHST_ME9003.accountingperiod,hst.dbo.vHST_ME9003.accountingyear, hst.dbo.vHST_ME9003.FinancialClassDesc 

UNION ALL 

/*Adjustment Credit*/
SELECT
	CONCAT('HST_',CONVERT(VARCHAR(8), GETDATE(), 112),'_44') AS 'JournalKey'
	,'1' AS 'Submit'
	,'1' AS 'AddOnlyJournal'
	,'Company_Reference_ID (WIP)' AS 'CompanyReferenceIDType'
	,44 AS 'CompanyReferenceID'
	,'USD' AS 'Currency'
	,'ACTUALS' AS 'LedgerType'
	--,hst.dbo.vHST_ME9003.postdate AS 'AccountingDate'
	,CONCAT(hst.dbo.vHST_ME9003.accountingperiod,'/1/',hst.dbo.vHST_ME9003.accountingyear) AS 'AccountingDate'
	,'FARGLD' as 'JournalSource'
	,CONCAT('HST ',FORMAT(GETDATE(), 'MMM'),' ',YEAR(GETDATE()),' Journal Load') AS 'JournalEntryMemo'
	,'Account_Set_ID' AS 'LedgerAccountReferenceID_ParentIDType'
	,'Workday' AS 'LedgerAccountReferenceID_ParentID'
	,'Adjustment' AS 'LedgerAccountReferenceIDType'
	
	,CASE 
		WHEN hst.dbo.vHST_ME9003.financialclass = 1  THEN '44-1021-10078'
		WHEN hst.dbo.vHST_ME9003.financialclass = 2  THEN '44-1021-10078'
		WHEN hst.dbo.vHST_ME9003.financialclass = 3  THEN '44-1021-10078'
		WHEN hst.dbo.vHST_ME9003.financialclass = 4  THEN '44-1021-10078'
		WHEN hst.dbo.vHST_ME9003.financialclass = 5  THEN '44-1021-10078'
		WHEN hst.dbo.vHST_ME9003.financialclass = 6  THEN '44-1021-10078'
		WHEN hst.dbo.vHST_ME9003.financialclass = 7  THEN '44-1021-10078'
		WHEN hst.dbo.vHST_ME9003.financialclass = 8  THEN '44-1021-10078'
		WHEN hst.dbo.vHST_ME9003.financialclass = 9  THEN '44-1021-10078'
		WHEN hst.dbo.vHST_ME9003.financialclass = 10 THEN '44-1021-10078'
		WHEN hst.dbo.vHST_ME9003.financialclass = 11 THEN '44-1021-10078'
		
		END AS 'LedgerAccountReferenceID'
		

	,0 AS 'DebitAmount'
	,(SUM(hst.dbo.vHST_ME9003.CWTranAmount) + SUM(hst.dbo.vHST_ME9003.ADTranAmount)) * -1 AS 'CreditAmount'
	,'Adjustment/Credit' AS 'EntryType'
	,'OutpatientStatLoad' AS 'LineMemo'
	,hst.dbo.vHST_ME9003.FinancialClassDesc AS 'PayorWorktag'
	,hst.dbo.vHST_ME9003.financialclass AS 'FinancialClass'
	,'Need to Find HST Cloumn' AS 'Worktag_Cost_Center_Reference_ID'
    ,'1' AS BP_AutoComplete
    ,'Stats_Integration_Journal_Load' AS 'BP_Comment' 


FROM [HST].[dbo].[vHST_ME9003]
GROUP BY hst.dbo.vHST_ME9003.financialclass, hst.dbo.vHST_ME9003.accountingperiod,hst.dbo.vHST_ME9003.accountingyear, hst.dbo.vHST_ME9003.FinancialClassDesc 
)a 
WHERE (a.DebitAmount <> 0 OR a.CreditAmount <> 0)
	AND YEAR(a.AccountingDate) = 2024 AND MONTH(a.AccountingDate) = 6
	-- AND a.LedgerAccountReferenceID = '44-5926-67040'
ORDER BY a.AccountingDate, a.PayorWorktag, a.LedgerAccountReferenceIDType, a.EntryType DESC
