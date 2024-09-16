codeunit 50800 "Api management"
{
    procedure Getcurrency()
    var
        // myInt: Integer;
        HTTPcilent: HttpClient;
        HttpResponse: HttpResponseMessage;
        HttpRequest: HttpRequestMessage;
        jsonObj: JsonObject;
        JsonToken: JsonToken;
        JSonarray: JsonArray;
        jsonText: text;
        i: Integer;
        currency: Record "Currency Rate";
        url: Text;
        j: Integer;

    begin
        url := 'https://www.nrb.org.np/api/forex/v1/rates?page=1&per_page=100&from=2023-02-12&to=2023-02-12';
        if not HTTPcilent.Get(url, HttpResponse) then
            Error('Call to the web service failed');

        if not HttpResponse.IsSuccessStatusCode then
            Error('The web service returned an error message:\\' +
                   'Status code: %1\' +
                   'Description: %2',
            HttpResponse.HttpStatusCode,
            HttpResponse.ReasonPhrase);
        HttpResponse.Content.ReadAs(JsonText);

        if not jsonObj.ReadFrom(JsonText) then
            Error('Invalid response, expected a JSON object');

        //Message(jsonText);
        jsonObj.Get('data', JsonToken);  //gets the object data from the result
        JsonObj.ReadFrom(Format(JsonToken));
        // Message(Format(jsonObj));
        jsonObj.get('payload', JsonToken);//get payload array from json object
        JSonarray.ReadFrom(Format(JsonToken));
        currency.DeleteAll();
        Message('Sucessfully delete Older data');
        for i := 0 to JsonArray.Count - 1 do begin //looping through array 

            JSonarray.Get(i, JsonToken);//gets value in JToken from each itrative objects as we can see in postman
            JsonObj := JsonToken.AsObject(); //since out JArray converts each itation objects so we pass it into Jobject
            jsonObj.Get('rates', JsonToken);
            JSonarray.ReadFrom(Format(JsonToken));

            for j := 0 to JSonarray.Count() - 1 do begin

                JSonarray.Get(j, JsonToken);
                jsonObj := JsonToken.AsObject();
                currency."Buying Rate" := getToken('buy', jsonObj).AsValue().AsDecimal();
                currency."selling Rate" := getToken('sell', jsonObj).AsValue().AsDecimal();
                jsonObj.Get('currency', JsonToken);
                jsonObj.ReadFrom(Format(JsonToken));
                //Message(Format(jsonObj));
                currency."Currency Symb" := getToken('iso3', jsonObj).AsValue().AsCode();
                currency."Currency name" := getToken('name', jsonObj).AsValue().AsText();
                currency.Unit := getToken('unit', jsonObj).AsValue().AsDecimal();
                currency.Insert(true);

            end;
            Message('New data updated');

        end;

    end;

    procedure getToken(keyVal: Text; JObj: JsonObject) JT: JsonToken
    var
    begin
        JObj.Get(keyVal, JT)
    end;
}
