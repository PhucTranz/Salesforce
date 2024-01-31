/**
 * クラス名：B02_CreateSubjectScoreBatch
 * クラス概要：Batch create subjectscore
 * @created：2024/01/25 Tran Dinh Phuc
 * @modified：
 */
public without sharing class B02_CreateSubjectScoreBatch implements Database.Batchable<sObject>, Database.Stateful {
    Batchlog__c batchLog;
    List<SubjectScore__c> newSubjectScores;

    /**
     * start
     * @param：Database.BatchableContext bc
     * @return：Database.QueryLocator
     * @created：2024/01/25 Tran Dinh Phuc
     * @modified：
     */
    public Database.QueryLocator start(Database.BatchableContext bc) {
        batchLog = new Batchlog__c(Name = 'B02_科目得点作成バッチ', StartTime__c =  System.now());
        return Database.getQueryLocator('SELECT Id FROM Student__c WHERE LearningStatus__c = \'Enrolled\'');
    }

    /**
     * execute
     * @param：Database.BatchableContext bc
     * @param: List<Student__c> students
     * @return：なし
     * @created：2024/01/25 Tran Dinh Phuc
     * @modified：
     */
    public void execute(Database.BatchableContext bc, List<Student__c> students) {
        newSubjectScores = new List<SubjectScore__c>();
        List<Semester__c> semesters = [SELECT Id FROM Semester__c];
        List<Subject__c> subjects = [SELECT Id, CourseCredit__c FROM Subject__c];

        if (semesters.size() > 1) {
            for (Student__c student: students) {
                Integer randomIndex1 = getRandomNumber(semesters.size());
                Integer randomIndex2 = randomIndex1; 
                do {
                    randomIndex2 = getRandomNumber(semesters.size());
                } while (randomIndex1 == randomIndex2);
                Semester__c semester1 = semesters.get(randomIndex1);
                Semester__c semester2 = semesters.get(randomIndex2);
                
                courseRegistration(semester1, student, subjects);
                courseRegistration(semester2, student, subjects);
            }
        }

        if (newSubjectScores.size() > 0) {
            insert newSubjectScores;

            List<String> examType = new List<String>();
            examType.add('Progress');
            examType.add('Practical');
            examType.add('Midterm Exam');
            examType.add('FinalTerm Exam');

            List<Score__c> scores = new List<Score__c>();
            for (SubjectScore__c subjectScore: newSubjectScores) {
                for (String type: examType) {
                    Decimal randomScore = Math.round((Math.random() * 9 + 1) * 100.0) / 100.0;
                    Score__c score = new Score__c(SubjectScore_look__c = subjectScore.Id,
                                                ExamType__c = type,
                                                Score__c = randomScore);
                    scores.add(score);
                }
            }
            insert scores;
        }
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
                B03_UpdateStudentScoreBatch b = new B03_UpdateStudentScoreBatch();
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

    /**
     * getRandomNumber
     * @param：Integer n
     * @return：Integer
     * @created：2024/01/25 Tran Dinh Phuc
     * @modified：
     */
    private Integer getRandomNumber(Integer n) {
        return (Integer) Math.floor(Math.random() * n);
    }

    /**
     * shuffle
     * @param：list<Subject__c> subjectList
     * @return：list<Subject__c>
     * @created：2024/01/26 Tran Dinh Phuc
     * @modified：
     */
    private list<Subject__c> shuffle(list<Subject__c> subjectList) {
        for (Integer i = subjectList.size() - 1; i > 0; i--) {
            Integer j = Math.mod(Math.abs(Crypto.getRandomInteger()), i + 1);
            Subject__c temp = subjectList[i];
            subjectList[i] = subjectList[j];
            subjectList[j] = temp;
        }
    
        return subjectList;
    }

    /**
     * courseRegistration
     * @param：Semester__c semester
     * @param：Student__c student
     * @param：List<Subject__c> subjects
     * @return：なし
     * @created：2024/01/25 Tran Dinh Phuc
     * @modified：
     */
    private void courseRegistration(Semester__c semester, Student__c student, List<Subject__c> subjects) {
        Decimal totalCredit = 0;
        Decimal numberOfSubject = 0;
        
        shuffle(subjects);
        for (Integer i = 0; i < subjects.size() && numberOfSubject < 5 && totalCredit < 25; i++) {
            if (totalCredit + subjects.get(i).CourseCredit__c <= 25) {
                SubjectScore__c subjectScore = new SubjectScore__c(Student_look__c = student.Id, 
                                                            Subject_look__c = subjects.get(i).Id, 
                                                            Semester_look__c = semester.Id);
                
                newSubjectScores.add(subjectScore);
                numberOfSubject++;
                totalCredit += subjects.get(i).CourseCredit__c;
            } 
        }
    }
}