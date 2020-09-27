@RestResource(urlMapping='/putEvents')
global with sharing class RESTSensorEventHandler {
    @HttpPut
    global static void putSensorEventData() {
        SensorData sensorData = (SensorData) JSON.deserialize(RestContext.request.requestBody.toString(), SensorData.class);
        SensorEventHandlerHelper.processEvents(sensorData.accountId, sensorData.sensorId, sensorData.line);
    }
}