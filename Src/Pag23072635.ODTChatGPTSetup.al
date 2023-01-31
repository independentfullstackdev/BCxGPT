page 23072635 "ODT Chat GPT Setup"
{
    ApplicationArea = All;
    Caption = 'Chat GPT Setup';
    PageType = Card;
    SourceTable = "ODT Chat GPT Setup";
    UsageCategory = Tasks;

    layout
    {
        area(content)
        {
            group(General)
            {
                field(Model; Rec.Model)
                {
                    ToolTip = 'Specifies the value of the Model field.';
                }
                field("API Key"; Rec."API Key")
                {
                    ToolTip = 'Specifies the value of the API Key field.';
                }
                field(Prompt; Rec.Prompt)
                {
                    ToolTip = 'Specifies the value of the Prompt field.';
                }
                field("Max Token"; Rec."Max Token")
                {
                    ToolTip = 'Specifies the value of the Max Token field.';
                }
                field(Temperature; Rec.Temperature)
                {
                    ToolTip = 'Specifies the value of the Temperature field.';
                }
                field("Top P"; Rec."Top P")
                {
                    ToolTip = 'Specifies the value of the Top P field.';
                }

                field("Frequency Penalty"; Rec."Frequency Penalty")
                {
                    ToolTip = 'Specifies the value of the Frequency Penalty field.';
                }
                field("Presence Penalty"; Rec."Presence Penalty")
                {
                    ToolTip = 'Specifies the value of the Presence Penalty field.';
                }
            }
        }
    }
}
