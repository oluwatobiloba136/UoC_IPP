

Documentation()

OnInitReport()

OnPreReport()
CustFilter := Customer.GETFILTERS;

GLSetup.GET;

CalcDates;
CreateHeadings;

PageGroupNo := 1;
NextPageGroupNo := 1;
CustFilterCheck := (CustFilter <> 'No.');

OnPostReport()

Customer - OnPreDataItem()

Customer - OnAfterGetRecord()
IF NewPagePercustomer THEN
  PageGroupNo += 1;
TempCurrency.RESET;
TempCurrency.DELETEALL;
TempCustLedgEntry.RESET;
TempCustLedgEntry.DELETEALL;

DimName := '';
IF DimValues.GET('COST CENTRE',Customer."Global Dimension 2 Code") THEN
  DimGrpCode := DimValues."Statistic Grouping";
  DimName := DimValues.Name;
IF DimValues.GET('COST CENTRE',DimGrpCode) THEN
  DimGrpName := DimValues.Name;

Customer - OnPostDataItem()

Dimension Value - OnPreDataItem()

Dimension Value - OnAfterGetRecord()

Dimension Value - OnPostDataItem()

Cust. Ledger Entry - OnPreDataItem()
SETRANGE("Posting Date",EndingDate + 1,12319999D);

Cust. Ledger Entry - OnAfterGetRecord()
CustLedgEntry.SETCURRENTKEY("Closed by Entry No.");
CustLedgEntry.SETRANGE("Closed by Entry No.","Entry No.");
CustLedgEntry.SETRANGE("Posting Date",0D,EndingDate);
IF CustLedgEntry.FINDSET(FALSE,FALSE) THEN
  REPEAT
    InsertTemp(CustLedgEntry);
  UNTIL CustLedgEntry.NEXT = 0;

IF "Closed by Entry No." <> 0 THEN BEGIN
  CustLedgEntry.SETRANGE("Closed by Entry No.","Closed by Entry No.");
  IF CustLedgEntry.FINDSET(FALSE,FALSE) THEN
    REPEAT
      InsertTemp(CustLedgEntry);
    UNTIL CustLedgEntry.NEXT = 0;
END;

CustLedgEntry.RESET;
CustLedgEntry.SETRANGE("Entry No.","Closed by Entry No.");
CustLedgEntry.SETRANGE("Posting Date",0D,EndingDate);
IF CustLedgEntry.FINDSET(FALSE,FALSE) THEN
  REPEAT
    InsertTemp(CustLedgEntry);
  UNTIL CustLedgEntry.NEXT = 0;
CurrReport.SKIP;

Cust. Ledger Entry - OnPostDataItem()

OpenCustLedgEntry - OnPreDataItem()
IF AgingBy = AgingBy::"Posting Date" THEN BEGIN
  SETRANGE("Posting Date",0D,EndingDate);
  SETRANGE("Date Filter",0D,EndingDate);
END;

OpenCustLedgEntry - OnAfterGetRecord()
IF AgingBy = AgingBy::"Posting Date" THEN BEGIN
  CALCFIELDS("Remaining Amt. (LCY)");
  IF "Remaining Amt. (LCY)" = 0 THEN
    CurrReport.SKIP;
END;

InsertTemp(OpenCustLedgEntry);
CurrReport.SKIP;

OpenCustLedgEntry - OnPostDataItem()

CurrencyLoop - OnPreDataItem()
NumberOfCurrencies := 0;

CurrencyLoop - OnAfterGetRecord()
CLEAR(TotalCustLedgEntry);

IF Number = 1 THEN BEGIN
  IF NOT TempCurrency.FINDSET(FALSE,FALSE) THEN
    CurrReport.BREAK;
END ELSE
  IF TempCurrency.NEXT = 0 THEN
    CurrReport.BREAK;

IF TempCurrency.Code <> '' THEN
  CurrencyCode := TempCurrency.Code
ELSE
  CurrencyCode := GLSetup."LCY Code";

NumberOfCurrencies := NumberOfCurrencies + 1;

CurrencyLoop - OnPostDataItem()

TempCustLedgEntryLoop - OnPreDataItem()
IF NOT PrintAmountInLCY THEN BEGIN
  IF (TempCurrency.Code = '') OR (TempCurrency.Code = GLSetup."LCY Code") THEN
    TempCustLedgEntry.SETFILTER("Currency Code",'%1|%2',GLSetup."LCY Code",'')
  ELSE
    TempCustLedgEntry.SETRANGE("Currency Code",TempCurrency.Code);
END;

PageGroupNo := NextPageGroupNo;
IF NewPagePercustomer AND (NumberOfCurrencies > 0) THEN
  NextPageGroupNo := PageGroupNo + 1;

TempCustLedgEntryLoop - OnAfterGetRecord()
IF Number = 1 THEN BEGIN
  IF NOT TempCustLedgEntry.FINDSET(FALSE,FALSE) THEN
    CurrReport.BREAK;
END ELSE
  IF TempCustLedgEntry.NEXT = 0 THEN
    CurrReport.BREAK;

CustLedgEntryEndingDate := TempCustLedgEntry;
DetailedCustomerLedgerEntry.SETRANGE("Cust. Ledger Entry No.",CustLedgEntryEndingDate."Entry No.");
IF DetailedCustomerLedgerEntry.FINDSET(FALSE,FALSE) THEN
  REPEAT
    IF (DetailedCustomerLedgerEntry."Entry Type" =
        DetailedCustomerLedgerEntry."Entry Type"::"Initial Entry") AND
       (CustLedgEntryEndingDate."Posting Date" > EndingDate) AND
       (AgingBy <> AgingBy::"Posting Date")
    THEN BEGIN
      IF CustLedgEntryEndingDate."Document Date" <= EndingDate THEN
        DetailedCustomerLedgerEntry."Posting Date" :=
          CustLedgEntryEndingDate."Document Date"
      ELSE
        IF (CustLedgEntryEndingDate."Due Date" <= EndingDate) AND
           (AgingBy = AgingBy::"Due Date")
        THEN
          DetailedCustomerLedgerEntry."Posting Date" :=
            CustLedgEntryEndingDate."Due Date"
    END;

    IF (DetailedCustomerLedgerEntry."Posting Date" <= EndingDate) OR
       (TempCustLedgEntry.Open AND
        (AgingBy = AgingBy::"Due Date") AND
        (CustLedgEntryEndingDate."Due Date" > EndingDate) AND
        (CustLedgEntryEndingDate."Posting Date" <= EndingDate))
    THEN BEGIN
      IF DetailedCustomerLedgerEntry."Entry Type" IN
         [DetailedCustomerLedgerEntry."Entry Type"::"Initial Entry",
          DetailedCustomerLedgerEntry."Entry Type"::"Unrealized Loss",
          DetailedCustomerLedgerEntry."Entry Type"::"Unrealized Gain",
          DetailedCustomerLedgerEntry."Entry Type"::"Realized Loss",
          DetailedCustomerLedgerEntry."Entry Type"::"Realized Gain",
          DetailedCustomerLedgerEntry."Entry Type"::"Payment Discount",
          DetailedCustomerLedgerEntry."Entry Type"::"Payment Discount (VAT Excl.)",
          DetailedCustomerLedgerEntry."Entry Type"::"Payment Discount (VAT Adjustment)",
          DetailedCustomerLedgerEntry."Entry Type"::"Payment Tolerance",
          DetailedCustomerLedgerEntry."Entry Type"::"Payment Discount Tolerance",
          DetailedCustomerLedgerEntry."Entry Type"::"Payment Tolerance (VAT Excl.)",
          DetailedCustomerLedgerEntry."Entry Type"::"Payment Tolerance (VAT Adjustment)",
          DetailedCustomerLedgerEntry."Entry Type"::"Payment Discount Tolerance (VAT Excl.)",
          DetailedCustomerLedgerEntry."Entry Type"::"Payment Discount Tolerance (VAT Adjustment)"]
      THEN BEGIN
        CustLedgEntryEndingDate.Amount := CustLedgEntryEndingDate.Amount + DetailedCustomerLedgerEntry.Amount;
        CustLedgEntryEndingDate."Amount (LCY)" :=
          CustLedgEntryEndingDate."Amount (LCY)" + DetailedCustomerLedgerEntry."Amount (LCY)";
      END;
      IF DetailedCustomerLedgerEntry."Posting Date" <= EndingDate THEN BEGIN
        CustLedgEntryEndingDate."Remaining Amount" :=
          CustLedgEntryEndingDate."Remaining Amount" + DetailedCustomerLedgerEntry.Amount;
        CustLedgEntryEndingDate."Remaining Amt. (LCY)" :=
          CustLedgEntryEndingDate."Remaining Amt. (LCY)" + DetailedCustomerLedgerEntry."Amount (LCY)";
      END;
    END;
  UNTIL DetailedCustomerLedgerEntry.NEXT = 0;

IF CustLedgEntryEndingDate."Remaining Amount" = 0 THEN
  CurrReport.SKIP;

CASE AgingBy OF
  AgingBy::"Due Date":
    PeriodIndex := GetPeriodIndex(CustLedgEntryEndingDate."Due Date");
  AgingBy::"Posting Date":
    PeriodIndex := GetPeriodIndex(CustLedgEntryEndingDate."Posting Date");
  AgingBy::"Document Date":
    BEGIN
      IF CustLedgEntryEndingDate."Document Date" > EndingDate THEN BEGIN
        CustLedgEntryEndingDate."Remaining Amount" := 0;
        CustLedgEntryEndingDate."Remaining Amt. (LCY)" := 0;
        CustLedgEntryEndingDate."Document Date" := CustLedgEntryEndingDate."Posting Date";
      END;
      PeriodIndex := GetPeriodIndex(CustLedgEntryEndingDate."Document Date");
    END;
END;
CLEAR(AgedCustLedgEntry);
AgedCustLedgEntry[PeriodIndex]."Remaining Amount" := CustLedgEntryEndingDate."Remaining Amount";
AgedCustLedgEntry[PeriodIndex]."Remaining Amt. (LCY)" := CustLedgEntryEndingDate."Remaining Amt. (LCY)";
TotalCustLedgEntry[PeriodIndex]."Remaining Amount" += CustLedgEntryEndingDate."Remaining Amount";
TotalCustLedgEntry[PeriodIndex]."Remaining Amt. (LCY)" += CustLedgEntryEndingDate."Remaining Amt. (LCY)";
GrandTotalCustLedgEntry[PeriodIndex]."Remaining Amt. (LCY)" += CustLedgEntryEndingDate."Remaining Amt. (LCY)";
TotalCustLedgEntry[1].Amount += CustLedgEntryEndingDate."Remaining Amount";
TotalCustLedgEntry[1]."Amount (LCY)" += CustLedgEntryEndingDate."Remaining Amt. (LCY)";
GrandTotalCustLedgEntry[1]."Amount (LCY)" += CustLedgEntryEndingDate."Remaining Amt. (LCY)";

TempCustLedgEntryLoop - OnPostDataItem()
IF NOT PrintAmountInLCY THEN
  UpdateCurrencyTotals;

CurrencyTotals - OnPreDataItem()

CurrencyTotals - OnAfterGetRecord()
IF Number = 1 THEN BEGIN
  IF NOT TempCurrency2.FINDSET(FALSE,FALSE) THEN
    CurrReport.BREAK;
END ELSE
  IF TempCurrency2.NEXT = 0 THEN
    CurrReport.BREAK;

CLEAR(AgedCustLedgEntry);
TempCurrencyAmount.SETRANGE("Currency Code",TempCurrency2.Code);
IF TempCurrencyAmount.FINDSET(FALSE,FALSE) THEN
  REPEAT
    IF TempCurrencyAmount.Date <> 12319999D THEN
      AgedCustLedgEntry[GetPeriodIndex(TempCurrencyAmount.Date)]."Remaining Amount" :=
        TempCurrencyAmount.Amount
    ELSE
      AgedCustLedgEntry[9]."Remaining Amount" := TempCurrencyAmount.Amount;
  UNTIL TempCurrencyAmount.NEXT = 0;

CurrencyTotals - OnPostDataItem()

LOCAL CalcDates()
EVALUATE(PeriodLength2,STRSUBSTNO(Text032,PeriodLength));
IF AgingBy = AgingBy::"Due Date" THEN BEGIN
  PeriodEndDate[1] := 12319999D;
  PeriodStartDate[1] := EndingDate + 1;
END ELSE BEGIN
  PeriodEndDate[1] := EndingDate;
  PeriodStartDate[1] := CALCDATE(PeriodLength2,EndingDate + 1);
END;
{
FOR i := 2 TO ARRAYLEN(PeriodEndDate) DO BEGIN
  PeriodEndDate[i] := PeriodStartDate[i - 1] - 1;
  PeriodStartDate[i] := CALCDATE(PeriodLength2,PeriodEndDate[i] + 1);
END;
}
FOR i := 2 TO 4 DO BEGIN
  PeriodEndDate[i] := PeriodStartDate[i - 1] - 1;
  PeriodStartDate[i] := CALCDATE(PeriodLength2,PeriodEndDate[i] + 1);
END;
FOR i := 5 TO 5 DO BEGIN
  PeriodEndDate[i] := PeriodStartDate[i - 1] - 1;
  PeriodStartDate[i] := CALCDATE('-3M',PeriodEndDate[i] + 1);
END;
FOR i := 6 TO 6 DO BEGIN
  PeriodEndDate[i] := PeriodStartDate[i - 1] - 1;
  PeriodStartDate[i] := CALCDATE('-6M',PeriodEndDate[i] + 1);
END;
FOR i := 7 TO ARRAYLEN(PeriodEndDate) DO BEGIN
  PeriodEndDate[i] := PeriodStartDate[i - 1] - 1;
  PeriodStartDate[i] := CALCDATE('-10Y',PeriodEndDate[i] + 1);
END;
PeriodStartDate[i] := 0D;

FOR i := 1 TO ARRAYLEN(PeriodEndDate) DO
  IF PeriodEndDate[i] < PeriodStartDate[i] THEN
    ERROR(Text010,PeriodLength);

LOCAL CreateHeadings()
IF AgingBy = AgingBy::"Due Date" THEN BEGIN
  HeaderText[1] := Text000;
  i := 2;
END ELSE
  i := 1;
WHILE i < ARRAYLEN(PeriodEndDate) DO BEGIN
  IF HeadingType = HeadingType::"Date Interval" THEN
    HeaderText[i] := STRSUBSTNO('%1\..%2',PeriodStartDate[i],PeriodEndDate[i])
  ELSE
    HeaderText[i] :=
      STRSUBSTNO('%1 - %2 %3',EndingDate - PeriodEndDate[i] + 1,EndingDate - PeriodStartDate[i] + 1,Text002);
  i := i + 1;
END;
IF HeadingType = HeadingType::"Date Interval" THEN
  HeaderText[i] := STRSUBSTNO('%1 %2',Text001,PeriodStartDate[i - 1])
ELSE
  HeaderText[i] := STRSUBSTNO('%1 \%2 %3',Text003,EndingDate - PeriodStartDate[i - 1] + 1,Text002);

LOCAL InsertTemp(VAR CustLedgEntry : Record "Cust. Ledger Entry")
WITH TempCustLedgEntry DO BEGIN
  IF GET(CustLedgEntry."Entry No.") THEN
    EXIT;
  TempCustLedgEntry := CustLedgEntry;
  INSERT;
  IF PrintAmountInLCY THEN BEGIN
    CLEAR(TempCurrency);
    TempCurrency."Amount Rounding Precision" := GLSetup."Amount Rounding Precision";
    IF TempCurrency.INSERT THEN;
    EXIT;
  END;
  IF TempCurrency.GET("Currency Code") THEN
    EXIT;
  IF TempCurrency.GET('') AND ("Currency Code" = GLSetup."LCY Code") THEN
    EXIT;
  IF TempCurrency.GET(GLSetup."LCY Code") AND ("Currency Code" = '') THEN
    EXIT;
  IF "Currency Code" <> '' THEN
    Currency.GET("Currency Code")
  ELSE BEGIN
    CLEAR(Currency);
    Currency."Amount Rounding Precision" := GLSetup."Amount Rounding Precision";
  END;
  TempCurrency := Currency;
  TempCurrency.INSERT;
END;

LOCAL GetPeriodIndex(Date : Date) : Integer
FOR i := 1 TO ARRAYLEN(PeriodEndDate) DO
  IF Date IN [PeriodStartDate[i]..PeriodEndDate[i]] THEN
    EXIT(i);

LOCAL Pct(a : Decimal;b : Decimal) : Text[30]
IF b <> 0 THEN
  EXIT(FORMAT(ROUND(100 * a / b,0.1),0,'<Sign><Integer><Decimals,2>') + '%');

LOCAL UpdateCurrencyTotals()
TempCurrency2.Code := CurrencyCode;
IF TempCurrency2.INSERT THEN;
WITH TempCurrencyAmount DO BEGIN
  FOR i := 1 TO ARRAYLEN(TotalCustLedgEntry) DO BEGIN
    "Currency Code" := CurrencyCode;
    Date := PeriodStartDate[i];
    IF FIND THEN BEGIN
      Amount := Amount + TotalCustLedgEntry[i]."Remaining Amount";
      MODIFY;
    END ELSE BEGIN
      "Currency Code" := CurrencyCode;
      Date := PeriodStartDate[i];
      Amount := TotalCustLedgEntry[i]."Remaining Amount";
      INSERT;
    END;
  END;
  "Currency Code" := CurrencyCode;
  Date := 12319999D;
  IF FIND THEN BEGIN
    Amount := Amount + TotalCustLedgEntry[1].Amount;
    MODIFY;
  END ELSE BEGIN
    "Currency Code" := CurrencyCode;
    Date := 12319999D;
    Amount := TotalCustLedgEntry[1].Amount;
    INSERT;
  END;
END;

InitializeRequest(NewEndingDate : Date;NewAgingBy : Option;NewPeriodLength : DateFormula;NewPrintAmountInLCY : Boolean;NewPrintDetails : Boolean;NewHeadingType : Option;NewPagePercust : Boolean)
EndingDate := NewEndingDate;
AgingBy := NewAgingBy;
PeriodLength := NewPeriodLength;
PrintAmountInLCY := NewPrintAmountInLCY;
PrintDetails := NewPrintDetails;
HeadingType := NewHeadingType;
NewPagePercustomer := NewPagePercust;
