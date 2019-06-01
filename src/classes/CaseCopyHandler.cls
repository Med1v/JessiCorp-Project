public with sharing class CaseCopyHandler {
    
    public static List<Id> casesToCopycId = new List<Id>();
    
    public static void toCopyOrNot(List<Case> newCases) {
    	for (Case c : newCases) {
    		if (c.CopyFromId__c != Null) {
    			casesToCopycId.add(c.CopyFromId__c);
    		}
    	}
    }
    
    @Future
    public static void copyAttachments() {
    	List<Case> cases = [SELECT Id, CopyFromId__c FROM CASE WHERE CopyFromId__c IN :casesToCopycId];
    	List<Attachment> attchs = [SELECT Id,
                              Body,
                              Name,
                              Description,
                              ParentId
                              FROM Attachment
                              WHERE ParentId IN :casesToCopycId];
		
		List<Attachment> attToInsert = new List<Attachment>();
		for (Case c : cases) {
			for (Attachment a : attchs) {
				if (a.ParentId == c.CopyFromId__c) {
					Attachment newa = a.clone();
					a.ParentId = c.Id;
					attToInsert.add(newa);
				}
			}
		}
		insert attToInsert;
    }
}