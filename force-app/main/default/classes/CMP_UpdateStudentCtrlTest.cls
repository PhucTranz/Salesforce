@IsTest
private class CMP_UpdateStudentCtrlTest {
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
        Student__c result = CMP_UpdateStudentCtrl.getStudentByID(student.Id);
        Test.stopTest();

        Assert.areEqual(student.FirstName__c, result.FirstName__c);
    }

    @isTest
    private static void testGetStudentByID_Exception() {
        Boolean error = false;
        Test.startTest();
        try {
            Student__c result = CMP_UpdateStudentCtrl.getStudentByID('invalidId');
        } catch (Exception e) {
            error = true;
        }
        Test.stopTest();
        
        Assert.isTrue(error);
    }

    @IsTest
    private static void testUpdateStudent() {
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
        student.FirstName__c = 'Phuc';

        Test.startTest();
        CMP_UpdateStudentCtrl.updateStudent(student);
        Test.stopTest();

        Student__c result = [SELECT Id, FirstName__c FROM Student__c WHERE Id =: student.Id];
        Assert.areEqual('Phuc', result.FirstName__c);
    }

    @IsTest
    private static void testUpdateStudentWithNoFirstName() {
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
        student.FirstName__c = '';

        Boolean error = false;
        Test.startTest();
        try {
            CMP_UpdateStudentCtrl.updateStudent(student);
        } catch (Exception e) {
            error = true;
        }
        Test.stopTest();

        Assert.isTrue(error);
    }

    @IsTest
    private static void testCreateStudentWithNoLastName() {
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
        student.LastName__c = '';
        
        Boolean error = false;
        Test.startTest();
        try {
            CMP_UpdateStudentCtrl.updateStudent(student);
        } catch (Exception e) {
            error = true;
        }
        Test.stopTest();

        Assert.isTrue(error);
    }

    @IsTest
    private static void testConstructor() {
        Test.startTest();
        CMP_UpdateStudentCtrl ctrl = new CMP_UpdateStudentCtrl();
        Test.stopTest();
        Assert.isTrue(true);
    }
}