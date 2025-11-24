codeunit 2000000009 "Debugger Triggers"
{
    SingleInstance = true;

    trigger OnRun()
    begin
    end;

    [BusinessEvent(false)]
    [Obsolete('Support for the classic debugger engine has been removed.')]
    procedure OnDebuggerBreak(ErrorMessage: Text)
    begin
    end;
}

