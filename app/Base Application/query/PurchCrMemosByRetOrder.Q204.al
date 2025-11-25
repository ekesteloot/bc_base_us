query 204 "Purch. Cr. Memos By Ret. Order"
{
    Caption = 'Purch. Cr. Memos By Ret. Order';
    DataAccessIntent = ReadOnly;

    elements
    {
        dataitem(PurchCrMemoLine; "Purch. Cr. Memo Line")
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