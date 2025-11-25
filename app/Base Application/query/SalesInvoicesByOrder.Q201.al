query 201 "Sales Invoices By Order"
{
    Caption = 'Sales Invoices By Order';
    DataAccessIntent = ReadOnly;

    elements
    {
        dataitem(SalesInvoiceLine; "Sales Invoice Line")
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