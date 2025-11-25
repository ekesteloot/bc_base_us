namespace Microsoft.FinancialMgt.FinancialReports;

using Microsoft.FinancialMgt.GeneralLedger.Account;
using Microsoft.FinancialMgt.GeneralLedger.Setup;

codeunit 573 "Run Acc. Sched. Income Stmt."
{

    trigger OnRun()
    var
        GeneralLedgerSetup: Record "General Ledger Setup";
        GLAccountCategoryMgt: Codeunit "G/L Account Category Mgt.";
    begin
        GLAccountCategoryMgt.GetGLSetup(GeneralLedgerSetup);
        GLAccountCategoryMgt.RunAccountScheduleReport(GeneralLedgerSetup."Fin. Rep. for Income Stmt.");
    end;
}

