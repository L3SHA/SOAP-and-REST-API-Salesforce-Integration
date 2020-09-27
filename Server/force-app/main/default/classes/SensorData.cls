public with sharing class SensorData {

    public String accountId {get;set;}
    public String sensorId {get;set;}
    public Decimal[] line {get;set;}

    public SensorData(String accountId, String sensorId, Decimal[] line) {
        this.accountId = accountId;
        this.sensorId = sensorId;
        this.line = line;
    }
}