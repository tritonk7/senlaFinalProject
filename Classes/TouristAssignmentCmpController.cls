public without sharing class TouristAssignmentCmpController {    
    
    @AuraEnabled(cacheable=true)
    public static List<Tourists__c> fetchTourist(String touristsId) {
        if (touristsId == null || String.isBlank(touristsId)) {
            throw new AuraHandledException(Constants.ERROR_MSG_NO_TOURIST_SELECTED);
        }
        
        List<Tourists__c> tourist = TouristManager.getById(touristsId);
        
        return tourist;
    }
    
    @AuraEnabled(cacheable=true)
    public static List<Trip__c> fetchTrips(String touristsId) {
        if (touristsId == null || String.isBlank(touristsId)) {
            throw new AuraHandledException(Constants.ERROR_MSG_NO_TOURIST_SELECTED);
        }
        
        List<Flight__c> flights = FlightManager.getByTouristId(touristsId);
        Set<String> tripIds = new Set<String>();
        
        
        for (Flight__c item : flights) {
            tripIds.add(item.Trip__c);
        }
        
        List<Trip__c> trips = TripManager.tripNotEqualById(tripIds);
        
        return trips;  
    }
    
    @AuraEnabled
    public static List<Flight__c> fetchFlights() {
        return FlightManager.allFlightsForTouristAssignment();
    }
    
    @AuraEnabled
    public static Flight__c createFlight(Id tripId, Id touristId) {
        if (tripId == null) {
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
}