public with sharing class Test_ClassBatch implements Database.Batchable<sObject>{
    public Database.QueryLocator start(Database.BatchableContext bc) {
        return Database.getQueryLocator('SELECT Id, ClassCode__c FROM Class__c ORDER BY ClassCode__c DESC LIMIT 1');
    }

    public void execute(Database.BatchableContext bc, List<Class__c> classes) {
        Integer classCode = 0;
        if (!classes.isEmpty()) {
            Class__c cl = classes[0];
            classCode = Integer.valueOf(cl.ClassCode__c);
        }

        List<Class__c> newClasses = new List<Class__c>();
        for (Integer i = classCode + 1; i <= classCode + 3; i++) {
            Class__c newClass = new Class__c(Name = 'Lớp '+i, NumberOfStudent__c = 0);
            newClasses.add(newClass);
        }

        insert newClasses;
    }

    public void finish(Database.BatchableContext bc) {
        System.debug('oke');
    }
}