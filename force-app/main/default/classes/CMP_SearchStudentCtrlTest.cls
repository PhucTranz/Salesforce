@IsTest
private class CMP_SearchStudentCtrlTest {
    @IsTest
    private static void testSearchByName() {
        Class__c cl = new Class__c();
        insert cl;

        List<Student__c> students = new List<Student__c>();
        for (Integer i = 0; i < 10; i++) {
            students.add( new Student__c(
                FirstName__c = 'Student',
                LastName__c = 'Test',
                Name = 'Student ' + i + 1,
                Class_look__c = cl.Id,
                Gender__c = 'Male',
                BirthDay__c = Date.valueOf('2002-11-23')
            ));
        }
        insert students;

        Test.startTest();
        List<Student__c> listStudent= CMP_SearchStudentCtrl.getAllStudent('Student', '', '', '', null, 0, 0, 0);
        Test.stopTest();

        System.assertEquals(10, listStudent.size()); 
    }

    @IsTest
    private static void testSearchByClass() {
        Class__c cl = new Class__c();
        insert cl;

        List<Student__c> students = new List<Student__c>();
        for (Integer i = 0; i < 10; i++) {
            students.add( new Student__c(
                FirstName__c = 'Student',
                LastName__c = 'Test',
                Name = 'Student ' + i + 1,
                Class_look__c = cl.Id,
                Gender__c = 'Male',
                BirthDay__c = Date.valueOf('2002-11-23')
            ));
        }
        insert students;

        Test.startTest();
        List<Student__c> listStudent= CMP_SearchStudentCtrl.getAllStudent('', cl.Id, '', '', null, 0, 0, 0);
        Test.stopTest();

        if (listStudent.size() > 0) {
            System.assertEquals(cl.Id, listStudent.get(0).Class_look__c); 
        } else {
            System.assert(false);
        } 
    }

    @IsTest
    private static void testSearchByStudentCode() {
        Class__c cl = new Class__c();
        insert cl;

        List<Student__c> students = new List<Student__c>();
        for (Integer i = 0; i < 10; i++) {
            students.add( new Student__c(
                FirstName__c = 'Student',
                LastName__c = 'Test',
                Name = 'Student ' + i + 1,
                Class_look__c = cl.Id,
                Gender__c = 'Male',
                BirthDay__c = Date.valueOf('2002-11-23')
            ));
        }
        insert students;
        
        students = [SELECT Id, StudentCode__c FROM Student__c];

        Test.startTest();
        List<Student__c> listStudent= CMP_SearchStudentCtrl.getAllStudent('', '', students[0].StudentCode__c, '', null, 0, 0, 0);
        Test.stopTest();

        if (listStudent.size() > 0) {
            System.assertEquals(students[0].StudentCode__c, listStudent.get(0).StudentCode__c); 
        } else {
            System.assert(false);
        }
    }

    @IsTest
    private static void testSearchByGender() {
        Class__c cl = new Class__c();
        insert cl;

        List<Student__c> students = new List<Student__c>();
        for (Integer i = 0; i < 3; i++) {
            students.add( new Student__c(
                FirstName__c = 'Student',
                LastName__c = 'Test',
                Name = 'Student ' + i + 1,
                Class_look__c = cl.Id,
                Gender__c = 'Male',
                BirthDay__c = Date.valueOf('2002-11-23')
            ));
        }

        for (Integer i = 0; i < 7; i++) {
            students.add( new Student__c(
                FirstName__c = 'Student',
                LastName__c = 'Test',
                Name = 'Student ' + i + 1,
                Class_look__c = cl.Id,
                Gender__c = 'Female',
                BirthDay__c = Date.valueOf('2002-11-23')
            ));
        }
        insert students;

        Test.startTest();
        List<Student__c> listStudent= CMP_SearchStudentCtrl.getAllStudent('', '', '', 'Male', null, 0, 0, 0);
        Test.stopTest();

        System.assertEquals(3, listStudent.size()); 
    }

    @IsTest
    private static void testSearchByBirthDay() {
        Class__c cl = new Class__c();
        insert cl;

        List<Student__c> students = new List<Student__c>();
        for (Integer i = 0; i < 3; i++) {
            students.add( new Student__c(
                FirstName__c = 'Student',
                LastName__c = 'Test',
                Name = 'Student ' + i + 1,
                Class_look__c = cl.Id,
                Gender__c = 'Male',
                BirthDay__c = Date.valueOf('2002-11-23')
            ));
        }

        for (Integer i = 0; i < 7; i++) {
            students.add( new Student__c(
                FirstName__c = 'Student',
                LastName__c = 'Test',
                Name = 'Student ' + i + 1,
                Class_look__c = cl.Id,
                Gender__c = 'Female',
                BirthDay__c = Date.valueOf('2003-11-23')
            ));
        }
        insert students;

        Test.startTest();
        List<Student__c> listStudent= CMP_SearchStudentCtrl.getAllStudent('', '', '', '', Date.valueOf('2003-11-23'), 0, 0, 0);
        Test.stopTest();

        System.assertEquals(7, listStudent.size()); 
    }

    @IsTest
    private static void testSearchByYear() {
        Class__c cl = new Class__c();
        insert cl;

        List<Student__c> students = new List<Student__c>();
        for (Integer i = 0; i < 3; i++) {
            students.add( new Student__c(
                FirstName__c = 'Student',
                LastName__c = 'Test',
                Name = 'Student ' + i + 1,
                Class_look__c = cl.Id,
                Gender__c = 'Male',
                BirthDay__c = Date.valueOf('2002-11-23')
            ));
        }

        for (Integer i = 0; i < 7; i++) {
            students.add( new Student__c(
                FirstName__c = 'Student',
                LastName__c = 'Test',
                Name = 'Student ' + i + 1,
                Class_look__c = cl.Id,
                Gender__c = 'Female',
                BirthDay__c = Date.valueOf('2003-11-23')
            ));
        }
        insert students;

        Test.startTest();
        List<Student__c> listStudent= CMP_SearchStudentCtrl.getAllStudent('', '', '', '', null, 2003, 0, 0);
        Test.stopTest();

        System.assertEquals(7, listStudent.size()); 
    }

    @IsTest
    private static void testSearchByMonth() {
        Class__c cl = new Class__c();
        insert cl;

        List<Student__c> students = new List<Student__c>();
        for (Integer i = 0; i < 3; i++) {
            students.add( new Student__c(
                FirstName__c = 'Student',
                LastName__c = 'Test',
                Name = 'Student ' + i + 1,
                Class_look__c = cl.Id,
                Gender__c = 'Male',
                BirthDay__c = Date.valueOf('2002-11-23')
            ));
        }

        for (Integer i = 0; i < 7; i++) {
            students.add( new Student__c(
                FirstName__c = 'Student',
                LastName__c = 'Test',
                Name = 'Student ' + i + 1,
                Class_look__c = cl.Id,
                Gender__c = 'Female',
                BirthDay__c = Date.valueOf('2003-1-23')
            ));
        }
        insert students;

        Test.startTest();
        List<Student__c> listStudent= CMP_SearchStudentCtrl.getAllStudent('', '', '', '', null, 0, 11, 0);
        Test.stopTest();

        System.assertEquals(3, listStudent.size()); 
    }

    @IsTest
    private static void testSearchByDay() {
        Class__c cl = new Class__c();
        insert cl;

        List<Student__c> students = new List<Student__c>();
        for (Integer i = 0; i < 3; i++) {
            students.add( new Student__c(
                FirstName__c = 'Student',
                LastName__c = 'Test',
                Name = 'Student ' + i + 1,
                Class_look__c = cl.Id,
                Gender__c = 'Male',
                BirthDay__c = Date.valueOf('2002-11-2')
            ));
        }

        for (Integer i = 0; i < 7; i++) {
            students.add( new Student__c(
                FirstName__c = 'Student',
                LastName__c = 'Test',
                Name = 'Student ' + i + 1,
                Class_look__c = cl.Id,
                Gender__c = 'Female',
                BirthDay__c = Date.valueOf('2003-1-23')
            ));
        }
        insert students;

        Test.startTest();
        List<Student__c> listStudent= CMP_SearchStudentCtrl.getAllStudent('', '', '', '', null, 0, 0, 2);
        Test.stopTest();

        System.assertEquals(3, listStudent.size()); 
    }
}