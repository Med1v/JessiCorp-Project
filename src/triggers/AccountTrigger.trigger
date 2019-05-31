trigger AccountTrigger on Account (after delete, after insert, after undelete, after update, before delete, before insert, before update) {
    // Use if statements to handle certain events 
    if (trigger.isBefore) {
    	
    }
    
    if (trigger.isAfter) {
    	
    }
}