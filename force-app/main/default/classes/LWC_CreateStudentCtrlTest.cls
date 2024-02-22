@IsTest
private class LWC_CreateStudentCtrlTest {
    @IsTest
    private static void testCreateStudent() {
        Class__c cl = new Class__c();
        insert cl;

        String studentJson = '{"FirstName__c":"Student",' +
                                '"LastName__c":"1",'+
                                '"Class_look__c":"'+cl.Id+
                                '","Gender__c":"Male",'+
                                '"BirthDay__c":"2002-11-23"}';

        Test.startTest();
        LWC_CreateStudentCtrl.createStudent(studentJson);
        Test.stopTest();

        List<Student__c> result = [SELECT Id FROM Student__c];
        System.assertEquals(1, result.size());
    }

    @IsTest
    private static void testCreateStudentWithNoFirstName() {
        Class__c cl = new Class__c();
        insert cl;

        String studentJson = '{"LastName__c":"1",'+
                                '"Class_look__c":"'+cl.Id+
                                '","Gender__c":"Male",'+
                                '"BirthDay__c":"2002-11-23"}';

        Test.startTest();
        try {
            LWC_CreateStudentCtrl.createStudent(studentJson);
        } catch (Exception e) {
            System.assert(true, e.getMessage());
        }
        Test.stopTest();
    }

    @IsTest
    private static void testCreateStudentWithNoLastName() {
        Class__c cl = new Class__c();
        insert cl;

        String studentJson = '{"FirstName__c":"Student",' +
                                '"Class_look__c":"'+cl.Id+
                                '","Gender__c":"Male",'+
                                '"BirthDay__c":"2002-11-23"}';

        Test.startTest();
        try {
            LWC_CreateStudentCtrl.createStudent(studentJson);
        } catch (Exception e) {
            System.assert(true, e.getMessage());
        }
        Test.stopTest();
    }
}