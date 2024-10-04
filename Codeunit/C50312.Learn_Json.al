codeunit 50312 LearnJson
{
    trigger OnRun()
    begin

    end;

    procedure CreateJson()
    var
        Object: JsonObject;
        SecondObject: JsonObject;
        ThirdObject: JsonObject;
        SeconArr: JsonArray;
        Arr: JsonArray;
        Cust: Record Customer;
        TempBlob: Codeunit "Temp Blob";
        Instr: InStream;
        Outstr: OutStream;
        FileName: Text;
        Result: Text;
    begin
        Cust.get('10000');
        Object.Add('No.', Cust."No.");
        Object.Add('Name', Cust.Name);
        SecondObject.Add('Address', Cust.Address);
        SecondObject.Add('City', Cust.City);
        SecondObject.Add('Country', Cust."Country/Region Code");
        Arr.Add(SecondObject);
        Object.Add('Correspondence', Arr);
        ThirdObject.Add('GBPG', Cust."Gen. Bus. Posting Group");
        ThirdObject.Add('CPG', Cust."Customer Posting Group");
        SeconArr.Add(ThirdObject);
        Object.Add('Posting Group', SeconArr);
        // DownLoad the Json File
        TempBlob.CreateInStream(Instr);
        TempBlob.CreateOutStream(Outstr);
        Object.WriteTo(Outstr);
        Outstr.WriteText(Result);
        Instr.ReadText(Result);
        DownloadFromStream(Instr, 'Download Json Data', '', '', FileName);
    end;

    procedure APIConnect()
    var
        Client: HttpClient;
        Response: HttpResponseMessage;
        Content: HttpContent;
        Result: Text;
        Request: HttpRequestMessage;
        Output: Text;
    begin
        //Method 1
        Client.Get('https://jsonplaceholder.typicode.com/posts', Response);
        if Response.IsSuccessStatusCode then
            Content := Response.Content
        else
            Message('Respnse was negative %1,%2', Response.HttpStatusCode, Response.ReasonPhrase);
        Content.ReadAs(Result);
        Message(Result);


        //Method 2
        Request.SetRequestUri('https://jsonplaceholder.typicode.com/users');
        Request.Method('Get');
        Client.Send(Request, Response);
        if Response.IsSuccessStatusCode then
            Content := Response.Content
        else
            Message('Respnse was negative %1,%2', Response.HttpStatusCode, Response.ReasonPhrase);
        Content.ReadAs(Output);
        Message(Output);
    end;

    procedure ReadJson(var API: Record JsonTable)
    var
        Client: HttpClient;
        Response: HttpResponseMessage;
        Content: HttpContent;
        Request: HttpRequestMessage;
        Result: Text;
        Output: Text;
        JObject: JsonObject;
        NewJsobject: JsonObject;
        NewJToken: JsonToken;
        Jtoken: JsonToken;
    begin
        //Method 1
        Client.Get('https://jsonplaceholder.typicode.com/users/' + Format(API.ID), Response);
        if Response.IsSuccessStatusCode then begin
            Content := Response.Content;
            Content.ReadAs(Result);
            // To store the content in JSON Object
            JObject.ReadFrom(Result);
            JObject.Get('name', Jtoken);
            API.Name := Jtoken.AsValue().AsText();
            JObject.Get('email', Jtoken);
            API.Email := Jtoken.AsValue().AsText();
            JObject.Get('username', Jtoken);
            API.Username := Jtoken.AsValue().AsText();
            JObject.Get('address', Jtoken);
            if Jtoken.IsObject then begin
                Jtoken.WriteTo(Output);
                NewJsobject.ReadFrom(Output);
                NewJsobject.Get('street', NewJToken);
                API.Street := NewJToken.AsValue().AsText();
                NewJsobject.Get('suite', NewJToken);
                API.Suite := NewJToken.AsValue().AsText();
                NewJsobject.Get('city', NewJToken);
                API.City := NewJToken.AsValue().AsText();
            end
            else
                Error('Jsontoken is not having the data available as JSON-Object')
        end
        else
            Message('Respnse was negative %1,%2', Response.HttpStatusCode, Response.ReasonPhrase);
    end;
}