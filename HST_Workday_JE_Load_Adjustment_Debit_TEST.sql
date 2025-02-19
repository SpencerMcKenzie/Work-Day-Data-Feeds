
SELECT 
    CONCAT('HST_', CONVERT(VARCHAR(8), GETDATE(), 112), '_44') AS 'JournalKey',
    '1' AS 'Submit',
    '1' AS 'AddOnlyJournal',
    'Company_Reference_ID (WIP)' AS 'CompanyReferenceIDType',
    44 AS 'CompanyReferenceID',
    'USD' AS 'Currency',
    'ACTUALS' AS 'LedgerType',
    CONCAT(hst.accountingperiod, '/1/', hst.accountingyear) AS 'AccountingDate',
    'FARGLD' AS 'JournalSource',
    CONCAT('HST ', FORMAT(GETDATE(), 'MMM'), ' ', YEAR(GETDATE()), ' Journal Load') AS 'JournalEntryMemo',
    'Account_Set_ID' AS 'LedgerAccountReferenceID_ParentIDType',
    'Workday' AS 'LedgerAccountReferenceID_ParentID',
    'Adjustment' AS 'LedgerAccountReferenceIDType',
    sub.LedgerAccountReferenceID,  -- Subquery for LedgerAccountReferenceID
    sub.Amount,  -- Amount from subquery
    SUM(
        CASE 
            WHEN hst.FinancialClassDesc IN ('MEDICARE PART B', 'MEDICAID', 'ALL KIDS BLUE CROSS', 'BLUE CROSS BLUE SHIELD', 'TRICARE') 
            THEN (hst.CWTranAmount + hst.ADTranAmount) * -1
            WHEN hst.FinancialClassDesc = 'SELF PAY' 
            THEN (hst.CWTranAmount + hst.BDTranAmount) * -1
            ELSE 0
        END
    ) AS 'DebitAmount',
    0 AS 'CreditAmount',
    'Adjustment/Debit' AS 'EntryType',
    'OutpatientStatLoad' AS 'LineMemo',
    hst.FinancialClassDesc AS 'PayorWorktag',
    hst.financialclass AS 'FinancialClass',
    'Need to Find HST Column' AS 'Worktag_Cost_Center_Reference_ID',
    '1' AS BP_AutoComplete,
    'Stats_Integration_Journal_Load' AS 'BP_Comment'
FROM [HST].[dbo].[vHST_ME9003] hst
CROSS APPLY (
    SELECT '44-5926-61040' AS LedgerAccountReferenceID, 
           -(SUM(CASE WHEN FinancialClassDesc = 'MEDICARE PART B' THEN CWTranAmount ELSE 0 END) 
           + SUM(CASE WHEN FinancialClassDesc = 'MEDICARE PART B' THEN ADTranAmount ELSE 0 END)) AS Amount
    FROM [HST].[dbo].[vHST_ME9003]
	WHERE FinancialClassDesc = 'MEDICARE PART B'
	/*TESTING ONLY REMOVE*/ AND accountingyear = 2024 AND accountingperiod = 06
	GROUP BY  accountingyear, accountingperiod
    
    UNION ALL
    
    SELECT '44-5926-62040', 
           -(SUM(CASE WHEN FinancialClassDesc = 'MEDICAID' THEN CWTranAmount ELSE 0 END) 
           + SUM(CASE WHEN FinancialClassDesc = 'MEDICAID' THEN ADTranAmount ELSE 0 END))
    FROM [HST].[dbo].[vHST_ME9003]
    WHERE FinancialClassDesc = 'MEDICAID'
	/*TESTING ONLY REMOVE*/ AND accountingyear = 2024 AND accountingperiod = 06
	GROUP BY  accountingyear, accountingperiod

    UNION ALL
    
    SELECT '44-5926-63040', 
           -(SUM(CASE WHEN FinancialClassDesc IN ('ALL KIDS BLUE CROSS', 'BLUE CROSS BLUE SHIELD') THEN CWTranAmount ELSE 0 END) 
           + SUM(CASE WHEN FinancialClassDesc IN ('ALL KIDS BLUE CROSS', 'BLUE CROSS BLUE SHIELD') THEN ADTranAmount ELSE 0 END))
    FROM [HST].[dbo].[vHST_ME9003]
    WHERE FinancialClassDesc IN ('ALL KIDS BLUE CROSS', 'BLUE CROSS BLUE SHIELD')
	/*TESTING ONLY REMOVE*/ AND accountingyear = 2024 AND accountingperiod = 06
	GROUP BY  accountingyear, accountingperiod

    UNION ALL
    
    SELECT '44-5926-64040', 
           -(SUM(CASE WHEN FinancialClassDesc IN ('COMMERCIAL', 'GOVERNMENT', 'PPO', 'WORKERS COMPENSATION') THEN CWTranAmount ELSE 0 END) 
           + SUM(CASE WHEN FinancialClassDesc IN ('COMMERCIAL', 'GOVERNMENT', 'PPO', 'WORKERS COMPENSATION') THEN ADTranAmount ELSE 0 END))
    FROM [HST].[dbo].[vHST_ME9003]
    WHERE FinancialClassDesc IN ('COMMERCIAL', 'GOVERNMENT', 'PPO', 'WORKERS COMPENSATION')
	/*TESTING ONLY REMOVE*/ AND accountingyear = 2024 AND accountingperiod = 06
	GROUP BY  accountingyear, accountingperiod

    UNION ALL

    SELECT '44-5926-65040', 
           -(SUM(CASE WHEN FinancialClassDesc = 'TRICARE' THEN CWTranAmount ELSE 0 END) 
           + SUM(CASE WHEN FinancialClassDesc = 'TRICARE' THEN ADTranAmount ELSE 0 END))
    FROM [HST].[dbo].[vHST_ME9003]
    WHERE FinancialClassDesc = 'TRICARE'
	/*TESTING ONLY REMOVE*/ AND accountingyear = 2024 AND accountingperiod = 06
	GROUP BY  accountingyear, accountingperiod

    UNION ALL

    SELECT '44-5926-67040', 
           -SUM(CASE WHEN FinancialClassDesc IN ('SELF PAY', 'MEDICAL OUTREACH CHARITY') THEN ADTranAmount ELSE 0 END)
    FROM [HST].[dbo].[vHST_ME9003]
    WHERE FinancialClassDesc IN ('SELF PAY', 'MEDICAL OUTREACH CHARITY')
	/*TESTING ONLY REMOVE*/ AND accountingyear = 2024 AND accountingperiod = 06
	GROUP BY  accountingyear, accountingperiod

    UNION ALL

    SELECT '44-5926-60040', 
           -(SUM(CASE WHEN FinancialClassDesc = 'SELF PAY' THEN CWTranAmount ELSE 0 END) 
           + SUM(CASE WHEN FinancialClassDesc = 'SELF PAY' THEN BDTranAmount ELSE 0 END))
    FROM [HST].[dbo].[vHST_ME9003]
    WHERE FinancialClassDesc = 'SELF PAY'
	/*TESTING ONLY REMOVE*/ AND accountingyear = 2024 AND accountingperiod = 06
	GROUP BY  accountingyear, accountingperiod

    UNION ALL

    SELECT '44-1021-10078', 
           SUM(CWTranAmount) + SUM(ADTranAmount) + SUM(BDTranAmount)
    FROM [HST].[dbo].[vHST_ME9003]
	GROUP BY  accountingyear, accountingperiod
) sub
WHERE accountingyear = 2024 AND accountingperiod = 6
GROUP BY 
    hst.financialclass, 
    hst.accountingperiod,
    hst.accountingyear, 
    hst.FinancialClassDesc, 
    sub.LedgerAccountReferenceID,
    sub.Amount
	
	
