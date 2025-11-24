codeunit 2000000010 "Extension Triggers"
{
    SingleInstance = true;

    trigger OnRun()
    begin
    end;

    [BusinessEvent(false)]
    procedure OnInstallAppPerDatabase()
    begin
    end;

    [BusinessEvent(false)]
    procedure OnInstallAppPerCompany()
    begin
    end;
}

