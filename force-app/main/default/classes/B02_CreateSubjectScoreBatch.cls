public without sharing class B02_CreateSubjectScoreBatch implements Database.Batchable<sObject> {
    public Database.QueryLocator start(Database.BatchableContext bc) {
        return Database.getQueryLocator('SELECT Id FROM SubjectScore__c');
    }

    public void execute(Database.BatchableContext bc, List<SubjectScore__c> subjectScores) {
    }

    public void finish(Database.BatchableContext bc) {
    }
}