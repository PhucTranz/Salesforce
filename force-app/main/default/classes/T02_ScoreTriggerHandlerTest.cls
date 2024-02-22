@IsTest
private class T02_ScoreTriggerHandlerTest {
    @IsTest
    private static void testUpdateSubjectScore_Pass() {
        Class__c cl = new Class__c();
        insert cl;

        Student__c st = new Student__c(
            FirstName__c = 'Student',
            LastName__c = 'Test',
            Class_look__c = cl.Id,
            Gender__c = 'Male',
            BirthDay__c = Date.valueOf('2002-11-23'),
            LearningStatus__c = 'Enrolled'
        );
        insert st;

        SubjectScore__c subjectScore = new SubjectScore__c(Student_look__c = st.Id);
        insert subjectScore;

        List<Score__c> scores = new List<Score__c>();
        scores.add(new Score__c(
            SubjectScore_look__c = subjectScore.Id,
            ExamType__c = 'Progress',
            Score__c = 4
        ));
        scores.add(new Score__c(
            SubjectScore_look__c = subjectScore.Id,
            ExamType__c = 'Practical',
            Score__c = 3
        ));
        scores.add(new Score__c(
            SubjectScore_look__c = subjectScore.Id,
            ExamType__c = 'Midterm Exam',
            Score__c = 8.4
        ));
        scores.add(new Score__c(
            SubjectScore_look__c = subjectScore.Id,
            ExamType__c = 'FinalTerm Exam',
            Score__c = 1
        ));
        insert scores;
        Test.startTest();
        T02_ScoreTriggerHandler.updateSubjectScore(scores);
        Test.stopTest();

        subjectScore = [SELECT Id, Status__c, AverageScore__c FROM SubjectScore__c WHERE Id =: subjectScore.Id];
        System.assertEquals(3.18, subjectScore.AverageScore__c);
        System.assertEquals('Not Passed', subjectScore.Status__c);
    }

    @IsTest
    private static void testUpdateSubjectScore_NotPass() {
        Class__c cl = new Class__c();
        insert cl;

        Student__c st = new Student__c(
            FirstName__c = 'Student',
            LastName__c = 'Test',
            Class_look__c = cl.Id,
            Gender__c = 'Male',
            BirthDay__c = Date.valueOf('2002-11-23'),
            LearningStatus__c = 'Enrolled'
        );
        insert st;

        SubjectScore__c subjectScore = new SubjectScore__c(Student_look__c = st.Id);
        insert subjectScore;

        List<Score__c> scores = new List<Score__c>();
        scores.add(new Score__c(
            SubjectScore_look__c = subjectScore.Id,
            ExamType__c = 'Progress',
            Score__c = 5
        ));
        scores.add(new Score__c(
            SubjectScore_look__c = subjectScore.Id,
            ExamType__c = 'Practical',
            Score__c = 5
        ));
        scores.add(new Score__c(
            SubjectScore_look__c = subjectScore.Id,
            ExamType__c = 'Midterm Exam',
            Score__c = 5
        ));
        scores.add(new Score__c(
            SubjectScore_look__c = subjectScore.Id,
            ExamType__c = 'FinalTerm Exam',
            Score__c = 6
        ));
        insert scores;
        Test.startTest();
        T02_ScoreTriggerHandler.updateSubjectScore(scores);
        Test.stopTest();

        subjectScore = [SELECT Id, Status__c, AverageScore__c FROM SubjectScore__c WHERE Id =: subjectScore.Id];
        System.assertEquals(5.5, subjectScore.AverageScore__c);
        System.assertEquals('Passed', subjectScore.Status__c);
    }
}