page 50051 "ODT Chat GPT Convo"
{
    ApplicationArea = All;
    Caption = 'Chat GPT Convo';
    PageType = List;
    SourceTable = "ODT Chat GPT Convo";
    SourceTableView = order(descending);
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            field(MessageToSend; MessageToSend)
            {
                ApplicationArea = All;
                Caption = 'Input';
                trigger OnValidate()
                begin
                    if MessageToSend <> '' then begin
                        ChatGPTIntegration.InsertResponse('Me: ' + MessageToSend);
                        Commit();
                        CurrPage.Update(false);
                        response := ChatGPTIntegration.SendMessage(ChatGPTSetup."API Key", MessageToSend);
                        MessageToSend := '';
                        CurrPage.Update(false);
                    end;
                end;
            }
            repeater(General)
            {
                Editable = false;
                field(Message; Rec.Message)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Message field.';
                    MultiLine = true;
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action(ODTChatGPT)
            {
                ApplicationArea = All;
                Caption = 'Send message to ChatGPT';
                ObsoleteState = Pending;
                ObsoleteReason = 'trigger will be in text/field onvalidate';

                trigger OnAction()
                begin
                    response := ChatGPTIntegration.SendMessage(ChatGPTSetup."API Key", MessageToSend);
                    Message(response);
                end;
            }
        }
    }

    trigger OnOpenPage()
    begin
        MessageToSend := 'create business central api?';
        ChatGPTSetup.FindFirst();
    end;


    var
        ChatGPTIntegration: Codeunit "ODT ChatGPT Integrationx";
        ChatGPTSetup: Record "ODT Chat GPT Setup";
        MessageToSend, response : Text;
}
