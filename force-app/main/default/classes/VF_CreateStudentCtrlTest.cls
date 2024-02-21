@IsTest
private class VF_CreateStudentCtrlTest {
    @IsTest
    private static void testGetOptions() {
        List<Class__c> listClass = new List<Class__c>();
        listClass.add(new Class__c());
        listClass.add(new Class__c());
        insert listClass;

        Test.startTest();
        VF_CreateStudentCtrl ctrl = new VF_CreateStudentCtrl();
        List<SelectOption> listSelectOptions = ctrl.getOptions();
        Test.stopTest();

        listClass = [SELECT Id, Name FROM Class__c];
        System.assertEquals(listClass.size(), listSelectOptions.size(), 'Number of options should match number of test classes');
        for (Integer i = 0; i < listClass.size(); i++) {
            System.assertEquals(listClass[i].Id, listSelectOptions[i].getValue(), 'Option value should match class Id');
            System.assertEquals(listClass[i].Name, listSelectOptions[i].getLabel(), 'Option label should match class Name');
        }
    }

    @IsTest
    private static void testCreateStudentSuccess() {
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
        VF_CreateStudentCtrl ctrl = new VF_CreateStudentCtrl();
        ctrl.student = student;
        PageReference result = ctrl.createStudent();
        Test.stopTest();

        String url = '/apex/VF_DetailStudent?studentId=' + student.Id;
        System.assertEquals(url, result.getUrl());
    }

    @IsTest
    private static void testCreateStudentFail() {

        Student__c student = new Student__c(
            FirstName__c = 'Student',
            LastName__c = 'Test',
            Gender__c = 'Male',
            BirthDay__c = Date.valueOf('2002-11-23')
        );

        VF_CreateStudentCtrl ctrl = new VF_CreateStudentCtrl();
        ctrl.student = student;

        Test.startTest();
        PageReference result = ctrl.createStudent();
        Test.stopTest();

        System.assertEquals(null, result);
    }
}