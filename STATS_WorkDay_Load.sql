SELECT 
    'Stats_' AS JournalKey,
    CONVERT(DATE, GETDATE()) AS JournalKey2,
    LEFT(dbo.tblTrendStatMaster.EntDept, 2) AS JournalKey3,
    '1' AS Submit,
    '1' AS AddOnlyJournal,
    LEFT(dbo.tblTrendStatMaster.EntDept, 2) + '_ReferenceID' AS CompanyReferenceIDType,
    'USD' AS Currency,
    'ACTUALS' AS LedgerType,
    CONVERT(DATE, dbo.vStatPeriodSelect.PostDate) AS AccountingDate,
    'FARGLD' AS JournalSource,
    'OutpatientStatsLoad' AS JournalEntryMemo,
    'Account_Set_ID' AS LedgerAccountReferenceID_ParentIDType,
    'Workday' AS LedgerAccountReferenceID_ParentID,
    'Ledger Account ID' AS LedgerAccountReferenceIDType,
    dbo.tblTrendStatMaster.HyperionStat AS LedgerAccountReferenceID, 
    SUM(dbo.vStatPeriodSelect.Modifier) AS DebitAmount,
    'OutpatientStatLoad' AS LineMemo,
    dbo.vStatPeriodSelect.PayorCode AS PayorWorktag, 
    dbo.tblTrendStatMaster.EntDept AS Worktag_Cost_Center_Reference_ID,
    '1' AS BP_AutoComplete,
    'Stats_Integration_Journal_Load' AS BP_Comment
FROM 
    dbo.tblTrendStatMaster
JOIN 
    dbo.vStatPeriodSelect 
    ON -- (Specify your join condition here)
GROUP BY 
    dbo.tblTrendStatMaster.EntDept,
    dbo.tblTrendStatMaster.HyperionStat,
    dbo.vStatPeriodSelect.PayorCode,
    dbo.vStatPeriodSelect.PostDate;
