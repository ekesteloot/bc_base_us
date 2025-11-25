namespace Microsoft.Intercompany.Partner;

using Microsoft.FinancialMgt.Dimension;
using Microsoft.Intercompany.BankAccount;
using Microsoft.Intercompany.CrossEnvironment;
using Microsoft.Intercompany.DataExchange;
using Microsoft.Intercompany.Setup;
using System.Environment;

page 609 "IC Partner Card"
{
    Caption = 'Intercompany Partner';
    PageType = Card;
    SourceTable = "IC Partner";

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("Inbox Type"; Rec."Inbox Type")
                {
                    ApplicationArea = Intercompany;
                    Caption = 'Transfer Type';
                    ToolTip = 'Specifies what type of inbox the intercompany partner has. File Location. You send the partner a file containing intercompany transactions. Database: The partner is set up as another company in the same database. Email: You send the partner transactions by email.';

                    trigger OnValidate()
                    begin
                        SetInboxDetailsCaption();
                        ClearPartnerOAuthKeys();
                        Rec."Inbox Details" := '';
                    end;
                }
                field("Inbox Details"; Rec."Inbox Details")
                {
                    ApplicationArea = Intercompany;
                    CaptionClass = TransferTypeLbl;
                    Editable = EnableInboxDetails;
                    Enabled = EnableInboxDetails;
                    ToolTip = 'Specifies the details of the intercompany partner''s inbox.';

                    trigger OnValidate()
                    begin
                        if not AcceptModifySensibleData(Rec.FieldNo(Rec."Inbox Details")) then
                            Error('');
                    end;
                }
                field("Code"; Rec.Code)
                {
                    ApplicationArea = Intercompany;
                    ToolTip = 'Specifies the intercompany partner code.';
                    trigger OnValidate()
                    var
                        TempICSetup: Record "IC Setup" temporary;
                        ICPartner: Record "IC Partner";
                        ICDataExchange: Interface "IC Data Exchange";
                    begin
                        if Rec."Inbox Type" <> Rec."Inbox Type"::Database then
                            exit;
                        if Rec."Inbox Details" = '' then
                            exit;

                        ICPartner.SetRange("Inbox Details", Rec."Inbox Details");
                        if not ICPartner.FindFirst() then
                            exit;

                        if not AcceptModifySensibleData(Rec.FieldNo(Rec.Code)) then
                            Error('');

                        ICDataExchange := ICPartner."Data Exchange Type";
                        ICDataExchange.GetICPartnerICSetup(ICPartner, TempICSetup);
                        if TempICSetup."IC Partner Code" <> Rec.Code then
                            Message(PartnerHasDifferentICCodeMsg);


                    end;
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = Intercompany;
                    ToolTip = 'Specifies the name of the intercompany partner.';

                    trigger OnValidate()
                    begin
                        if not AcceptModifySensibleData(Rec.FieldNo(Rec.Name)) then
                            Error('');
                    end;
                }
                field("Country/Region Code"; Rec."Country/Region Code")
                {
                    ApplicationArea = Intercompany;
                    Tooltip = 'Specifies the country or region of this intercompany partner. It will be used as default for documents with no country specified.';
                }
                field("Currency Code"; Rec."Currency Code")
                {
                    ApplicationArea = Intercompany;
                    ToolTip = 'Specifies the currency that is used on the entry.';

                    trigger OnValidate()
                    begin
                        if not AcceptModifySensibleData(Rec.FieldNo(Rec."Currency Code")) then
                            Error('');
                    end;
                }
                field("Auto. Accept Transactions"; Rec."Auto. Accept Transactions")
                {
                    ApplicationArea = Intercompany;
                    Caption = 'Auto. Accept Transactions';
                    Editable = Rec."Inbox Type" = Rec."Inbox Type"::Database;
                    Enabled = Rec."Inbox Type" = Rec."Inbox Type"::Database;
                    ToolTip = 'Specifies that transactions from this intercompany partner are automatically accepted.';
                }
                field(Blocked; Rec.Blocked)
                {
                    ApplicationArea = Intercompany;
                    ToolTip = 'Specifies that the related record is blocked from being posted in transactions, for example a customer that is declared insolvent or an item that is placed in quarantine.';
                }
                group(DataExchangeType)
                {
                    Visible = Rec."Inbox Type" = Rec."Inbox Type"::Database;
                    ShowCaption = false;

                    field("Data Exchange Type"; Rec."Data Exchange Type")
                    {
                        Caption = 'Data Exchange Type';
                        ApplicationArea = Intercompany;
                        Importance = Additional;
                        ToolTip = 'Specifies the type of communication with the partner.';

                        trigger OnValidate()
                        begin
                            ClearPartnerOAuthKeys();
                        end;
                    }
                    field(ConnectionUrl; ConnectionUrl)
                    {
                        Caption = 'IC Partner''s Connection URL';
                        ApplicationArea = Intercompany;
                        Importance = Additional;
                        ExtendedDatatype = URL;
                        ToolTip = 'Specifies the connection URL for the intercompany partner''s environment.';
                        trigger OnValidate()
                        begin
                            if AcceptModifySensibleData(Rec.FieldNo(Rec."Connection Url Key")) then
                                Rec.SetSecret(Rec."Connection Url Key", ConnectionUrl)
                            else
                                PopulatePartnerSensibleDetails();
                        end;
                    }
                    field(CompanyId; CompanyId)
                    {
                        Caption = 'IC Partner''s Company ID';
                        ApplicationArea = Intercompany;
                        Importance = Additional;
                        ToolTip = 'Specifies the intercompany partner''s company ID in their environment.';
                        trigger OnValidate()
                        begin
                            if AcceptModifySensibleData(Rec.FieldNo(Rec."Company Id Key")) then
                                Rec.SetSecret(Rec."Company Id Key", CompanyId)
                            else
                                PopulatePartnerSensibleDetails();
                        end;
                    }
                    field(ClientId; ClientId)
                    {
                        Caption = 'Client ID';
                        ApplicationArea = Intercompany;
                        Importance = Additional;
                        ToolTip = 'Specifies the client ID of the Microsoft Entra authentication application.';
                        trigger OnValidate()
                        begin
                            if AcceptModifySensibleData(Rec.FieldNo(Rec."Client Id Key")) then
                                Rec.SetSecret(Rec."Client Id Key", ClientId)
                            else
                                PopulatePartnerSensibleDetails();
                        end;
                    }
                    field(ClientSecret; ClientSecret)
                    {
                        Caption = 'Client Secret';
                        ApplicationArea = Intercompany;
                        Importance = Additional;
                        ExtendedDatatype = Masked;
                        ToolTip = 'Specifies the client secret of the Microsoft Entra authentication application.';
                        trigger OnValidate()
                        begin
                            if AcceptModifySensibleData(Rec.FieldNo(Rec."Client Secret Key")) then
                                Rec.SetSecret(Rec."Client Secret Key", ClientSecret)
                            else
                                PopulatePartnerSensibleDetails();
                        end;
                    }
                    field(AuthorityUrl; AuthorityUrl)
                    {
                        Caption = 'Authority Endpoint';
                        ApplicationArea = Intercompany;
                        Importance = Additional;
                        ExtendedDatatype = URL;
                        ToolTip = 'Specifies the OAuth 2.0 authority endpoint of the Microsoft Entra authentication application.';
                        trigger OnValidate()
                        begin
                            if AcceptModifySensibleData(Rec.FieldNo(Rec."Authority Url Key")) then
                                Rec.SetSecret(Rec."Authority Url Key", AuthorityUrl)
                            else
                                PopulatePartnerSensibleDetails();
                        end;
                    }
                    field(RedirectUrl; RedirectUrl)
                    {
                        Caption = 'Redirect URL';
                        ApplicationArea = Intercompany;
                        Importance = Additional;
                        ExtendedDatatype = URL;
                        ToolTip = 'Specifies the OAuth 2.0 redirect URL of the Microsoft Entra authentication application.';
                        trigger OnValidate()
                        begin
                            if AcceptModifySensibleData(Rec.FieldNo(Rec."Redirect Url key")) then
                                Rec.SetSecret(Rec."Redirect Url key", RedirectUrl)
                            else
                                PopulatePartnerSensibleDetails();
                        end;
                    }
                }
            }
            group("Sales Transaction")
            {
                Caption = 'Sales Transaction';
                field("Customer No."; Rec."Customer No.")
                {
                    ApplicationArea = Intercompany;
                    ToolTip = 'Specifies the customer number that this intercompany partner is linked to.';

                    trigger OnValidate()
                    begin
                        CurrPage.Update(true);
                        Rec.PropagateCustomerICPartner(xRec."Customer No.", Rec."Customer No.", Rec.Code);
                        Rec.Find();
                    end;
                }
                field("Receivables Account"; Rec."Receivables Account")
                {
                    ApplicationArea = Intercompany;
                    ToolTip = 'Specifies the general ledger account to use when you post receivables from customers in this posting group.';
                }
                field("Outbound Sales Item No. Type"; Rec."Outbound Sales Item No. Type")
                {
                    ApplicationArea = Intercompany;
                    ToolTip = 'Specifies what type of item number is entered in the IC Partner Reference field for items on purchase lines that you send to this IC partner.';
                }
            }
            group("Purchase Transaction")
            {
                Caption = 'Purchase Transaction';
                field("Vendor No."; Rec."Vendor No.")
                {
                    ApplicationArea = Intercompany;
                    ToolTip = 'Specifies the vendor number that this intercompany partner is linked to.';

                    trigger OnValidate()
                    begin
                        CurrPage.Update(true);
                        Rec.PropagateVendorICPartner(xRec."Vendor No.", Rec."Vendor No.", Rec.Code);
                        Rec.Find();
                    end;
                }
                field("Payables Account"; Rec."Payables Account")
                {
                    ApplicationArea = Intercompany;
                    ToolTip = 'Specifies the general ledger account to use when you post payables due to vendors in this posting group.';
                }
                field("Outbound Purch. Item No. Type"; Rec."Outbound Purch. Item No. Type")
                {
                    ApplicationArea = Intercompany;
                    ToolTip = 'Specifies what type of item number is entered in the IC Partner Reference field for items on purchase lines that you send to this IC partner.';
                }
                field("Cost Distribution in LCY"; Rec."Cost Distribution in LCY")
                {
                    ApplicationArea = Intercompany;
                    ToolTip = 'Specifies whether costs are allocated in local currency to one or several IC partners.';
                }
            }
        }
        area(factboxes)
        {
            systempart(Control1900383207; Links)
            {
                ApplicationArea = RecordLinks;
                Visible = false;
            }
            systempart(Control1905767507; Notes)
            {
                ApplicationArea = Notes;
                Visible = false;
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("IC &Partner")
            {
                Caption = 'IC &Partner';
                Image = ICPartner;
                action(Dimensions)
                {
                    ApplicationArea = Dimensions;
                    Caption = 'Dimensions';
                    Image = Dimensions;
                    RunObject = Page "Default Dimensions";
                    RunPageLink = "Table ID" = const(413),
                                  "No." = field(Code);
                    ShortCutKey = 'Alt+D';
                    ToolTip = 'View or edit dimensions, such as area, project, or department, that you can assign to intercompany transactions to distribute costs and analyze transaction history.';
                }
                action(ICBankAccounts)
                {
                    Caption = 'Bank Accounts';
                    ShortCutKey = 'Alt+B';
                    Image = BankAccount;
                    ApplicationArea = Intercompany;
                    RunObject = Page "IC Bank Account List";
                    RunPageLink = "IC Partner Code" = field(Code);
                    ToolTip = 'Define the bank accounts to use during bank transactions with this partner.';
                }
                action(ConnectExternallySetup)
                {
                    Caption = 'Connect Externally Setup';
                    Image = LinkWithExisting;
                    ApplicationArea = Intercompany;
                    ToolTip = 'Define the partner''s endpoint to work with intercompany across environments.';
                    Enabled = (Rec.Code = '') and (Rec."Inbox Details" = '');

                    trigger OnAction()
                    begin
                        Page.Run(Page::"CrossIntercomp. Partner Setup");
                        CurrPage.Close();
                    end;
                }
            }
        }
        area(Promoted)
        {
            group(Category_Process)
            {
                Caption = 'Process';

                actionref(Dimensions_Promoted; Dimensions)
                {
                }
                actionref(ICBankAccounts_Promoted; ICBankAccounts)
                {
                }
                actionref(ConnectExternallySetup_Promoted; ConnectExternallySetup)
                {
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        SetInboxDetailsCaption();
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        SetInboxDetailsCaption();
    end;

    trigger OnOpenPage()
    begin
        PopulatePartnerSensibleDetails();
    end;

    var
        EnvironmentInformation: Codeunit "Environment Information";
        TransferTypeLbl: Text;
        [NonDebuggable]
        ConnectionUrl, ClientSecret, AuthorityUrl, RedirectUrl : Text;
        [NonDebuggable]
        CompanyId, ClientId : Guid;
        ModifySensibleDataQst: Label 'Modifying field %1 may disrupt the connection with the intercompany partner. Do you want to modify it?', Comment = '%1 = Field name';
        CompanyNameTransferTypeTxt: Label 'Company Name';
        FolderPathTransferTypeTxt: Label 'Folder Path';
        EmailAddressTransferTypeTxt: Label 'Email Address';
        PartnerHasDifferentICCodeMsg: Label 'The partner company has been configured with a different intercompany code. This mismatch can cause issues when using intercompany features.';

    protected var
        EnableInboxDetails: Boolean;

    local procedure SetInboxDetailsCaption()
    begin
        EnableInboxDetails :=
          (Rec."Inbox Type" <> Rec."Inbox Type"::"No IC Transfer") and
          not ((Rec."Inbox Type" = Rec."Inbox Type"::"File Location") and EnvironmentInformation.IsSaaS());
        case Rec."Inbox Type" of
            Rec."Inbox Type"::Database:
                TransferTypeLbl := CompanyNameTransferTypeTxt;
            Rec."Inbox Type"::"File Location":
                TransferTypeLbl := FolderPathTransferTypeTxt;
            Rec."Inbox Type"::Email:
                TransferTypeLbl := EmailAddressTransferTypeTxt;
            else
                OnSetInboxDetailsCaptionOnCaseElse(Rec, TransferTypeLbl);
        end;
    end;

    [NonDebuggable]
    local procedure PopulatePartnerSensibleDetails()
    begin
        ConnectionUrl := Rec.GetSecret(Rec."Connection Url Key");
        if Rec.GetSecret(Rec."Company Id Key") <> '' then
            CompanyId := Rec.GetSecret(Rec."Company Id Key");
        if Rec.GetSecret(Rec."Client Id Key") <> '' then
            ClientId := Rec.GetSecret(Rec."Client Id Key");
        ClientSecret := Rec.GetSecret(Rec."Client Secret Key");
        AuthorityUrl := Rec.GetSecret(Rec."Authority Url Key");
        RedirectUrl := Rec.GetSecret(Rec."Redirect Url Key");
    end;

    local procedure ClearPartnerOAuthKeys()
    var
        EmptyGuid: Guid;
    begin
        ConnectionUrl := '';
        Rec."Connection Url Key" := EmptyGuid;
        CompanyId := EmptyGuid;
        Rec."Company Id Key" := EmptyGuid;
        ClientId := EmptyGuid;
        Rec."Client Id Key" := EmptyGuid;
        ClientSecret := '';
        Rec."Client Secret Key" := EmptyGuid;
        AuthorityUrl := '';
        Rec."Authority Url Key" := EmptyGuid;
        RedirectUrl := '';
        Rec."Redirect Url Key" := EmptyGuid;
    end;

    local procedure AcceptModifySensibleData(FieldId: Integer): Boolean
    var
        RecordReference: RecordRef;
        FieldReference: FieldRef;
    begin
        if Rec."Data Exchange Type" = Enum::"IC Data Exchange Type"::Database then
            exit(false);

        RecordReference.Open(Database::"IC Partner");
        FieldReference := RecordReference.Field(FieldId);
        if FieldReference.Number IN
            [Rec.FieldNo(Rec."Inbox Type"),
            Rec.FieldNo(Rec."Inbox Details"),
            Rec.FieldNo(Rec.Code),
            Rec.FieldNo(Rec.Name),
            Rec.FieldNo(Rec."Currency Code"),
            Rec.FieldNo(Rec."Connection Url Key"),
            Rec.FieldNo(Rec."Company Id Key"),
            Rec.FieldNo(Rec."Client Id Key"),
            Rec.FieldNo(Rec."Client Secret Key"),
            Rec.FieldNo(Rec."Authority Url Key"),
            Rec.FieldNo(Rec."Redirect Url key")] then
            exit(Confirm(StrSubstNo(ModifySensibleDataQst, FieldReference.Name), false));

        exit(false);
    end;

    [IntegrationEvent(false, false)]
    local procedure OnSetInboxDetailsCaptionOnCaseElse(var ICPartner: Record "IC Partner"; var TransferTypeText: Text)
    begin
    end;
}

