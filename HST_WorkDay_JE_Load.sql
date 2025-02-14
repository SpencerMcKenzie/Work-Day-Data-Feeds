
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
	,'Ledger Account ID' AS 'LedgerAccountReferenceIDType'
	,'Need to Find HST Cloumn' AS 'LedgerAccountReferenceID'
	,'Need to Find HST Cloumn' AS 'DebitAmount'
	,'OutpatientStatLoad' AS 'LineMemo'
	,hst.dbo.vHST_ME9003.FinancialClassDesc AS 'PayorWorktag'
	,'Need to Find HST Cloumn' AS Worktag_Cost_Center_Reference_ID
    ,'1' AS BP_AutoComplete
    ,'Stats_Integration_Journal_Load' AS 'BP_Comment'


FROM [HST].[dbo].[vHST_ME9003]
