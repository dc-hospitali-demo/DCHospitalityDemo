/**
* @description : This class handles the logic for displaying the recent and dining bookings based on contact Id input.
* @date        : December 26, 2024
*/

public with sharing class ActivityFeedController {
     @AuraEnabled(cacheable=true)
     public static List<Booking__dlm> GetRecentBookings(Id contactId)
     { 
         System.debug('the contact id is:'+ contactId);
     return [SELECT Id, Experience_Name__c, Booking_Date__c,Start_Time__c,End_Time__c FROM Booking__dlm WHERE Contact_c__c =: contactId ORDER BY Booking_Date__c DESC LIMIT 1];
     }
    
    @AuraEnabled(cacheable=true)
     public static List<Booking__dlm> GetDiningBookings(Id contactId)
     { 
         System.debug('the contact id is:'+ contactId);
     return [SELECT Id, Experience_Name__c, Booking_Date__c FROM Booking__dlm WHERE Contact_c__c =: contactId AND Type__c = 'Dining Experiences' ORDER BY Booking_Date__c DESC LIMIT 1];
     }
}