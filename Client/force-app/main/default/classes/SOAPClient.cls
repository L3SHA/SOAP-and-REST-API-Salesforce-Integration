global class SOAPClient {
        
    public void sendData(String accountId, String sensorName, Decimal[] line) {
    
        String ACCESS_TOKEN = 'access_token';
        String INSTANCE_URL = 'instance_url';
        
		Map<String, String> authParams = AuthorizationHelper.getAuthTokens();
        
        String accessToken = authParams.get(ACCESS_TOKEN);
        String instanceURL = authParams.get(INSTANCE_URL);
        
        //add access token to soap request
        soapSforceComSchemasClassWebService.SessionHeader_element webserviceSessionHeader = new soapSforceComSchemasClassWebService.SessionHeader_element();  
        webserviceSessionHeader.sessionId = accessToken;
        soapSforceComSchemasClassWebService.WebServiceSensorEventHandler myWebservice = new soapSforceComSchemasClassWebService.WebServiceSensorEventHandler(); 
        myWebservice.SessionHeader = webserviceSessionHeader; 
		myWebService.handleSensorEvent(accountId, sensorName, line);
    }
}