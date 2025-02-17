
SELECT TOP 1000
	CONCAT('HST_',CONVERT(VARCHAR(8), GETDATE(), 112),'_44') AS 'JournalKey'
	,'1' AS 'Submit'
	,'1' AS 'AddOnlyJournal'
	,'Company_Reference_ID (WIP)' AS 'CompanyReferenceIDType'
	,44 AS 'CompanyReferenceID'
	,'USD' AS 'Currency'
	,'ACTUALS' AS 'LedgerType'
	,hst.dbo.vHST_ME9003.postdate AS 'AccountingDate'
	,'FARGLD' as 'JournalSource'
	,CONCAT('HST ',FORMAT(GETDATE(), 'MMM'),' ',YEAR(GETDATE()),' Journal Load') AS 'JournalEntryMemo'
	,'Account_Set_ID' AS 'LedgerAccountReferenceID_ParentIDType'
	,'Workday' AS 'LedgerAccountReferenceID_ParentID'
	,'Revenue' AS 'LedgerAccountReferenceIDType'
	,CASE 
		WHEN hst.dbo.vHST_ME9003.financialclass = 1  THEN 10078
		WHEN hst.dbo.vHST_ME9003.financialclass = 2  THEN 10078
		WHEN hst.dbo.vHST_ME9003.financialclass = 3  THEN 10078
		WHEN hst.dbo.vHST_ME9003.financialclass = 4  THEN 10078
		WHEN hst.dbo.vHST_ME9003.financialclass = 5  THEN 10078
		WHEN hst.dbo.vHST_ME9003.financialclass = 6  THEN 10078
		WHEN hst.dbo.vHST_ME9003.financialclass = 7  THEN 10078
		WHEN hst.dbo.vHST_ME9003.financialclass = 8  THEN 10078
		WHEN hst.dbo.vHST_ME9003.financialclass = 9  THEN 10078
		WHEN hst.dbo.vHST_ME9003.financialclass = 10 THEN 10078
		WHEN hst.dbo.vHST_ME9003.financialclass = 11 THEN 10078
		
		END AS 'LedgerAccountReferenceID'
	,SUM(hst.dbo.vHST_ME9003.BLTranAmount) AS 'DebitAmount'
	,0 AS 'CreditAmount'
	,'OutpatientStatLoad' AS 'LineMemo'
	,hst.dbo.vHST_ME9003.FinancialClassDesc AS 'PayorWorktag'
	,'Need to Find HST Cloumn' AS 'Worktag_Cost_Center_Reference_ID'
    ,'1' AS BP_AutoComplete
    ,'Stats_Integration_Journal_Load' AS 'BP_Comment'


FROM [HST].[dbo].[vHST_ME9003]
GROUP BY hst.dbo.vHST_ME9003.financialclass, hst.dbo.vHST_ME9003.postdate, hst.dbo.vHST_ME9003.FinancialClassDesc 

UNION ALL 


SELECT TOP 1000
	CONCAT('HST_',CONVERT(VARCHAR(8), GETDATE(), 112),'_44') AS 'JournalKey'
	,'1' AS 'Submit'
	,'1' AS 'AddOnlyJournal'
	,'Company_Reference_ID (WIP)' AS 'CompanyReferenceIDType'
	,44 AS 'CompanyReferenceID'
	,'USD' AS 'Currency'
	,'ACTUALS' AS 'LedgerType'
	,hst.dbo.vHST_ME9003.postdate AS 'AccountingDate'
	,'FARGLD' as 'JournalSource'
	,CONCAT('HST ',FORMAT(GETDATE(), 'MMM'),' ',YEAR(GETDATE()),' Journal Load') AS 'JournalEntryMemo'
	,'Account_Set_ID' AS 'LedgerAccountReferenceID_ParentIDType'
	,'Workday' AS 'LedgerAccountReferenceID_ParentID'
	,'Revenue' AS 'LedgerAccountReferenceIDType'
	,CASE 
		WHEN hst.dbo.vHST_ME9003.financialclass = 1  THEN 43040
		WHEN hst.dbo.vHST_ME9003.financialclass = 2  THEN 43040
		WHEN hst.dbo.vHST_ME9003.financialclass = 3  THEN 43040
		WHEN hst.dbo.vHST_ME9003.financialclass = 4  THEN 43040
		WHEN hst.dbo.vHST_ME9003.financialclass = 5  THEN 43040
		WHEN hst.dbo.vHST_ME9003.financialclass = 6  THEN 43040
		WHEN hst.dbo.vHST_ME9003.financialclass = 7  THEN 43040
		WHEN hst.dbo.vHST_ME9003.financialclass = 8  THEN 43040
		WHEN hst.dbo.vHST_ME9003.financialclass = 9  THEN 43040
		WHEN hst.dbo.vHST_ME9003.financialclass = 10 THEN 43040
		WHEN hst.dbo.vHST_ME9003.financialclass = 11 THEN 43040
		
		END AS 'LedgerAccountReferenceID'
	,0 AS 'DebitAmount'
	,SUM(hst.dbo.vHST_ME9003.BLTranAmount) AS 'CreditAmount'
	,'OutpatientStatLoad' AS 'LineMemo'
	,hst.dbo.vHST_ME9003.FinancialClassDesc AS 'PayorWorktag'
	,'Need to Find HST Cloumn' AS 'Worktag_Cost_Center_Reference_ID'
    ,'1' AS BP_AutoComplete
    ,'Stats_Integration_Journal_Load' AS 'BP_Comment'


FROM [HST].[dbo].[vHST_ME9003]
GROUP BY hst.dbo.vHST_ME9003.financialclass, hst.dbo.vHST_ME9003.postdate, hst.dbo.vHST_ME9003.FinancialClassDesc 
