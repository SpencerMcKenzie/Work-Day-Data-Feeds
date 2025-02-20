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
	,'44-1021-10078' AS 'LedgerAccountReferenceID'
	,SUM(hst.dbo.vHST_ME9003.BLTranAmount) AS 'DebitAmount'
	,0 AS 'CreditAmount'
	,'Revenue/Debit' AS 'EntryType'
	,'OutpatientStatLoad' AS 'LineMemo'
	,' ' AS 'PayorWorkTag'
	,'Need to Find HST Cloumn' AS 'Worktag_Cost_Center_Reference_ID'
    ,'1' AS BP_AutoComplete
    ,'Stats_Integration_Journal_Load' AS 'BP_Comment'

FROM [HST].[dbo].[vHST_ME9003]

GROUP BY hst.dbo.vHST_ME9003.accountingperiod,hst.dbo.vHST_ME9003.accountingyear


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
		WHEN hst.dbo.vHST_ME9003.FinancialClassDesc IN ('ALL KIDS BLUE CROSS','BLUE CROSS BLUE SHIELD')  THEN '44-4075-43040'
		WHEN hst.dbo.vHST_ME9003.FinancialClassDesc = 'MEDICARE PART B'  THEN '44-4075-41040'
		WHEN hst.dbo.vHST_ME9003.FinancialClassDesc IN ('PPO','TRICARE','GOVERNMENT','COMMERCIAL', 'WORKERS COMPENSATION' )  THEN '44-4075-44040'
		WHEN hst.dbo.vHST_ME9003.FinancialClassDesc = 'MEDICAID'  THEN '44-4075-42040'
		WHEN hst.dbo.vHST_ME9003.FinancialClassDesc IN ('MEDICAL OUTREACH CHARITY','SELF PAY') THEN '44-4075-47040'
		END AS 'LedgerAccountReferenceID'
	,0 AS 'DebitAmount'
	,SUM(hst.dbo.vHST_ME9003.BLTranAmount) AS 'CreditAmount'
	,'Revenue/Credit' AS 'EntryType'
	,'OutpatientStatLoad' AS 'LineMemo'
	,CASE 
		WHEN hst.dbo.vHST_ME9003.FinancialClassDesc IN ('ALL KIDS BLUE CROSS',  'BLUE CROSS BLUE SHIELD') THEN 'BCBS'
		WHEN hst.dbo.vHST_ME9003.FinancialClassDesc IN ('MEDICAID') THEN 'MEDICAID'
		WHEN hst.dbo.vHST_ME9003.FinancialClassDesc IN ('MEDICARE PART B') THEN 'MEDICARE'
		WHEN hst.dbo.vHST_ME9003.FinancialClassDesc IN ('MEDICAL OUTREACH CHARITY', 'PPO', 'TRICARE', 'WORKERS COMPENSATION', 'COMMERCIAL','GOVERNMENT') THEN 'OTHER'
		WHEN hst.dbo.vHST_ME9003.FinancialClassDesc IN ('SELF PAY') THEN 'SELF PAY'
		ELSE 'NONE'
		END AS 'PayorWorkTag'
	,'Need to Find HST Cloumn' AS 'Worktag_Cost_Center_Reference_ID'
    ,'1' AS BP_AutoComplete
    ,'Stats_Integration_Journal_Load' AS 'BP_Comment'

FROM [HST].[dbo].[vHST_ME9003]

GROUP BY hst.dbo.vHST_ME9003.accountingperiod,hst.dbo.vHST_ME9003.accountingyear, hst.dbo.vHST_ME9003.FinancialClassDesc 

UNION ALL 

/*Adjustment Debit #1 44-5926-61040, 44-5926-62040, 44-5926-63040, 44-5926-64040, 44-5926-65040*/
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
	, CASE 
		WHEN FinancialClassDesc = 'MEDICARE PART B' THEN '44-5926-61040'
		WHEN FinancialClassDesc = 'MEDICAID' THEN '44-5926-62040'
		WHEN FinancialClassDesc IN ('ALL KIDS BLUE CROSS', 'BLUE CROSS BLUE SHIELD') THEN '44-5926-63040'
		WHEN FinancialClassDesc IN ('COMMERCIAL', 'GOVERNMENT', 'PPO', 'WORKERS COMPENSATION') THEN '44-5926-64040'
		WHEN FinancialClassDesc = 'TRICARE' THEN '44-5926-65040' 
	END	AS 'LedgerAccountReferenceID'
	-- ,(SUM(hst.dbo.vHST_ME9003.CWTranAmount) + SUM(hst.dbo.vHST_ME9003.ADTranAmount)) * -1 AS 'DebitAmount'
	,(SUM(hst.dbo.vHST_ME9003.CWTranAmount) + SUM(hst.dbo.vHST_ME9003.ADTranAmount)) * -1 AS 'DebitAmount'

	,0 AS 'CreditAmount'
	,'Adjustment/Debit' AS 'EntryType'
	,'OutpatientStatLoad' AS 'LineMemo'
	,CASE 
		WHEN hst.dbo.vHST_ME9003.FinancialClassDesc IN ('ALL KIDS BLUE CROSS',  'BLUE CROSS BLUE SHIELD') THEN 'BCBS'
		WHEN hst.dbo.vHST_ME9003.FinancialClassDesc IN ('MEDICAID') THEN 'MEDICAID'
		WHEN hst.dbo.vHST_ME9003.FinancialClassDesc IN ('MEDICARE PART B') THEN 'MEDICARE'
		WHEN hst.dbo.vHST_ME9003.FinancialClassDesc IN ('MEDICAL OUTREACH CHARITY', 'PPO', 'TRICARE', 'WORKERS COMPENSATION', 'COMMERCIAL','GOVERNMENT') THEN 'OTHER'
		WHEN hst.dbo.vHST_ME9003.FinancialClassDesc IN ('SELF PAY') THEN 'SELF PAY'
		ELSE 'NONE'
		END AS 'PayorWorkTag'
	,'Need to Find HST Cloumn' AS 'Worktag_Cost_Center_Reference_ID'
    ,'1' AS BP_AutoComplete
    ,'Stats_Integration_Journal_Load' AS 'BP_Comment'


FROM [HST].[dbo].[vHST_ME9003]
WHERE FinancialClassDesc IN ('MEDICARE PART B', 'MEDICAID', 'ALL KIDS BLUE CROSS', 'BLUE CROSS BLUE SHIELD', 'COMMERCIAL', 'GOVERNMENT', 'PPO', 'WORKERS COMPENSATION', 'TRICARE')
GROUP BY  hst.dbo.vHST_ME9003.accountingperiod,hst.dbo.vHST_ME9003.accountingyear, hst.dbo.vHST_ME9003.FinancialClassDesc 

UNION ALL 

/*Adjustment Debit #2 44-5926-67040*/
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
	,'44-5926-67040' AS 'LedgerAccountReferenceID'
	-- ,(SUM(hst.dbo.vHST_ME9003.CWTranAmount) + SUM(hst.dbo.vHST_ME9003.ADTranAmount)) * -1 AS 'DebitAmount'
	,SUM(hst.dbo.vHST_ME9003.ADTranAmount) * -1 AS 'DebitAmount'
	,0 AS 'CreditAmount'
	,'Adjustment/Debit' AS 'EntryType'
	,'OutpatientStatLoad' AS 'LineMemo'
	,CASE 
		WHEN hst.dbo.vHST_ME9003.FinancialClassDesc IN ('ALL KIDS BLUE CROSS',  'BLUE CROSS BLUE SHIELD') THEN 'BCBS'
		WHEN hst.dbo.vHST_ME9003.FinancialClassDesc IN ('MEDICAID') THEN 'MEDICAID'
		WHEN hst.dbo.vHST_ME9003.FinancialClassDesc IN ('MEDICARE PART B') THEN 'MEDICARE'
		WHEN hst.dbo.vHST_ME9003.FinancialClassDesc IN ('MEDICAL OUTREACH CHARITY', 'PPO', 'TRICARE', 'WORKERS COMPENSATION', 'COMMERCIAL','GOVERNMENT') THEN 'OTHER'
		WHEN hst.dbo.vHST_ME9003.FinancialClassDesc IN ('SELF PAY') THEN 'SELF PAY'
		ELSE 'NONE'
		END AS 'PayorWorkTag'
	
	,'Need to Find HST Cloumn' AS 'Worktag_Cost_Center_Reference_ID'
    ,'1' AS BP_AutoComplete
    ,'Stats_Integration_Journal_Load' AS 'BP_Comment'


FROM [HST].[dbo].[vHST_ME9003]
WHERE FinancialClassDesc IN ('SELF PAY', 'MEDICAL OUTREACH CHARITY')
GROUP BY  hst.dbo.vHST_ME9003.accountingperiod,hst.dbo.vHST_ME9003.accountingyear, hst.dbo.vHST_ME9003.FinancialClassDesc 

UNION ALL 

/*Adjustment Debit #3 44-5926-60040*/
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
	,'44-5926-60040' AS 'LedgerAccountReferenceID'
	-- ,(SUM(hst.dbo.vHST_ME9003.CWTranAmount) + SUM(hst.dbo.vHST_ME9003.ADTranAmount)) * -1 AS 'DebitAmount'
	,(SUM(hst.dbo.vHST_ME9003.CWTranAmount) + SUM(hst.dbo.vHST_ME9003.BDTranAmount)) * -1 AS 'DebitAmount'

	,0 AS 'CreditAmount'
	,'Adjustment/Debit' AS 'EntryType'
	,'OutpatientStatLoad' AS 'LineMemo'
	,CASE 
		WHEN hst.dbo.vHST_ME9003.FinancialClassDesc IN ('ALL KIDS BLUE CROSS',  'BLUE CROSS BLUE SHIELD') THEN 'BCBS'
		WHEN hst.dbo.vHST_ME9003.FinancialClassDesc IN ('MEDICAID') THEN 'MEDICAID'
		WHEN hst.dbo.vHST_ME9003.FinancialClassDesc IN ('MEDICARE PART B') THEN 'MEDICARE'
		WHEN hst.dbo.vHST_ME9003.FinancialClassDesc IN ('MEDICAL OUTREACH CHARITY', 'PPO', 'TRICARE', 'WORKERS COMPENSATION', 'COMMERCIAL','GOVERNMENT') THEN 'OTHER'
		WHEN hst.dbo.vHST_ME9003.FinancialClassDesc IN ('SELF PAY') THEN 'SELF PAY'
		ELSE 'NONE'
		END AS 'PayorWorkTag'
	
	,'Need to Find HST Cloumn' AS 'Worktag_Cost_Center_Reference_ID'
    ,'1' AS BP_AutoComplete
    ,'Stats_Integration_Journal_Load' AS 'BP_Comment'


FROM [HST].[dbo].[vHST_ME9003]
WHERE FinancialClassDesc IN ('SELF PAY')
GROUP BY  hst.dbo.vHST_ME9003.accountingperiod,hst.dbo.vHST_ME9003.accountingyear, hst.dbo.vHST_ME9003.FinancialClassDesc 

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
	,'44-1021-10078' AS 'LedgerAccountReferenceID'
	,0 AS 'DebitAmount'
	,(SUM(hst.dbo.vHST_ME9003.CWTranAmount) + SUM(hst.dbo.vHST_ME9003.ADTranAmount) + SUM(hst.dbo.vHST_ME9003.BDTranAmount)) * -1 AS 'CreditAmount'
	,'Adjustment/Credit' AS 'EntryType'
	,'OutpatientStatLoad' AS 'LineMemo'
	,' ' AS 'PayorWorkTag'
	,'Need to Find HST Cloumn' AS 'Worktag_Cost_Center_Reference_ID'
    ,'1' AS BP_AutoComplete
    ,'Stats_Integration_Journal_Load' AS 'BP_Comment' 


FROM [HST].[dbo].[vHST_ME9003]
GROUP BY hst.dbo.vHST_ME9003.accountingperiod,hst.dbo.vHST_ME9003.accountingyear, hst.dbo.vHST_ME9003.FinancialClassDesc 
)a 
WHERE (a.DebitAmount <> 0 OR a.CreditAmount <> 0)
	AND YEAR(a.AccountingDate) = 2024 AND MONTH(a.AccountingDate) = 6
	-- AND a.LedgerAccountReferenceID = '44-5926-67040'
ORDER BY a.AccountingDate, a.PayorWorktag, a.LedgerAccountReferenceIDType, a.EntryType DESC
