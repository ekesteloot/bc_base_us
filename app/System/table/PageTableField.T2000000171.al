table 2000000171 "Page Table Field"
{
    DataPerCompany = false;
    Scope = OnPrem;

    fields
    {
        field(1; "Page ID"; Integer)
        {
        }
        field(2; "Field ID"; Integer)
        {
        }
        field(3; Type; Option)
        {
            OptionMembers = TableFilter,RecordID,OemText,Date,Time,DateFormula,Decimal,Media,MediaSet,Text,Code,NotSupported_Binary,BLOB,Boolean,Integer,OemCode,Option,BigInteger,Duration,GUID,DateTime;
            // This list must stay in sync with NCLOptionMetadataNavTypeField
            OptionOrdinalValues = 4912, 4988, 11519, 11775, 11776, 11797, 12799, 26207, 26208, 31488, 31489, 33791, 33793, 34047, 34559, 35071, 35583, 36095, 36863, 37119, 37375;
        }
        field(4; Length; Integer)
        {
        }
        field(5; Caption; Text[80])
        {
        }
        field(6; Status; Option)
        {
            OptionMembers = New,Ready,Placed;
        }
        field(7; IsTableField; Boolean)
        {
            Caption = 'IsTableField';
        }
    }

    keys
    {
        key(pk; "Page ID", "Field ID")
        {
        }
    }

    fieldGroups
    {
        fieldgroup("Brick"; Type, Caption, Status)
        {
        }
    }
}