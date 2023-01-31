table 50050 "ODT Chat GPT Setup"
{
    Caption = 'Chat GPT Setup';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "API Key"; Text[250])
        {
            Caption = 'API Key';
            DataClassification = CustomerContent;
        }
        field(2; Model; Text[100])
        {
            Caption = 'Model';
            DataClassification = CustomerContent;
        }
        field(3; Prompt; Text[250])
        {
            Caption = 'Prompt';
            DataClassification = CustomerContent;
        }
        field(4; "Max Token"; Integer)
        {
            Caption = 'Max Token';
            DataClassification = CustomerContent;
        }
        field(5; Temperature; Integer)
        {
            Caption = 'Temperature';
            DataClassification = CustomerContent;
        }
        field(6; "Top P"; Integer)
        {
            Caption = 'Top P';
            DataClassification = CustomerContent;
        }
        field(7; "Frequency Penalty"; Integer)
        {
            Caption = 'Frequency Penalty';
            DataClassification = CustomerContent;
        }
        field(8; "Presence Penalty"; Integer)
        {
            Caption = 'Presence Penalty';
            DataClassification = CustomerContent;
        }
    }
    keys
    {
        key(PK; "API Key")
        {
            Clustered = true;
        }
    }
}
