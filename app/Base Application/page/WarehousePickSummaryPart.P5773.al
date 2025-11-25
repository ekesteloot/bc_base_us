namespace Microsoft.WarehouseMgt.Activity;
using Microsoft.InventoryMgt.Tracking;
using Microsoft.InventoryMgt.Ledger;
using Microsoft.WarehouseMgt.Ledger;

page 5773 "Warehouse Pick Summary Part"
{
    PageType = CardPart;
    ApplicationArea = All;
    UsageCategory = None;
    SourceTable = "Warehouse Pick Summary";
    SourceTableTemporary = true;
    Editable = false;

    layout
    {
        area(Content)
        {
            group(Calculation)
            {
                ShowCaption = false;

                group(MovementWorksheet)
                {
                    ShowCaption = false;
                    Visible = IsCalledFromMovementWorksheet;

                    field("Takeable qty."; Rec."Potential pickable qty.")
                    {
                        Caption = 'Takeable qty.';
                        ToolTip = 'Specifies the maximum quantity that can be considered for moving. This quantity consists of items in all the bins excluding Receipt bins, bins that are blocked, dedicated, blocked by item tracking or items that are being picked. This quantity cannot be more than the total quantity in the warehouse including adjustment bins.';
                    }
                }
                group(NonMovementWorksheet)
                {
                    ShowCaption = false;
                    Visible = not IsCalledFromMovementWorksheet;

                    field("Pickable qty."; Rec."Potential pickable qty.")
                    {
                        Caption = 'Pickable qty.';
                        ToolTip = 'Specifies the maximum quantity that can be considered for picking. This quantity consists of items in pickable bins excluding bins that are blocked, dedicated, blocked by item tracking or items that are being picked. This quantity cannot be more than the total quantity in the warehouse including adjustment bins.';
                    }
                }

                field(QtyAvailableToPick; Rec."Qty. available to pick")
                {
                    Caption = 'Pickable qty. (Actual)';
                    ToolTip = 'Specifies the quantity that is actually available to pick.';
                    Visible = false;
                }

                group(Details)
                {
                    ShowCaption = false;

                    group(PickableQtyDetails)
                    {
                        Caption = 'Pickable qty. details';
                        Visible = not IsCalledFromMovementWorksheet;

                        field("Qty. in pickable bins"; Rec."Qty. in pickable bins")
                        {
                            Caption = 'Qty. in pickable bins';
                            ToolTip = 'Specifies the quantity in pickable bins. The quantity is not reduced by item tracking.';

                            trigger OnDrillDown()
                            begin
                                Rec.ShowBinContents(BinTypeFilter::OnlyPickBins);
                            end;
                        }
                    }

                    group(TakeableQtyDetails)
                    {
                        Caption = 'Takeable qty. details';
                        Visible = IsCalledFromMovementWorksheet;

                        field("Qty. in takeable bins"; Rec."Qty. in pickable bins")
                        {
                            Caption = 'Qty. in takeable bins';
                            ToolTip = 'Specifies the quantity in takeable bins. The quantity is not reduced by item tracking.';

                            trigger OnDrillDown()
                            begin
                                Rec.ShowBinContents(BinTypeFilter::ExcludeReceive);
                            end;
                        }
                    }

                    field("Qty. in Warehouse"; Rec."Qty. in Warehouse")
                    {
                        Caption = 'Qty. in warehouse';
                        ToolTip = 'Specifies the quantity in warehouse.';

                        trigger OnDrillDown()
                        var
                            WarehouseEntry: Record "Warehouse Entry";
                            WarehouseEntriesPage: Page "Warehouse Entries";
                        begin
                            WarehouseEntry.SetRange("Item No.", Rec."Item No.");
                            WarehouseEntry.SetRange("Location Code", Rec."Location Code");
                            WarehouseEntry.SetRange("Variant Code", Rec."Variant Code");
                            WarehouseEntry.SetRange("Unit of Measure Code", Rec."Unit of Measure Code");
                            WarehouseEntriesPage.SetTableView(WarehouseEntry);
                            WarehouseEntriesPage.Run();
                        end;
                    }
                    group(TrackingEnabled1)
                    {
                        ShowCaption = false;
                        Visible = IsTrackingVisible;

                        field("Qty. in blocked item tracking"; Rec."Qty. in blocked Item Tracking")
                        {
                            Caption = 'Qty. blocked by item tracking';
                            ToolTip = 'Specifies the quantity in blocked item tracking for the pickable/takeable bins.';
                        }
                    }
                    group(QtyAssigned)
                    {
                        ShowCaption = false;
                        Visible = Rec."Qty. assigned" > 0;

                        field("Qty. assigned"; Rec."Qty. assigned")
                        {
                            Caption = 'Qty. handled across source lines';
                            ToolTip = 'Specifies the quantity that has been handled for other source lines. If tracking is enabled, then the same source line is also included. The quantity consists of the current execution of create warehouse pick action.';
                        }
                    }

                    field("Qty. in active pick lines"; Rec."Qty. in active pick lines")
                    {
                        Caption = 'Qty. in active pick lines';
                        ToolTip = 'Specifies the quantity assigned in active warehouse pick documents.';
                        Visible = false;
                    }
                    field(QtyAvailableInInventory; Rec."Qty. in Inventory")
                    {
                        Caption = 'Qty. in inventory';
                        ToolTip = 'Specifies the quantity in the inventory.';
                        Visible = false;
                    }
                }
            }

            group("Impact of reservations")
            {
                Visible = IsReservationImpactVisible;

                field("Available qty. not in ship bin"; Rec."Available qty. not in ship bin")
                {
                    Caption = 'Avail. qty. excluding shipment bin';
                    ToolTip = 'Specifies the quantity available to pick in the warehouse excluding the shipment bins, bins that are blocked, dedicated, blocked by item tracking or items that are being picked.';

                    trigger OnDrillDown()
                    begin
                        Rec.ShowBinContents(BinTypeFilter::ExcludeShip);
                    end;
                }
                field("Qty. reserved in warehouse"; Rec."Qty. reserved in warehouse")
                {
                    Caption = 'Total reserved qty. in warehouse';
                    ToolTip = 'Specifies the quantity reserved in warehouse. This quantity consists of inventory from reservation excluding inventory that is picked or being picked but not yet shipped or consumed.';

                    trigger OnDrillDown()
                    begin
                        ShowReservationEntries();
                    end;
                }
                field("Qty. res. in pick/ship bins"; Rec."Qty. res. in pick/ship bins")
                {
                    Caption = 'Reserved qty. in pick/ship bins';
                    ToolTip = 'Specifies the quantity reserved in pick/ship bins.';
                }
                field("Qty. reserved for this line"; Rec."Qty. reserved for this line")
                {
                    Caption = 'Qty. reserved for current line';
                    ToolTip = 'Specifies the quantity reserved for the selected line.';
                }

                group(TrackingEnabled2)
                {
                    ShowCaption = false;
                    Visible = IsTrackingVisible;

                    field("Qty. block. Item Tracking Res."; Rec."Qty. block. Item Tracking Res.")
                    {
                        Caption = 'Qty. in blocked item tracking';
                        ToolTip = 'Specifies the quantity in blocked item tracking for the quantity reserved in warehouse.';
                    }
                }

                field("Qty. in active pick lines Res."; Rec."Qty. in active pick lines Res.")
                {
                    Caption = 'Qty. in active pick lines';
                    ToolTip = 'Specifies the quantity assigned in active warehouse pick documents.';
                    Visible = false;
                }

                field(Impact; ReservationImpactValue)
                {
                    Caption = 'Impact';
                    ToolTip = 'Specifies the impact of reservations on the quantity available to pick. Pickable quantity is reduced by the quantity reserved in warehouse by other documents.';
                    DecimalPlaces = 0 : 5;
                    StyleExpr = ReservationImpactStyle;
                }
            }
            field("Qty. Handled"; Rec."Qty. Handled")
            {
                StyleExpr = QtyToHandleStyle;
                ToolTip = 'Specifies the number of items on the line that have been handled in this warehouse activity.';
            }
        }
    }

    var
        WhseItemTrackingSetup: Record "Item Tracking Setup";
        BinTypeFilter: Option ExcludeReceive,ExcludeShip,OnlyPickBins;
        IsCalledFromMovementWorksheet: Boolean;
        IsTrackingVisible: Boolean;
        IsReservationImpactVisible: Boolean;
        ReservationImpactValue: Decimal;
        ReservationImpactStyle: Text;
        QtyToHandleStyle: Text;

    trigger OnAfterGetCurrRecord()
    var
        ItemTrackingManagement: Codeunit "Item Tracking Management";
    begin
        IsTrackingVisible := ItemTrackingManagement.GetWhseItemTrkgSetup(Rec."Item No.", WhseItemTrackingSetup);
        IsReservationImpactVisible := Rec."Qty. reserved in warehouse" > 0;
        if IsReservationImpactVisible then
            SetReservationImpactValue();
        QtyToHandleStyle := Rec.SetQtyToHandleStyle();
    end;

    internal procedure SetRecords(var WarehousePickSummary: Record "Warehouse Pick Summary")
    begin
        if WarehousePickSummary.FindFirst() then
            Rec.Copy(WarehousePickSummary, true);
    end;

    internal procedure SetCalledFromMovementWorksheet(CalledFromMovementWorksheet: Boolean)
    begin
        IsCalledFromMovementWorksheet := CalledFromMovementWorksheet;
    end;

    local procedure SetReservationImpactValue()
    var
        CreatePick: Codeunit "Create Pick";
        AvailabilityAfterReservationImpactValue: Decimal;
    begin
        AvailabilityAfterReservationImpactValue := CreatePick.CalcAvailabilityAfterReservationImpact(Rec."Available qty. not in ship bin", Rec."Qty. reserved in warehouse", Rec."Qty. res. in pick/ship bins", Rec."Qty. reserved for this line");
        if AvailabilityAfterReservationImpactValue < Rec."Potential pickable qty." then
            ReservationImpactValue := (Rec."Potential pickable qty." - AvailabilityAfterReservationImpactValue) * -1
        else
            ReservationImpactValue := 0;
        ReservationImpactStyle := SetReservationImpactStyle();
    end;

    local procedure SetReservationImpactStyle(): Text
    begin
        if ReservationImpactValue < 0 then
            exit('attention')
        else
            exit('favorable');
    end;

    local procedure ShowReservationEntries()
    var
        ReservationEntry: Record "Reservation Entry";
    begin
        ReservationEntry.InitSortingAndFilters(true);
        SetReservationFilters(ReservationEntry);
        Page.RunModal(Page::"Reservation Entries", ReservationEntry);
    end;

    local procedure SetReservationFilters(var ReservationEntry: Record "Reservation Entry")
    begin
        ReservationEntry.SetRange("Source Type", Database::"Item Ledger Entry");
        ReservationEntry.SetRange("Source Subtype", 0);
        ReservationEntry.SetRange("Reservation Status", Enum::"Reservation Status"::Reservation);
        ReservationEntry.SetRange("Location Code", Rec."Location Code");
        ReservationEntry.SetRange("Item No.", Rec."Item No.");
        ReservationEntry.SetRange("Variant Code", Rec."Variant Code");
        SetTrackingFilterFromWhseItemTrackingSetupIfRequired(ReservationEntry);
    end;

    local procedure SetTrackingFilterFromWhseItemTrackingSetupIfRequired(var ReservationEntry: Record "Reservation Entry")
    begin
        if WhseItemTrackingSetup."Serial No." <> '' then
            if WhseItemTrackingSetup."Serial No. Required" then
                ReservationEntry.SetRange("Serial No.", WhseItemTrackingSetup."Serial No.")
            else
                ReservationEntry.SetFilter("Serial No.", '%1|%2', WhseItemTrackingSetup."Serial No.", '');

        if WhseItemTrackingSetup."Lot No." <> '' then
            if WhseItemTrackingSetup."Lot No. Required" then
                ReservationEntry.SetRange("Lot No.", WhseItemTrackingSetup."Lot No.")
            else
                ReservationEntry.SetFilter("Lot No.", '%1|%2', WhseItemTrackingSetup."Lot No.", '');

        if WhseItemTrackingSetup."Package No." <> '' then
            if WhseItemTrackingSetup."Package No. Required" then
                ReservationEntry.SetRange("Package No.", WhseItemTrackingSetup."Lot No.")
            else
                ReservationEntry.SetFilter("Package No.", '%1|%2', WhseItemTrackingSetup."Lot No.", '');
    end;
}