trigger Test_StudentTrigger on Student__c (after delete, after insert, after update, before update) {
    if (Trigger.isInsert) {
        if (Trigger.isAfter) {
            Test_StudentTriggerHandler.afterInsertHandler(Trigger.new);
        }
    }

    if (Trigger.isDelete) {
        if (Trigger.isAfter) {
            Test_StudentTriggerHandler.afterDeleteHandeler(Trigger.old);
        }
    }

    if (Trigger.isUpdate) {
        if (Trigger.isAfter) {
            Test_StudentTriggerHandler.afterUpdateHandler(Trigger.old, Trigger.new);
        } 
        if (Trigger.isBefore) {
            Test_StudentTriggerHandler.beforeUpdateHandler(Trigger.old, Trigger.new);
        }
    }
}