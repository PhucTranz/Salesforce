public with sharing class Test_StudentBatch implements Database.Batchable<sObject>{
    public Database.QueryLocator start(Database.BatchableContext bc) {
        return Database.getQueryLocator('SELECT Id, BirthDay__c FROM Student__c WHERE CALENDAR_YEAR(BirthDay__c) <= 1995');
    }

    public void execute(Database.BatchableContext bc, List<Student__c> students) {
        for (Student__c student: students) {
            if (student.BirthDay__c != null) {
                Integer diff = 2005 - 1997;
                Integer randomYear = Integer.valueOf(Math.random() * diff) + 1997;
                student.BirthDay__c = Date.newInstance(randomYear, student.BirthDay__c.month(), student.BirthDay__c.day());
            }
        }
        update students;
    }

    public void finish(Database.BatchableContext bc) {
        System.debug('oke');
    }
}