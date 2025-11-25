namespace Microsoft.InventoryMgt.Tracking;

page 316 "Allocation Policies"
{
    PageType = List;
    ApplicationArea = Reservation;
    SourceTable = "Allocation Policy";
    Caption = 'Allocation Policy';
    PopulateAllFields = true;
    DelayedInsert = true;

    layout
    {
        area(Content)
        {
            field(PageDescription; PageDescriptionTxt)
            {
                ToolTip = 'Specifies the description of the page.';
                ShowCaption = false;
                Editable = false;
            }
            repeater(Shortage)
            {
                field("Step No."; Rec."Line No.")
                {
                    Caption = 'Step No.';
                    ToolTip = 'Specifies the step number of the allocation policy.';
                }
                field("Name"; Rec."Allocation Rule")
                {
                    Caption = 'Name';
                    ToolTip = 'Specifies the name of the allocation policy. Click or tap the AssistEdit button to see an example of how the allocation policy will be applied.';

                    trigger OnAssistEdit()
                    begin
                        if (Rec."Allocation Rule" <> Rec."Allocation Rule"::" ") and GuiAllowed() then
                            Message(Rec.GetAllocationPolicyDescription());
                    end;
                }
            }
        }
    }

    var
        PageDescriptionTxt: Label 'Specify one or more allocation policies to control how you distribute available inventory among demands.';

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec."Line No." := Rec.GetNextLineNo();
    end;
}