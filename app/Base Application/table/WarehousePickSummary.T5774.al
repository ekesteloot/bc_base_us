namespace Microsoft.WarehouseMgt.Activity;

using Microsoft.InventoryMgt.Item;
using Microsoft.InventoryMgt.Ledger;
using Microsoft.InventoryMgt.Location;
using Microsoft.WarehouseMgt.Structure;

table 5774 "Warehouse Pick Summary"
{
    DataClassification = CustomerContent;
    TableType = Temporary;
    Access = Internal;
    Caption = 'Warehouse Pick Summary';
    DataCaptionFields = "Source Document", "Source No.", "Item No.";

    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
            Editable = false;
        }
        field(2; "Source Type"; Integer)
        {
            Caption = 'Source Type';
            Editable = false;
        }
        field(3; "Source Subtype"; Option)
        {
            Caption = 'Source Subtype';
            Editable = false;
            OptionCaption = '0,1,2,3,4,5,6,7,8,9,10';
            OptionMembers = "0","1","2","3","4","5","6","7","8","9","10";
        }
        field(4; "Source No."; Code[20])
        {
            Caption = 'Source No.';
            Editable = false;
        }
        field(5; "Source Line No."; Integer)
        {
            BlankZero = true;
            Caption = 'Source Line No.';
            Editable = false;
        }
        field(6; "Source Subline No."; Integer)
        {
            BlankZero = true;
            Caption = 'Source Subline No.';
            Editable = false;
        }
        field(7; "Source Document"; Enum "Warehouse Activity Source Document")
        {
            BlankZero = true;
            Caption = 'Source Document';
            Editable = false;
        }
        field(11; "Location Code"; Code[10])
        {
            Caption = 'Location Code';
            Editable = false;
            TableRelation = Location;
        }
        field(12; "Bin Code"; Code[20])
        {
            Editable = false;
            TableRelation = Bin.Code;
            ValidateTableRelation = false;
        }
        field(14; "Item No."; Code[20])
        {
            Editable = false;
            TableRelation = Item."No.";
        }
        field(15; "Variant Code"; Code[10])
        {
            Editable = false;
            TableRelation = "Item Variant".Code where("Item No." = field("Item No."));
            ValidateTableRelation = false;
        }
        field(16; "Unit of Measure Code"; Code[10])
        {
            Caption = 'Unit of Measure Code';
            Editable = false;
            TableRelation = "Item Unit of Measure".Code where("Item No." = field("Item No."));
            ValidateTableRelation = false;
        }
        field(18; Description; Text[100])
        {
            Caption = 'Description';
            Editable = false;
        }
        field(19; "Description 2"; Text[50])
        {
            Caption = 'Description 2';
            Editable = false;
        }
        field(26; "Qty. to Handle"; Decimal)
        {
            Caption = 'Qty. to Handle';
            DecimalPlaces = 0 : 5;
            MinValue = 0;
        }
        field(27; "Qty. to Handle (Base)"; Decimal)
        {
            Caption = 'Qty. to Handle (Base)';
            DecimalPlaces = 0 : 5;
        }
        field(28; "Qty. Handled"; Decimal)
        {
            Caption = 'Qty. Handled';
            DecimalPlaces = 0 : 5;
            Editable = false;
        }
        field(29; "Qty. Handled (Base)"; Decimal)
        {
            Caption = 'Qty. Handled (Base)';
            DecimalPlaces = 0 : 5;
            Editable = false;
        }
        field(40; "Qty. in Inventory"; Decimal)
        {
            Editable = false;
            Caption = 'Qty. in inventory';
            DecimalPlaces = 0 : 5;
            FieldClass = FlowField;
            CalcFormula = sum("Item Ledger Entry".Quantity where("Item No." = field("Item No."),
                                                                  "Location Code" = field("Location Code"),
                                                                  "Variant Code" = field("Variant Code"),
                                                                  "Unit of Measure Code" = field("Unit of Measure Code")));

        }
        field(41; "Qty. available to pick"; Decimal)
        {
            Editable = false;
            Caption = 'Qty. available to pick';
            DecimalPlaces = 0 : 5;
        }
        field(42; "Potential pickable qty."; Decimal)
        {
            Editable = false;
            Caption = 'Potential qty. available to pick';
            DecimalPlaces = 0 : 5;
        }
        field(43; "Available qty. not in ship bin"; Decimal)
        {
            Editable = false;
            Caption = 'Available quantity excluding ship bin';
            DecimalPlaces = 0 : 5;
        }
        field(44; "Qty. assigned"; Decimal)
        {
            Editable = false;
            Caption = 'Qty. assigned';
            DecimalPlaces = 0 : 5;
        }
        field(50; "Qty. reserved in warehouse"; Decimal)
        {
            Editable = false;
            Caption = 'Qty. reserved in warehouse';
            DecimalPlaces = 0 : 5;
        }
        field(51; "Qty. res. in pick/ship bins"; Decimal)
        {
            Editable = false;
            Caption = 'Qty. reserved in pick/ship bins';
            DecimalPlaces = 0 : 5;
        }
        field(52; "Qty. reserved for this line"; Decimal)
        {
            Editable = false;
            Caption = 'Qty. reserved for this line';
            DecimalPlaces = 0 : 5;
        }
        field(60; "Qty. in blocked Item Tracking"; Decimal)
        {
            Editable = false;
            Caption = 'Qty. in blocked Item Tracking';
            DecimalPlaces = 0 : 5;
        }
        field(61; "Qty. in active pick lines"; Decimal)
        {
            Editable = false;
            Caption = 'Qty. in active pick lines';
            DecimalPlaces = 0 : 5;
        }
        field(62; "Qty. in pickable bins"; Decimal)
        {
            Editable = false;
            Caption = 'Qty. in pickable bins';
            DecimalPlaces = 0 : 5;
        }
        field(63; "Qty. in Warehouse"; Decimal)
        {
            Editable = false;
            Caption = 'Qty. in warehouse';
            DecimalPlaces = 0 : 5;
        }
        field(70; "Qty. block. Item Tracking Res."; Decimal)
        {
            Editable = false;
            Caption = 'Qty. in blocked item tracking for checking reservation';
            DecimalPlaces = 0 : 5;
        }
        field(71; "Qty. in active pick lines Res."; Decimal)
        {
            Editable = false;
            Caption = 'Qty. in active pick lines for checking reservation';
            DecimalPlaces = 0 : 5;
        }
        field(72; "Qty. not in ship bin"; Decimal)
        {
            Editable = false;
            Caption = 'Qty. not in ship bins for checking reservation';
            DecimalPlaces = 0 : 5;
        }
    }

    keys
    {
        key(Key1; "Entry No.")
        {
            Clustered = true;
        }
    }

    procedure IncrementEntryNumber()
    begin
        Rec.ReadIsolation := IsolationLevel::ReadUncommitted;
        Rec.SetLoadFields("Entry No.");
        if Rec.FindLast() then
            Rec."Entry No." += 1;
    end;

    internal procedure ShowBinContents(BinTypeFilter: Option ExcludeReceive,ExcludeShip,OnlyPickBins)
    var
        BinContent: Record "Bin Content";
        CreatePick: Codeunit "Create Pick";
        BinContentsPage: Page "Bin Contents";
    begin
        BinContent.SetRange("Item No.", Rec."Item No.");
        BinContent.SetRange("Variant Code", Rec."Variant Code");
        BinContent.SetRange("Location Code", Rec."Location Code");
        BinContent.SetRange("Unit of Measure Code", Rec."Unit of Measure Code");
        BinContent.SetRange("Block Movement", BinContent."Block Movement"::" ", BinContent."Block Movement"::Inbound);
        BinContent.SetRange(Dedicated, false);
        case BinTypeFilter of
            BinTypeFilter::ExcludeReceive:
                BinContent.SetFilter("Bin Type Code", '<>%1', CreatePick.GetBinTypeFilter(0));
            BinTypeFilter::ExcludeShip:
                BinContent.SetFilter("Bin Type Code", '<>%1', CreatePick.GetBinTypeFilter(1));
            BinTypeFilter::OnlyPickBins:
                BinContent.SetFilter("Bin Type Code", CreatePick.GetBinTypeFilter(3));
        end;
        BinContentsPage.SetTableView(BinContent);
        BinContentsPage.RunModal();
    end;

    internal procedure SetQtyToHandleStyle(): Text
    begin
        if Rec."Qty. to Handle (Base)" <> 0 then
            case true of
                Rec."Qty. to Handle (Base)" = Rec."Qty. Handled (Base)":
                    exit('favorable');
                Rec."Qty. Handled (Base)" = 0:
                    exit('unfavorable');
                Rec."Qty. to Handle (Base)" > Rec."Qty. Handled (Base)":
                    exit('attention');
            end;
    end;
}