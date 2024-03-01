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

        listClass = [SELECT Id, Name FROM Class__c ORDER BY ClassCode__c ASC];
        Assert.areEqual(listClass.size(), listSelectOptions.size());
        Assert.areEqual(2, listSelectOptions.size());
        Assert.areEqual(listClass[0].Id, listSelectOptions[0].getValue());
        Assert.areEqual(listClass[0].Name, listSelectOptions[0].getLabel());
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

        Student__c st = [SELECT Id, FirstName__c FROM Student__c WHERE Id =: student.Id];
        Assert.areEqual(student.FirstName__c, st.FirstName__c);
        String url = '/apex/VF_DetailStudent?studentId=' + student.Id;
        Assert.areEqual(url, result.getUrl());
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

        Assert.areEqual(null, result);
    }
}