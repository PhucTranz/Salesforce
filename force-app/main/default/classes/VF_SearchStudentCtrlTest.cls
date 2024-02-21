@IsTest
private class VF_SearchStudentCtrlTest {
    @IsTest
    private static void testGetPagesCase1() {
        Class__c cl = new Class__c();
        insert cl;

        List<Student__c> students = new List<Student__c>();
        for(Integer i = 0; i < 50; i++) {
            students.add( new Student__c(
                FirstName__c = 'Student',
                LastName__c = String.valueOf(i+1),
                Class_look__c = cl.Id,
                Gender__c = 'Male',
                BirthDay__c = Date.valueOf('2002-11-23')
            ));
        }
        insert students;

        Test.startTest();
        VF_SearchStudentCtrl ctrl = new VF_SearchStudentCtrl();
        List<Integer> result = ctrl.getPages();
        Test.stopTest();
        Integer count = 1;
        for (Integer i: result) {
            if (i == count) {
                count++;
            }
        }

        System.assertEquals(6, count);
    }

    @IsTest
    private static void testGetPagesCase2() {
        Class__c cl = new Class__c();
        insert cl;

        List<Student__c> students = new List<Student__c>();
        for(Integer i = 0; i < 50; i++) {
            students.add( new Student__c(
                FirstName__c = 'Student',
                LastName__c = String.valueOf(i+1),
                Class_look__c = cl.Id,
                Gender__c = 'Male',
                BirthDay__c = Date.valueOf('2002-11-23')
            ));
        }
        insert students;

        Test.startTest();
        VF_SearchStudentCtrl ctrl = new VF_SearchStudentCtrl();
        ctrl.pageNumber = 2;
        List<Integer> result = ctrl.getPages();
        Test.stopTest();
        Integer count = 1;
        for (Integer i: result) {
            if (i == count) {
                count++;
            }
        }

        System.assertEquals(6, count);
    }

    @IsTest
    private static void testGetPagesCase3() {
        Class__c cl = new Class__c();
        insert cl;

        List<Student__c> students = new List<Student__c>();
        for(Integer i = 0; i < 50; i++) {
            students.add( new Student__c(
                FirstName__c = 'Student',
                LastName__c = String.valueOf(i+1),
                Class_look__c = cl.Id,
                Gender__c = 'Male',
                BirthDay__c = Date.valueOf('2002-11-23')
            ));
        }
        insert students;

        Test.startTest();
        VF_SearchStudentCtrl ctrl = new VF_SearchStudentCtrl();
        ctrl.pageNumber = 4;
        List<Integer> result = ctrl.getPages();
        Test.stopTest();
        Integer count = 2;
        for (Integer i: result) {
            if (i == count) {
                count++;
            }
        }

        System.assertEquals(7, count);
    }

    @IsTest
    private static void testGetPagesCase4() {
        Class__c cl = new Class__c();
        insert cl;

        List<Student__c> students = new List<Student__c>();
        for(Integer i = 0; i < 50; i++) {
            students.add( new Student__c(
                FirstName__c = 'Student',
                LastName__c = String.valueOf(i+1),
                Class_look__c = cl.Id,
                Gender__c = 'Male',
                BirthDay__c = Date.valueOf('2002-11-23')
            ));
        }
        insert students;

        Test.startTest();
        VF_SearchStudentCtrl ctrl = new VF_SearchStudentCtrl();
        ctrl.pageNumber = 10;
        List<Integer> result = ctrl.getPages();
        Test.stopTest();
        Integer count = 6;
        for (Integer i: result) {
            if (i == count) {
                count++;
            }
        }

        System.assertEquals(11, count);
    }

    @IsTest
    private static void testGetPagesCase5() {
        Class__c cl = new Class__c();
        insert cl;

        List<Student__c> students = new List<Student__c>();
        for(Integer i = 0; i < 50; i++) {
            students.add( new Student__c(
                FirstName__c = 'Student',
                LastName__c = String.valueOf(i+1),
                Class_look__c = cl.Id,
                Gender__c = 'Male',
                BirthDay__c = Date.valueOf('2002-11-23')
            ));
        }
        insert students;

        Test.startTest();
        VF_SearchStudentCtrl ctrl = new VF_SearchStudentCtrl();
        ctrl.pageNumber = 9;
        List<Integer> result = ctrl.getPages();
        Test.stopTest();
        Integer count = 6;
        for (Integer i: result) {
            if (i == count) {
                count++;
            }
        }

        System.assertEquals(11, count);
    }
}