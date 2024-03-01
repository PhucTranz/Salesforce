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

        List<Student__c> result = [SELECT Id, FirstName__c FROM Student__c WHERE Class_look__c = :cl.Id];
        Assert.areEqual(1, result.size());
        Assert.areEqual('Student', result[0].FirstName__c);
    }

    @IsTest
    private static void testCreateStudentWithNoFirstName() {
        Class__c cl = new Class__c();
        insert cl;

        String studentJson = '{"LastName__c":"1",'+
                                '"Class_look__c":"'+cl.Id+
                                '","Gender__c":"Male",'+
                                '"BirthDay__c":"2002-11-23"}';

        Boolean error = false;

        Test.startTest();
        try {
            LWC_CreateStudentCtrl.createStudent(studentJson);
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

        String studentJson = '{"FirstName__c":"Student",' +
                                '"Class_look__c":"'+cl.Id+
                                '","Gender__c":"Male",'+
                                '"BirthDay__c":"2002-11-23"}';

        Boolean error = false;

        Test.startTest();
        try {
            LWC_CreateStudentCtrl.createStudent(studentJson);
        } catch (Exception e) {
            error = true;
        }
        Test.stopTest();

        Assert.isTrue(error);
    }
}