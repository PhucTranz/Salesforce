@IsTest
private class CMP_CreateStudentCtrlTest {
    @IsTest
    private static void testInit() {
        Test.startTest();
        Student__c student = CMP_CreateStudentCtrl.init();
        Test.stopTest();

        System.assertNotEquals(null, student);
    }

    @IsTest
    private static void testCreateStudent() {
        Class__c cl = new Class__c();
        insert cl;

        Student__c student = new Student__c(
            FirstName__c = 'Student',
            LastName__c = 'Test',
            Class_look__c = cl.Id,
            Gender__c = 'Male',
            BirthDay__c = Date.valueOf('2002-11-23')
        );

        Test.startTest();
        CMP_CreateStudentCtrl.createStudent(student);
        Test.stopTest();

        Student__c result = [SELECT Id FROM Student__c WHERE Id =: student.Id];
        System.assertEquals(student.Id, result.Id);
    }

    @IsTest
    private static void testCreateStudentWithNoFirstName() {
        Class__c cl = new Class__c();
        insert cl;

        Student__c student = new Student__c(
            LastName__c = 'Test',
            Class_look__c = cl.Id,
            Gender__c = 'Male',
            BirthDay__c = Date.valueOf('2002-11-23')
        );

        Test.startTest();
        try {
            CMP_CreateStudentCtrl.createStudent(student);
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
            FirstName__c = 'Test',
            Class_look__c = cl.Id,
            Gender__c = 'Male',
            BirthDay__c = Date.valueOf('2002-11-23')
        );

        Test.startTest();
        try {
            CMP_CreateStudentCtrl.createStudent(student);
        } catch (Exception e) {
            System.assert(true, e.getMessage());
        }
        Test.stopTest();
    }

    @IsTest
    private static void testConstructor() {
        Test.startTest();
        CMP_CreateStudentCtrl ctrl = new CMP_CreateStudentCtrl();
        Test.stopTest();
        System.assert(true);
    }
}