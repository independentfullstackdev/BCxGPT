codeunit 50050 "ODT ChatGPT Integrationx"
{

    // Send a message to ChatGPT and receive a response
    procedure SendMessage(apiKey: Text; message: Text): Text
    var
        ChatGPTSetup: Record "ODT Chat GPT Setup";
        Client: HttpClient;
        Headers: HttpHeaders;
        request: HttpRequestMessage;
        response: HttpResponseMessage;
        json: JsonObject;
        content: HttpContent;
        data: Text;
    begin
        ChatGPTSetup.FindFirst();
        json.Add('model', ChatGPTSetup.Model);
        json.Add('prompt', message);
        json.Add('max_tokens', ChatGPTSetup."Max Token");
        json.Add('temperature', ChatGPTSetup.Temperature);
        json.Add('top_p', ChatGPTSetup."Top P");
        json.Add('frequency_penalty', ChatGPTSetup."Frequency Penalty");
        json.Add('presence_penalty', ChatGPTSetup."Presence Penalty");

        request.Method := 'POST';
        request.SetRequestUri('https://api.openai.com/v1/completions');
        Request.GetHeaders(Headers);
        Headers.Add('Authorization', 'Bearer ' + apiKey);
        content.WriteFrom(Format(json));

        content.GetHeaders(Headers);
        Headers.Remove('Content-Type');
        Headers.TryAddWithoutValidation('Content-Type', 'application/json');
        request.Content := content;

        // Send the request and get the response
        Client.Send(request, response);

        // Check the response status
        if response.HttpStatusCode <> 200 then begin
            // Handle error
            Error('Error sending message to ChatGPT.');
        end;

        // Parse the response body       
        response.Content.ReadAs(data);
        data := ReadResponse(data);
        // Return the chatbot's response
        exit(data);
    end;

    local procedure CreateRequestJSONForAccessRefreshToken(var JsonString: Text; ServiceURL: Text; URLRequestPath: Text; var ContentJson: JsonObject)
    var
        JObject: JsonObject;
    begin
        if JObject.ReadFrom(JsonString) then;
        JObject.Add('ServiceURL', ServiceURL);
        JObject.Add('Method', 'POST');
        JObject.Add('URLRequestPath', URLRequestPath);
        JObject.Add('Content-Type', 'application/json');
        JObject.Add('Content', ContentJson);
        JObject.WriteTo(JsonString);
    end;

    local procedure ReadResponse(data: Text): Text
    var
        obj: JsonObject;
        O2: JsonObject;
        item: JsonObject;
        Token: JsonToken;
        T2: JsonToken;
        T3: JsonToken;
        ja: JsonArray;
        v: JsonValue;
        txt: Text;
    begin
        obj.ReadFrom(data);
        if obj.Contains('choices') then begin
            obj.get('choices', Token);
            foreach T2 in Token.AsArray() do begin
                if T2.IsObject() then begin
                    O2 := T2.AsObject();
                    O2.Get('text', T3);
                    if T3.IsValue() then begin
                        V := T3.AsValue();
                        txt := CopyStr(V.AsText(), 1, 240);
                        InsertResponse('ChatGPT: ' + txt);
                    end;
                end;
            end;
        end;
        if txt <> '' then
            txt := CopyStr(txt, 1, 250);
        exit(txt);
    end;

    procedure InsertResponse(ConVo: Text)
    var
        ChatGPTConvo: Record "ODT Chat GPT Convo";
        LastLine: Integer;
    begin
        if ChatGPTConvo.FindLast() then
            LastLine := ChatGPTConvo."Entry No.";

        ChatGPTConvo.Init();
        ChatGPTConvo."Entry No." := LastLine + 1;
        ChatGPTConvo.Message := ConVo;
        ChatGPTConvo.Insert();
    end;

}