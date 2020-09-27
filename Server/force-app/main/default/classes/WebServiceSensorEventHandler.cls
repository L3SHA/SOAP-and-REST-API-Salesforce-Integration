global class WebServiceSensorEventHandler {

    webService static void handleSensorEvent(ID accountId, String sensorName, Decimal[] line)
    {
        SensorEventHandlerHelper.processEvents(accountId, sensorName, line);
    }
}