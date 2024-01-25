public without sharing class B01_DeleteSubjectScoreBatch implements Database.Batchable<sObject>, Database.Stateful {
    Batchlog__c batchLog;

    public Database.QueryLocator start(Database.BatchableContext bc) {
        batchLog = new Batchlog__c(Name = 'B01_科目得点削除バッチ', StartTime__c =  System.now());
        return Database.getQueryLocator('SELECT Id FROM SubjectScore__c');
    }

    public void execute(Database.BatchableContext bc, List<SubjectScore__c> subjectScores) {
        try {
            delete subjectScores;
        } catch (Exception e) {
            batchLog.ErrorMessage__c = e.getMessage();
        }
    }

    public void finish(Database.BatchableContext bc) {
        AsyncApexJob job = [SELECT Id, NumberOfErrors FROM AsyncApexJob WHERE Id = :bc.getJobId()];
        if(job.NumberOfErrors > 0) {
            batchLog.Result__c = 'Error';
        } else {
            batchLog.Result__c = 'Success';
            B02_CreateSubjectScoreBatch b = new B02_CreateSubjectScoreBatch();
            Database.executeBatch(b);
        }
        batchLog.EndTime__c =  System.now();
        insert batchLog;
    }
}