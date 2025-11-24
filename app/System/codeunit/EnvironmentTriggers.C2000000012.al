codeunit 2000000012 "Environment Triggers"
{
    SingleInstance = true;

    trigger OnRun()
    begin
    end;

    [BusinessEvent(false)]
    procedure OnAfterCopyEnvironmentToSandbox()
    begin
    end;

    [BusinessEvent(false)]
    procedure OnAfterCopyEnvironmentToSandboxPerCompany()
    begin
    end;

    [BusinessEvent(false)]
    procedure OnAfterCopyEnvironmentPerDatabase(SourceEnvironmentType: Option Production,Sandbox; SourceEnvironmentName: Text; DestinationEnvironmentType: Option Production,Sandbox; DestinationEnvironmentName: Text)
    begin
    end;

    [BusinessEvent(false)]
    procedure OnAfterCopyEnvironmentPerCompany(SourceEnvironmentType: Option Production,Sandbox; SourceEnvironmentName: Text; DestinationEnvironmentType: Option Production,Sandbox; DestinationEnvironmentName: Text)
    begin
    end;
}

