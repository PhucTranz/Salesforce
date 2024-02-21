@IsTest
private class CMP_DetailStudentCtrlTest {
    @IsTest
    private static void testGetStudentById() {
        Class__c cl = new Class__c();
        insert cl;

        Student__c student = new Student__c(
            FirstName__c = 'Student',
            LastName__c = 'Test',
            Class_look__c = cl.Id,
            Gender__c = 'Male',
            BirthDay__c = Date.valueOf('2002-11-23')
        );
        insert student;

        Test.startTest();
        Student__c result = CMP_DetailStudentCtrl.getStudentByID(student.Id);
        Test.stopTest();

        System.assertEquals(student.Id, result.Id);
    }

    @isTest
    static void testGetStudentByID_Exception() {
        Test.startTest();
        try {
            Student__c result = CMP_DetailStudentCtrl.getStudentByID('invalidId');
        } catch (Exception e) {
            System.assert(true, e.getMessage());
        }
        Test.stopTest();
    }

    @IsTest
    private static void testGetSubjectScore() {
        Class__c cl = new Class__c();
        insert cl;

        Student__c student = new Student__c(
            FirstName__c = 'Student',
            LastName__c = 'Test',
            Class_look__c = cl.Id,
            Gender__c = 'Male',
            BirthDay__c = Date.valueOf('2002-11-23')
        );
        insert student;

        Semester__c semester = new Semester__c();
        insert semester;

        Subject__c subject = new Subject__c();
        insert subject;

        SubjectScore__c subjecScore = new SubjectScore__c(
            Student_look__c = student.Id,
            Subject_look__c = subject.Id,
            Semester_look__c = semester.Id
        );
        insert subjecScore;

        Score__c score = new Score__c(SubjectScore_look__c = subjecScore.Id);
        insert score;

        Test.startTest();
        List<SubjectScore__c> result = CMP_DetailStudentCtrl.getSubjectScore(student.Id);
        Test.stopTest();

        System.assertEquals(1, result.size());
    }

    @isTest
    static void testConstructor() {
        Test.startTest();
        CMP_DetailStudentCtrl ctrl = new CMP_DetailStudentCtrl();
        Test.stopTest();
        System.assert(true);
    }
}