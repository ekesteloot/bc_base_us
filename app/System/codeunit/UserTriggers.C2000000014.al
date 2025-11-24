codeunit 2000000014 "User Triggers"
{
    SingleInstance = true;

    trigger OnRun()
    begin
    end;

    [BusinessEvent(false)]
    procedure OnAfterUserInitialization()
    begin
    end;
}

