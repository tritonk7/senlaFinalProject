public without sharing class PriceListPDFController {
    
    public List<Tourists__c> touristRecords {get; set;} 
    public List<Trip__c> records {get; set;}
    public List<PriceBookEntry> getPrice {get; set;}
    
    public PriceListPDFController(ApexPages.StandardController stdController) {
        Id touristId = ApexPages.CurrentPage().getparameters().get('id');
        List<Flight__c> flights = FlightManager.getByTouristId(touristId);
        Set<String> tripIds = new Set<String>();
        
        for (Flight__c item : flights) {
            tripIds.add(item.Trip__c);
        }
        
        records = TripManager.tripNotEqualById(tripIds);
        List<String> nameTrips = new List<String>();
        
        for (Trip__c item : records) {
            nameTrips.add(item.Name);
        }
        
        getPrice = PriceBookEntryManager.getByName(nameTrips);
    }
}