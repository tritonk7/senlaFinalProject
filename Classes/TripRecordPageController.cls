public without sharing class TripRecordPageController {
    
    @AuraEnabled(cacheable=true) 
    public static List<Tourists__c> fetchTourists(String tripId) {
        if (tripId == null) {
            throw new AuraHandledException(Constants.ERROR_MSG_TRIP_NOT_SELECTED);
        }
        
        Trip__c trip = TripManager.tripById(tripId);
        List<Flight__c> flight = FlightManager.allFlights();
        List<String> touristsId = new List<String>();
        
        try {
            for (Flight__c value : flight) {
                if((value.Trip__r.Start_Data__c <= trip.End_Date__c) && (trip.Start_Data__c <= value.Trip__r.End_Date__c)){
                    touristsId.add(value.New_Tourist__c);
                }
            }
        } catch(Exception ex) {
            throw new AuraHandledException(Constants.ERROR_CONTACT_SYSTEM_ADMINISTRATOR);
        }
        
        List<Tourists__c> tourists = TouristManager.getByNotMatchId(touristsId,trip.Mininmum_Age__c);
        
        return tourists;
    }
    
    @AuraEnabled
    public static List<Flight__c> saveFlight (String tripId, List<String> touristIds) {
        if (touristIds == null || touristIds.isEmpty()) {
            throw new AuraHandledException(Constants.ERROR_MSG_NO_TOURIST_SELECTED);
        }
        
        List<Flight__c> flights = new List<Flight__c>();
        List<Tourists__c> tourists = TouristManager.getByIdsForAura(touristIds);
        Trip__c trip = TripManager.tripById(tripId);
        List<Flight__c> checkflights = FlightManager.getByTripId(tripId);
        
        Decimal freeSeats = trip.Seats__c - checkflights.size();
        
        try {
            for (Tourists__c tourist : tourists) {
                if (tourists.size() <= trip.Seats__c && freeSeats >= tourists.size() && trip.Start_Data__c > Date.today()) {
                    Flight__c flight = new Flight__c(
                        New_Tourist__c = tourist.Id,
                        Status__c = Constants.FLIGHT_STATUS_OFFER_PENDING,
                        Trip__c = tripId);
                    flights.add(flight);
                } else {
                    return new List<Flight__c>();
                }
            }
        } catch(Exception ex) {
            throw new AuraHandledException(Constants.ERROR_CONTACT_SYSTEM_ADMINISTRATOR);
        }
        insert flights;
        
        return flights;
    }
    
    @AuraEnabled(cacheable=true) 
    public static Decimal getSeats (String tripId) {
        if (tripId == null) {
            throw new AuraHandledException(Constants.ERROR_MSG_TRIP_NOT_SELECTED);
        }
        Trip__c trip = TripManager.tripById(tripId);
        List<Flight__c> checkflights = FlightManager.getByTripId(tripId);
        Decimal freeSeats = trip.Seats__c - checkflights.size();
        
        return freeSeats;
    }
    
    @AuraEnabled(cacheable=true) 
    public static Date getStartDate (String tripId) {
        if (tripId == null) {
            throw new AuraHandledException(Constants.ERROR_MSG_TRIP_NOT_SELECTED);
        }
        Trip__c trip = TripManager.tripById(tripId);
        Date StartDate = trip.Start_Data__c;
        
        return StartDate;
    }
}
