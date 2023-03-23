
let
  Source = Sql.Database(sql, dbLive),
  Navigation = Source{[Schema = "dbo", Item = "InfraCredit$G_L Account"]}[Data]
                  [[No_],[Name],[Account Type],[Global Dimension 1 Code],
                  [Global Dimension 2 Code],[Gen_ Bus_ Posting Group], 
                  [Account Category],[Income_Balance]],
  #"Filtered Rows" = Table.SelectRows( Navigation, each [No_] = Text.Select([No_],{"a".."z","A".."Z","0".."9"} ) ),
  #"Changed Type" = Table.TransformColumnTypes(#"Filtered Rows", {{"Account Type", type text}, {"Account Category", type text}, {"Income_Balance", type text}, {"No_", Int64.Type}}),
  #"Account Type Mapping" = [
        #"0" = "Posting",
        #"1" = "Heading",
        #"2" = "Total",
        #"3" = "Begin-Total",
        #"4" = "End-Total"
        ],
  #"Account Type Substituted" = Table.TransformColumns(#"Changed Type", 
                        {{"Account Type", each Record.FieldOrDefault(#"Account Type Mapping", _, _)}}),
  #"Account Category Mapping" = [
        #"0" = "Not Categorised",
        #"1" = "Assets",
        #"2" = "Liabilities",
        #"3" = "Equity",
        #"4" = "Income",
        #"5" = "Cost of Goods Sold",
        #"6" = "Expense"
        ],
  #"Account Category Substituted" = Table.TransformColumns(#"Account Type Substituted" , 
                  {{"Account Category", each Record.FieldOrDefault(#"Account Category Mapping", _, _)}}),
  #"Income_Balance Mapping" = [
        #"0" = "Income Statement",
        #"1" = "Balance Sheet"
       
        ],
  #"Income_Balance Substituted" = Table.TransformColumns(#"Account Category Substituted", 
                  {{"Income_Balance", each Record.FieldOrDefault(#"Income_Balance Mapping", _, _)}}),
  #"Changed column type" = Table.TransformColumnTypes(#"Income_Balance Substituted", {{"Account Type", type text}, {"Account Category", type text}, {"Income_Balance", type text}}),
  AccountCategoryColumn = Table.AddColumn(#"Changed column type", "AccountSubCategory", each if List.Contains({410001..410004,500007},[No_])
    then "Guarantee fee income"

    // Guarantee fee expenses 
    else if
    List.Contains({600001..600003,600007,600009},[No_])
    then "Guarantee fee expenses"

    // Interest income 
    else if
    List.Contains({500001..500006,500008,500010,500011},[No_])
    then "Interest income"

    // Interest expense 
    else if
    List.Contains({600004..600008},[No_])
    then "Interest expense"

    // Other income 
    else if
    List.Contains({510002},[No_])
    then "Other income"

    else if
    List.Contains({810012,830001..830006},[No_])
    then "Impairment loss on financial instruments"

    // Foreign exchange gain/(loss) 
    else if
    List.Contains({500009},[No_]) // 510001 was removed from dataflow
    then "Foreign exchange gain/(loss)"

    
    // Personnel expenses 
    else if
    List.Contains({700001..700099},[No_])
    then "Personnel expenses"

    else if
    List.Contains({810001..810009,810014,810013,810010,
    820000..820099,800001..800035,810011},[No_]) 
    then "Other operating expenses"

   

      /* 
        ----------------------------------------------------------------
        P&L ACCOUNT MAPPING ENDS HERE WHILE BALANCE SHEET START HERE
        ----------------------------------------------------------------

    */

    // ---------------------------- ASSETS  ----------------------------


    // Cash and cash equivalents
    else if
    List.Contains({120001..120099,130001..130099,200001},[No_])
    then "Cash and cash equivalents"

    
    
     // Investment securities
    else if
    List.Contains({140001,150001,1510001..1510099,160001,170001,190001,
                   200002..200005},[No_])
    then "Investment securities"

     // Guarantee fee receivable
    else if
    List.Contains({210003,200006},[No_])
    then "Guarantee fee receivable"

     

    // Other assets
    // 210029 was included 16/12/2020 as instructed by Elijah
    else if
    List.Contains({210001..210002,210004..210062,220001..220006,200007},[No_])
    then "Other assets"

    // Property and equipment
    else if
    List.Contains({230001..230004,240001..240002,250001..250002,
                   260001..260002,270001..270002,280001..280002,
                   290001..290004,300001,310001,320002..320003,
                   320005,321001,321002,320004},[No_])
    then "Property and equipment"

    // Right of use asset
    else if
    List.Contains({323001..323002},[No_])
    then "Right of use asset"

    // Intangible assets
    else if
    List.Contains({330001..330002,320001},[No_])
    then "Intangible assets"

     // Deferred tax asset
    else if
    List.Contains({340001},[No_])
    then "Deferred tax asset"

     

    // ---------------------------- ASSETS  ------------------------------

   
		
	// ---------------------------- LIABILITIES  -------------------------

    // Current tax liability
    else if
    List.Contains({380002},[No_])
    then "Current tax liability"

    // Financial guarantee liability
    else if
    List.Contains({360014},[No_])
    then "Financial Guarantee Liability"

    // Other liabilities
    // 370014 was included 12/16/2020
    else if
    List.Contains({350001..350002,360001..360008,360010..360013,
                   360015..360017,370001..370014,380001,380003},[No_])
    then "Other liabilities"

    // Lease liability
    else if
    List.Contains({360009},[No_])
    then "Lease liability"

    // Unsecured subordinated long term loan
    else if
    List.Contains({390001..390002,400999},[No_])
    then "Unsecured subordinated capital"


    // ---------------------------- LIABILITIES  -------------------------


    // ---------------------------- EQUITY  ------------------------------

    // Ordinary share capital
    else if
    List.Contains({400001},[No_])
    then "Ordinary share capital"

    //  Cummulative irredeemable preference share capital
    else if
    List.Contains({400002},[No_])
    then "Cummulative irredeemable preference share capital"

    // Cummulative redeemable preference share capital
    else if
    List.Contains({400005},[No_])
    then "Cummulative redeemable preference share capital"

    else if
    List.Contains({400004},[No_])
    then "Fair value reserves"

    else if
    List.Contains({400003},[No_])
    then "Deposit for shares"

    else if
    List.Contains({400009},[No_])
    then "Share Premium"


     // Retained earnings/(accumulated losses) 
    //  400008 was included 12/16/2020
    else if
    List.Contains({400006, 400008},[No_])
    then "Retained earnings/(accumulated losses)"
/*	
		
    This will be linked to YTD P&L VALUE FOR ANY SELECTED  YEAR
	400008	Profit/Loss-Current Year

*/	

// ---------------------------- EQUITY  ------------------------------
     else "", type text)
in
  AccountCategoryColumn