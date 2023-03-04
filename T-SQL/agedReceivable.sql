SELECT

       C_LedEntry.[Customer No_]

      ,C_LedEntry.[Entry No_]

      ,C_LedEntry.[Posting Date]

	,C_LedEntry.[Document No.]

      ,C_LedEntry.[Document Type]

      ,C_LedEntry.[Customer Posting Group]

      ,C_LedEntry.[Salesperson Code]

      ,C_LedEntry.[Due Date]

      ,C_LedEntry.[Open]

      ,Det_LedEntry.[Cust_ Ledger Entry No_]

    --   ,Det_LedEntry.[Amount]

      ,SUM(Det_LedEntry.[Amount (LCY)])

      ,Det_LedEntry.[Ledger Entry Amount]



    --   [SCHEMA].[dbo].[DATABASE$Cust_ Ledger Entry]

      FROM [Demo Database BC (14-00)].[dbo].[CRONUS International Ltd_$Cust_ Ledger Entry] AS C_LedEntry

    FULL OUTER JOIN

    [Demo Database BC (14-00)].[dbo].[CRONUS International Ltd_$Detailed Cust_ Ledg_ Entry] AS Det_LedEntry

    ON C_LedEntry.[Entry No_] = Det_LedEntry.[Cust_ Ledger Entry No_]

    WHERE Det_LedEntry.[Ledger Entry Amount] = 1

    and C_LedEntry.[Document Type] = 2

    and C_LedEntry.[Open] = 1

    GROUP BY C_LedEntry.[Entry No_]

    ,C_LedEntry.[Customer No_]

      ,C_LedEntry.[Entry No_]

      ,C_LedEntry.[Posting Date]

      ,C_LedEntry.[Document Type]

      ,C_LedEntry.[Customer Posting Group]

      ,C_LedEntry.[Salesperson Code]

      ,C_LedEntry.[Due Date]

      ,C_LedEntry.[Open]

      ,Det_LedEntry.[Ledger Entry Amount]

      ,Det_LedEntry.[Cust_ Ledger Entry No_]

    order by C_LedEntry.[Customer No_]