namespace Microsoft.Purchases.Document;

codeunit 384 "Upd. Pending Prepmt. Purchase"
{

    trigger OnRun()
    var
        PrepaymentMgt: Codeunit "Prepayment Mgt.";
    begin
        PrepaymentMgt.UpdatePendingPrepaymentPurchase();
    end;
}

