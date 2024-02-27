@IsTest
private class B03_UpdateStudentScoreBatchTest {
    @IsTest
    private static void testB03() {
        Class__c cl = new Class__c();
        insert cl;

        Student__c student = new Student__c(
            FirstName__c = 'Student',
            LastName__c = 'Test',
            Class_look__c = cl.Id,
            Gender__c = 'Male',
            BirthDay__c = Date.valueOf('2002-11-23'),
            LearningStatus__c = 'Enrolled'
        );
        insert student;

        List<Subject__c> subjects = new List<Subject__c>();
        subjects.add(new Subject__c(CourseCredit__c = 3));
        subjects.add(new Subject__c(CourseCredit__c = 4));
        insert subjects;

        List<SubjectScore__c> subjectScores = new List<SubjectScore__c>();

        subjectScores.add(new SubjectScore__c(
            Student_look__c = student.Id,
            Subject_look__c = subjects[0].Id,
            AverageScore__c = 8.5
        ));
        subjectScores.add(new SubjectScore__c(
            Student_look__c = student.Id,
            Subject_look__c = subjects[1].Id,
            AverageScore__c = 7
        ));
        subjectScores.add(new SubjectScore__c(
            Student_look__c = student.Id,
            Subject_look__c = subjects[0].Id,
            AverageScore__c = 5
        ));
        subjectScores.add(new SubjectScore__c(
            Student_look__c = student.Id,
            Subject_look__c = subjects[1].Id,
            AverageScore__c = 9
        ));

        insert subjectScores;

        Test.startTest();
        B03_UpdateStudentScoreBatch b03 = new B03_UpdateStudentScoreBatch();
        Database.executeBatch(b03);
        Test.stopTest();

        Batchlog__c log = [SELECT Id, Result__c FROM Batchlog__c WHERE Name = 'B03_学生得点更新バッチ' LIMIT 1];
        System.assertEquals('Success', log.Result__c);
        student = [SELECT Id, GPAScore__c FROM Student__c WHERE Id =: student.Id];
        System.assertEquals(8.79, student.GPAScore__c);
    }

    @IsTest 
    private static void testB03_Exception() {
        Test.startTest();
        B03_UpdateStudentScoreBatch b03 = new B03_UpdateStudentScoreBatch();
        b03.testException = true;
        Database.executeBatch(b03);
        Test.stopTest();

        Batchlog__c log = [SELECT Id, Result__c, ErrorMessage__c FROM Batchlog__c WHERE Name = 'B03_学生得点更新バッチ' LIMIT 1];
        System.assertEquals('Error', log.Result__c);
        System.assertEquals('Test error message', log.ErrorMessage__c);
    }
}