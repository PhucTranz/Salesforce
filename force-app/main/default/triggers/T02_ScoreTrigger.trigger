trigger T02_ScoreTrigger on Score__c (after insert, after update) {
    if (Trigger.isAfter) {
        if (Trigger.isInsert || Trigger.isUpdate) {
            T02_ScoreTriggerHandler.updateSubjectScore(Trigger.new);
        }
    }
}