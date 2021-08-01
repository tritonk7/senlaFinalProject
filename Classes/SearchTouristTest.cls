@isTest
private class SearchTouristTest {
    
    @isTest
    public static void testSearchTourists() {
        TestDataFactory.createTrip();
        List<Trip__c> trip = TestDataFactory.getTrips();
        System.assertEquals(1, trip.size());
        SearchTourist testcls = new SearchTourist();
       // List<Trip__c> checkTrip = testcls().searchTourists(trip);
        System.assertEquals(1, Trip.size());
        
    }

}