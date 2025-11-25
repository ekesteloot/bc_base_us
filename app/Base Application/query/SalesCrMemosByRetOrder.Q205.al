query 205 "Sales Cr. Memos By Ret. Order"
{
    Caption = 'Sales Cr. Memos By Ret. Order';
    DataAccessIntent = ReadOnly;

    elements
    {
        dataitem(SalesCrMemoLine; "Sales Cr.Memo Line")
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