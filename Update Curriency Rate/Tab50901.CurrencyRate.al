table 50801 "Currency Rate"
{
    Caption = 'Currency Rate';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Currency Name"; Text[400])
        {
            Caption = 'Currency Name';
        }
        field(2; "Buying Rate"; Decimal)
        {
            Caption = 'Buying Rate';
        }
        field(3; "selling Rate"; Decimal)
        {
            Caption = 'selling Rate';
        }
        field(4; "Currency Symb"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(5; Unit; Decimal)
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; "Currency Name")
        {
            Clustered = true;
        }
    }
}
