codeunit 10143 "Deposit-Printed"
{
    Permissions = TableData "Posted Deposit Header" = rm;
    TableNo = "Posted Deposit Header";

    trigger OnRun()
    begin
        Rec.Find();
        Rec."No. Printed" := Rec."No. Printed" + 1;
        Rec.Modify();
        Commit();
    end;
}

