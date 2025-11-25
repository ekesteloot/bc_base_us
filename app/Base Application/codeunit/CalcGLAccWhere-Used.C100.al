namespace Microsoft.FinancialMgt.GeneralLedger.Account;

using Microsoft.BankMgt.BankAccount;
using Microsoft.FinancialMgt.Currency;
using Microsoft.FinancialMgt.GeneralLedger.Journal;
using Microsoft.FinancialMgt.GeneralLedger.Setup;
using Microsoft.FinancialMgt.VAT;
using Microsoft.FixedAssets.FixedAsset;
using Microsoft.Foundation.Enums;
using Microsoft.Intercompany.Partner;
using Microsoft.ProjectMgt.Jobs.Job;
using Microsoft.Purchases.Setup;
using Microsoft.Purchases.Vendor;
using Microsoft.Sales.Customer;
using Microsoft.Sales.Setup;
using Microsoft.ServiceMgt.Contract;
using System.Reflection;
using System.Utilities;

codeunit 100 "Calc. G/L Acc. Where-Used"
{

    trigger OnRun()
    begin
    end;

    var
        TempGLAccWhereUsed: Record "G/L Account Where-Used" temporary;
        NextEntryNo: Integer;
        Text000: Label 'The update has been interrupted to respect the warning.';
        ShowWhereUsedQst: Label 'You cannot delete a %1 that is used in one or more setup windows.\Do you want to open the G/L Account No. Where-Used List Window?', Comment = '%1 -  Table Caption';

    procedure ShowSetupForm(GLAccWhereUsed: Record "G/L Account Where-Used")
    var
        Currency: Record Currency;
        GenJnlTemplate: Record "Gen. Journal Template";
        GenJnlBatch: Record "Gen. Journal Batch";
        CustPostingGr: Record "Customer Posting Group";
        VendPostingGr: Record "Vendor Posting Group";
        JobPostingGr: Record "Job Posting Group";
        GenJnlAlloc: Record "Gen. Jnl. Allocation";
        GenPostingSetup: Record "General Posting Setup";
        BankAccPostingGr: Record "Bank Account Posting Group";
        VATPostingSetup: Record "VAT Posting Setup";
        FAPostingGr: Record "FA Posting Group";
        FAAlloc: Record "FA Allocation";
        InventoryPostingSetup: Record "Inventory Posting Setup";
        ServiceContractAccGr: Record "Service Contract Account Group";
        ICPartner: Record "IC Partner";
        PaymentMethod: Record "Payment Method";
    begin
        with GLAccWhereUsed do
            case "Table ID" of
                Enum::TableID::Currency.AsInteger():
                    begin
                        Currency.Code := CopyStr("Key 1", 1, MaxStrLen(Currency.Code));
                        PAGE.Run(0, Currency);
                    end;
                Enum::TableID::"Gen. Journal Template".AsInteger():
                    begin
                        GenJnlTemplate.Name := CopyStr("Key 1", 1, MaxStrLen(GenJnlTemplate.Name));
                        PAGE.Run(PAGE::"General Journal Templates", GenJnlTemplate);
                    end;
                Enum::TableID::"Gen. Journal Batch".AsInteger():
                    begin
                        GenJnlBatch."Journal Template Name" := CopyStr("Key 1", 1, MaxStrLen(GenJnlBatch."Journal Template Name"));
                        GenJnlBatch.Name := CopyStr("Key 2", 1, MaxStrLen(GenJnlBatch.Name));
                        GenJnlBatch.SetRange("Journal Template Name", GenJnlBatch."Journal Template Name");
                        PAGE.Run(0, GenJnlBatch);
                    end;
                Enum::TableID::"Customer Posting Group".AsInteger():
                    begin
                        CustPostingGr.Code := CopyStr("Key 1", 1, MaxStrLen(CustPostingGr.Code));
                        PAGE.Run(0, CustPostingGr);
                    end;
                Enum::TableID::"Vendor Posting Group".AsInteger():
                    begin
                        VendPostingGr.Code := CopyStr("Key 1", 1, MaxStrLen(VendPostingGr.Code));
                        PAGE.Run(0, VendPostingGr);
                    end;
                Enum::TableID::"Job Posting Group".AsInteger():
                    begin
                        JobPostingGr.Code := CopyStr("Key 1", 1, MaxStrLen(JobPostingGr.Code));
                        PAGE.Run(0, JobPostingGr);
                    end;
                Enum::TableID::"Gen. Jnl. Allocation".AsInteger():
                    begin
                        GenJnlAlloc."Journal Template Name" := CopyStr("Key 1", 1, MaxStrLen(GenJnlAlloc."Journal Template Name"));
                        GenJnlAlloc."Journal Batch Name" := CopyStr("Key 2", 1, MaxStrLen(GenJnlAlloc."Journal Batch Name"));
                        Evaluate(GenJnlAlloc."Journal Line No.", "Key 3");
                        Evaluate(GenJnlAlloc."Line No.", "Key 4");
                        GenJnlAlloc.SetRange("Journal Template Name", GenJnlAlloc."Journal Template Name");
                        GenJnlAlloc.SetRange("Journal Batch Name", GenJnlAlloc."Journal Batch Name");
                        GenJnlAlloc.SetRange("Journal Line No.", GenJnlAlloc."Journal Line No.");
                        PAGE.Run(PAGE::Allocations, GenJnlAlloc);
                    end;
                Enum::TableID::"General Posting Setup".AsInteger():
                    begin
                        GenPostingSetup."Gen. Bus. Posting Group" :=
                          CopyStr("Key 1", 1, MaxStrLen(GenPostingSetup."Gen. Bus. Posting Group"));
                        GenPostingSetup."Gen. Prod. Posting Group" :=
                          CopyStr("Key 2", 1, MaxStrLen(GenPostingSetup."Gen. Prod. Posting Group"));
                        PAGE.Run(0, GenPostingSetup);
                    end;
                Enum::TableID::"Bank Account Posting Group".AsInteger():
                    begin
                        BankAccPostingGr.Code := CopyStr("Key 1", 1, MaxStrLen(BankAccPostingGr.Code));
                        PAGE.Run(0, BankAccPostingGr);
                    end;
                Enum::TableID::"VAT Posting Setup".AsInteger():
                    begin
                        VATPostingSetup."VAT Bus. Posting Group" :=
                          CopyStr("Key 1", 1, MaxStrLen(VATPostingSetup."VAT Bus. Posting Group"));
                        VATPostingSetup."VAT Prod. Posting Group" :=
                          CopyStr("Key 2", 1, MaxStrLen(VATPostingSetup."VAT Prod. Posting Group"));
                        PAGE.Run(0, VATPostingSetup);
                    end;
                Enum::TableID::"FA Posting Group".AsInteger():
                    begin
                        FAPostingGr.Code := CopyStr("Key 1", 1, MaxStrLen(FAPostingGr.Code));
                        PAGE.Run(PAGE::"FA Posting Group Card", FAPostingGr);
                    end;
                Enum::TableID::"FA Allocation".AsInteger():
                    begin
                        FAAlloc.Code := CopyStr("Key 1", 1, MaxStrLen(FAAlloc.Code));
                        Evaluate(FAAlloc."Allocation Type", "Key 2");
                        Evaluate(FAAlloc."Line No.", "Key 3");
                        FAAlloc.SetRange(Code, FAAlloc.Code);
                        FAAlloc.SetRange("Allocation Type", FAAlloc."Allocation Type");
                        OnShowSetupFormOnBeforeFAAllocationRunPage(FAAlloc, GLAccWhereUsed);
                        PAGE.Run(0, FAAlloc);
                    end;
                Enum::TableID::"Inventory Posting Setup".AsInteger():
                    begin
                        InventoryPostingSetup."Location Code" := CopyStr("Key 1", 1, MaxStrLen(InventoryPostingSetup."Location Code"));
                        InventoryPostingSetup."Invt. Posting Group Code" :=
                          CopyStr("Key 2", 1, MaxStrLen(InventoryPostingSetup."Invt. Posting Group Code"));
                        PAGE.Run(PAGE::"Inventory Posting Setup", InventoryPostingSetup);
                    end;
                Enum::TableID::"Service Contract Account Group".AsInteger():
                    begin
                        ServiceContractAccGr.Code := CopyStr("Key 1", 1, MaxStrLen(ServiceContractAccGr.Code));
                        PAGE.Run(0, ServiceContractAccGr);
                    end;
                Enum::TableID::"IC Partner".AsInteger():
                    begin
                        ICPartner.Code := CopyStr("Key 1", 1, MaxStrLen(ICPartner.Code));
                        PAGE.Run(0, ICPartner);
                    end;
                Enum::TableID::"Payment Method".AsInteger():
                    begin
                        PaymentMethod.Code := CopyStr("Key 1", 1, MaxStrLen(PaymentMethod.Code));
                        PAGE.Run(0, PaymentMethod);
                    end;
                Enum::TableID::"Sales & Receivables Setup".AsInteger():
                    PAGE.Run(PAGE::"Sales & Receivables Setup");
                Enum::TableID::"Purchases & Payables Setup".AsInteger():
                    PAGE.Run(PAGE::"Purchases & Payables Setup");
                else
                    OnShowExtensionPage(GLAccWhereUsed);
            end;
    end;

    procedure DeleteGLNo(GLAccNo: Code[20]): Boolean
    var
        GLSetup: Record "General Ledger Setup";
        GLAcc: Record "G/L Account";
        ConfirmManagement: Codeunit "Confirm Management";
    begin
        GLSetup.Get();
        if GLSetup."Check G/L Account Usage" then begin
            CheckPostingGroups(GLAccNo);
            OnDeleteGLNoOnBeforeTempGLAccWhereUsedFindFirst(TempGLAccWhereUsed);
            if TempGLAccWhereUsed.FindFirst() then begin
                Commit();
                if ConfirmManagement.GetResponse(StrSubstNo(ShowWhereUsedQst, GLAcc.TableCaption()), true) then
                    ShowGLAccWhereUsed();
                Error(Text000);
            end;
        end;
        exit(true);
    end;

    procedure CheckGLAcc(GLAccNo: Code[20])
    begin
        CheckPostingGroups(GLAccNo);
        ShowGLAccWhereUsed();
    end;

    local procedure ShowGLAccWhereUsed()
    begin
        OnBeforeShowGLAccWhereUsed(TempGLAccWhereUsed);

        TempGLAccWhereUsed.SetCurrentKey("Table Name");
        PAGE.RunModal(0, TempGLAccWhereUsed);
    end;

    procedure InsertGroupForRecord(var TempGLAccountWhereUsed: Record "G/L Account Where-Used" temporary; TableID: Integer; TableCaption: Text[80]; GLAccNo: Code[20]; GLAccNo2: Code[20]; FieldCaption: Text[80]; "Key": array[8] of Text[80])
    begin
        TempGLAccountWhereUsed."Table ID" := TableID;
        TempGLAccountWhereUsed."Table Name" := TableCaption;
        TempGLAccWhereUsed.Copy(TempGLAccountWhereUsed, true);
        InsertGroup(GLAccNo, GLAccNo2, FieldCaption, Key);
    end;

    local procedure InsertGroup(GLAccNo: Code[20]; GLAccNo2: Code[20]; FieldCaption: Text[80]; "Key": array[8] of Text[80])
    begin
        if GLAccNo = GLAccNo2 then begin
            if NextEntryNo = 0 then
                NextEntryNo := TempGLAccWhereUsed.GetLastEntryNo() + 1;

            TempGLAccWhereUsed."Field Name" := FieldCaption;
            if Key[1] <> '' then
                TempGLAccWhereUsed.Line := Key[1] + '=' + Key[4]
            else
                TempGLAccWhereUsed.Line := '';
            if Key[2] <> '' then
                TempGLAccWhereUsed.Line := TempGLAccWhereUsed.Line + ', ' + Key[2] + '=' + Key[5];
            if Key[3] <> '' then
                TempGLAccWhereUsed.Line := TempGLAccWhereUsed.Line + ', ' + Key[3] + '=' + Key[6];
            if Key[7] <> '' then
                TempGLAccWhereUsed.Line := TempGLAccWhereUsed.Line + ', ' + Key[7] + '=' + Key[8];
            TempGLAccWhereUsed."Entry No." := NextEntryNo;
            TempGLAccWhereUsed."Key 1" := CopyStr(Key[4], 1, MaxStrLen(TempGLAccWhereUsed."Key 1"));
            TempGLAccWhereUsed."Key 2" := CopyStr(Key[5], 1, MaxStrLen(TempGLAccWhereUsed."Key 2"));
            TempGLAccWhereUsed."Key 3" := CopyStr(Key[6], 1, MaxStrLen(TempGLAccWhereUsed."Key 3"));
            TempGLAccWhereUsed."Key 4" := CopyStr(Key[8], 1, MaxStrLen(TempGLAccWhereUsed."Key 4"));
            NextEntryNo := NextEntryNo + 1;
            TempGLAccWhereUsed.Insert();
        end;
    end;

    local procedure InsertGroupFromRecRef(var RecRef: RecordRef; FieldCaption: Text[80])
    var
        FieldRef: FieldRef;
        KeyRef: KeyRef;
        KeyFieldCount: Integer;
        FieldCaptionAndValue: Text;
    begin
        if NextEntryNo = 0 then
            NextEntryNo := TempGLAccWhereUsed.GetLastEntryNo() + 1;

        TempGLAccWhereUsed."Entry No." := NextEntryNo;
        TempGLAccWhereUsed."Field Name" := FieldCaption;
        TempGLAccWhereUsed.Line := '';
        KeyRef := RecRef.KeyIndex(1);
        for KeyFieldCount := 1 to KeyRef.FieldCount do begin
            FieldRef := KeyRef.FieldIndex(KeyFieldCount);
            FieldCaptionAndValue := StrSubstNo('%1=%2', FieldRef.Caption, FieldRef.Value);
            if TempGLAccWhereUsed.Line = '' then
                TempGLAccWhereUsed.Line := CopyStr(FieldCaptionAndValue, 1, MaxStrLen(TempGLAccWhereUsed.Line))
            else
                TempGLAccWhereUsed.Line :=
                  CopyStr(TempGLAccWhereUsed.Line + ', ' + FieldCaptionAndValue, 1, MaxStrLen(TempGLAccWhereUsed.Line));

            case KeyFieldCount of
                1:
                    TempGLAccWhereUsed."Key 1" := CopyStr(Format(FieldRef.Value), 1, MaxStrLen(TempGLAccWhereUsed."Key 1"));
                2:
                    TempGLAccWhereUsed."Key 2" := CopyStr(Format(FieldRef.Value), 1, MaxStrLen(TempGLAccWhereUsed."Key 2"));
                3:
                    TempGLAccWhereUsed."Key 3" := CopyStr(Format(FieldRef.Value), 1, MaxStrLen(TempGLAccWhereUsed."Key 3"));
                4:
                    TempGLAccWhereUsed."Key 4" := CopyStr(Format(FieldRef.Value), 1, MaxStrLen(TempGLAccWhereUsed."Key 4"));
            end;
        end;
        NextEntryNo := NextEntryNo + 1;
        TempGLAccWhereUsed.Insert();
    end;

    procedure CheckPostingGroups(GLAccNo: Code[20])
    var
        GLAcc: Record "G/L Account";
        TempTableBuffer: Record "Integer" temporary;
    begin
        NextEntryNo := 0;
        Clear(TempGLAccWhereUsed);
        TempGLAccWhereUsed.DeleteAll();
        GLAcc.Get(GLAccNo);
        TempGLAccWhereUsed."G/L Account No." := GLAccNo;
        TempGLAccWhereUsed."G/L Account Name" := GLAcc.Name;

        if FillTableBuffer(TempTableBuffer) then
            repeat
                CheckTable(GLAccNo, TempTableBuffer.Number);
            until TempTableBuffer.Next() = 0;

        OnAfterCheckPostingGroups(TempGLAccWhereUsed, GLAccNo);
    end;

    local procedure FillTableBuffer(var TableBuffer: Record "Integer"): Boolean
    begin
        AddTable(TableBuffer, Enum::TableID::Currency.AsInteger());
        AddTable(TableBuffer, Enum::TableID::"Gen. Journal Template".AsInteger());
        AddTable(TableBuffer, Enum::TableID::"Gen. Journal Batch".AsInteger());
        AddTable(TableBuffer, Enum::TableID::"Customer Posting Group".AsInteger());
        AddTable(TableBuffer, Enum::TableID::"Vendor Posting Group".AsInteger());
        AddTable(TableBuffer, Enum::TableID::"Job Posting Group".AsInteger());
        AddTable(TableBuffer, Enum::TableID::"Gen. Jnl. Allocation".AsInteger());
        AddTable(TableBuffer, Enum::TableID::"General Posting Setup".AsInteger());
        AddTable(TableBuffer, Enum::TableID::"Bank Account Posting Group".AsInteger());
        AddTable(TableBuffer, Enum::TableID::"VAT Posting Setup".AsInteger());
        AddTable(TableBuffer, Enum::TableID::"FA Posting Group".AsInteger());
        AddTable(TableBuffer, Enum::TableID::"FA Allocation".AsInteger());
        AddTable(TableBuffer, Enum::TableID::"Inventory Posting Setup".AsInteger());
        AddTable(TableBuffer, Enum::TableID::"Service Contract Account Group".AsInteger());
        AddTable(TableBuffer, Enum::TableID::"IC Partner".AsInteger());
        AddTable(TableBuffer, Enum::TableID::"Payment Method".AsInteger());
        AddTable(TableBuffer, Enum::TableID::"Sales & Receivables Setup".AsInteger());
        AddTable(TableBuffer, Enum::TableID::"Purchases & Payables Setup".AsInteger());
        AddTable(TableBuffer, Enum::TableID::"Employee Posting Group".AsInteger());
        AddTable(TableBuffer, Enum::TableID::"Business Unit".AsInteger());
        AddTable(TableBuffer, Enum::TableID::"Cash Flow Setup".AsInteger());

        AddCountryTables(TableBuffer);

        OnAfterFillTableBuffer(TableBuffer);

        exit(TableBuffer.FindSet());
    end;

    procedure AddTable(var TableBuffer: Record "Integer"; TableID: Integer)
    begin
        if not TableBuffer.Get(TableID) then begin
            TableBuffer.Number := TableID;
            TableBuffer.Insert();
        end;
    end;

    local procedure AddCountryTables(var TableBuffer: Record "Integer")
    begin
        TableBuffer.Reset();
    end;

    local procedure CheckTable(GLAccNo: Code[20]; TableID: Integer)
    var
        TableRelationsMetadata: Record "Table Relations Metadata";
        "Field": Record "Field";
        RecRef: RecordRef;
    begin
        RecRef.Open(TableID);
        TempGLAccWhereUsed.Init();
        TempGLAccWhereUsed."Table ID" := TableID;
        TempGLAccWhereUsed."Table Name" := RecRef.Caption;

        TableRelationsMetadata.SetRange("Table ID", TableID);
        TableRelationsMetadata.SetRange("Related Table ID", Enum::TableID::"G/L Account");
        if TableRelationsMetadata.FindSet() then
            repeat
                Field.Get(TableRelationsMetadata."Table ID", TableRelationsMetadata."Field No.");
                if (Field.Class = Field.Class::Normal) and (Field.ObsoleteState <> Field.ObsoleteState::Removed) then
                    CheckField(RecRef, TableRelationsMetadata, GLAccNo);
            until TableRelationsMetadata.Next() = 0;
    end;

    local procedure CheckField(var RecRef: RecordRef; TableRelationsMetadata: Record "Table Relations Metadata"; GLAccNo: Code[20])
    var
        FieldRef: FieldRef;
    begin
        RecRef.Reset();
        FieldRef := RecRef.Field(TableRelationsMetadata."Field No.");
        FieldRef.SetRange(GLAccNo);
        SetConditionFilter(RecRef, TableRelationsMetadata);
        if RecRef.FindSet() then
            repeat
                InsertGroupFromRecRef(RecRef, FieldRef.Caption);
            until RecRef.Next() = 0;
    end;

    local procedure SetConditionFilter(var RecRef: RecordRef; TableRelationsMetadata: Record "Table Relations Metadata")
    var
        FieldRef: FieldRef;
    begin
        if TableRelationsMetadata."Condition Field No." <> 0 then begin
            FieldRef := RecRef.Field(TableRelationsMetadata."Condition Field No.");
            FieldRef.SetFilter(TableRelationsMetadata."Condition Value");
        end;
    end;

    [IntegrationEvent(false, false)]
    local procedure OnShowExtensionPage(GLAccountWhereUsed: Record "G/L Account Where-Used")
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterCheckPostingGroups(var TempGLAccountWhereUsed: Record "G/L Account Where-Used" temporary; GLAccNo: Code[20])
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterFillTableBuffer(var TableBuffer: Record "Integer")
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeShowGLAccWhereUsed(var GLAccountWhereUsed: Record "G/L Account Where-Used")
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnShowSetupFormOnBeforeFAAllocationRunPage(var FAAllocation: Record "FA Allocation"; var GLAccountWhereUsed: Record "G/L Account Where-Used")
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnDeleteGLNoOnBeforeTempGLAccWhereUsedFindFirst(var TempGLAccountWhereUsed: Record "G/L Account Where-Used" temporary)
    begin
    end;
}

