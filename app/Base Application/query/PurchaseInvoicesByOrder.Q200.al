query 200 "Purchase Invoices By Order"
{
    Caption = 'Purchase Invoices By Order';
    DataAccessIntent = ReadOnly;

    elements
    {
        dataitem(PurchInvLine; "Purch. Inv. Line")
        {
            column(Document_No_; "Document No.")
            {
            }
            column(LinesCount)
            {
                Method = Count;
            }
            filter(Order_No_; "Order No.")
            {
            }
            filter(Quantity; Quantity)
            {
            }
        }
    }
}