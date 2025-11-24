codeunit 2000000002 "Global Triggers"
{

    trigger OnRun()
    begin
    end;

    [BusinessEvent(false)]
    procedure GetGlobalTableTriggerMask(TableID: Integer; var TableTriggerMask: Integer)
    begin
    end;

    [BusinessEvent(false)]
    procedure OnGlobalInsert(RecRef: RecordRef)
    begin
    end;

    [BusinessEvent(false)]
    procedure OnGlobalModify(RecRef: RecordRef; xRecRef: RecordRef)
    begin
    end;

    [BusinessEvent(false)]
    procedure OnGlobalDelete(RecRef: RecordRef)
    begin
    end;

    [BusinessEvent(false)]
    procedure OnGlobalRename(RecRef: RecordRef; xRecRef: RecordRef)
    begin
    end;

    [BusinessEvent(false)]
    procedure GetDatabaseTableTriggerSetup(TableId: Integer; var OnDatabaseInsert: Boolean; var OnDatabaseModify: Boolean; var OnDatabaseDelete: Boolean; var OnDatabaseRename: Boolean)
    begin
    end;

    [BusinessEvent(false)]
    procedure OnDatabaseInsert(RecRef: RecordRef)
    begin
    end;

    [BusinessEvent(false)]
    procedure OnDatabaseModify(RecRef: RecordRef)
    begin
    end;

    [BusinessEvent(false)]
    procedure OnDatabaseDelete(RecRef: RecordRef)
    begin
    end;

    [BusinessEvent(false)]
    procedure OnDatabaseRename(RecRef: RecordRef; xRecRef: RecordRef)
    begin
    end;
}

