public without sharing class B03_UpdateStudentScoreBatch implements Database.Batchable<sObject>, Database.Stateful {
    Batchlog__c batchLog;

    public Database.QueryLocator start(Database.BatchableContext bc) {
        batchLog = new Batchlog__c(Name = 'B03_学生得点更新バッチ', StartTime__c =  System.now());
        return Database.getQueryLocator('SELECT Id FROM Student__c WHERE LearningStatus__c = \'Enrolled\'');
    }

    public void execute(Database.BatchableContext bc, List<Student__c> students) {
        Map<Id, Student__c> studentMap = new Map<Id, Student__c>(students);

        List<SubjectScore__c> subjectScores = [SELECT Id, 
                                                Student_look__c, 
                                                Subject_look__c, 
                                                Subject_look__r.CourseCredit__c,
                                                AverageScore__c
                                                FROM SubjectScore__c
                                                WHERE Student_look__c = :studentMap.keySet()
                                                ORDER BY Student_look__r.Name, Subject_look__r.Name, AverageScore__c DESC];
        
        Map<String, Decimal> filterSubjectScore = new Map<String, Decimal>();
        Map<String, Decimal> totalCreditMap = new Map<String, Decimal>();
        Map<String, Decimal> totalScoreMap = new Map<String, Decimal>();
        for (SubjectScore__c subjectScore: subjectScores) {
            String key = subjectScore.Student_look__c + '-' + subjectScore.Subject_look__c;

            if (!totalCreditMap.containsKey(subjectScore.Student_look__c)) {
                totalCreditMap.put(subjectScore.Student_look__c, 0);
                totalScoreMap.put(subjectScore.Student_look__c, 0);
            }

            
            Decimal credit = subjectScore.Subject_look__r.CourseCredit__c;
            if (filterSubjectScore.containsKey(key)) {
                if (filterSubjectScore.get(key) < subjectScore.AverageScore__c) {
                    Decimal totalScore = totalScoreMap.get(subjectScore.Student_look__c) - (filterSubjectScore.get(key) - subjectScore.AverageScore__c)*credit;
                    totalScoreMap.put(subjectScore.Student_look__c, totalScore);
                    filterSubjectScore.put(key, subjectScore.AverageScore__c);
                }
            } else {
                filterSubjectScore.put(key,subjectScore.AverageScore__c);
                Decimal totalCredit = totalCreditMap.get(subjectScore.Student_look__c) + credit;
                totalCreditMap.put(subjectScore.Student_look__c, totalCredit);
                Decimal totalScore = totalScoreMap.get(subjectScore.Student_look__c) + subjectScore.AverageScore__c*credit;
                totalScoreMap.put(subjectScore.Student_look__c, totalScore);
            }
        }

        for (String key: totalScoreMap.keySet()) {
            Decimal gpa = (totalScoreMap.get(key)/totalCreditMap.get(key)).setScale(2, System.RoundingMode.HALF_UP);
            studentMap.get(key).GPAScore__c = gpa; 
            studentMap.get(key).TotalCredit__c = totalCreditMap.get(key); 
        }

        update studentMap.values();
    }

    public void finish(Database.BatchableContext bc) {
        try {
            AsyncApexJob job = [SELECT Id, NumberOfErrors, ExtendedStatus FROM AsyncApexJob WHERE Id = :bc.getJobId()];
            if(job.NumberOfErrors > 0) {
                batchLog.Result__c = 'Error';
                batchLog.ErrorMessage__c = job.ExtendedStatus;
            } else {
                batchLog.Result__c = 'Success';
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