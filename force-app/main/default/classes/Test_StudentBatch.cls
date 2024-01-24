public with sharing class Test_StudentBatch implements Database.Batchable<sObject>{
    public Database.QueryLocator start(Database.BatchableContext bc) {
        return Database.getQueryLocator('SELECT Id, Class_look__c FROM Student__c');
    }

    public void execute(Database.BatchableContext bc, List<Student__c> students) {
        // for (Student__c student: students) {
        //     if (student.Class_look__c != null) {
        //         student.Class_look__c = student.Class_look__c;
        //     }
        // }
        // update students;
    }

    public void finish(Database.BatchableContext bc) {
        System.debug('oke');
    }
}