public class CreateTourist {
    
    @AuraEnabled
    public static Tourists__c submitScoreAction(String cardName, Date cardBirthday, String cardEmail, String cardGender){
        Tourists__c scoreCardObj = new Tourists__c();
        scoreCardObj.Name = cardName;
        scoreCardObj.Birthday__c = cardBirthday;
        scoreCardObj.Tourist_Email__c = cardEmail;
        scoreCardObj.Gender__c = cardGender;
        
        insert scoreCardObj;
        return scoreCardObj;
    }
}