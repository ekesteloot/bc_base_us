codeunit 2000000003 "Company Triggers"
{
    SingleInstance = true;

    trigger OnRun()
    begin
    end;

#if NOT CLEAN20
    [Obsolete('Replaced by OnCompanyOpenCompleted to avoid errors in login.', '20.0')]
#else
    [Scope('OnPrem')]
#endif
    [BusinessEvent(false)]
    procedure OnCompanyOpen()
    begin
    end;

    [BusinessEvent(false, true)]
    procedure OnCompanyOpenCompleted()
    begin
    end;

    [BusinessEvent(false)]
    procedure OnCompanyClose()
    begin
    end;

    [BusinessEvent(false)]
    procedure OpenCompanySettings()
    begin
    end;
}

