public class RESTClient {

    public static void sendData(String accountId, String sensorId, Decimal[] line) {
        
        String ACCESS_TOKEN = 'access_token';
        String INSTANCE_URL = 'instance_url';
        
		Map<String, String> authParams = AuthorizationHelper.getAuthTokens();
        
        String accessToken = authParams.get(ACCESS_TOKEN);
        String instanceURL = authParams.get(INSTANCE_URL);
        
    	SensorData sensorData = new SensorData(accountId, sensorId, line);
        Http http = new Http();
        HttpRequest request = new HttpRequest();  
        request.setEndpoint('https://resourceful-otter-tjq54y-dev-ed.my.salesforce.com/services/apexrest/putEvents');  
        request.setMethod('PUT');    
        request.setHeader('Content-Type', 'application/json');
        request.setHeader('Authorization', 'Bearer ' + accessToken);
        System.debug(JSON.serialize(sensorData));
        request.setBody(JSON.serialize(sensorData));    

        HttpResponse response = http.send(request);
        
        System.debug(response.getStatusCode() + response.getStatus());
    }
        
}