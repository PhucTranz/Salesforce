@IsTest
private class VF_DetailStudentCtrlTest {
    @IsTest
    private static void testConstructor() {
        Class__c testClass = new Class__c();
        insert testClass;

        Student__c student = new Student__c(
            FirstName__c = 'Student',
            LastName__c = 'Test',
            Class_look__c = testClass.Id,
            Gender__c = 'Male',
            BirthDay__c = Date.valueOf('2002-11-23')
        );
        insert student;

        PageReference page = Page.VF_DetailStudent;
        Test.setCurrentPage(page);
        page.getParameters().put('studentId', student.Id);

        Test.startTest();
        VF_DetailStudentCtrl ctrl = new VF_DetailStudentCtrl();
        Test.stopTest();

        testClass = [SELECT Id, Name FROM Class__c WHERE Id =: testClass.Id];
        Assert.areEqual(student.Id, ctrl.student.Id, 'Student Id should match');
        Assert.areEqual(testClass.Name, ctrl.className, 'Class name should match');
    }
}