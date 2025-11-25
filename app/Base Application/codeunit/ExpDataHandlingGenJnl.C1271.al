namespace System.IO;

using Microsoft.FinancialMgt.GeneralLedger.Journal;

codeunit 1271 "Exp. Data Handling Gen. Jnl."
{
    Permissions = TableData "Gen. Journal Line" = rimd;
    TableNo = "Gen. Journal Line";

    trigger OnRun()
    begin
    end;
}

