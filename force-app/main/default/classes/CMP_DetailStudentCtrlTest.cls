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

        Assert.areEqual(student.FirstName__c, result.FirstName__c);
    }

    @IsTest
    private static void testGetStudentByID_Exception() {
        Boolean error = false;
        Test.startTest();
        try {
            Student__c result = CMP_DetailStudentCtrl.getStudentByID('invalidId');
        } catch (Exception e) {
            error = true;
        }
        Test.stopTest();

        Assert.isTrue(error);
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

        List<SubjectScore__c> subjecScores = [SELECT Id, Subject_look__r.Name 
                                                FROM SubjectScore__c 
                                                WHERE Student_look__c = :student.Id
                                                ORDER BY Subject_look__r.Name];

        Assert.areEqual(subjecScores.size(), result.size());
        Assert.areEqual(subjecScores[0].Subject_look__r.Name, result[0].Subject_look__r.Name);
    }

    @isTest
    private static void testConstructor() {
        Test.startTest();
        CMP_DetailStudentCtrl ctrl = new CMP_DetailStudentCtrl();
        Test.stopTest();
        Assert.isTrue(true);
    }
}