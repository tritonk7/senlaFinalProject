public without sharing class TouristAssignmentCmpController {    
    
    @AuraEnabled(cacheable=true)
    public static List<Tourists__c> fetchTourist(String touristsId) {
        List<Tourists__c> tourist = TouristManager.getById(touristsId);
        
        return tourist;
    }
    
    @AuraEnabled(cacheable=true)
    public static List<Trip__c> fetchTrips(String touristsId) {
        List<Flight__c> flights = FlightManager.getByTouristId(touristsId);
        
        List<Trip__c> trips = TripManager.getAllTripValidDate();
        
        Set<String> tripsId = new Set<String>();
        
        for (Trip__c value : trips) {
            
            for (Flight__c item : flights) {
                
                if((value.Start_Data__c <= item.Trip__r.End_Date__c) && (item.Trip__r.Start_Data__c <= value.End_Date__c)){
                    tripsId.add(value.Id);
                }
            }
        }
        
        List<Trip__c> returnTrips = TripManager.tripNotEqualById(tripsId);
 
        return returnTrips;  
    }
    
    @AuraEnabled
    public static List<Flight__c> fetchFlights() {
        return FlightManager.allFlightsForTouristAssignment();
    }
    
    @AuraEnabled
    public static Flight__c createFlight(Id tripId, Id touristId) {
        if (touristId == null) {
            throw new AuraHandledException(Constants.ERROR_MSG_NO_TOURIST_SELECTED);
        }
        Flight__c flightToInsert  = new Flight__c();
        
        try {
            Flight__c flight = new Flight__c(
                New_Tourist__c = touristId,
                Trip__c = tripId,
                Status__c = Constants.FLIGHT_STATUS_REQUESTED
            );
            flightToInsert = flight;
        } catch(Exception ex) {
            throw new AuraHandledException(Constants.ERROR_CONTACT_SYSTEM_ADMINISTRATOR);
        }
        
        insert flightToInsert;
        
        return flightToInsert;
    }
    
    @AuraEnabled(cacheable=true)
    public static List<Weather_Daily_Forecast__c> fetchWeather() {
        return WeatherDailyForecastManager.getTodayWeather();
    }
