pageextension 1705 AccountManagerActivitiesExt extends "Account Manager Activities"
{
    Caption = 'Activities';
    layout
    {
        addlast("Cash Management")
        {
            field("Bank Deposits to Post"; "Bank Deposits to Post")
            {
                ApplicationArea = Basic, Suite;
                DrillDownPageID = "Bank Deposits";
                ToolTip = 'Specifies bank deposits that are ready to be posted.';
            }
        }
    }
}