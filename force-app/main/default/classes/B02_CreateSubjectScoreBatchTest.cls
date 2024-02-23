@IsTest
private class B02_CreateSubjectScoreBatchTest {
    @IsTest
    private static void testB02() {
        Class__c cl = new Class__c();
        insert cl;

        List<Student__c> students = new List<Student__c>();
        for (Integer i = 0; i < 50; i++) {
            students.add( new Student__c(
                FirstName__c = 'Student',
                LastName__c = 'Test',
                Class_look__c = cl.Id,
                Gender__c = 'Male',
                BirthDay__c = Date.valueOf('2002-11-23'),
                LearningStatus__c = 'Enrolled'
            ));
        }
        insert students;

        List<Semester__c> semesters = new List<Semester__c>();
        semesters.add(new Semester__c());
        semesters.add(new Semester__c());
        insert semesters;

        List<Subject__c> subjects = new List<Subject__c>();
        subjects.add(new Subject__c(CourseCredit__c = 3));
        subjects.add(new Subject__c(CourseCredit__c = 4));
        insert subjects;

        Test.startTest();
        B02_CreateSubjectScoreBatch b02 = new B02_CreateSubjectScoreBatch();
        Database.executeBatch(b02);
        Test.stopTest();

        Batchlog__c log = [SELECT Id, Result__c FROM Batchlog__c WHERE Name = 'B02_科目得点作成バッチ' LIMIT 1];
        System.assertEquals('Success', log.Result__c);
    }
}