public class PriceBookEntryManager {
    
    public static List<PriceBookEntry> getByName(List<String> nameTrips) {
        return [
            SELECT Name,
            UnitPrice
            FROM PriceBookEntry
            WHERE Name = :nameTrips
        ];
    }
    
}