page 50800 "Currency Rate"
{
    ApplicationArea = All;
    Caption = 'Currency Rate';
    PageType = List;
    SourceTable = "Currency Rate";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Currency Symb"; Rec."Currency Symb")
                {
                    ToolTip = 'Specifies the value of the Currency Symb field.';
                }
                field("Currency Name"; Rec."Currency Name")
                {
                    ToolTip = 'Specifies the value of the Currency Name field.';
                }
                field("Unit"; Rec.Unit)
                {
                    ToolTip = 'Specifies the value of the selling Rate field.';
                }
                field("Buying Rate"; Rec."Buying Rate")
                {
                    ToolTip = 'Specifies the value of the Buying Rate field.';
                }
                field("selling Rate"; Rec."selling Rate")
                {
                    ToolTip = 'Specifies the value of the selling Rate field.';
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action("Get Currency")
            {
                ApplicationArea = All;
                Image = Currencies;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    apimanage: Codeunit "Api management";
                begin
                    apimanage.Getcurrency();

                end;
            }
        }
    }
}
