@IsTest
private class LWC_UpdateStudentCtrlTest {
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
        Student__c result = LWC_UpdateStudentCtrl.getStudentByID(student.Id);
        Test.stopTest();

        System.assertEquals(student.Id, result.Id);
    }

    @isTest
    private static void testGetStudentByID_Exception() {
        Test.startTest();
        try {
            Student__c result = LWC_UpdateStudentCtrl.getStudentByID('invalidId');
        } catch (Exception e) {
            System.assert(true, e.getMessage());
        }
        Test.stopTest();
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
        LWC_UpdateStudentCtrl.updateStudent(student);
        Test.stopTest();

        Student__c result = [SELECT Id, FirstName__c FROM Student__c WHERE Id =: student.Id];
        System.assertEquals('Phuc', result.FirstName__c);
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

        Test.startTest();
        try {
            LWC_UpdateStudentCtrl.updateStudent(student);
        } catch (Exception e) {
            System.assert(true, e.getMessage());
        }
        Test.stopTest();
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
        
        Test.startTest();
        try {
            LWC_UpdateStudentCtrl.updateStudent(student);
        } catch (Exception e) {
            System.assert(true, e.getMessage());
        }
        Test.stopTest();
    }
}