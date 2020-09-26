global class SOAPClient {
        
    public void sendData(String accountId, String sensorName, Decimal[] line) {
    
		STRING GRANT_TYPE = 'password';
    	String CLIENT_ID = '3MVG9n_HvETGhr3B1Nkkz3WEN19IIfPDOn5_4KPJ.KHvhG0d4TArk0YgeuGVLEe4KSDOa1GPS4OuvdItsU631';
    	String CLIENT_SECRET = 'ACE3E16772B6C1E59ADC40BEFEB65A881BD3ED96959C029F5EFE423E00D7F171';
    	String USER_NAME = 'lesha18.02.2001@resourceful-otter-tjq54y.com';
    	String PASSWORD = 'FIFA_2020r3NIRJM1xerlhaffYSW8IeXO';
    	String TOKEN_REQUEST_URL = 'https://login.salesforce.com/services/oauth2/token';
    	String LOG_INFO = 'grant_type=' + GRANT_TYPE +
        			  	  '&client_id=' + CLIENT_ID +
        			  	  '&client_secret=' + CLIENT_SECRET + 
                      	  '&username=' + USER_NAME +
                          '&password=' + PASSWORD;
        String ACCESS_TOKEN = 'access_token';
        String INSTANCE_URL = 'instance_url';
        
		Http client = new Http();
    	HttpRequest request = new HttpRequest();
    	request.setEndpoint(TOKEN_REQUEST_URL);
    	request.setMethod('POST');
		request.setBody(LOG_INFO);   
    	HttpResponse response = client.send(request);
        Map<String, String> authParams = (Map<String, String>)System.JSON.deserialize(response.getBody(), Map<String, String>.class);
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