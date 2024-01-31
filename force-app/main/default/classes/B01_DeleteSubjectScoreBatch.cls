/**
 * クラス名：B01_DeleteSubjectScoreBatch
 * クラス概要：Batch delete subjectscore
 * @created：2024/01/25 Tran Dinh Phuc
 * @modified：
 */
public without sharing class B01_DeleteSubjectScoreBatch implements Database.Batchable<sObject>, Database.Stateful {
    Batchlog__c batchLog;
    
    /**
     * start
     * @param：Database.BatchableContext bc
     * @return：Database.QueryLocator
     * @created：2024/01/25 Tran Dinh Phuc
     * @modified：
     */
    public Database.QueryLocator start(Database.BatchableContext bc) {
        batchLog = new Batchlog__c(Name = 'B01_科目得点削除バッチ', StartTime__c =  System.now());
        return Database.getQueryLocator('SELECT Id FROM SubjectScore__c');
    }

    /**
     * execute
     * @param：Database.BatchableContext bc
     * @param: List<SubjectScore__c> subjectScores
     * @return：なし
     * @created：2024/01/25 Tran Dinh Phuc
     * @modified：
     */
    public void execute(Database.BatchableContext bc, List<SubjectScore__c> subjectScores) {
        delete subjectScores;
    }

    /**
     * finish
     * @param：Database.BatchableContext bc
     * @return：なし
     * @created：2024/01/25 Tran Dinh Phuc
     * @modified：
     */
    public void finish(Database.BatchableContext bc) {
        try {
            AsyncApexJob job = [SELECT Id, NumberOfErrors, ExtendedStatus FROM AsyncApexJob WHERE Id = :bc.getJobId()];
            
            if(job.NumberOfErrors > 0) {
                batchLog.Result__c = 'Error';
                batchLog.ErrorMessage__c = job.ExtendedStatus;
            } else {
                batchLog.Result__c = 'Success';
                B02_CreateSubjectScoreBatch b = new B02_CreateSubjectScoreBatch();
                Database.executeBatch(b);
            }

            batchLog.EndTime__c =  System.now();
            insert batchLog;
        } catch (Exception e) {
            batchLog.Result__c = 'Error';
            batchLog.ErrorMessage__c = e.getMessage();
            insert batchLog;
        }
    }
}