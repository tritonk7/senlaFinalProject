public class TripManager {
    
    public static Trip__c tripById(String tripId) {
        if (tripId == null || String.isBlank(tripId)) {
            return new Trip__c();
        }        
        return [
            SELECT Id,
            Mininmum_Age__c,
            Start_Data__c,
            End_Date__c,
            Seats__c
            FROM Trip__c
            WHERE Id = :tripId
        ]; 
    }
    
    public static List<Trip__c> tripNotEqualById(Set<String> tripIds) {
        return [
            SELECT Id,
            Start_Data__c,
            End_Date__c,
            Departure_Space_Point__r.City__c,
            Departure_Space_Point__r.Name,
            Name,
            Mininmum_Age__c,
            Seats__c
            FROM Trip__c
            WHERE Id != :tripIds
            AND Start_Data__c > :Date.today()
            ORDER BY Name
        ];
    }
    public static List<Trip__c> tripNotEqualByIdGetByTouristAge(Set<String> tripIds, Decimal touristAge) {
        return [
            SELECT Id,
            Start_Data__c,
            End_Date__c,
            Departure_Space_Point__r.City__c,
            Departure_Space_Point__r.Name,
            Name,
            Mininmum_Age__c,
            Seats__c
            FROM Trip__c
            WHERE Id != :tripIds
            AND Start_Data__c > :Date.today()
            AND Mininmum_Age__c <= :touristAge
            ORDER BY Name
        ];
    }
    
     public static List<Trip__c> tripsById(Set<String> tripsId) {
        return [
            SELECT Id,
            Mininmum_Age__c,
            Start_Data__c,
            End_Date__c,
            Seats__c
            FROM Trip__c
            WHERE Id = :tripsId
        ]; 
    }
    
     public static List<Trip__c> getAllTripValidDate() {
         
        return [
            SELECT Id,
            Name,
            Mininmum_Age__c,
            Start_Data__c,
            End_Date__c,
            Seats__c
            FROM Trip__c
            WHERE Start_Data__c > :Date.today()
        ]; 
    }
    
    public static List<Trip__c> getTrips(Set<String> ids) {
        return [
            SELECT Id,
            Name,
            Mininmum_Age__c,
            Start_Data__c,
            End_Date__c,
            Seats__c
            FROM Trip__c
            WHERE Id = :ids
        ]; 
    }
}
