public with sharing class SensorEventHandlerHelper {
    public static void processEvents(String accId, String sensorName, Decimal[] line) {
        Id accountId = Id.ValueOf(accId);
        
        Sensor__c sensor;
        
        if ([SELECT count() FROM Sensor__c WHERE (Sensor__c.Account_Id__c =: accountId AND Sensor__c.Name =: sensorName)] == 0) {
            sensor = new Sensor__c(Name = sensorName, Account_Id__c = accountId);
            insert sensor;
        } 
        else {
            sensor = [SELECT Account_Id__c, Name FROM Sensor__c WHERE (Sensor__c.Account_Id__c =: accountId AND Sensor__c.Name =: sensorName)];
        }

        Sensor_Event__c previousEvent; 
        
        if ([SELECT count() FROM Sensor_Event__c WHERE Next_Event__c = null AND Sensor__r.Name =: sensorName] == 0) {
            previousEvent = null;
        }
        else {
            previousEvent = [SELECT Sensor__c, Next_Event__c FROM Sensor_Event__c WHERE (Next_Event__c = null AND Sensor__r.Name =: sensorName)];
        }

        Sensor_Event__c newEvent;

        List<Sensor_Event__c> eventsList = new List<Sensor_Event__c>();

        for(Integer i = 0; i < line.size(); i += 3) {
            newEvent = new Sensor_Event__c(
                Sensor__c = sensor.Id,
                Previous_Event__c = previousEvent == null ? null : previousEvent.Id,
                X__c = line[i],
                Y__c = line[i + 1],
                Z__c = line[i + 2]
            );
            if(previousEvent != null) {
                previousEvent.Next_Event__c = newEvent.Id;
                if(i == 0) {
                    eventsList.Add(previousEvent);
                }
            }
            eventsList.Add(newEvent);
            previousEvent = newEvent; 
        }

        upsert eventsList;
    }
}