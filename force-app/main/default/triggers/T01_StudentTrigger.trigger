trigger T01_StudentTrigger on Student__c (before insert, before update, after insert, after delete, after update, before delete) {
    if (Trigger.isBefore) {
        if (Trigger.isInsert || Trigger.isUpdate) {
            T01_StudentTriggerHandler.beforeInsertOrUpdate(Trigger.new);
        }
        if (Trigger.isDelete) {
            T01_StudentTriggerHandler.beforeDelete(Trigger.old);
        }
    }

    if (Trigger.isAfter) {
        if (Trigger.isInsert) {
            T01_StudentTriggerHandler.afterInsert(Trigger.new);
        }
        if (Trigger.isDelete) {
            T01_StudentTriggerHandler.afterDelete(Trigger.old);
        }
        if (Trigger.isUpdate) {
            T01_StudentTriggerHandler.afterUpdate(Trigger.old, Trigger.new);
        }
    }
}