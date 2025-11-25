namespace System.IO;

using Microsoft.Foundation.Enums;
#if not CLEAN21
using Microsoft.Purchases.Pricing;
using Microsoft.Sales.Pricing;
#endif
using System.Environment;
using System.Reflection;
using System.Security.AccessControl;
using System.Utilities;

codeunit 8616 "Config. Management"
{
    EventSubscriberInstance = Manual;

    trigger OnRun()
    begin
    end;

    var
        TempFieldRec: Record "Field" temporary;
        ConfigProgressBar: Codeunit "Config. Progress Bar";
        ConfigPackageMgt: Codeunit "Config. Package Management";
        HideDialog: Boolean;

        Text000: Label 'You must specify a company name.';
        Text001: Label 'Do you want to copy the data from the %1 table in %2?';
        Text002: Label 'Data from the %1 table in %2 has been copied successfully.';
        Text003: Label 'Do you want to copy the data from the selected tables in %1?';
        Text004: Label 'Data from the selected tables in %1 has been copied successfully.';
        Text006: Label 'The base company must not be the same as the current company.';
        Text007: Label 'The %1 table in %2 already contains data.\\You must delete the data from the table before you can use this function.';
        Text009: Label 'There is no data in the %1 table in %2.\\You must set up the table in %3 manually.';
        Text023: Label 'Processing tables';

    procedure CopyDataDialog(NewCompanyName: Text[30]; var ConfigLine: Record "Config. Line")
    var
        ConfirmTableText: Text[250];
        MessageTableText: Text[250];
        SingleTable: Boolean;
        IsHandled: Boolean;
    begin
        IsHandled := false;
        OnBeforeCopyDataDialog(ConfigLine, NewCompanyName, IsHandled);
        if IsHandled then
            exit;

        with ConfigLine do begin
            if NewCompanyName = '' then
                Error(Text000);
            if not FindFirst() then
                exit;
            SingleTable := Next() = 0;
            if SingleTable then begin
                ConfirmTableText := StrSubstNo(Text001, Name, NewCompanyName);
                MessageTableText := StrSubstNo(Text002, Name, NewCompanyName);
            end else begin
                ConfirmTableText := StrSubstNo(Text003, NewCompanyName);
                MessageTableText := StrSubstNo(Text004, NewCompanyName);
            end;
            if not Confirm(ConfirmTableText, SingleTable) then
                exit;
            if FindSet() then
                repeat
                    CopyData(ConfigLine);
                until Next() = 0;
            Commit();
            Message(MessageTableText)
        end;
    end;

    local procedure CopyData(var ConfigLine: Record "Config. Line")
    var
        BaseCompanyName: Text[30];
    begin
        with ConfigLine do begin
            CheckBlocked();
            FilterGroup := 2;
            BaseCompanyName := GetRangeMax("Company Filter (Source Table)");
            FilterGroup := 0;
            if BaseCompanyName = CompanyName then
                Error(Text006);
            CalcFields("No. of Records", "No. of Records (Source Table)");
            if "No. of Records" <> 0 then
                Error(
                  Text007,
                  Name, CompanyName);
            if "No. of Records (Source Table)" = 0 then
                Error(
                  Text009,
                  Name, BaseCompanyName, CompanyName);
            TransferContents("Table ID", BaseCompanyName, true);
        end;
    end;

    procedure TransferContents(TableID: Integer; NewCompanyName: Text[30]; CopyTable: Boolean): Boolean
    begin
        TempFieldRec.DeleteAll();
        if CopyTable then
            MarkPostValidationData(Enum::TableID::Contact, 5053);
        TransferContent(TableID, NewCompanyName, CopyTable);
        TempFieldRec.DeleteAll();
        exit(true);
    end;

    local procedure TransferContent(TableNumber: Integer; NewCompanyName: Text[30]; CopyTable: Boolean)
    var
        FieldRec: Record "Field";
        FromCompanyRecRef: RecordRef;
        ToCompanyRecRef: RecordRef;
        FromCompanyFieldRef: FieldRef;
        ToCompanyFieldRef: FieldRef;
    begin
        if not CopyTable then
            exit;
        FromCompanyRecRef.Open(TableNumber, false, NewCompanyName);
        if FromCompanyRecRef.IsEmpty() then begin
            FromCompanyRecRef.Close();
            exit;
        end;
        FromCompanyRecRef.Find('-');
        ToCompanyRecRef.Open(TableNumber, false, CompanyName);
        FieldRec.SetRange(TableNo, TableNumber);
        FieldRec.SetRange(ObsoleteState, FieldRec.ObsoleteState::No);
        repeat
            if FieldRec.FindSet() then begin
                ToCompanyRecRef.Init();
                repeat
                    if not TempFieldRec.Get(TableNumber, FieldRec."No.") then begin
                        FromCompanyFieldRef := FromCompanyRecRef.Field(FieldRec."No.");
                        ToCompanyFieldRef := ToCompanyRecRef.Field(FieldRec."No.");
                        OnTransferContentOnBeforeToCompanyFieldRefValue(FieldRec, FromCompanyFieldRef);
                        ToCompanyFieldRef.Value(FromCompanyFieldRef.Value);
                    end;
                until FieldRec.Next() = 0;
                ToCompanyRecRef.Insert(true);
            end;
        until FromCompanyRecRef.Next() = 0;
        // Treatment of fields that require post-validation:
        TempFieldRec.SetRange(TableNo, TableNumber);
        TempFieldRec.SetRange(ObsoleteState, TempFieldRec.ObsoleteState::No);
        if TempFieldRec.FindSet() then begin
            FromCompanyRecRef.Find('-');
            repeat
                ToCompanyRecRef.SetPosition(FromCompanyRecRef.GetPosition());
                ToCompanyRecRef.Find('=');
                TempFieldRec.FindSet();
                repeat
                    FromCompanyFieldRef := FromCompanyRecRef.Field(TempFieldRec."No.");
                    ToCompanyFieldRef := ToCompanyRecRef.Field(TempFieldRec."No.");
                    ToCompanyFieldRef.Value(FromCompanyFieldRef.Value);
                until TempFieldRec.Next() = 0;
                ToCompanyRecRef.Modify(true);
            until FromCompanyRecRef.Next() = 0;
        end;

        FromCompanyRecRef.Close();
        ToCompanyRecRef.Close();
    end;

    local procedure MarkPostValidationData(TableNo: Integer; FieldNo: Integer)
    begin
        TempFieldRec.Init();
        TempFieldRec.TableNo := TableNo;
        TempFieldRec."No." := FieldNo;
        if TempFieldRec.Insert() then;
    end;

    procedure FindPage(TableID: Integer): Integer
    var
        PageID: Integer;
    begin
        case TableID of
            Enum::TableID::"Company Information".AsInteger():
                exit(Enum::PageID::"Company Information".AsInteger());
            Enum::TableID::"Responsibility Center".AsInteger():
                exit(Enum::PageID::"Responsibility Center List".AsInteger());
            Enum::TableID::"Accounting Period".AsInteger():
                exit(Enum::PageID::"Accounting Periods".AsInteger());
            Enum::TableID::"General Ledger Setup".AsInteger():
                exit(Enum::PageID::"General Ledger Setup".AsInteger());
            Enum::TableID::"No. Series".AsInteger():
                exit(Enum::PageID::"No. Series".AsInteger());
            Enum::TableID::"No. Series Line".AsInteger():
                exit(Enum::PageID::"No. Series Lines".AsInteger());
            Enum::TableID::"G/L Account".AsInteger():
                exit(Enum::PageID::"Chart of Accounts".AsInteger());
            Enum::TableID::"Gen. Business Posting Group".AsInteger():
                exit(Enum::PageID::"Gen. Business Posting Groups".AsInteger());
            Enum::TableID::"Gen. Product Posting Group".AsInteger():
                exit(Enum::PageID::"Gen. Product Posting Groups".AsInteger());
            Enum::TableID::"General Posting Setup".AsInteger():
                exit(Enum::PageID::"General Posting Setup".AsInteger());
            Enum::TableID::"VAT Business Posting Group".AsInteger():
                exit(Enum::PageID::"VAT Business Posting Groups".AsInteger());
            Enum::TableID::"VAT Product Posting Group".AsInteger():
                exit(Enum::PageID::"VAT Product Posting Groups".AsInteger());
            Enum::TableID::"VAT Posting Setup".AsInteger():
                exit(Enum::PageID::"VAT Posting Setup".AsInteger());
            Enum::TableID::"Acc. Schedule Name".AsInteger():
                exit(Enum::PageID::"Account Schedule Names".AsInteger());
            Enum::TableID::"Column Layout Name".AsInteger():
                exit(Enum::PageID::"Column Layout Names".AsInteger());
            Enum::TableID::"G/L Budget Name".AsInteger():
                exit(Enum::PageID::"G/L Budget Names".AsInteger());
            Enum::TableID::"VAT Statement Template".AsInteger():
                exit(Enum::PageID::"VAT Statement Templates".AsInteger());
            Enum::TableID::"Tariff Number".AsInteger():
                exit(Enum::PageID::"Tariff Numbers".AsInteger());
            Enum::TableID::"Transaction Type".AsInteger():
                exit(Enum::PageID::"Transaction Types".AsInteger());
            Enum::TableID::"Transaction Specification".AsInteger():
                exit(Enum::PageID::"Transaction Specifications".AsInteger());
            Enum::TableID::"Transport Method".AsInteger():
                exit(Enum::PageID::"Transport Methods".AsInteger());
            Enum::TableID::"Entry/Exit Point".AsInteger():
                exit(Enum::PageID::"Entry/Exit Points".AsInteger());
            Enum::TableID::Area.AsInteger():
                exit(Enum::PageID::Areas.AsInteger());
            Enum::TableID::Territory.AsInteger():
                exit(Enum::PageID::Territories.AsInteger());
            Enum::TableID::"Tax Jurisdiction".AsInteger():
                exit(Enum::PageID::"Tax Jurisdictions".AsInteger());
            Enum::TableID::"Tax Group".AsInteger():
                exit(Enum::PageID::"Tax Groups".AsInteger());
            Enum::TableID::"Tax Detail".AsInteger():
                exit(Enum::PageID::"Tax Details".AsInteger());
            Enum::TableID::"Tax Area".AsInteger():
                exit(Enum::PageID::"Tax Area".AsInteger());
            Enum::TableID::"Tax Area Line".AsInteger():
                exit(Enum::PageID::"Tax Area Line".AsInteger());
            Enum::TableID::"Source Code".AsInteger():
                exit(Enum::PageID::"Source Codes".AsInteger());
            Enum::TableID::"Reason Code".AsInteger():
                exit(Enum::PageID::"Reason Codes".AsInteger());
            Enum::TableID::"Standard Text".AsInteger():
                exit(Enum::PageID::"Standard Text Codes".AsInteger());
            Enum::TableID::"Business Unit".AsInteger():
                exit(Enum::PageID::"Business Unit List".AsInteger());
            Enum::TableID::Dimension.AsInteger():
                exit(Enum::PageID::Dimensions.AsInteger());
            Enum::TableID::"Default Dimension Priority".AsInteger():
                exit(Enum::PageID::"Default Dimension Priorities".AsInteger());
            Enum::TableID::"Dimension Combination".AsInteger():
                exit(Enum::PageID::"Dimension Combinations".AsInteger());
            Enum::TableID::"Analysis View".AsInteger():
                exit(Enum::PageID::"Analysis View List".AsInteger());
            Enum::TableID::"Post Code".AsInteger():
                exit(Enum::PageID::"Post Codes".AsInteger());
            Enum::TableID::"Country/Region".AsInteger():
                exit(Enum::PageID::"Countries/Regions".AsInteger());
            Enum::TableID::Language.AsInteger():
                exit(Enum::PageID::Languages.AsInteger());
            Enum::TableID::Currency.AsInteger():
                exit(Enum::PageID::Currencies.AsInteger());
            Enum::TableID::"Bank Account".AsInteger():
                exit(Enum::PageID::"Bank Account List".AsInteger());
            Enum::TableID::"Bank Account Posting Group".AsInteger():
                exit(Enum::PageID::"Bank Account Posting Groups".AsInteger());
            Enum::TableID::"Change Log Setup (Table)".AsInteger():
                exit(Enum::PageID::"Change Log Setup (Table) List".AsInteger());
            Enum::TableID::"Change Log Setup (Field)".AsInteger():
                exit(Enum::PageID::"Change Log Setup (Field) List".AsInteger());
            Enum::TableID::"Sales & Receivables Setup".AsInteger():
                exit(Enum::PageID::"Sales & Receivables Setup".AsInteger());
            Enum::TableID::Customer.AsInteger():
                exit(Enum::PageID::"Customer List".AsInteger());
            Enum::TableID::"Customer Posting Group".AsInteger():
                exit(Enum::PageID::"Customer Posting Groups".AsInteger());
            Enum::TableID::"Payment Terms".AsInteger():
                exit(Enum::PageID::"Payment Terms".AsInteger());
            Enum::TableID::"Payment Method".AsInteger():
                exit(Enum::PageID::"Payment Methods".AsInteger());
            Enum::TableID::"Reminder Terms".AsInteger():
                exit(Enum::PageID::"Reminder Terms".AsInteger());
            Enum::TableID::"Reminder Level".AsInteger():
                exit(Enum::PageID::"Reminder Levels".AsInteger());
            Enum::TableID::"Reminder Text".AsInteger():
                exit(Enum::PageID::"Reminder Text".AsInteger());
            Enum::TableID::"Finance Charge Terms".AsInteger():
                exit(Enum::PageID::"Finance Charge Terms".AsInteger());
            Enum::TableID::"Shipment Method".AsInteger():
                exit(Enum::PageID::"Shipment Methods".AsInteger());
            Enum::TableID::"Shipping Agent".AsInteger():
                exit(Enum::PageID::"Shipping Agents".AsInteger());
            Enum::TableID::"Shipping Agent Services".AsInteger():
                exit(Enum::PageID::"Shipping Agent Services".AsInteger());
            Enum::TableID::"Customer Discount Group".AsInteger():
                exit(Enum::PageID::"Customer Disc. Groups".AsInteger());
            Enum::TableID::"Salesperson/Purchaser".AsInteger():
                exit(Enum::PageID::"Salespersons/Purchasers".AsInteger());
            Enum::TableID::"Marketing Setup".AsInteger():
                exit(Enum::PageID::"Marketing Setup".AsInteger());
            Enum::TableID::"Duplicate Search String Setup".AsInteger():
                exit(Enum::PageID::"Duplicate Search String Setup".AsInteger());
            Enum::TableID::Contact.AsInteger():
                exit(Enum::PageID::"Contact List".AsInteger());
            Enum::TableID::"Business Relation".AsInteger():
                exit(Enum::PageID::"Business Relations".AsInteger());
            Enum::TableID::"Mailing Group".AsInteger():
                exit(Enum::PageID::"Mailing Groups".AsInteger());
            Enum::TableID::"Industry Group".AsInteger():
                exit(Enum::PageID::"Industry Groups".AsInteger());
            Enum::TableID::"Web Source".AsInteger():
                exit(Enum::PageID::"Web Sources".AsInteger());
            Enum::TableID::"Interaction Group".AsInteger():
                exit(Enum::PageID::"Interaction Groups".AsInteger());
            Enum::TableID::"Interaction Template".AsInteger():
                exit(Enum::PageID::"Interaction Templates".AsInteger());
            Enum::TableID::"Job Responsibility".AsInteger():
                exit(Enum::PageID::"Job Responsibilities".AsInteger());
            Enum::TableID::"Organizational Level".AsInteger():
                exit(Enum::PageID::"Organizational Levels".AsInteger());
            Enum::TableID::"Campaign Status".AsInteger():
                exit(Enum::PageID::"Campaign Status".AsInteger());
            Enum::TableID::Activity.AsInteger():
                exit(Enum::PageID::Activity.AsInteger());
            Enum::TableID::Team.AsInteger():
                exit(Enum::PageID::Teams.AsInteger());
            Enum::TableID::"Profile Questionnaire Header".AsInteger():
                exit(Enum::PageID::"Profile Questionnaires".AsInteger());
            Enum::TableID::"Sales Cycle".AsInteger():
                exit(Enum::PageID::"Sales Cycles".AsInteger());
            Enum::TableID::"Close Opportunity Code".AsInteger():
                exit(Enum::PageID::"Close Opportunity Codes".AsInteger());
            Enum::TableID::"Service Mgt. Setup".AsInteger():
                exit(Enum::PageID::"Service Mgt. Setup".AsInteger());
            Enum::TableID::"Service Item".AsInteger():
                exit(Enum::PageID::"Service Item List".AsInteger());
            Enum::TableID::"Service Hour".AsInteger():
                exit(Enum::PageID::"Default Service Hours".AsInteger());
            Enum::TableID::"Work-Hour Template".AsInteger():
                exit(Enum::PageID::"Work-Hour Templates".AsInteger());
            Enum::TableID::"Resource Service Zone".AsInteger():
                exit(Enum::PageID::"Resource Service Zones".AsInteger());
            Enum::TableID::Loaner.AsInteger():
                exit(Enum::PageID::"Loaner List".AsInteger());
            Enum::TableID::"Skill Code".AsInteger():
                exit(Enum::PageID::"Skill Codes".AsInteger());
            Enum::TableID::"Fault Reason Code".AsInteger():
                exit(Enum::PageID::"Fault Reason Codes".AsInteger());
            Enum::TableID::"Service Cost".AsInteger():
                exit(Enum::PageID::"Service Costs".AsInteger());
            Enum::TableID::"Service Zone".AsInteger():
                exit(Enum::PageID::"Service Zones".AsInteger());
            Enum::TableID::"Service Order Type".AsInteger():
                exit(Enum::PageID::"Service Order Types".AsInteger());
            Enum::TableID::"Service Item Group".AsInteger():
                exit(Enum::PageID::"Service Item Groups".AsInteger());
            Enum::TableID::"Service Shelf".AsInteger():
                exit(Enum::PageID::"Service Shelves".AsInteger());
            Enum::TableID::"Service Status Priority Setup".AsInteger():
                exit(Enum::PageID::"Service Order Status Setup".AsInteger());
            Enum::TableID::"Repair Status".AsInteger():
                exit(Enum::PageID::"Repair Status Setup".AsInteger());
            Enum::TableID::"Service Price Group".AsInteger():
                exit(Enum::PageID::"Service Price Groups".AsInteger());
            Enum::TableID::"Serv. Price Group Setup".AsInteger():
                exit(Enum::PageID::"Serv. Price Group Setup".AsInteger());
            Enum::TableID::"Service Price Adjustment Group".AsInteger():
                exit(Enum::PageID::"Serv. Price Adjmt. Group".AsInteger());
            Enum::TableID::"Serv. Price Adjustment Detail".AsInteger():
                exit(Enum::PageID::"Serv. Price Adjmt. Detail".AsInteger());
            Enum::TableID::"Resolution Code".AsInteger():
                exit(Enum::PageID::"Resolution Codes".AsInteger());
            Enum::TableID::"Fault Area".AsInteger():
                exit(Enum::PageID::"Fault Areas".AsInteger());
            Enum::TableID::"Symptom Code".AsInteger():
                exit(Enum::PageID::"Symptom Codes".AsInteger());
            Enum::TableID::"Fault Code".AsInteger():
                exit(Enum::PageID::"Fault Codes".AsInteger());
            Enum::TableID::"Fault/Resol. Cod. Relationship".AsInteger():
                exit(Enum::PageID::"Fault/Resol. Cod. Relationship".AsInteger());
            Enum::TableID::"Contract Group".AsInteger():
                exit(Enum::PageID::"Service Contract Groups".AsInteger());
            Enum::TableID::"Service Contract Template".AsInteger():
                exit(Enum::PageID::"Service Contract Template".AsInteger());
            Enum::TableID::"Service Contract Account Group".AsInteger():
                exit(Enum::PageID::"Serv. Contract Account Groups".AsInteger());
            Enum::TableID::"Troubleshooting Header".AsInteger():
                exit(Enum::PageID::Troubleshooting.AsInteger());
            Enum::TableID::"Purchases & Payables Setup".AsInteger():
                exit(Enum::PageID::"Purchases & Payables Setup".AsInteger());
            Enum::TableID::Vendor.AsInteger():
                exit(Enum::PageID::"Vendor List".AsInteger());
            Enum::TableID::"Vendor Posting Group".AsInteger():
                exit(Enum::PageID::"Vendor Posting Groups".AsInteger());
            Enum::TableID::Purchasing.AsInteger():
                exit(Enum::PageID::"Purchasing Codes".AsInteger());
            Enum::TableID::"Inventory Setup".AsInteger():
                exit(Enum::PageID::"Inventory Setup".AsInteger());
            Enum::TableID::"Nonstock Item Setup".AsInteger():
                exit(Enum::PageID::"Catalog Item Setup".AsInteger());
            Enum::TableID::"Item Tracking Code".AsInteger():
                exit(Enum::PageID::"Item Tracking Codes".AsInteger());
            Enum::TableID::Item.AsInteger():
                exit(Enum::PageID::"Item List".AsInteger());
            Enum::TableID::"Nonstock Item".AsInteger():
                exit(Enum::PageID::"Catalog Item List".AsInteger());
            Enum::TableID::"Inventory Posting Group".AsInteger():
                exit(Enum::PageID::"Inventory Posting Groups".AsInteger());
            Enum::TableID::"Inventory Posting Setup".AsInteger():
                exit(Enum::PageID::"Inventory Posting Setup".AsInteger());
            Enum::TableID::"Unit of Measure".AsInteger():
                exit(Enum::PageID::"Units of Measure".AsInteger());
            Enum::TableID::"Customer Price Group".AsInteger():
                exit(Enum::PageID::"Customer Price Groups".AsInteger());
            Enum::TableID::"Item Discount Group".AsInteger():
                exit(Enum::PageID::"Item Disc. Groups".AsInteger());
            Enum::TableID::Manufacturer.AsInteger():
                exit(Enum::PageID::Manufacturers.AsInteger());
            Enum::TableID::"Item Category".AsInteger():
                exit(Enum::PageID::"Item Categories".AsInteger());
            Enum::TableID::"Rounding Method".AsInteger():
                exit(Enum::PageID::"Rounding Methods".AsInteger());
            Enum::TableID::Location.AsInteger():
                exit(Enum::PageID::"Location List".AsInteger());
            Enum::TableID::"Transfer Route".AsInteger():
                exit(Enum::PageID::"Transfer Routes".AsInteger());
            Enum::TableID::"Stockkeeping Unit".AsInteger():
                exit(Enum::PageID::"Stockkeeping Unit List".AsInteger());
            Enum::TableID::"Warehouse Setup".AsInteger():
                exit(Enum::PageID::"Warehouse Setup".AsInteger());
            Enum::TableID::"Resources Setup".AsInteger():
                exit(Enum::PageID::"Resources Setup".AsInteger());
            Enum::TableID::Resource.AsInteger():
                exit(Enum::PageID::"Resource List".AsInteger());
            Enum::TableID::"Resource Group".AsInteger():
                exit(Enum::PageID::"Resource Groups".AsInteger());
            Enum::TableID::"Work Type".AsInteger():
                exit(Enum::PageID::"Work Types".AsInteger());
            Enum::TableID::"Jobs Setup".AsInteger():
                exit(Enum::PageID::"Jobs Setup".AsInteger());
            Enum::TableID::"Job Posting Group".AsInteger():
                exit(Enum::PageID::"Job Posting Groups".AsInteger());
            Enum::TableID::"FA Setup".AsInteger():
                exit(Enum::PageID::"Fixed Asset Setup".AsInteger());
            Enum::TableID::"Fixed Asset".AsInteger():
                exit(Enum::PageID::"Fixed Asset List".AsInteger());
            Enum::TableID::Insurance.AsInteger():
                exit(Enum::PageID::"Insurance List".AsInteger());
            Enum::TableID::"FA Posting Group".AsInteger():
                exit(Enum::PageID::"FA Posting Groups".AsInteger());
            Enum::TableID::"FA Journal Template".AsInteger():
                exit(Enum::PageID::"FA Journal Templates".AsInteger());
            Enum::TableID::"FA Reclass. Journal Template".AsInteger():
                exit(Enum::PageID::"FA Reclass. Journal Templates".AsInteger());
            Enum::TableID::"Insurance Journal Template".AsInteger():
                exit(Enum::PageID::"Insurance Journal Templates".AsInteger());
            Enum::TableID::"Depreciation Book".AsInteger():
                exit(Enum::PageID::"Depreciation Book List".AsInteger());
            Enum::TableID::"FA Class".AsInteger():
                exit(Enum::PageID::"FA Classes".AsInteger());
            Enum::TableID::"FA Subclass".AsInteger():
                exit(Enum::PageID::"FA Subclasses".AsInteger());
            Enum::TableID::"FA Location".AsInteger():
                exit(Enum::PageID::"FA Locations".AsInteger());
            Enum::TableID::"Insurance Type".AsInteger():
                exit(Enum::PageID::"Insurance Types".AsInteger());
            Enum::TableID::Maintenance.AsInteger():
                exit(Enum::PageID::Maintenance.AsInteger());
            Enum::TableID::"Human Resources Setup".AsInteger():
                exit(Enum::PageID::"Human Resources Setup".AsInteger());
            Enum::TableID::Employee.AsInteger():
                exit(Enum::PageID::"Employee List".AsInteger());
            Enum::TableID::"Cause of Absence".AsInteger():
                exit(Enum::PageID::"Causes of Absence".AsInteger());
            Enum::TableID::"Cause of Inactivity".AsInteger():
                exit(Enum::PageID::"Causes of Inactivity".AsInteger());
            Enum::TableID::"Grounds for Termination".AsInteger():
                exit(Enum::PageID::"Grounds for Termination".AsInteger());
            Enum::TableID::"Employment Contract".AsInteger():
                exit(Enum::PageID::"Employment Contracts".AsInteger());
            Enum::TableID::Qualification.AsInteger():
                exit(Enum::PageID::Qualifications.AsInteger());
            Enum::TableID::Relative.AsInteger():
                exit(Enum::PageID::Relatives.AsInteger());
            Enum::TableID::"Misc. Article".AsInteger():
                exit(Enum::PageID::"Misc. Article Information".AsInteger());
            Enum::TableID::Confidential.AsInteger():
                exit(Enum::PageID::Confidential.AsInteger());
            Enum::TableID::"Employee Statistics Group".AsInteger():
                exit(Enum::PageID::"Employee Statistics Groups".AsInteger());
            Enum::TableID::Union.AsInteger():
                exit(Enum::PageID::Unions.AsInteger());
            Enum::TableID::"Manufacturing Setup".AsInteger():
                exit(Enum::PageID::"Manufacturing Setup".AsInteger());
            Enum::TableID::Family.AsInteger():
                exit(Enum::PageID::Family.AsInteger());
            Enum::TableID::"Production BOM Header".AsInteger():
                exit(Enum::PageID::"Production BOM".AsInteger());
            Enum::TableID::"Capacity Unit of Measure".AsInteger():
                exit(Enum::PageID::"Capacity Units of Measure".AsInteger());
            Enum::TableID::"Work Shift".AsInteger():
                exit(Enum::PageID::"Work Shifts".AsInteger());
            Enum::TableID::"Shop Calendar".AsInteger():
                exit(Enum::PageID::"Shop Calendars".AsInteger());
            Enum::TableID::"Work Center Group".AsInteger():
                exit(Enum::PageID::"Work Center Groups".AsInteger());
            Enum::TableID::"Standard Task".AsInteger():
                exit(Enum::PageID::"Standard Tasks".AsInteger());
            Enum::TableID::"Routing Link".AsInteger():
                exit(Enum::PageID::"Routing Links".AsInteger());
            Enum::TableID::Stop.AsInteger():
                exit(Enum::PageID::"Stop Codes".AsInteger());
            Enum::TableID::Scrap.AsInteger():
                exit(Enum::PageID::"Scrap Codes".AsInteger());
            Enum::TableID::"Machine Center".AsInteger():
                exit(Enum::PageID::"Machine Center List".AsInteger());
            Enum::TableID::"Work Center".AsInteger():
                exit(Enum::PageID::"Work Center List".AsInteger());
            Enum::TableID::"Routing Header".AsInteger():
                exit(Enum::PageID::Routing.AsInteger());
            Enum::TableID::"Cost Type".AsInteger():
                exit(Enum::PageID::"Cost Type List".AsInteger());
            Enum::TableID::"Cost Journal Template".AsInteger():
                exit(Enum::PageID::"Cost Journal Templates".AsInteger());
            Enum::TableID::"Cost Allocation Source".AsInteger():
                exit(Enum::PageID::"Cost Allocation".AsInteger());
            Enum::TableID::"Cost Allocation Target".AsInteger():
                exit(Enum::PageID::"Cost Allocation Target List".AsInteger());
            Enum::TableID::"Cost Accounting Setup".AsInteger():
                exit(Enum::PageID::"Cost Accounting Setup".AsInteger());
            Enum::TableID::"Cost Budget Name".AsInteger():
                exit(Enum::PageID::"Cost Budget Names".AsInteger());
            Enum::TableID::"Cost Center".AsInteger():
                exit(Enum::PageID::"Chart of Cost Centers".AsInteger());
            Enum::TableID::"Cost Object".AsInteger():
                exit(Enum::PageID::"Chart of Cost Objects".AsInteger());
            Enum::TableID::"Cash Flow Setup".AsInteger():
                exit(Enum::PageID::"Cash Flow Setup".AsInteger());
            Enum::TableID::"Cash Flow Forecast".AsInteger():
                exit(Enum::PageID::"Cash Flow Forecast List".AsInteger());
            Enum::TableID::"Cash Flow Account".AsInteger():
                exit(Enum::PageID::"Chart of Cash Flow Accounts".AsInteger());
            Enum::TableID::"Cash Flow Manual Expense".AsInteger():
                exit(Enum::PageID::"Cash Flow Manual Expenses".AsInteger());
            Enum::TableID::"Cash Flow Manual Revenue".AsInteger():
                exit(Enum::PageID::"Cash Flow Manual Revenues".AsInteger());
            Enum::TableID::"IC Partner".AsInteger():
                exit(Enum::PageID::"IC Partner List".AsInteger());
            Enum::TableID::"Base Calendar".AsInteger():
                exit(Enum::PageID::"Base Calendar List".AsInteger());
            Enum::TableID::"Finance Charge Text".AsInteger():
                exit(Enum::PageID::"Reminder Text".AsInteger());
            Enum::TableID::"Currency for Fin. Charge Terms".AsInteger():
                exit(Enum::PageID::"Currencies for Fin. Chrg Terms".AsInteger());
            Enum::TableID::"Currency for Reminder Level".AsInteger():
                exit(Enum::PageID::"Currencies for Reminder Level".AsInteger());
            Enum::TableID::"Currency Exchange Rate".AsInteger():
                exit(Enum::PageID::"Currency Exchange Rates".AsInteger());
            Enum::TableID::"VAT Statement Name".AsInteger():
                exit(Enum::PageID::"VAT Statement Names".AsInteger());
            Enum::TableID::"VAT Statement Line".AsInteger():
                exit(Enum::PageID::"VAT Statement".AsInteger());
            Enum::TableID::"No. Series Relationship".AsInteger():
                exit(Enum::PageID::"No. Series Relationships".AsInteger());
            Enum::TableID::"User Setup".AsInteger():
                exit(Enum::PageID::"User Setup".AsInteger());
            Enum::TableID::"Gen. Journal Template".AsInteger():
                exit(Enum::PageID::"General Journal Template List".AsInteger());
            Enum::TableID::"Gen. Journal Batch".AsInteger():
                exit(Enum::PageID::"General Journal Batches".AsInteger());
            Enum::TableID::"Gen. Journal Line".AsInteger():
                exit(Enum::PageID::"General Journal".AsInteger());
            Enum::TableID::"Item Journal Template".AsInteger():
                exit(Enum::PageID::"Item Journal Template List".AsInteger());
            Enum::TableID::"Item Journal Batch".AsInteger():
                exit(Enum::PageID::"Item Journal Batches".AsInteger());
            Enum::TableID::"Customer Bank Account".AsInteger():
                exit(Enum::PageID::"Customer Bank Account List".AsInteger());
            Enum::TableID::"Vendor Bank Account".AsInteger():
                exit(Enum::PageID::"Vendor Bank Account List".AsInteger());
            Enum::TableID::"Cust. Invoice Disc.".AsInteger():
                exit(Enum::PageID::"Cust. Invoice Discounts".AsInteger());
            Enum::TableID::"Vendor Invoice Disc.".AsInteger():
                exit(Enum::PageID::"Vend. Invoice Discounts".AsInteger());
            Enum::TableID::"Dimension Value".AsInteger():
                exit(Enum::PageID::"Dimension Value List".AsInteger());
            Enum::TableID::"Dimension Value Combination".AsInteger():
                exit(Enum::PageID::"Dimension Combinations".AsInteger());
            Enum::TableID::"Default Dimension".AsInteger():
                exit(Enum::PageID::"Default Dimensions".AsInteger());
            Enum::TableID::"Dimension Translation".AsInteger():
                exit(Enum::PageID::"Dimension Translations".AsInteger());
            Enum::TableID::"Dimension Set Entry".AsInteger():
                exit(Enum::PageID::"Dimension Set Entries".AsInteger());
            Enum::TableID::"VAT Report Setup".AsInteger():
                exit(Enum::PageID::"VAT Report Setup".AsInteger());
            Enum::TableID::"VAT Registration No. Format".AsInteger():
                exit(Enum::PageID::"VAT Registration No. Formats".AsInteger());
            Enum::TableID::"G/L Entry".AsInteger():
                exit(Enum::PageID::"General Ledger Entries".AsInteger());
            Enum::TableID::"Cust. Ledger Entry".AsInteger():
                exit(Enum::PageID::"Customer Ledger Entries".AsInteger());
            Enum::TableID::"Vendor Ledger Entry".AsInteger():
                exit(Enum::PageID::"Vendor Ledger Entries".AsInteger());
            Enum::TableID::"Item Ledger Entry".AsInteger():
                exit(Enum::PageID::"Item Ledger Entries".AsInteger());
            Enum::TableID::"Sales Header".AsInteger():
                exit(Enum::PageID::"Sales List".AsInteger());
            Enum::TableID::"Purchase Header".AsInteger():
                exit(Enum::PageID::"Purchase List".AsInteger());
            Enum::TableID::"G/L Register".AsInteger():
                exit(Enum::PageID::"G/L Registers".AsInteger());
            Enum::TableID::"Item Register".AsInteger():
                exit(Enum::PageID::"Item Registers".AsInteger());
            Enum::TableID::"Item Journal Line".AsInteger():
                exit(Enum::PageID::"Item Journal Lines".AsInteger());
            Enum::TableID::"Sales Shipment Header".AsInteger():
                exit(Enum::PageID::"Posted Sales Shipments".AsInteger());
            Enum::TableID::"Sales Invoice Header".AsInteger():
                exit(Enum::PageID::"Posted Sales Invoices".AsInteger());
            Enum::TableID::"Sales Cr.Memo Header".AsInteger():
                exit(Enum::PageID::"Posted Sales Credit Memos".AsInteger());
            Enum::TableID::"Purch. Rcpt. Header".AsInteger():
                exit(Enum::PageID::"Posted Purchase Receipts".AsInteger());
            Enum::TableID::"Purch. Inv. Header".AsInteger():
                exit(Enum::PageID::"Posted Purchase Invoices".AsInteger());
            Enum::TableID::"Purch. Cr. Memo Hdr.".AsInteger():
                exit(Enum::PageID::"Posted Purchase Credit Memos".AsInteger());
#if not CLEAN21
            Database::"Sales Price":
                exit(Page::"Sales Prices");
            Database::"Purchase Price":
                exit(Page::"Purchase Prices");
#endif
            Enum::TableID::"Price List Line".AsInteger():
                exit(Enum::PageID::"Price List Line Review".AsInteger());
            Enum::TableID::"VAT Entry".AsInteger():
                exit(Enum::PageID::"VAT Entries".AsInteger());
            Enum::TableID::"FA Ledger Entry".AsInteger():
                exit(Enum::PageID::"FA Ledger Entries".AsInteger());
            Enum::TableID::"Value Entry".AsInteger():
                exit(Enum::PageID::"Value Entries".AsInteger());
            Enum::TableID::"Source Code Setup".AsInteger():
                exit(Enum::PageID::"Source Code Setup".AsInteger());
            else begin
                OnFindPage(TableID, PageID);
                exit(PageID);
            end;
        end;
    end;

    procedure GetConfigTables(var AllObj: Record AllObj; IncludeWithDataOnly: Boolean; IncludeRelatedTables: Boolean; IncludeDimensionTables: Boolean; IncludeLicensedTablesOnly: Boolean; IncludeReferringTable: Boolean)
    var
        TempInt: Record "Integer" temporary;
        TableInfo: Record "Table Information";
        ConfigLine: Record "Config. Line";
        "Field": Record "Field";
        NextLineNo: Integer;
        NextVertNo: Integer;
        Include: Boolean;
    begin
        if not HideDialog then
            ConfigProgressBar.Init(AllObj.Count, 1, Text023);

        TempInt.DeleteAll();

        NextLineNo := 10000;
        ConfigLine.Reset();
        if ConfigLine.FindLast() then
            NextLineNo := ConfigLine."Line No." + 10000;

        NextVertNo := 0;
        ConfigLine.SetCurrentKey("Vertical Sorting");
        if ConfigLine.FindLast() then
            NextVertNo := ConfigLine."Vertical Sorting" + 1;

        if AllObj.FindSet() then
            repeat
                if not HideDialog then
                    ConfigProgressBar.Update(AllObj."Object Name");
                Include := true;
                if IncludeWithDataOnly then begin
                    Include := false;
                    TableInfo.SetRange("Company Name", CompanyName);
                    TableInfo.SetRange("Table No.", AllObj."Object ID");
                    if TableInfo.FindFirst() then
                        if TableInfo."No. of Records" > 0 then
                            Include := true;
                end;
                if Include then begin
                    if IncludeReferringTable then
                        InsertTempInt(TempInt, AllObj."Object ID", IncludeLicensedTablesOnly);
                    if IncludeRelatedTables then begin
                        ConfigPackageMgt.SetFieldFilter(Field, AllObj."Object ID", 0);
                        Field.SetFilter(RelationTableNo, '<>%1&<>%2&..%3', 0, AllObj."Object ID", 99000999);
                        if Field.FindSet() then
                            repeat
                                InsertTempInt(TempInt, Field.RelationTableNo, IncludeLicensedTablesOnly);
                            until Field.Next() = 0;
                    end;
                    if IncludeDimensionTables then
                        if CheckDimTables(AllObj."Object ID") then begin
                            InsertDimTables(TempInt, IncludeLicensedTablesOnly);
                            IncludeDimensionTables := false;
                        end;
                end;
            until AllObj.Next() = 0;

        if TempInt.FindSet() then
            repeat
                InsertConfigLine(TempInt.Number, NextLineNo, NextVertNo);
            until TempInt.Next() = 0;

        if not HideDialog then
            ConfigProgressBar.Close();
    end;

    local procedure InsertConfigLine(TableID: Integer; var NextLineNo: Integer; var NextVertNo: Integer)
    var
        ConfigLine: Record "Config. Line";
    begin
        ConfigLine.Init();
        ConfigLine.Validate("Line Type", ConfigLine."Line Type"::Table);
        ConfigLine.Validate("Table ID", TableID);
        ConfigLine."Line No." := NextLineNo;
        NextLineNo := NextLineNo + 10000;
        ConfigLine."Vertical Sorting" := NextVertNo;
        NextVertNo := NextVertNo + 1;
        ConfigLine.Insert(true);
    end;

    local procedure CheckDimTables(TableID: Integer): Boolean
    var
        "Field": Record "Field";
    begin
        ConfigPackageMgt.SetFieldFilter(Field, TableID, 0);
        if Field.FindSet() then
            repeat
                if IsDimSetIDField(Field.TableNo, Field."No.") then
                    exit(true);
            until Field.Next() = 0;
    end;

    local procedure CheckTable(TableID: Integer): Boolean
    begin
        exit(IsNormalTable(TableID) and TableIsInAllowedRange(TableID));
    end;

    local procedure InsertDimTables(var TempInt: Record "Integer"; IncludeLicensedTablesOnly: Boolean)
    begin
        InsertTempInt(TempInt, Enum::TableID::Dimension.AsInteger(), IncludeLicensedTablesOnly);
        InsertTempInt(TempInt, Enum::TableID::"Dimension Value".AsInteger(), IncludeLicensedTablesOnly);
        InsertTempInt(TempInt, Enum::TableID::"Dimension Combination".AsInteger(), IncludeLicensedTablesOnly);
        InsertTempInt(TempInt, Enum::TableID::"Dimension Value Combination".AsInteger(), IncludeLicensedTablesOnly);
        InsertTempInt(TempInt, Enum::TableID::"Dimension Set Entry".AsInteger(), IncludeLicensedTablesOnly);
        InsertTempInt(TempInt, Enum::TableID::"Dimension Set Tree Node".AsInteger(), IncludeLicensedTablesOnly);
        InsertTempInt(TempInt, Enum::TableID::"Default Dimension".AsInteger(), IncludeLicensedTablesOnly);
        InsertTempInt(TempInt, Enum::TableID::"Default Dimension Priority".AsInteger(), IncludeLicensedTablesOnly);
    end;

    procedure IsDefaultDimTable(TableID: Integer) Result: Boolean
    begin
        case TableID of
            Enum::TableID::"G/L Account".AsInteger(),
          Enum::TableID::Customer.AsInteger(),
          Enum::TableID::Vendor.AsInteger(),
          Enum::TableID::Item.AsInteger(),
          Enum::TableID::"Resource Group".AsInteger(),
          Enum::TableID::Resource.AsInteger(),
          Enum::TableID::Job.AsInteger(),
          Enum::TableID::"Bank Account".AsInteger(),
          Enum::TableID::Employee.AsInteger(),
          Enum::TableID::"Fixed Asset".AsInteger(),
          Enum::TableID::Insurance.AsInteger(),
          Enum::TableID::"Responsibility Center".AsInteger(),
          Enum::TableID::"Work Center".AsInteger(),
          Enum::TableID::"Salesperson/Purchaser".AsInteger(),
          Enum::TableID::Campaign.AsInteger(),
          Enum::TableID::"Cash Flow Manual Expense".AsInteger(),
          Enum::TableID::"Cash Flow Manual Revenue".AsInteger():
                exit(true);
        end;

        OnAfterIsDefaultDimTable(TableID, Result);
    end;

    procedure IsDimSetIDTable(TableID: Integer) Result: Boolean
    var
        RecRef: RecordRef;
    begin
        RecRef.Open(TableID);
        Result := RecRef.FieldExist(Enum::TableID::"Dimension Set Entry".AsInteger());
        OnAfterIsDimSetIDTable(TableID, Result);
    end;

    local procedure IsDimSetIDField(TableID: Integer; FieldID: Integer): Boolean
    var
        ConfigValidateMgt: Codeunit "Config. Validate Management";
    begin
        exit(
          (FieldID = Enum::TableID::"Dimension Set Entry".AsInteger()) or
          (ConfigValidateMgt.GetRelationTableID(TableID, FieldID) = Enum::TableID::"Dimension Value".AsInteger()));
    end;

    local procedure TableIsInAllowedRange(TableID: Integer) Result: Boolean
    begin
        // This condition duplicates table relation of ConfigLine."Table ID" field to prevent runtime errors
        Result := TableID in [1 .. 99000999,
                              Database::"Permission Set",
                              Database::Permission,
                              Database::"Tenant Permission Set Rel.",
                              Database::"Tenant Permission Set",
                              Database::"Tenant Permission"];
        OnAfterTableIsInAllowedRange(TableID, Result);
    end;

    local procedure IsNormalTable(TableID: Integer): Boolean
    var
        TableMetadata: Record "Table Metadata";
    begin
        if TableMetadata.Get(TableID) then
            exit(TableMetadata.TableType = TableMetadata.TableType::Normal);
    end;

    procedure IsSystemTable(TableID: Integer) Result: Boolean
    begin
        Result := (TableID > 2000000000) and not (TableID in [Database::"Permission Set",
                                                              Database::Permission,
                                                              Database::"Tenant Permission Set Rel.",
                                                              Database::"Tenant Permission Set",
                                                              Database::"Tenant Permission"]);
        OnAfterIsSystemTable(TableID, Result);
    end;

    procedure AssignParentLineNos()
    var
        ConfigLine: Record "Config. Line";
        LastAreaLineNo: Integer;
        LastGroupLineNo: Integer;
    begin
        with ConfigLine do begin
            Reset();
            SetCurrentKey("Vertical Sorting");
            if FindSet() then
                repeat
                    case "Line Type" of
                        "Line Type"::Area:
                            begin
                                "Parent Line No." := 0;
                                LastAreaLineNo := "Line No.";
                                LastGroupLineNo := 0;
                            end;
                        "Line Type"::Group:
                            begin
                                "Parent Line No." := LastAreaLineNo;
                                LastGroupLineNo := "Line No.";
                            end;
                        "Line Type"::Table:
                            if LastGroupLineNo <> 0 then
                                "Parent Line No." := LastGroupLineNo
                            else
                                "Parent Line No." := LastAreaLineNo;
                    end;
                    Modify();
                until Next() = 0;
        end;
    end;

    procedure MakeTableFilter(var ConfigLine: Record "Config. Line"; Export: Boolean) "Filter": Text
    var
        AddDimTables: Boolean;
    begin
        Filter := '';
        if ConfigLine.FindSet() then
            repeat
                ConfigLine.CheckBlocked();
                if (ConfigLine."Table ID" > 0) and (ConfigLine.Status <= ConfigLine.Status::Completed) then
                    Filter += Format(ConfigLine."Table ID") + '|';
                AddDimTables := AddDimTables or ConfigLine."Dimensions as Columns";
            until ConfigLine.Next() = 0;
        if AddDimTables and not Export then
            Filter += StrSubstNo('%1|%2|', Enum::TableID::"Dimension Value".AsInteger(), Enum::TableID::"Default Dimension".AsInteger());
        if Filter <> '' then
            Filter := CopyStr(Filter, 1, StrLen(Filter) - 1);

        exit(Filter);
    end;

    procedure SetHideDialog(NewHideDialog: Boolean)
    begin
        HideDialog := NewHideDialog;
    end;

    local procedure InsertTempInt(var TempInt: Record "Integer"; TableId: Integer; IncludeLicensedTablesOnly: Boolean)
    var
        ConfigLine: Record "Config. Line";
        EnvironmentInformation: Codeunit "Environment Information";
        EffectivePermissionsMgt: Codeunit "Effective Permissions Mgt.";
    begin
        if CheckTable(TableId) then begin
            TempInt.Number := TableId;

            ConfigLine.Init();
            ConfigLine."Line Type" := ConfigLine."Line Type"::Table;
            ConfigLine."Table ID" := TableId;
            if IncludeLicensedTablesOnly then begin
                if EnvironmentInformation.IsSaaS() then begin
                    if EffectivePermissionsMgt.HasDirectRIMPermissionsOnTableData(TableId) then
                        if TempInt.Insert() then;
                end
                else begin
                    ConfigLine.CalcFields("Licensed Table");
                    if ConfigLine."Licensed Table" then
                        if TempInt.Insert() then;
                end;
            end else
                if TempInt.Insert() then;
        end;
    end;

    procedure DimensionFieldID(): Integer
    begin
        exit(999999900);
    end;

    [IntegrationEvent(false, false)]
    local procedure OnFindPage(TableID: Integer; var PageID: Integer)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterIsDimSetIDTable(TableID: Integer; var Result: Boolean)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterIsDefaultDimTable(TableID: Integer; var Result: Boolean)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterTableIsInAllowedRange(TableID: Integer; var Result: Boolean)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterIsSystemTable(TableID: Integer; var Result: Boolean)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeCopyDataDialog(var ConfigLine: Record "Config. Line"; NewCompanyName: Text[30]; var IsHandled: Boolean)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnTransferContentOnBeforeToCompanyFieldRefValue(FieldRec: Record "Field"; FromCompanyFieldRef: FieldRef)
    begin
    end;
}

