namespace Microsoft.Intercompany.CrossEnvironment;

using Microsoft.BankMgt.BankAccount;
using Microsoft.FinancialMgt.GeneralLedger.Setup;
using Microsoft.Foundation.Company;
using Microsoft.Intercompany.DataExchange;
using Microsoft.Intercompany.Dimension;
using Microsoft.Intercompany.GLAccount;
using Microsoft.Intercompany.Inbox;
using Microsoft.Intercompany.Partner;
using Microsoft.Intercompany.Setup;
using System.Threading;

codeunit 561 "IC Data Exchange API" implements "IC Data Exchange"
{
    var
        CrossIntercompanyConnector: Codeunit "CrossIntercompany Connector";
        JsonResponse: JsonArray;
        SelectedToken: JsonToken;
        AttributeToken: JsonToken;

        JobQueueCategoryCodeTok: Label 'ICAUTOACC', Locked = true;
        ICPartnerMissingCurrentCompanyErr: Label 'The current company is not registered as a partner in the list of partners of company %1', Comment = '%1 = Partner company name';
        PartnerMissingTableSetupErr: Label 'Partner %1 has not completed the information required at table %2 for using intercompany.', Comment = '%1 = Partner code, %2 = Table caption';
        ICTransactionAlreadyExistMsg: Label '%1 %2 to IC Partner %3 already exists in the IC inbox of IC Partner %3. IC Partner %3 must complete the line action for transaction %2 in their IC inbox.', Comment = '%1 = Field caption, %2 = field value, %3 = IC Partner code';
        WrongICPartnerInboxTypeErr: Label 'Partner %1 inbox type is not valid for this interaction. Only partners with database as Inbox Type can be used.', Comment = '%1 = IC Partner Code';
        WrongICDataExchangeTypeErr: Label 'Partner %1 does not support intercompany communication using APIs. Only partners setup to use API as their data exchange type can use this type of communication.', Comment = '%1 = IC Partner Code';
        UnexpectedValueFromJsonValueErr: Label 'Unexpected value for field %1 in table %2. Value: %3', Comment = '%1 = Field caption, %2 = Table caption, %3 = Value';
        AutoAcceptTransactionTxt: Label 'API - Auto. accept transaction %1 of partner %2 for document %3', Comment = '%1 = Transaction ID, %2 = Partner Code, %3 = Document No.';
        ICPartnerNotFoundErr: Label 'IC Partner %1 not found.', Comment = '%1 = IC Partner Code';

    procedure GetICPartnerICGLAccount(ICPartner: Record "IC Partner"; var TempICPartnerICGLAccount: Record "IC G/L Account" temporary)
    begin
        TempICPartnerICGLAccount.Reset();
        TempICPartnerICGLAccount.DeleteAll();
        CheckICPartnerSetup(ICPartner);

        JsonResponse := CrossIntercompanyConnector.RequestICPartnerRecordsFromEntityName(ICPartner, 'intercompanyGeneralLedgerAccounts');

        foreach SelectedToken in JsonResponse do
            PopulateICGLAccountFromJson(SelectedToken, TempICPartnerICGLAccount);
    end;

    procedure GetICPartnerICDimension(ICPartner: Record "IC Partner"; var TempICPartnerICDimension: Record "IC Dimension" temporary)
    begin
        TempICPartnerICDimension.Reset();
        TempICPartnerICDimension.DeleteAll();
        CheckICPartnerSetup(ICPartner);

        JsonResponse := CrossIntercompanyConnector.RequestICPartnerRecordsFromEntityName(ICPartner, 'intercompanyDimensions');

        foreach SelectedToken in JsonResponse do
            PopulateICDimensionFromJson(SelectedToken, TempICPartnerICDimension);
    end;

    procedure GetICPartnerICDimensionValue(ICPartner: Record "IC Partner"; var TempICPartnerICDimensionValue: Record "IC Dimension Value" temporary)
    begin
        TempICPartnerICDimensionValue.Reset();
        TempICPartnerICDimensionValue.DeleteAll();
        CheckICPartnerSetup(ICPartner);

        JsonResponse := CrossIntercompanyConnector.RequestICPartnerRecordsFromEntityName(ICPartner, 'intercompanyDimensionValues');

        foreach SelectedToken in JsonResponse do
            PopulateICDimensionValueFromJson(SelectedToken, TempICPartnerICDimensionValue);
    end;

    procedure GetICPartnerFromICPartner(ICPartner: Record "IC Partner"; var TempRegisteredICPartner: Record "IC Partner" temporary)
    var
        ICSetup: Record "IC Setup";
    begin
        ICSetup.Get();
        GetICPartnerFromICPartner(ICPartner, ICSetup."IC Partner Code", TempRegisteredICPartner);
    end;

    procedure GetICPartnerFromICPartner(ICPartner: Record "IC Partner"; ICPartnerCode: Code[20]; var TempRegisteredICPartner: Record "IC Partner" temporary)
    var
        TempICPartners: Record "IC Partner" temporary;
    begin
        TempRegisteredICPartner.Reset();
        TempRegisteredICPartner.DeleteAll();
        CheckICPartnerSetup(ICPartner);

        JsonResponse := CrossIntercompanyConnector.RequestICPartnerRecordsFromEntityName(ICPartner, 'intercompanyPartners');

        foreach SelectedToken in JsonResponse do
            PopulateICPartnerFromJson(SelectedToken, TempICPartners);


        if not TempICPartners.Get(ICPartnerCode) then
            Error(ICPartnerMissingCurrentCompanyErr, ICPartner."Inbox Details");

        TempRegisteredICPartner.TransferFields(TempICPartners);
        TempRegisteredICPartner.Insert();
    end;

    procedure GetICPartnerICSetup(ICPartnerName: Text; var TempICPartnerICSetup: Record "IC Setup" temporary)
    var
        ICPartner: Record "IC Partner";
    begin
        ICPartner.SetRange("Inbox Details", ICPartnerName);
        if not ICPartner.FindFirst() then
            Error(ICPartnerNotFoundErr, ICPartnerName);

        GetICPartnerICSetup(ICPartner, TempICPartnerICSetup);
    end;

    procedure GetICPartnerICSetup(ICPartner: Record "IC Partner"; var TempICPartnerICSetup: Record "IC Setup" temporary)
    begin
        TempICPartnerICSetup.Reset();
        TempICPartnerICSetup.DeleteAll();
        CheckICPartnerSetup(ICPartner);

        JsonResponse := CrossIntercompanyConnector.RequestICPartnerRecordsFromEntityName(ICPartner, 'intercompanySetup');

        foreach SelectedToken in JsonResponse do
            PopulateICSetupFromJson(SelectedToken, TempICPartnerICSetup);

        if not TempICPartnerICSetup.FindFirst() then begin
            if System.GuiAllowed() then
                Message(PartnerMissingTableSetupErr, ICPartner."Inbox Details", TempICPartnerICSetup.TableCaption);
            exit;
        end;
    end;

    procedure GetICPartnerGeneralLedgerSetup(ICPartnerName: Text; var TempICPartnerGeneralLedgerSetup: Record "General Ledger Setup" temporary)
    var
        ICPartner: Record "IC Partner";
    begin
        ICPartner.SetRange("Inbox Details", ICPartnerName);
        if not ICPartner.FindFirst() then
            Error(ICPartnerNotFoundErr, ICPartnerName);

        GetICPartnerGeneralLedgerSetup(ICPartner, TempICPartnerGeneralLedgerSetup);
    end;

    procedure GetICPartnerGeneralLedgerSetup(ICPartner: Record "IC Partner"; var TempICPartnerGeneralLedgerSetup: Record "General Ledger Setup" temporary)
    begin
        TempICPartnerGeneralLedgerSetup.Reset();
        TempICPartnerGeneralLedgerSetup.DeleteAll();
        CheckICPartnerSetup(ICPartner);

        JsonResponse := CrossIntercompanyConnector.RequestICPartnerGeneralLedgerSetup(ICPartner);

        foreach SelectedToken in JsonResponse do
            PopulateGeneralLedgerSetupFromJson(SelectedToken, TempICPartnerGeneralLedgerSetup);

        if not TempICPartnerGeneralLedgerSetup.FindFirst() then begin
            if System.GuiAllowed() then
                Message(PartnerMissingTableSetupErr, ICPartner."Inbox Details", TempICPartnerGeneralLedgerSetup.TableCaption);
            exit;
        end;
    end;

    procedure GetICPartnerCompanyInformation(ICPartnerName: Text; var TempICPartnerCompanyInformation: Record "Company Information" temporary)
    var
        ICPartner: Record "IC Partner";
    begin
        ICPartner.SetRange("Inbox Details", ICPartnerName);
        if not ICPartner.FindFirst() then
            Error(ICPartnerNotFoundErr, ICPartnerName);

        GetICPartnerCompanyInformation(ICPartner, TempICPartnerCompanyInformation);
    end;

    procedure GetICPartnerCompanyInformation(ICPartner: Record "IC Partner"; var TempICPartnerCompanyInformation: Record "Company Information" temporary)
    begin
        TempICPartnerCompanyInformation.Reset();
        TempICPartnerCompanyInformation.DeleteAll();
        CheckICPartnerSetup(ICPartner);

        JsonResponse := CrossIntercompanyConnector.RequestICPartnerCompanyInformation(ICPartner);

        foreach SelectedToken in JsonResponse do
            PopulateCompanyInformationFromJson(SelectedToken, TempICPartnerCompanyInformation);

        if not TempICPartnerCompanyInformation.FindFirst() then begin
            if System.GuiAllowed() then
                Message(PartnerMissingTableSetupErr, ICPartner."Inbox Details", TempICPartnerCompanyInformation.TableCaption);
            exit;
        end;
    end;

    procedure GetICPartnerBankAccount(ICPartner: Record "IC Partner"; var TempICPartnerBankAccount: Record "Bank Account" temporary)
    var
        GeneralLedgerSetup: Record "General Ledger Setup";
        TempBankAccount: Record "Bank Account" temporary;
        LCYCurrencyCode: Code[10];
    begin
        TempICPartnerBankAccount.Reset();
        TempICPartnerBankAccount.DeleteAll();
        CheckICPartnerSetup(ICPartner);

        JsonResponse := CrossIntercompanyConnector.RequestICPartnerBankAccount(ICPartner);

        GeneralLedgerSetup.Get();
        LCYCurrencyCode := GeneralLedgerSetup."LCY Code";
        foreach SelectedToken in JsonResponse do
            PopulateBankAccountFromJson(SelectedToken, TempBankAccount, LCYCurrencyCode);

        TempBankAccount.SetRange(IntercompanyEnable, true);
        if not TempBankAccount.IsEmpty() then begin
            TempBankAccount.FindSet();
            repeat
                TempICPartnerBankAccount.TransferFields(TempBankAccount);
                TempICPartnerBankAccount.Insert();
            until TempBankAccount.Next() = 0;
        end;
    end;

    procedure GetICPartnerICInboxTransaction(ICPartner: Record "IC Partner"; var TempICPartnerICInboxTransaction: Record "IC Inbox Transaction" temporary)
    begin
        TempICPartnerICInboxTransaction.Reset();
        TempICPartnerICInboxTransaction.DeleteAll();
        CheckICPartnerSetup(ICPartner);

        JsonResponse := CrossIntercompanyConnector.RequestICPartnerRecordsFromEntityName(ICPartner, 'intercompanyInboxTransactions');

        foreach SelectedToken in JsonResponse do
            PopulateICInboxTransactionFromJson(SelectedToken, TempICPartnerICInboxTransaction);
    end;

    procedure GetICPartnerHandledICInboxTransaction(ICPartner: Record "IC Partner"; var TempICPartnerHandledICInboxTransaction: Record "Handled IC Inbox Trans." temporary)
    begin
        TempICPartnerHandledICInboxTransaction.Reset();
        TempICPartnerHandledICInboxTransaction.DeleteAll();
        CheckICPartnerSetup(ICPartner);

        JsonResponse := CrossIntercompanyConnector.RequestICPartnerRecordsFromEntityName(ICPartner, 'handledIntercompanyInboxTransactions');

        foreach SelectedToken in JsonResponse do
            PopulateHandledICInboxTransactionFromJson(SelectedToken, TempICPartnerHandledICInboxTransaction);
    end;

    procedure PostICTransactionToICPartnerInbox(ICPartner: Record "IC Partner"; var TempICPartnerICInboxTransaction: Record "IC Inbox Transaction" temporary)
    var
        ContentJsonText: Text;
    begin
        if not TempICPartnerICInboxTransaction.IsEmpty() then begin
            TempICPartnerICInboxTransaction.FindSet();
            repeat
                CreateJsonContentFromICInboxTransaction(TempICPartnerICInboxTransaction, ContentJsonText);
                if not CrossIntercompanyConnector.SubmitRecordsToICPartnerFromEntityName(ICPartner, ContentJsonText, 'intercompanyInboxTransaction', 'documentNumber', TempICPartnerICInboxTransaction."Document No.") then
                    Error(
                      ICTransactionAlreadyExistMsg, TempICPartnerICInboxTransaction.FieldCaption("Transaction No."),
                      TempICPartnerICInboxTransaction."Transaction No.",
                      TempICPartnerICInboxTransaction."IC Partner Code");
            until TempICPartnerICInboxTransaction.Next() = 0;
        end;
    end;

    procedure PostICJournalLineToICPartnerInbox(ICPartner: Record "IC Partner"; var TempICPartnerICInboxJnlLine: Record "IC Inbox Jnl. Line" temporary)
    var
        GeneralLedgerSetup: Record "General Ledger Setup";
        ContentJsonText: Text;
    begin
        GeneralLedgerSetup.Get();
        if not TempICPartnerICInboxJnlLine.IsEmpty() then begin
            TempICPartnerICInboxJnlLine.FindSet();
            repeat
                if TempICPartnerICInboxJnlLine."Currency Code" = '' then
                    TempICPartnerICInboxJnlLine."Currency Code" := GeneralLedgerSetup."LCY Code";

                if TempICPartnerICInboxJnlLine."Currency Code" = ICPartner."Currency Code" then
                    TempICPartnerICInboxJnlLine."Currency Code" := '';

                CreateJsonContentFromICInboxJnlLine(TempICPartnerICInboxJnlLine, ContentJsonText);
                if not CrossIntercompanyConnector.SubmitRecordsToICPartnerFromEntityName(ICPartner, ContentJsonText, 'intercompanyInboxJournalLine', 'documentNumber', TempICPartnerICInboxJnlLine."Document No.") then
                    Error(
                      ICTransactionAlreadyExistMsg, TempICPartnerICInboxJnlLine.FieldCaption("Transaction No."),
                      TempICPartnerICInboxJnlLine."Transaction No.",
                      TempICPartnerICInboxJnlLine."IC Partner Code");
            until TempICPartnerICInboxJnlLine.Next() = 0;
        end;
    end;

    procedure PostICPurchaseHeaderToICPartnerInbox(ICPartner: Record "IC Partner"; var TempICPartnerICInboxPurchaseHeader: Record "IC Inbox Purchase Header" temporary; var RegisteredPartner: Record "IC Partner" temporary)
    var
        ContentJsonText: Text;
    begin
        if not TempICPartnerICInboxPurchaseHeader.IsEmpty() then begin
            TempICPartnerICInboxPurchaseHeader.FindSet();
            repeat
                TempICPartnerICInboxPurchaseHeader."Buy-from Vendor No." := RegisteredPartner."Vendor No.";
                TempICPartnerICInboxPurchaseHeader."Pay-to Vendor No." := RegisteredPartner."Vendor No.";
                CreateJsonContentFromICInboxPurchaseHeader(TempICPartnerICInboxPurchaseHeader, ContentJsonText);
                if not CrossIntercompanyConnector.SubmitRecordsToICPartnerFromEntityName(ICPartner, ContentJsonText, 'intercompanyInboxPurchaseHeader', 'number', TempICPartnerICInboxPurchaseHeader."No.") then
                    Error(
                      ICTransactionAlreadyExistMsg, TempICPartnerICInboxPurchaseHeader.FieldCaption("IC Transaction No."),
                      TempICPartnerICInboxPurchaseHeader."IC Transaction No.",
                      TempICPartnerICInboxPurchaseHeader."IC Partner Code");
            until TempICPartnerICInboxPurchaseHeader.Next() = 0;
        end;
    end;

    procedure PostICPurchaseLineToICPartnerInbox(ICPartner: Record "IC Partner"; var TempICPartnerICInboxPurchaseLine: Record "IC Inbox Purchase Line" temporary)
    var
        ContentJsonText: Text;
    begin
        if not TempICPartnerICInboxPurchaseLine.IsEmpty() then begin
            TempICPartnerICInboxPurchaseLine.FindSet();
            repeat
                CreateJsonContentFromICInboxPurchaseLine(TempICPartnerICInboxPurchaseLine, ContentJsonText);
                if not CrossIntercompanyConnector.SubmitRecordsToICPartnerFromEntityName(ICPartner, ContentJsonText, 'intercompanyInboxPurchaseLine', 'documentNumber', TempICPartnerICInboxPurchaseLine."Document No.") then
                    Error(
                      ICTransactionAlreadyExistMsg, TempICPartnerICInboxPurchaseLine.FieldCaption("IC Transaction No."),
                      TempICPartnerICInboxPurchaseLine."IC Transaction No.",
                      TempICPartnerICInboxPurchaseLine."IC Partner Code");
            until TempICPartnerICInboxPurchaseLine.Next() = 0;
        end;
    end;

    procedure PostICSalesHeaderToICPartnerInbox(ICPartner: Record "IC Partner"; var TempICPartnerICInboxSalesHeader: Record "IC Inbox Sales Header" temporary; var RegisteredPartner: Record "IC Partner" temporary)
    var
        ContentJsonText: Text;
    begin
        if not TempICPartnerICInboxSalesHeader.IsEmpty() then begin
            TempICPartnerICInboxSalesHeader.FindSet();
            repeat
                TempICPartnerICInboxSalesHeader."Sell-to Customer No." := RegisteredPartner."Customer No.";
                TempICPartnerICInboxSalesHeader."Bill-to Customer No." := RegisteredPartner."Customer No.";
                CreateJsonContentFromICInboxSalesHeader(TempICPartnerICInboxSalesHeader, ContentJsonText);
                if not CrossIntercompanyConnector.SubmitRecordsToICPartnerFromEntityName(ICPartner, ContentJsonText, 'intercompanyInboxSalesHeader', 'documentNumber', TempICPartnerICInboxSalesHeader."No.") then
                    Error(
                      ICTransactionAlreadyExistMsg, TempICPartnerICInboxSalesHeader.FieldCaption("IC Transaction No."),
                      TempICPartnerICInboxSalesHeader."IC Transaction No.",
                      TempICPartnerICInboxSalesHeader."IC Partner Code");
            until TempICPartnerICInboxSalesHeader.Next() = 0;
        end;
    end;

    procedure PostICSalesLineToICPartnerInbox(ICPartner: Record "IC Partner"; var TempICPartnerICInboxSalesLine: Record "IC Inbox Sales Line" temporary)
    var
        ContentJsonText: Text;
    begin
        if not TempICPartnerICInboxSalesLine.IsEmpty() then begin
            TempICPartnerICInboxSalesLine.FindSet();
            repeat
                CreateJsonContentFromICInboxSalesLine(TempICPartnerICInboxSalesLine, ContentJsonText);
                if not CrossIntercompanyConnector.SubmitRecordsToICPartnerFromEntityName(ICPartner, ContentJsonText, 'intercompanyInboxSalesLine', 'documentNumber', TempICPartnerICInboxSalesLine."Document No.") then
                    Error(
                      ICTransactionAlreadyExistMsg, TempICPartnerICInboxSalesLine.FieldCaption("IC Transaction No."),
                      TempICPartnerICInboxSalesLine."IC Transaction No.",
                      TempICPartnerICInboxSalesLine."IC Partner Code");
            until TempICPartnerICInboxSalesLine.Next() = 0;
        end;
    end;

    procedure PostICJournalLineDimensionToICPartnerInbox(ICPartner: Record "IC Partner"; var TempICPartnerICInboxOutboxJnlLineDim: Record "IC Inbox/Outbox Jnl. Line Dim." temporary)
    var
        ContentJsonText: Text;
    begin
        if not TempICPartnerICInboxOutboxJnlLineDim.IsEmpty() then begin
            TempICPartnerICInboxOutboxJnlLineDim.FindSet();
            repeat
                CreateJsonContentFromICInboxOutboxJournalLineDimension(TempICPartnerICInboxOutboxJnlLineDim, ContentJsonText);
                if not CrossIntercompanyConnector.SubmitRecordsToICPartnerFromEntityName(ICPartner, ContentJsonText, 'intercompanyInboxOutboxJournalLineDimension', 'transactionNumber', Format(TempICPartnerICInboxOutboxJnlLineDim."Transaction No.")) then
                    Error(
                      ICTransactionAlreadyExistMsg, TempICPartnerICInboxOutboxJnlLineDim.FieldCaption("Transaction No."),
                      TempICPartnerICInboxOutboxJnlLineDim."Transaction No.",
                      TempICPartnerICInboxOutboxJnlLineDim."IC Partner Code");
            until TempICPartnerICInboxOutboxJnlLineDim.Next() = 0;
        end;
    end;

    procedure PostICDocumentDimensionToICPartnerInbox(ICPartner: Record "IC Partner"; var TempICPartnerICDocDim: Record "IC Document Dimension" temporary)
    var
        ContentJsonText: Text;
    begin
        if not TempICPartnerICDocDim.IsEmpty() then begin
            TempICPartnerICDocDim.FindSet();
            repeat
                CreateJsonContentFromICDocumentDimension(TempICPartnerICDocDim, ContentJsonText);
                if not CrossIntercompanyConnector.SubmitRecordsToICPartnerFromEntityName(ICPartner, ContentJsonText, 'intercompanyDocumentDimension', 'transactionNumber', Format(TempICPartnerICDocDim."Transaction No.")) then
                    Error(
                      ICTransactionAlreadyExistMsg, TempICPartnerICDocDim.FieldCaption("Transaction No."),
                      TempICPartnerICDocDim."Transaction No.",
                      TempICPartnerICDocDim."IC Partner Code");
            until TempICPartnerICDocDim.Next() = 0;
        end;
    end;

    procedure PostICCommentLineToICPartnerInbox(ICPartner: Record "IC Partner"; var TempICPartnerICInboxCommentLine: Record "IC Comment Line" temporary)
    var
        ContentJsonText: Text;
    begin
        if not TempICPartnerICInboxCommentLine.IsEmpty() then begin
            TempICPartnerICInboxCommentLine.FindSet();
            repeat
                CreateJsonContentFromICCommentLine(TempICPartnerICInboxCommentLine, ContentJsonText);
                if not CrossIntercompanyConnector.SubmitRecordsToICPartnerFromEntityName(ICPartner, ContentJsonText, 'intercompanyCommentLine', 'transactionNumber', Format(TempICPartnerICInboxCommentLine."Transaction No.")) then
                    Error(
                      ICTransactionAlreadyExistMsg, TempICPartnerICInboxCommentLine.FieldCaption("Transaction No."),
                      TempICPartnerICInboxCommentLine."Transaction No.",
                      TempICPartnerICInboxCommentLine."IC Partner Code");
            until TempICPartnerICInboxCommentLine.Next() = 0;
        end;
    end;

    procedure EnqueueAutoAcceptedICInboxTransaction(ICPartner: Record "IC Partner"; ICInboxTransaction: Record "IC Inbox Transaction")
    var
        JobQueueEntry: Record "Job Queue Entry";
        ContentJsonText: Text;
    begin
        if not ICInboxTransaction.IsEmpty() then begin
            ICInboxTransaction.FindSet();
            repeat
                CreateJsonContentForJobQueueEntry(ICInboxTransaction, ContentJsonText);
                if not CrossIntercompanyConnector.SubmitJobQueueEntryToICPartner(ICPartner, ContentJsonText, 'recordIdToProcess', Format(ICInboxTransaction.RecordId)) then
                    Error(
                      ICTransactionAlreadyExistMsg, JobQueueEntry.FieldCaption("Record ID to Process"),
                      ICInboxTransaction.RecordId,
                      ICInboxTransaction."IC Partner Code");
            until ICInboxTransaction.Next() = 0;
        end;
    end;

    local procedure CheckICPartnerSetup(var ICPartner: Record "IC Partner")
    begin
        if ICPartner."Inbox Type" <> Enum::"IC Partner Inbox Type"::Database then
            Error(WrongICPartnerInboxTypeErr, ICPartner.Code);

        if ICPartner."Data Exchange Type" <> Enum::"IC Data Exchange Type"::API then
            Error(WrongICDataExchangeTypeErr, ICPartner.Code);
    end;

    #region Procedures to populate records from Json
#pragma warning disable AA0139 // Ignore warning about possible overflow from JSON Text
    local procedure PopulateICGLAccountFromJson(IndividualToken: JsonToken; var TempICPartnerICGLAccount: Record "IC G/L Account" temporary)
    begin
        TempICPartnerICGLAccount.Init();

        TempICPartnerICGLAccount."No." := GetValueFromJsonTokenOrEmptyText(IndividualToken, 'accountNumber');
        TempICPartnerICGLAccount.Name := GetValueFromJsonTokenOrEmptyText(IndividualToken, 'name');
        IndividualToken.AsObject().Get('accountType', AttributeToken);
        Evaluate(TempICPartnerICGLAccount."Account Type", AttributeToken.AsValue().AsText());

        IndividualToken.AsObject().Get('incomeBalance', AttributeToken);
        case AttributeToken.AsValue().AsText() of
            'Income Statement':
                TempICPartnerICGLAccount."Income/Balance" := TempICPartnerICGLAccount."Income/Balance"::"Income Statement";
            'Balance Sheet':
                TempICPartnerICGLAccount."Income/Balance" := TempICPartnerICGLAccount."Income/Balance"::"Balance Sheet";
            else
                Error(UnexpectedValueFromJsonValueErr, TempICPartnerICGLAccount.FieldCaption("Income/Balance"), TempICPartnerICGLAccount.TableCaption(), AttributeToken.AsValue().AsText());
        end;

        TempICPartnerICGLAccount.Blocked := GetValueFromJsonTokenOrFalse(IndividualToken, 'blocked');

        TempICPartnerICGLAccount.Insert();
    end;

    local procedure PopulateICDimensionFromJson(IndividualToken: JsonToken; var TempICPartnerICDimension: Record "IC Dimension" temporary)
    begin
        TempICPartnerICDimension.Init();

        TempICPartnerICDimension.Code := GetValueFromJsonTokenOrEmptyText(IndividualToken, 'code');
        TempICPartnerICDimension.Name := GetValueFromJsonTokenOrEmptyText(IndividualToken, 'name');
        TempICPartnerICDimension.Blocked := GetValueFromJsonTokenOrFalse(IndividualToken, 'blocked');

        TempICPartnerICDimension.Insert();
    end;

    local procedure PopulateICDimensionValueFromJson(IndividualToken: JsonToken; var TempICPartnerICDimensionValue: Record "IC Dimension Value" temporary)
    begin
        TempICPartnerICDimensionValue.Init();

        TempICPartnerICDimensionValue."Dimension Code" := GetValueFromJsonTokenOrEmptyText(IndividualToken, 'dimensionCode');
        TempICPartnerICDimensionValue.Code := GetValueFromJsonTokenOrEmptyText(IndividualToken, 'code');
        TempICPartnerICDimensionValue.Name := GetValueFromJsonTokenOrEmptyText(IndividualToken, 'name');

        IndividualToken.AsObject().Get('dimensionValueType', AttributeToken);
        case AttributeToken.AsValue().AsText() of
            'Begin-Total':
                TempICPartnerICDimensionValue."Dimension Value Type" := TempICPartnerICDimensionValue."Dimension Value Type"::"Begin-Total";
            'End-Total':
                TempICPartnerICDimensionValue."Dimension Value Type" := TempICPartnerICDimensionValue."Dimension Value Type"::"End-Total";
            'Heading':
                TempICPartnerICDimensionValue."Dimension Value Type" := TempICPartnerICDimensionValue."Dimension Value Type"::Heading;
            'Standard':
                TempICPartnerICDimensionValue."Dimension Value Type" := TempICPartnerICDimensionValue."Dimension Value Type"::Standard;
            'Total':
                TempICPartnerICDimensionValue."Dimension Value Type" := TempICPartnerICDimensionValue."Dimension Value Type"::Total;
            else
                Error(UnexpectedValueFromJsonValueErr, TempICPartnerICDimensionValue.FieldCaption("Dimension Value Type"), TempICPartnerICDimensionValue.TableCaption(), AttributeToken.AsValue().AsText());
        end;

        TempICPartnerICDimensionValue.Blocked := GetValueFromJsonTokenOrFalse(IndividualToken, 'blocked');

        TempICPartnerICDimensionValue.Insert();
    end;

    local procedure PopulateICPartnerFromJson(IndividualToken: JsonToken; var TempRegisteredICPartner: Record "IC Partner" temporary)
    begin
        TempRegisteredICPartner.Init();

        TempRegisteredICPartner.Code := GetValueFromJsonTokenOrEmptyText(IndividualToken, 'partnerCode');
        TempRegisteredICPartner.Name := GetValueFromJsonTokenOrEmptyText(IndividualToken, 'name');
        TempRegisteredICPartner."Currency Code" := GetValueFromJsonTokenOrEmptyText(IndividualToken, 'currencyCode');

        IndividualToken.AsObject().Get('inboxType', AttributeToken);
        Evaluate(TempRegisteredICPartner."Inbox Type", AttributeToken.AsValue().AsText());

        TempRegisteredICPartner."Inbox Details" := GetValueFromJsonTokenOrEmptyText(IndividualToken, 'inboxDetails');
        TempRegisteredICPartner."Receivables Account" := GetValueFromJsonTokenOrEmptyText(IndividualToken, 'receivablesAccount');
        TempRegisteredICPartner."Payables Account" := GetValueFromJsonTokenOrEmptyText(IndividualToken, 'payablesAccount');
        TempRegisteredICPartner."Country/Region Code" := GetValueFromJsonTokenOrEmptyText(IndividualToken, 'countryRegionCode');
        TempRegisteredICPartner.Blocked := GetValueFromJsonTokenOrFalse(IndividualToken, 'blocked');
        TempRegisteredICPartner."Customer No." := GetValueFromJsonTokenOrEmptyText(IndividualToken, 'customerNumber');
        TempRegisteredICPartner."Vendor No." := GetValueFromJsonTokenOrEmptyText(IndividualToken, 'vendorNumber');

        IndividualToken.AsObject().Get('outboundSalesItemNumberType', AttributeToken);
        Evaluate(TempRegisteredICPartner."Outbound Sales Item No. Type", AttributeToken.AsValue().AsText());

        IndividualToken.AsObject().Get('outboundPurchaseItemNumberType', AttributeToken);
        Evaluate(TempRegisteredICPartner."Outbound Purch. Item No. Type", AttributeToken.AsValue().AsText());

        TempRegisteredICPartner."Cost Distribution in LCY" := GetValueFromJsonTokenOrFalse(IndividualToken, 'costDistributionInLCY');
        TempRegisteredICPartner."Auto. Accept Transactions" := GetValueFromJsonTokenOrFalse(IndividualToken, 'autoAcceptTransactions');

        IndividualToken.AsObject().Get('dataExchangeType', AttributeToken);
        Evaluate(TempRegisteredICPartner."Data Exchange Type", AttributeToken.AsValue().AsText());

        TempRegisteredICPartner.Insert();
    end;

    local procedure PopulateICSetupFromJson(IndividualToken: JsonToken; var TempICPartnerICSetup: Record "IC Setup" temporary)
    begin
        TempICPartnerICSetup.Init();

        TempICPartnerICSetup."IC Partner Code" := GetValueFromJsonTokenOrEmptyText(IndividualToken, 'icPartnerCode');

        IndividualToken.AsObject().Get('icInboxType', AttributeToken);
        case AttributeToken.AsValue().AsText() of
            'Database':
                TempICPartnerICSetup."IC Inbox Type" := TempICPartnerICSetup."IC Inbox Type"::Database;
            'File Location':
                TempICPartnerICSetup."IC Inbox Type" := TempICPartnerICSetup."IC Inbox Type"::"File Location";
            else
                Error(UnexpectedValueFromJsonValueErr, TempICPartnerICSetup.FieldCaption("IC Inbox Type"), TempICPartnerICSetup.TableCaption(), AttributeToken.AsValue().AsText());
        end;

        TempICPartnerICSetup."IC Inbox Details" := GetValueFromJsonTokenOrEmptyText(IndividualToken, 'icInboxDetails');
        TempICPartnerICSetup."Default IC Gen. Jnl. Template" := GetValueFromJsonTokenOrEmptyText(IndividualToken, 'defaultICGeneralJournalTemplate');
        TempICPartnerICSetup."Default IC Gen. Jnl. Batch" := GetValueFromJsonTokenOrEmptyText(IndividualToken, 'defaultICGeneralJournalBatch');

        TempICPartnerICSetup.Insert();
    end;

    local procedure PopulateGeneralLedgerSetupFromJson(IndividualToken: JsonToken; var TempICPartnerGeneralLedgerSetup: Record "General Ledger Setup" temporary)
    begin
        TempICPartnerGeneralLedgerSetup.Init();

        TempICPartnerGeneralLedgerSetup."Allow Posting From" := GetValueFromJsonTokenOrToday(IndividualToken, 'allowPostingFrom');
        TempICPartnerGeneralLedgerSetup."Allow Posting To" := GetValueFromJsonTokenOrToday(IndividualToken, 'allowPostingTo');
        TempICPartnerGeneralLedgerSetup."Additional Reporting Currency" := GetValueFromJsonTokenOrEmptyText(IndividualToken, 'additionalReportingCurrency');
        TempICPartnerGeneralLedgerSetup."LCY Code" := GetValueFromJsonTokenOrEmptyText(IndividualToken, 'localCurrencyCode');
        TempICPartnerGeneralLedgerSetup."Local Currency Symbol" := GetValueFromJsonTokenOrEmptyText(IndividualToken, 'localCurrencySymbol');

        TempICPartnerGeneralLedgerSetup.Insert();
    end;

    local procedure PopulateCompanyInformationFromJson(IndividualToken: JsonToken; var TempICPartnerCompanyInformation: Record "Company Information" temporary)
    begin
        TempICPartnerCompanyInformation.Init();

        TempICPartnerCompanyInformation.Name := GetValueFromJsonTokenOrEmptyText(IndividualToken, 'displayName');
        TempICPartnerCompanyInformation.Address := GetValueFromJsonTokenOrEmptyText(IndividualToken, 'addressLine1');
        TempICPartnerCompanyInformation."Address 2" := GetValueFromJsonTokenOrEmptyText(IndividualToken, 'addressLine2');
        TempICPartnerCompanyInformation.City := GetValueFromJsonTokenOrEmptyText(IndividualToken, 'city');
        TempICPartnerCompanyInformation.County := GetValueFromJsonTokenOrEmptyText(IndividualToken, 'state');
        TempICPartnerCompanyInformation."Country/Region Code" := GetValueFromJsonTokenOrEmptyText(IndividualToken, 'country');
        TempICPartnerCompanyInformation."Post Code" := GetValueFromJsonTokenOrEmptyText(IndividualToken, 'postalCode');
        TempICPartnerCompanyInformation."Phone No." := GetValueFromJsonTokenOrEmptyText(IndividualToken, 'phoneNumber');

        TempICPartnerCompanyInformation.Insert();
    end;

    local procedure PopulateBankAccountFromJson(IndividualToken: JsonToken; var TempICPartnerBankAccount: Record "Bank Account" temporary; LCYCurrencyCode: Code[10])
    var
        CurrencyCode: Code[10];
    begin
        TempICPartnerBankAccount.Init();

        TempICPartnerBankAccount."No." := GetValueFromJsonTokenOrEmptyText(IndividualToken, 'number');
        TempICPartnerBankAccount.Name := GetValueFromJsonTokenOrEmptyText(IndividualToken, 'displayName');
        TempICPartnerBankAccount."Bank Account No." := GetValueFromJsonTokenOrEmptyText(IndividualToken, 'bankAccountNumber');
        TempICPartnerBankAccount.Blocked := GetValueFromJsonTokenOrFalse(IndividualToken, 'blocked');

        IndividualToken.AsObject().Get('currencyCode', AttributeToken);
        CurrencyCode := AttributeToken.AsValue().AsText();
        if CurrencyCode = LCYCurrencyCode then
            TempICPartnerBankAccount."Currency Code" := ''
        else
            TempICPartnerBankAccount."Currency Code" := CurrencyCode;

        TempICPartnerBankAccount.IBAN := GetValueFromJsonTokenOrEmptyText(IndividualToken, 'iban');

        TempICPartnerBankAccount.IntercompanyEnable := true;
        TempICPartnerBankAccount.Insert();
    end;

    local procedure PopulateICInboxTransactionFromJson(IndividualToken: JsonToken; var TempICPartnerICInboxTransaction: Record "IC Inbox Transaction" temporary)
    begin
        TempICPartnerICInboxTransaction.Init();

        TempICPartnerICInboxTransaction."Transaction No." := GetValueFromJsonTokenOrZero(IndividualToken, 'transactionNumber');
        TempICPartnerICInboxTransaction."IC Partner Code" := GetValueFromJsonTokenOrEmptyText(IndividualToken, 'icPartnerCode');

        IndividualToken.AsObject().Get('sourceType', AttributeToken);
        case AttributeToken.AsValue().AsText() of
            'Journal':
                TempICPartnerICInboxTransaction."Source Type" := TempICPartnerICInboxTransaction."Source Type"::Journal;
            'Purchase Document':
                TempICPartnerICInboxTransaction."Source Type" := TempICPartnerICInboxTransaction."Source Type"::"Purchase Document";
            'Sales Document':
                TempICPartnerICInboxTransaction."Source Type" := TempICPartnerICInboxTransaction."Source Type"::"Sales Document";
            else
                Error(UnexpectedValueFromJsonValueErr, TempICPartnerICInboxTransaction.FieldCaption("Source Type"), TempICPartnerICInboxTransaction.TableCaption(), AttributeToken.AsValue().AsText());
        end;

        IndividualToken.AsObject().Get('documentType', AttributeToken);
        Evaluate(TempICPartnerICInboxTransaction."Document Type", AttributeToken.AsValue().AsText());

        TempICPartnerICInboxTransaction."Document No." := GetValueFromJsonTokenOrEmptyText(IndividualToken, 'documentNumber');
        TempICPartnerICInboxTransaction."Posting Date" := GetValueFromJsonTokenOrToday(IndividualToken, 'postingDate');

        IndividualToken.AsObject().Get('transactionSource', AttributeToken);
        case AttributeToken.AsValue().AsText() of
            'Created by Partner':
                TempICPartnerICInboxTransaction."Transaction Source" := TempICPartnerICInboxTransaction."Transaction Source"::"Created by Partner";
            'Returned by Partner':
                TempICPartnerICInboxTransaction."Transaction Source" := TempICPartnerICInboxTransaction."Transaction Source"::"Returned by Partner";
            else
                Error(UnexpectedValueFromJsonValueErr, TempICPartnerICInboxTransaction.FieldCaption("Transaction Source"), TempICPartnerICInboxTransaction.TableCaption(), AttributeToken.AsValue().AsText());
        end;

        TempICPartnerICInboxTransaction."Posting Date" := GetValueFromJsonTokenOrToday(IndividualToken, 'documentDate');

        IndividualToken.AsObject().Get('lineAction', AttributeToken);
        case AttributeToken.AsValue().AsText() of
            'Accept':
                TempICPartnerICInboxTransaction."Line Action" := TempICPartnerICInboxTransaction."Line Action"::Accept;
            'Cancel':
                TempICPartnerICInboxTransaction."Line Action" := TempICPartnerICInboxTransaction."Line Action"::Cancel;
            'No Action':
                TempICPartnerICInboxTransaction."Line Action" := TempICPartnerICInboxTransaction."Line Action"::"No Action";
            'Return to IC Partner':
                TempICPartnerICInboxTransaction."Line Action" := TempICPartnerICInboxTransaction."Line Action"::"Return to IC Partner";
            else
                Error(UnexpectedValueFromJsonValueErr, TempICPartnerICInboxTransaction.FieldCaption("Line Action"), TempICPartnerICInboxTransaction.TableCaption(), AttributeToken.AsValue().AsText());
        end;

        TempICPartnerICInboxTransaction."Original Document No." := GetValueFromJsonTokenOrEmptyText(IndividualToken, 'originalDocumentNumber');
        TempICPartnerICInboxTransaction."Source Line No." := GetValueFromJsonTokenOrZero(IndividualToken, 'sourceLineNumber');

        IndividualToken.AsObject().Get('icAccountType', AttributeToken);
        Evaluate(TempICPartnerICInboxTransaction."IC Account Type", AttributeToken.AsValue().AsText());

        TempICPartnerICInboxTransaction."IC Account No." := GetValueFromJsonTokenOrEmptyText(IndividualToken, 'icAccountNumber');

        TempICPartnerICInboxTransaction.Insert();
    end;

    local procedure PopulateHandledICInboxTransactionFromJson(IndividualToken: JsonToken; var TempICPartnerHandledICInboxTransaction: Record "Handled IC Inbox Trans." temporary)
    begin

        TempICPartnerHandledICInboxTransaction.Init();

        TempICPartnerHandledICInboxTransaction."Transaction No." := GetValueFromJsonTokenOrZero(IndividualToken, 'transactionNumber');
        TempICPartnerHandledICInboxTransaction."IC Partner Code" := GetValueFromJsonTokenOrEmptyText(IndividualToken, 'icPartnerCode');

        IndividualToken.AsObject().Get('sourceType', AttributeToken);
        case AttributeToken.AsValue().AsText() of
            'Journal':
                TempICPartnerHandledICInboxTransaction."Source Type" := TempICPartnerHandledICInboxTransaction."Source Type"::Journal;
            'Purchase Document':
                TempICPartnerHandledICInboxTransaction."Source Type" := TempICPartnerHandledICInboxTransaction."Source Type"::"Purchase Document";
            'Sales Document':
                TempICPartnerHandledICInboxTransaction."Source Type" := TempICPartnerHandledICInboxTransaction."Source Type"::"Sales Document";
            else
                Error(UnexpectedValueFromJsonValueErr, TempICPartnerHandledICInboxTransaction.FieldCaption("Source Type"), TempICPartnerHandledICInboxTransaction.TableCaption(), AttributeToken.AsValue().AsText());
        end;

        IndividualToken.AsObject().Get('documentType', AttributeToken);
        Evaluate(TempICPartnerHandledICInboxTransaction."Document Type", AttributeToken.AsValue().AsText());

        TempICPartnerHandledICInboxTransaction."Document No." := GetValueFromJsonTokenOrEmptyText(IndividualToken, 'documentNumber');
        TempICPartnerHandledICInboxTransaction."Posting Date" := GetValueFromJsonTokenOrToday(IndividualToken, 'postingDate');

        IndividualToken.AsObject().Get('transactionSource', AttributeToken);
        case AttributeToken.AsValue().AsText() of
            'Created by Partner':
                TempICPartnerHandledICInboxTransaction."Transaction Source" := TempICPartnerHandledICInboxTransaction."Transaction Source"::"Created by Partner";
            'Returned by Partner':
                TempICPartnerHandledICInboxTransaction."Transaction Source" := TempICPartnerHandledICInboxTransaction."Transaction Source"::"Returned by Partner";
            else
                Error(UnexpectedValueFromJsonValueErr, TempICPartnerHandledICInboxTransaction.FieldCaption("Transaction Source"), TempICPartnerHandledICInboxTransaction.TableCaption(), AttributeToken.AsValue().AsText());
        end;

        TempICPartnerHandledICInboxTransaction."Posting Date" := GetValueFromJsonTokenOrToday(IndividualToken, 'documentDate');

        IndividualToken.AsObject().Get('status', AttributeToken);
        case AttributeToken.AsValue().AsText() of
            'Accepted':
                TempICPartnerHandledICInboxTransaction.Status := TempICPartnerHandledICInboxTransaction.Status::Accepted;
            'Cancelled':
                TempICPartnerHandledICInboxTransaction.Status := TempICPartnerHandledICInboxTransaction.Status::Cancelled;
            'Posted':
                TempICPartnerHandledICInboxTransaction.Status := TempICPartnerHandledICInboxTransaction.Status::Posted;
            'Returned to IC Partner':
                TempICPartnerHandledICInboxTransaction.Status := TempICPartnerHandledICInboxTransaction.Status::"Returned to IC Partner";
            else
                Error(UnexpectedValueFromJsonValueErr, TempICPartnerHandledICInboxTransaction.FieldCaption(Status), TempICPartnerHandledICInboxTransaction.TableCaption(), AttributeToken.AsValue().AsText());
        end;

        TempICPartnerHandledICInboxTransaction."Source Line No." := GetValueFromJsonTokenOrZero(IndividualToken, 'sourceLineNumber');

        IndividualToken.AsObject().Get('icAccountType', AttributeToken);
        Evaluate(TempICPartnerHandledICInboxTransaction."IC Account Type", AttributeToken.AsValue().AsText());

        TempICPartnerHandledICInboxTransaction."IC Account No." := GetValueFromJsonTokenOrEmptyText(IndividualToken, 'icAccountNumber');

        TempICPartnerHandledICInboxTransaction.Insert();
    end;

    local procedure GetValueFromJsonTokenOrEmptyText(IndividualToken: JsonToken; AttributeName: Text): Text
    begin
        if IndividualToken.AsObject().Get(AttributeName, AttributeToken) then
            exit(AttributeToken.AsValue().AsText());
        exit('');
    end;

    local procedure GetValueFromJsonTokenOrFalse(IndividualToken: JsonToken; AttributeName: Text): Boolean
    begin
        if IndividualToken.AsObject().Get(AttributeName, AttributeToken) then
            exit(AttributeToken.AsValue().AsBoolean());
        exit(false);
    end;

    local procedure GetValueFromJsonTokenOrZero(IndividualToken: JsonToken; AttributeName: Text): Integer
    begin
        if IndividualToken.AsObject().Get(AttributeName, AttributeToken) then
            exit(AttributeToken.AsValue().AsInteger());
        exit(0);
    end;

    local procedure GetValueFromJsonTokenOrToday(IndividualToken: JsonToken; AttributeName: Text): Date
    begin
        if IndividualToken.AsObject().Get(AttributeName, AttributeToken) then
            exit(AttributeToken.AsValue().AsDate());
        exit(Today);
    end;
#pragma warning restore AA0139
    #endregion


    #region Procedures to populate records from Json
    local procedure CreateJsonContentFromICInboxTransaction(var TempICPartnerICInboxTransaction: Record "IC Inbox Transaction" temporary; var ContentJsonText: Text)
    var
        LineJson: JsonObject;
    begin

        LineJson.Add('transactionNumber', TempICPartnerICInboxTransaction."Transaction No.");
        LineJson.Add('icPartnerCode', TempICPartnerICInboxTransaction."IC Partner Code");
        LineJson.Add('sourceType', Format(TempICPartnerICInboxTransaction."Source Type"));
        LineJson.Add('documentType', TempICPartnerICInboxTransaction."Document Type".Names.Get(TempICPartnerICInboxTransaction."Document Type".Ordinals.IndexOf(TempICPartnerICInboxTransaction."Document Type".AsInteger())));
        LineJson.Add('documentNumber', TempICPartnerICInboxTransaction."Document No.");
        LineJson.Add('postingDate', TempICPartnerICInboxTransaction."Posting Date");
        LineJson.Add('transactionSource', Format(TempICPartnerICInboxTransaction."Transaction Source"));
        LineJson.Add('documentDate', TempICPartnerICInboxTransaction."Posting Date");
        LineJson.Add('lineAction', Format(TempICPartnerICInboxTransaction."Line Action"));
        LineJson.Add('originalDocumentNumber', TempICPartnerICInboxTransaction."Original Document No.");
        LineJson.Add('sourceLineNumber', TempICPartnerICInboxTransaction."Source Line No.");
        LineJson.Add('icAccountType', TempICPartnerICInboxTransaction."IC Account Type".Names.Get(TempICPartnerICInboxTransaction."IC Account Type".Ordinals.IndexOf(TempICPartnerICInboxTransaction."IC Account Type".AsInteger())));
        LineJson.Add('icAccountNumber', TempICPartnerICInboxTransaction."IC Account No.");

        LineJson.WriteTo(ContentJsonText);
    end;

    local procedure CreateJsonContentFromICInboxJnlLine(var TempICPartnerICInboxJnlLine: Record "IC Inbox Jnl. Line" temporary; var ContentJsonText: Text)
    var
        LineJson: JsonObject;
    begin
        LineJson.Add('transactionNumber', TempICPartnerICInboxJnlLine."Transaction No.");
        LineJson.Add('icPartnerCode', TempICPartnerICInboxJnlLine."IC Partner Code");
        LineJson.Add('lineNumber', TempICPartnerICInboxJnlLine."Line No.");
        LineJson.Add('accountType', Format(TempICPartnerICInboxJnlLine."Account Type"));
        LineJson.Add('accountNumber', TempICPartnerICInboxJnlLine."Account No.");
        LineJson.Add('amount', TempICPartnerICInboxJnlLine.Amount);
        LineJson.Add('description', TempICPartnerICInboxJnlLine.Description);
        LineJson.Add('vatAmount', TempICPartnerICInboxJnlLine."VAT Amount");
        LineJson.Add('currencyCode', TempICPartnerICInboxJnlLine."Currency Code");
        LineJson.Add('dueDate', TempICPartnerICInboxJnlLine."Due Date");
        LineJson.Add('paymentDiscount', TempICPartnerICInboxJnlLine."Payment Discount %");
        LineJson.Add('paymentDiscountDate', TempICPartnerICInboxJnlLine."Payment Discount Date");
        LineJson.Add('quantity', TempICPartnerICInboxJnlLine.Quantity);
        LineJson.Add('transactionSource', Format(TempICPartnerICInboxJnlLine."Transaction Source"));
        LineJson.Add('documentNumber', TempICPartnerICInboxJnlLine."Document No.");

        LineJson.WriteTo(ContentJsonText);
    end;

    local procedure CreateJsonContentFromICInboxPurchaseHeader(var TempICPartnerICInboxPurchaseHeader: Record "IC Inbox Purchase Header" temporary; var ContentJsonText: Text)
    var
        LineJson: JsonObject;
    begin
        LineJson.Add('documentType', TempICPartnerICInboxPurchaseHeader."Document Type".Names.Get(TempICPartnerICInboxPurchaseHeader."Document Type".Ordinals.IndexOf(TempICPartnerICInboxPurchaseHeader."Document Type".AsInteger())));
        LineJson.Add('buyFromVendorNumber', TempICPartnerICInboxPurchaseHeader."Buy-from Vendor No.");
        LineJson.Add('number', TempICPartnerICInboxPurchaseHeader."No.");
        LineJson.Add('payToVendorNumber', TempICPartnerICInboxPurchaseHeader."Pay-to Vendor No.");
        LineJson.Add('shipToName', TempICPartnerICInboxPurchaseHeader."Ship-to Name");
        LineJson.Add('shipToAddress', TempICPartnerICInboxPurchaseHeader."Ship-to Address");
        LineJson.Add('shipToAddress2', TempICPartnerICInboxPurchaseHeader."Ship-to Address 2");
        LineJson.Add('shipToCity', TempICPartnerICInboxPurchaseHeader."Ship-to City");
        LineJson.Add('postingDate', TempICPartnerICInboxPurchaseHeader."Posting Date");
        LineJson.Add('expectedReceiptDate', TempICPartnerICInboxPurchaseHeader."Expected Receipt Date");
        LineJson.Add('dueDate', TempICPartnerICInboxPurchaseHeader."Due Date");
        LineJson.Add('paymentDiscount', TempICPartnerICInboxPurchaseHeader."Payment Discount %");
        LineJson.Add('paymentDiscountDate', TempICPartnerICInboxPurchaseHeader."Pmt. Discount Date");
        LineJson.Add('currencyCode', TempICPartnerICInboxPurchaseHeader."Currency Code");
        LineJson.Add('pricesIncludingVat', TempICPartnerICInboxPurchaseHeader."Prices Including VAT");
        LineJson.Add('vendorOrderNumber', TempICPartnerICInboxPurchaseHeader."Vendor Order No.");
        LineJson.Add('vendorInvoiceNumber', TempICPartnerICInboxPurchaseHeader."Vendor Invoice No.");
        LineJson.Add('vendorCreditMemoNumber', TempICPartnerICInboxPurchaseHeader."Vendor Cr. Memo No.");
        LineJson.Add('sellToCustomerNumber', TempICPartnerICInboxPurchaseHeader."Sell-to Customer No.");
        LineJson.Add('shipToPostCode', TempICPartnerICInboxPurchaseHeader."Ship-to Post Code");
        LineJson.Add('shipToCounty', TempICPartnerICInboxPurchaseHeader."Ship-to County");
        LineJson.Add('shipToCountryRegionCode', TempICPartnerICInboxPurchaseHeader."Ship-to Country/Region Code");
        LineJson.Add('documentDate', TempICPartnerICInboxPurchaseHeader."Document Date");
        LineJson.Add('intercompanyPartnerCode', TempICPartnerICInboxPurchaseHeader."IC Partner Code");
        LineJson.Add('intercompanyTransactionNumber', TempICPartnerICInboxPurchaseHeader."IC Transaction No.");
        LineJson.Add('transactionSource', TempICPartnerICInboxPurchaseHeader."Transaction Source");
        LineJson.Add('requestedReceiptDate', TempICPartnerICInboxPurchaseHeader."Requested Receipt Date");
        LineJson.Add('promisedReceiptDate', TempICPartnerICInboxPurchaseHeader."Promised Receipt Date");

        LineJson.WriteTo(ContentJsonText);
    end;

    local procedure CreateJsonContentFromICInboxPurchaseLine(var TempICPartnerICInboxPurchaseLine: Record "IC Inbox Purchase Line" temporary; var ContentJsonText: Text)
    var
        LineJson: JsonObject;
    begin
        LineJson.Add('documentType', TempICPartnerICInboxPurchaseLine."Document Type".Names.Get(TempICPartnerICInboxPurchaseLine."Document Type".Ordinals.IndexOf(TempICPartnerICInboxPurchaseLine."Document Type".AsInteger())));
        LineJson.Add('documentNumber', TempICPartnerICInboxPurchaseLine."Document No.");
        LineJson.Add('lineNumber', TempICPartnerICInboxPurchaseLine."Line No.");
        LineJson.Add('description', TempICPartnerICInboxPurchaseLine.Description);
        LineJson.Add('description2', TempICPartnerICInboxPurchaseLine."Description 2");
        LineJson.Add('quantity', TempICPartnerICInboxPurchaseLine.Quantity);
        LineJson.Add('directUnitCost', TempICPartnerICInboxPurchaseLine."Direct Unit Cost");
        LineJson.Add('lineDiscount', TempICPartnerICInboxPurchaseLine."Line Discount %");
        LineJson.Add('lineDiscountAmount', TempICPartnerICInboxPurchaseLine."Line Discount Amount");
        LineJson.Add('amountIncludingVat', TempICPartnerICInboxPurchaseLine."Amount Including VAT");
        LineJson.Add('jobNumber', TempICPartnerICInboxPurchaseLine."Job No.");
        LineJson.Add('indirectCost', TempICPartnerICInboxPurchaseLine."Indirect Cost %");
        LineJson.Add('receiptNumber', TempICPartnerICInboxPurchaseLine."Receipt No.");
        LineJson.Add('receiptLineNumber', TempICPartnerICInboxPurchaseLine."Receipt Line No.");
        LineJson.Add('dropShipment', TempICPartnerICInboxPurchaseLine."Drop Shipment");
        LineJson.Add('currencyCode', TempICPartnerICInboxPurchaseLine."Currency Code");
        LineJson.Add('vatBaseAmount', TempICPartnerICInboxPurchaseLine."VAT Base Amount");
        LineJson.Add('unitCost', TempICPartnerICInboxPurchaseLine."Unit Cost");
        LineJson.Add('lineAmount', TempICPartnerICInboxPurchaseLine."Line Amount");
        LineJson.Add('icPartnerReferenceType', TempICPartnerICInboxPurchaseLine."IC Partner Ref. Type".Names.Get(TempICPartnerICInboxPurchaseLine."IC Partner Ref. Type".Ordinals.IndexOf(TempICPartnerICInboxPurchaseLine."IC Partner Ref. Type".AsInteger())));
        LineJson.Add('icPartnerReference', TempICPartnerICInboxPurchaseLine."IC Partner Reference");
        LineJson.Add('icPartnerCode', TempICPartnerICInboxPurchaseLine."IC Partner Code");
        LineJson.Add('icTransactionNumber', TempICPartnerICInboxPurchaseLine."IC Transaction No.");
        LineJson.Add('transactionSource', TempICPartnerICInboxPurchaseLine."Transaction Source");
        LineJson.Add('itemReference', TempICPartnerICInboxPurchaseLine."Item Ref.");
        LineJson.Add('icItemreferenceNumber', TempICPartnerICInboxPurchaseLine."IC Item Reference No.");
        LineJson.Add('unitOfMeasureCode', TempICPartnerICInboxPurchaseLine."Unit of Measure Code");
        LineJson.Add('requestedReceiptDate', TempICPartnerICInboxPurchaseLine."Requested Receipt Date");
        LineJson.Add('promisedReceiptDate', TempICPartnerICInboxPurchaseLine."Promised Receipt Date");
        LineJson.Add('returnShipmentNumber', TempICPartnerICInboxPurchaseLine."Return Shipment No.");
        LineJson.Add('returnShipmentLineNumber', TempICPartnerICInboxPurchaseLine."Return Shipment Line No.");

        LineJson.WriteTo(ContentJsonText);
    end;

    local procedure CreateJsonContentFromICInboxSalesHeader(var TempICPartnerICInboxSalesHeader: Record "IC Inbox Sales Header" temporary; var ContentJsonText: Text)
    var
        LineJson: JsonObject;
    begin
        LineJson.Add('sellToCustomerNumber', TempICPartnerICInboxSalesHeader."Sell-to Customer No.");
        LineJson.Add('number', TempICPartnerICInboxSalesHeader."No.");
        LineJson.Add('billToCustomerNumber', TempICPartnerICInboxSalesHeader."Bill-to Customer No.");
        LineJson.Add('documentType', TempICPartnerICInboxSalesHeader."Document Type".Names.Get(TempICPartnerICInboxSalesHeader."Document Type".Ordinals.IndexOf(TempICPartnerICInboxSalesHeader."Document Type".AsInteger())));
        LineJson.Add('shipToName', TempICPartnerICInboxSalesHeader."Ship-to Name");
        LineJson.Add('shipToAddress', TempICPartnerICInboxSalesHeader."Ship-to Address");
        LineJson.Add('shipToAddress2', TempICPartnerICInboxSalesHeader."Ship-to Address 2");
        LineJson.Add('shipToCity', TempICPartnerICInboxSalesHeader."Ship-to City");
        LineJson.Add('postingDate', TempICPartnerICInboxSalesHeader."Posting Date");
        LineJson.Add('dueDate', TempICPartnerICInboxSalesHeader."Due Date");
        LineJson.Add('paymentDiscount', TempICPartnerICInboxSalesHeader."Payment Discount %");
        LineJson.Add('paymentDiscountDate', TempICPartnerICInboxSalesHeader."Pmt. Discount Date");
        LineJson.Add('currencyCode', TempICPartnerICInboxSalesHeader."Currency Code");
        LineJson.Add('pricesIncludingVat', TempICPartnerICInboxSalesHeader."Prices Including VAT");
        LineJson.Add('shipToPostCode', TempICPartnerICInboxSalesHeader."Ship-to Post Code");
        LineJson.Add('shipToCounty', TempICPartnerICInboxSalesHeader."Ship-to County");
        LineJson.Add('shipToCountryRegionCode', TempICPartnerICInboxSalesHeader."Ship-to Country/Region Code");
        LineJson.Add('documentDate', TempICPartnerICInboxSalesHeader."Document Date");
        LineJson.Add('externalDocumentNumber', TempICPartnerICInboxSalesHeader."External Document No.");
        LineJson.Add('intercompanyPartnerCode', TempICPartnerICInboxSalesHeader."IC Partner Code");
        LineJson.Add('intercompanyTransactionNumber', TempICPartnerICInboxSalesHeader."IC Transaction No.");
        LineJson.Add('transactionSource', TempICPartnerICInboxSalesHeader."Transaction Source");
        LineJson.Add('requestedDeliveryDate', TempICPartnerICInboxSalesHeader."Requested Delivery Date");
        LineJson.Add('promisedDeliveryDate', TempICPartnerICInboxSalesHeader."Promised Delivery Date");

        LineJson.WriteTo(ContentJsonText);
    end;

    local procedure CreateJsonContentFromICInboxSalesLine(var TempICPartnerICInboxSalesLine: Record "IC Inbox Sales Line" temporary; var ContentJsonText: Text)
    var
        LineJson: JsonObject;
    begin
        LineJson.Add('documentType', TempICPartnerICInboxSalesLine."Document Type".Names.Get(TempICPartnerICInboxSalesLine."Document Type".Ordinals.IndexOf(TempICPartnerICInboxSalesLine."Document Type".AsInteger())));
        LineJson.Add('documentNumber', TempICPartnerICInboxSalesLine."Document No.");
        LineJson.Add('lineNumber', TempICPartnerICInboxSalesLine."Line No.");
        LineJson.Add('description', TempICPartnerICInboxSalesLine.Description);
        LineJson.Add('description2', TempICPartnerICInboxSalesLine."Description 2");
        LineJson.Add('quantity', TempICPartnerICInboxSalesLine.Quantity);
        LineJson.Add('unitPrice', TempICPartnerICInboxSalesLine."Unit Price");
        LineJson.Add('lineDiscount', TempICPartnerICInboxSalesLine."Line Discount %");
        LineJson.Add('lineDiscountAmount', TempICPartnerICInboxSalesLine."Line Discount Amount");
        LineJson.Add('amountIncludingVat', TempICPartnerICInboxSalesLine."Amount Including VAT");
        LineJson.Add('jobNumber', TempICPartnerICInboxSalesLine."Job No.");
        LineJson.Add('dropShipment', TempICPartnerICInboxSalesLine."Drop Shipment");
        LineJson.Add('currencyCode', TempICPartnerICInboxSalesLine."Currency Code");
        LineJson.Add('vatBaseAmount', TempICPartnerICInboxSalesLine."VAT Base Amount");
        LineJson.Add('lineAmount', TempICPartnerICInboxSalesLine."Line Amount");
        LineJson.Add('icPartnerReferenceType', TempICPartnerICInboxSalesLine."IC Partner Ref. Type".Names.Get(TempICPartnerICInboxSalesLine."Document Type".Ordinals.IndexOf(TempICPartnerICInboxSalesLine."Document Type".AsInteger())));
        LineJson.Add('icPartnerReference', TempICPartnerICInboxSalesLine."IC Partner Reference");
        LineJson.Add('icPartnerCode', TempICPartnerICInboxSalesLine."IC Partner Code");
        LineJson.Add('icTransactionNumber', TempICPartnerICInboxSalesLine."IC Transaction No.");
        LineJson.Add('transactionSource', TempICPartnerICInboxSalesLine."Transaction Source");
        LineJson.Add('itemReference', TempICPartnerICInboxSalesLine."Item Ref.");
        LineJson.Add('icItemreferenceNumber', TempICPartnerICInboxSalesLine."IC Item Reference No.");
        LineJson.Add('unitOfMeasureCode', TempICPartnerICInboxSalesLine."Unit of Measure Code");
        LineJson.Add('requestedDeliveryDate', TempICPartnerICInboxSalesLine."Requested Delivery Date");
        LineJson.Add('promisedDeliveryDate', TempICPartnerICInboxSalesLine."Promised Delivery Date");

        LineJson.WriteTo(ContentJsonText);
    end;

    local procedure CreateJsonContentFromICInboxOutboxJournalLineDimension(var TempICPartnerICInboxOutboxJournalLineDimension: Record "IC Inbox/Outbox Jnl. Line Dim." temporary; var ContentJsonText: Text)
    var
        LineJson: JsonObject;
    begin
        LineJson.Add('tableId', TempICPartnerICInboxOutboxJournalLineDimension."Table ID");
        LineJson.Add('icPartnerCode', TempICPartnerICInboxOutboxJournalLineDimension."IC Partner Code");
        LineJson.Add('transactionNumber', TempICPartnerICInboxOutboxJournalLineDimension."Transaction No.");
        LineJson.Add('lineNumber', TempICPartnerICInboxOutboxJournalLineDimension."Line No.");
        LineJson.Add('dimensionCode', TempICPartnerICInboxOutboxJournalLineDimension."Dimension Code");
        LineJson.Add('dimensionValueCode', TempICPartnerICInboxOutboxJournalLineDimension."Dimension Value Code");
        LineJson.Add('transactionSource', TempICPartnerICInboxOutboxJournalLineDimension."Transaction Source");

        LineJson.WriteTo(ContentJsonText);
    end;

    local procedure CreateJsonContentFromICDocumentDimension(var TempICPartnerICDocumentDimension: Record "IC Document Dimension" temporary; var ContentJsonText: Text)
    var
        LineJson: JsonObject;
    begin
        LineJson.Add('tableId', TempICPartnerICDocumentDimension."Table ID");
        LineJson.Add('transactionNumber', TempICPartnerICDocumentDimension."Transaction No.");
        LineJson.Add('icPartnerCode', TempICPartnerICDocumentDimension."IC Partner Code");
        LineJson.Add('transactionSource', TempICPartnerICDocumentDimension."Transaction Source");
        LineJson.Add('lineNumber', TempICPartnerICDocumentDimension."Line No.");
        LineJson.Add('dimensionCode', TempICPartnerICDocumentDimension."Dimension Code");
        LineJson.Add('dimensionValueCode', TempICPartnerICDocumentDimension."Dimension Value Code");

        LineJson.WriteTo(ContentJsonText);
    end;

    local procedure CreateJsonContentFromICCommentLine(var TempICPartnerICCommentLine: Record "IC Comment Line" temporary; var ContentJsonText: Text)
    var
        LineJson: JsonObject;
    begin
        LineJson.Add('tableName', TempICPartnerICCommentLine."Table Name");
        LineJson.Add('icPartnerCode', TempICPartnerICCommentLine."IC Partner Code");
        LineJson.Add('lineNumber', TempICPartnerICCommentLine."Line No.");
        LineJson.Add('date', TempICPartnerICCommentLine.Date);
        LineJson.Add('comment', TempICPartnerICCommentLine.Comment);
        LineJson.Add('transactionSource', TempICPartnerICCommentLine."Transaction Source");
        LineJson.Add('createdByIcPartnerCode', TempICPartnerICCommentLine."Created By IC Partner Code");

        LineJson.WriteTo(ContentJsonText);
    end;

    local procedure CreateJsonContentForJobQueueEntry(var ICInboxTransaction: Record "IC Inbox Transaction"; var ContentJsonText: Text)
    var
        JobQueueEntry: Record "Job Queue Entry";
        LineJson: JsonObject;
    begin
        LineJson.Add('jobQueueId', CreateGuid());
        LineJson.Add('objectTypeToRun', JobQueueEntry."Object Type to Run"::Codeunit);
        LineJson.Add('objectIdToRun', Codeunit::"IC Inbox Outbox Subs. Runner");
        LineJson.Add('recordIdToProcess', Format(ICInboxTransaction.RecordId));
        LineJson.Add('jobqueueCategoryCode', JobQueueCategoryCodeTok);
        LineJson.Add('runInUserSession', Format(false));
        LineJson.Add('status', JobQueueEntry.Status::Ready);
        LineJson.Add('description', StrSubstNo(AutoAcceptTransactionTxt, ICInboxTransaction."Transaction No.", ICInboxTransaction."IC Partner Code", ICInboxTransaction."Document No."));

        LineJson.WriteTo(ContentJsonText);
    end;

    #endregion
}
