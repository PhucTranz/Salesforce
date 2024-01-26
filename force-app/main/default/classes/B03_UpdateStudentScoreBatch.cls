public without sharing class B03_UpdateStudentScoreBatch implements Database.Batchable<sObject>, Database.Stateful {
    Batchlog__c batchLog;

    public Database.QueryLocator start(Database.BatchableContext bc) {
        batchLog = new Batchlog__c(Name = 'B03_学生得点更新バッチ', StartTime__c =  System.now());
        return Database.getQueryLocator('SELECT Id FROM Student__c WHERE LearningStatus__c = \'Enrolled\'');
    }

    public void execute(Database.BatchableContext bc, List<Student__c> students) {
        List<Semester__c> semesters = [SELECT Id FROM Semester__c];
         
    }
}