namespace Microsoft.Intercompany.CrossEnvironment;

using Microsoft.FinancialMgt.GeneralLedger.Setup;
using Microsoft.Intercompany.Partner;
using System.Environment;
using System.Security.Authentication;

codeunit 560 "CrossIntercompany Connector"
{
    trigger OnRun()
    begin
        StandardExpirationInSeconds := 3599;
        StoreTokenInICPartner := true;
    end;

    var
        StandardExpirationInSeconds: Integer;
        StoreTokenInICPartner: Boolean;
        CrossIntercompanyTok: Label 'CrossEnvironmentIntercompanyToken', Locked = true;
        CrossEnvironmentAPIsPathTok: Label 'microsoft/intercompany/v1.0/companies', Locked = true;
        GeneralAPIsPathTok: Label 'v2.0/companies', Locked = true;
        BCResourceURLScopeTok: Label 'https://api.businesscentral.dynamics.com/.default', Locked = true;

        NonSaaSEnvironmentErr: Label 'This functionality is only available in online environments.';
        HttpErrorMsg: Label 'Error Code: %1, Error Message: %2', Comment = '%1 = Error Code, %2 = Error Message';
        HTTPSuccessMsg: Label 'The HTTP request was successful and the body contains the resource fetched.'; // 200
        HTTPSuccessAndCreatedMsg: Label 'The HTTP request was successful and a new resource was created.'; //201
        HTTPBadRequestMsg: Label 'The HTTP request was incorrectly formed or invalid.'; // 400
        HTTPUnauthorizedMsg: Label 'The HTTP request is not authorized. Authentication credentials are not valid.'; // 401
        HTTPForbiddenMsg: Label 'The HTTP request is forbidden. Missing permissions to access the requested resource.'; // 403
        HTTPNotFoundMsg: Label 'The HTTP request is not found. The requested resource does not exist.'; // 404
        HTTPNotSupportInsertMsg: Label 'The HTTP request is not supported. The requested resource does not support insert.'; // 405
        HTTPInternalServerErrorMsg: Label 'The HTTP request is not successful. An internal server error occurred.'; // 500
        HTTPServiceUnavailableMsg: Label 'The HTTP request is not successful. The service is unavailable.'; // 503
        HTTPGeneralErrMsg: Label 'Something went wrong, try again later.';
        SuccessConnectingToPartnerMsg: Label 'Successfuly connected, the partner %1 is avaialable to be used with intercompany.', Comment = '%1 = IC Partner Code';
        PartnerMissingICSetupErr: Label 'Partner %1 has not completed the information required to use intercompany.', Comment = '%1 = IC Partner Code';
        MissalignmentBetweenNamesErr: Label 'The partner''s company name %1 does not match the name you are introducing for partner %2.', Comment = '%1 = Partner''s Company Name, %2 = IC Partner Name';

    internal procedure TestICPartnerSetup(var TempICPartner: Record "IC Partner" temporary): Boolean
    var
        JsonResponse: JsonArray;
    begin
        StoreTokenInICPartner := false;
        JsonResponse := RequestICPartnerRecordsFromEntityName(TempICPartner, 'intercompanySetup');

        if FindValueFromJsonAttribute(JsonResponse, 'icPartnerCode') = TempICPartner.Code then begin
            Message(SuccessConnectingToPartnerMsg, TempICPartner.Code);
            exit(true);
        end
        else begin
            Message(PartnerMissingICSetupErr, TempICPartner.Code);
            exit(false);
        end;
    end;

    internal procedure FinishICPartnerSetup(var TempICPartner: Record "IC Partner" temporary): Boolean
    var
        GeneralLedgerSetup: Record "General Ledger Setup";
        JsonResponse: JsonArray;
        DisplayName: Text;
        CurrencyCode: Code[10];
    begin
        StoreTokenInICPartner := false;
        JsonResponse := RequestICPartnerCompanyInformation(TempICPartner);

        DisplayName := FindValueFromJsonAttribute(JsonResponse, 'displayName');
        StoreTokenInICPartner := true;
        if DisplayName = TempICPartner.Name then begin
#pragma warning disable AA0139
            CurrencyCode := FindValueFromJsonAttribute(JsonResponse, 'currencyCode');
#pragma warning restore AA0139
            GeneralLedgerSetup.Get();
            if CurrencyCode <> GeneralLedgerSetup."LCY Code" then begin
                TempICPartner."Currency Code" := CurrencyCode;
                TempICPartner.Modify();
            end;
            exit(true);
        end
        else begin
            Message(MissalignmentBetweenNamesErr, DisplayName, TempICPartner.Name);
            exit(false);
        end;
    end;

    [NonDebuggable]
    internal procedure RequestICPartnerRecordsFromEntityName(ICPartner: Record "IC Partner"; EntityName: Text): JsonArray
    var
        QueryURL: Text;
        HttpResponseBodyText: Text;
    begin
        QueryURL := BuildQueryURL(ICPartner, EntityName);
        exit(GetRequest(QueryURL, HttpResponseBodyText, ICPartner));
    end;

    [NonDebuggable]
    internal procedure RequestICPartnerGeneralLedgerSetup(ICPartner: Record "IC Partner"): JsonArray
    var
        QueryURL: Text;
        HttpResponseBodyText: Text;
    begin
        QueryURL := BuildQueryURL(ICPartner, GeneralAPIsPathTok, 'generalLedgerSetup');
        exit(GetRequest(QueryURL, HttpResponseBodyText, ICPartner));
    end;

    [NonDebuggable]
    internal procedure RequestICPartnerCompanyInformation(ICPartner: Record "IC Partner"): JsonArray
    var
        QueryURL: Text;
        HttpResponseBodyText: Text;
    begin
        QueryURL := BuildQueryURL(ICPartner, GeneralAPIsPathTok, 'companyInformation');
        exit(GetRequest(QueryURL, HttpResponseBodyText, ICPartner));
    end;

    [NonDebuggable]
    internal procedure RequestICPartnerBankAccount(ICPartner: Record "IC Partner"): JsonArray
    var
        QueryURL: Text;
        HttpResponseBodyText: Text;
    begin
        QueryURL := BuildQueryURL(ICPartner, GeneralAPIsPathTok, 'bankAccounts');
        exit(GetRequest(QueryURL, HttpResponseBodyText, ICPartner));
    end;

    [NonDebuggable]
    local procedure GetRequest(QueryURL: Text; var HttpResponseBodyText: Text; var ICPartner: Record "IC Partner"): JsonArray
    begin
        Send('GET', QueryURL, '', HttpResponseBodyText, ICPartner);
        exit(ParseArrayData(HttpResponseBodyText));
    end;

    [NonDebuggable]
    procedure SubmitRecordsToICPartnerFromEntityName(ICPartner: Record "IC Partner"; Content: Text; EntityName: Text; JsonFieldKey: Text; JsonFieldExpectedValue: Text): Boolean
    var
        QueryURL: Text;
        HttpResponseBodyText: Text;
        ResultResponse: JsonObject;
        AttributeJsonToken: JsonToken;
    begin
        QueryURL := BuildQueryURL(ICPartner, EntityName);
        ResultResponse := PostRequest(QueryURL, Content, HttpResponseBodyText, ICPartner);
        ResultResponse.Get(JsonFieldKey, AttributeJsonToken);
        exit(AttributeJsonToken.AsValue().AsText() = JsonFieldExpectedValue);
    end;

    [NonDebuggable]
    procedure SubmitJobQueueEntryToICPartner(ICPartner: Record "IC Partner"; Content: Text; JsonFieldKey: Text; JsonFieldExpectedValue: Text): Boolean
    var
        QueryURL: Text;
        HttpResponseBodyText: Text;
        ResultResponse: JsonObject;
        AttributeJsonToken: JsonToken;
    begin
        QueryURL := BuildQueryURL(ICPartner, CrossEnvironmentAPIsPathTok, 'jobQueueEntry');
        ResultResponse := PostRequest(QueryURL, Content, HttpResponseBodyText, ICPartner);
        ResultResponse.Get(JsonFieldKey, AttributeJsonToken);
        exit(AttributeJsonToken.AsValue().AsText() = JsonFieldExpectedValue);
    end;

    [NonDebuggable]
    local procedure PostRequest(QueryURL: Text; Content: Text; var HttpResponseBodyText: Text; var ICPartner: Record "IC Partner"): JsonObject
    begin
        Send('POST', QueryURL, Content, HttpResponseBodyText, ICPartner);
        exit(ParseObjectData(HttpResponseBodyText));
    end;

    [TryFunction]
    [NonDebuggable]
    internal procedure Send(Method: Text; Uri: Text; Content: Text; var HttpResponseBodyText: Text; var ICPartner: Record "IC Partner")
    var
        HttpClient: HttpClient;
        HttpRequestMessage: HttpRequestMessage;
        HttpResponseMessage: HttpResponseMessage;
    begin
        HttpRequestMessage.Method(Method);
        HttpRequestMessage.SetRequestUri(Uri);
        PrepareHeaders(HttpRequestMessage, ICPartner);
        PrepareContent(HttpRequestMessage, Content);

        HttpClient.Send(HttpRequestMessage, HttpResponseMessage);
        HttpResponseMessage.Content().ReadAs(HttpResponseBodyText);
        HandleHttpResponse(HttpResponseMessage);
    end;

    [NonDebuggable]
    local procedure PrepareHeaders(HttpRequestMessage: HttpRequestMessage; var ICPartner: Record "IC Partner")
    var
        HttpRequestHeaders: HttpHeaders;
    begin
        HttpRequestMessage.GetHeaders(HttpRequestHeaders);

        HttpRequestHeaders.Add('Accept', 'application/json');
        HttpRequestHeaders.Add('Authorization', 'Bearer ' + GetBearerAccessToken(ICPartner));
    end;

    [NonDebuggable]
    local procedure PrepareContent(HttpRequestMessage: HttpRequestMessage; Content: Text)
    var
        HttpContent: HttpContent;
        HttpContentHeaders: HttpHeaders;
    begin
        if Content = '' then
            exit;

        HttpContent.GetHeaders(HttpContentHeaders);
        HttpContent.WriteFrom(Content);
        HttpContentHeaders.Remove('Content-Type');
        HttpContentHeaders.Add('Content-Type', 'application/json');
        HttpRequestMessage.Content(HttpContent);
    end;

    local procedure HandleHttpResponse(HttpResponseMessage: HttpResponseMessage)
    var
        FriendlyErrorMsg, ErrorMsg : Text;
    begin
        case HttpResponseMessage.HttpStatusCode() of
            200:
                begin
                    Session.LogMessage('0000KZE', HTTPSuccessMsg, Verbosity::Normal, DataClassification::SystemMetadata, TelemetryScope::ExtensionPublisher, 'Category', CrossIntercompanyTok);
                    exit;
                end;
            201:
                begin
                    Session.LogMessage('0000KZF', HTTPSuccessAndCreatedMsg, Verbosity::Normal, DataClassification::SystemMetadata, TelemetryScope::ExtensionPublisher, 'Category', CrossIntercompanyTok);
                    exit;
                end;
            400:
                FriendlyErrorMsg := HTTPBadRequestMsg;
            401:
                FriendlyErrorMsg := HTTPUnauthorizedMsg;
            403:
                FriendlyErrorMsg := HTTPForbiddenMsg;
            404:
                FriendlyErrorMsg := HTTPNotFoundMsg;
            405:
                FriendlyErrorMsg := HTTPNotSupportInsertMsg;
            500:
                FriendlyErrorMsg := HTTPInternalServerErrorMsg;
            503:
                FriendlyErrorMsg := HTTPServiceUnavailableMsg;
            else
                FriendlyErrorMsg := HTTPGeneralErrMsg;
        end;

        HttpResponseMessage.Content().ReadAs(ErrorMsg);
        Session.LogMessage('0000KZG', StrSubstNo(HttpErrorMsg, HttpResponseMessage.HttpStatusCode(), ErrorMsg), Verbosity::Error, DataClassification::SystemMetadata, TelemetryScope::ExtensionPublisher, 'Category', CrossIntercompanyTok);
        Error(FriendlyErrorMsg);
    end;

    [NonDebuggable]
    internal procedure GetBearerAccessToken(var ICPartner: Record "IC Partner"): Text
    var
        Token: Text;
    begin
        if (ICPartner."Token Expiration Time" <= CurrentDateTime) then begin
            Token := AcquireBearerAccessToken(ICPartner);
            if StoreTokenInICPartner then begin
                ICPartner.SetSecret(ICPartner."Token Key", Token);
                ICPartner."Token Expiration Time" := CurrentDateTime + StandardExpirationInSeconds;
                ICPartner.Modify();
            end
        end
        else
            Token := ICPartner.GetSecret(ICPartner."Token Key");
        exit(Token);
    end;

    [NonDebuggable]
    internal procedure AcquireBearerAccessToken(var ICPartner: Record "IC Partner"): Text
    var
        EnvironmentInformation: Codeunit "Environment Information";
        OAuth2: Codeunit OAuth2;
        Scopes: List of [Text];
        ClientId, ClientSecret, AuthorityURL, RedirectURL : Text;
        BearerAccessToken: Text;
    begin
        if not EnvironmentInformation.IsSaaSInfrastructure() then
            Error(NonSaaSEnvironmentErr);

        ClientId := ICPartner.GetSecret(ICPartner."Client Id Key");
        ClientSecret := ICPartner.GetSecret(ICPartner."Client Secret Key");
        AuthorityURL := ICPartner.GetSecret(ICPartner."Authority URL Key");
        RedirectURL := ICPartner.GetSecret(ICPartner."Redirect URL Key");
        Scopes.Add(BCResourceURLScopeTok);

        OAuth2.AcquireTokenWithClientCredentials(ClientId, ClientSecret, AuthorityUrl, RedirectURL, Scopes, BearerAccessToken);

        exit(BearerAccessToken);
    end;

    #region Auxiliar methods
    local procedure ParseArrayData(Response: Text): JsonArray
    var
        JsonObject: JsonObject;
        JsonToken: JsonToken;
    begin
        JsonObject.ReadFrom(Response);
        JsonObject.Get('value', JsonToken);
        exit(JsonToken.AsArray());
    end;

    local procedure ParseObjectData(Response: Text): JsonObject
    var
        JsonObject: JsonObject;
    begin
        JsonObject.ReadFrom(Response);
        exit(JsonObject);
    end;

    local procedure FindValueFromJsonAttribute(JsonInput: JsonArray; JsonKey: Text): Text
    var
        IndividualToken: JsonToken;
        AttributeJsonToken: JsonToken;
    begin
        foreach IndividualToken in JsonInput do begin
            IndividualToken.AsObject().Get(JsonKey, AttributeJsonToken);
            exit(AttributeJsonToken.AsValue().AsText());
        end;
    end;

    [NonDebuggable]
    local procedure BuildQueryURL(ICPartner: Record "IC Partner"; EntityName: Text): Text
    begin
        exit(BuildQueryURL(ICPartner, CrossEnvironmentAPIsPathTok, EntityName));
    end;

    [NonDebuggable]
    local procedure BuildQueryURL(ICPartner: Record "IC Partner"; APIPath: Text; EntityName: Text): Text
    begin
        exit(ICPartner.GetSecret(ICPartner."Connection Url Key") + APIPath + '(' + RemoveCurlyBracketsAndUpperCases(ICPartner.GetSecret(ICPartner."Company Id Key")) + ')/' + EntityName);
    end;

    [NonDebuggable]
    internal procedure RemoveCurlyBracketsAndUpperCases(Input: Guid): Text
    begin
        exit(LowerCase(DelChr(Input, '=', '{}')));
    end;
    #endregion
}
