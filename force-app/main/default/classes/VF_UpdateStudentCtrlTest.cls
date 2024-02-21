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

        listClass = [SELECT Id, Name FROM Class__c];
        System.assertEquals(listClass.size(), listSelectOptions.size(), 'Number of options should match number of test classes');
        for (Integer i = 0; i < listClass.size(); i++) {
            System.assertEquals(listClass[i].Id, listSelectOptions[i].getValue(), 'Option value should match class Id');
            System.assertEquals(listClass[i].Name, listSelectOptions[i].getLabel(), 'Option label should match class Name');
        }
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

        PageReference page = Page.VF_UpdateStudent;
        Test.setCurrentPage(page);
        page.getParameters().put('studentId', student.Id);

        Test.startTest();
        VF_UpdateStudentCtrl ctrl = new VF_UpdateStudentCtrl();
        ctrl.student = student;
        PageReference result = ctrl.updateStudent();
        Test.stopTest();

        String url = '/apex/VF_DetailStudent?studentId=' + student.Id;
        System.assertEquals(url, result.getUrl());
    }
}