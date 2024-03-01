@IsTest
private class VF_UpdateStudentCtrlTest {

    @IsTest
    private static void testGetOptions() {
        List<Class__c> listClass = new List<Class__c>();
        listClass.add(new Class__c());
        listClass.add(new Class__c());
        insert listClass;

        Student__c student = new Student__c(
            FirstName__c = 'Student',
            LastName__c = 'Test',
            Class_look__c = listClass[0].Id,
            Gender__c = 'Male',
            BirthDay__c = Date.valueOf('2002-11-23')
        );
        insert student;

        PageReference page = Page.VF_UpdateStudent;
        Test.setCurrentPage(page);
        page.getParameters().put('studentId', student.Id);

        Test.startTest();
        VF_UpdateStudentCtrl ctrl = new VF_UpdateStudentCtrl();
        List<SelectOption> listSelectOptions = ctrl.getOptions();
        Test.stopTest();

        listClass = [SELECT Id, Name FROM Class__c ORDER BY ClassCode__c ASC];
        Assert.areEqual(listClass.size(), listSelectOptions.size());
        Assert.areEqual(2, listSelectOptions.size());
        Assert.areEqual(listClass[0].Id, listSelectOptions[0].getValue());
        Assert.areEqual(listClass[0].Name, listSelectOptions[0].getLabel());
    }

    @IsTest
    private static void testUpdateStudentSuccess() {
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

        PageReference page = Page.VF_UpdateStudent;
        Test.setCurrentPage(page);
        page.getParameters().put('studentId', student.Id);

        Test.startTest();
        VF_UpdateStudentCtrl ctrl = new VF_UpdateStudentCtrl();
        ctrl.student = student;
        PageReference result = ctrl.updateStudent();
        Test.stopTest();

        Student__c st = [SELECT Id, FirstName__c FROM Student__c WHERE Id =: student.Id];
        Assert.areEqual('Phuc', st.FirstName__c);
        String url = '/apex/VF_DetailStudent?studentId=' + student.Id;
        Assert.areEqual(url, result.getUrl());
    }
}