@IsTest
private class LWC_SearchStudentCtrlTest {
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
        List<Student__c> listStudent= LWC_SearchStudentCtrl.searchCondition('{"searchByName": "Student"}');
        Test.stopTest();

        Assert.areEqual(10, listStudent.size()); 
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
        List<Student__c> listStudent= LWC_SearchStudentCtrl.searchCondition('{"searchByClass": "'+cl.Id+'"}');
        Test.stopTest();

        Assert.areEqual(10, listStudent.size());
        Assert.areEqual(cl.Id, listStudent.get(0).Class_look__c); 
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
        List<Student__c> listStudent= LWC_SearchStudentCtrl.searchCondition('{"searchByStudentCode": "'+students[0].StudentCode__c+'"}');
        Test.stopTest();

        Assert.areEqual(1, listStudent.size());
        Assert.areEqual(students[0].StudentCode__c, listStudent.get(0).StudentCode__c); 
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
        List<Student__c> listStudent= LWC_SearchStudentCtrl.searchCondition('{"searchByGender": "Male"}');
        Test.stopTest();

        Assert.areEqual(3, listStudent.size()); 
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
        List<Student__c> listStudent= LWC_SearchStudentCtrl.searchCondition('{"searchByBirthday": "2003-11-23"}');
        Test.stopTest();

        Assert.areEqual(7, listStudent.size()); 
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
        List<Student__c> listStudent= LWC_SearchStudentCtrl.searchCondition('{"searchByYear": 2003}');
        Test.stopTest();

        Assert.areEqual(7, listStudent.size()); 
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
        List<Student__c> listStudent= LWC_SearchStudentCtrl.searchCondition('{"searchByMonth": 11}');
        Test.stopTest();

        Assert.areEqual(3, listStudent.size()); 
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
        List<Student__c> listStudent= LWC_SearchStudentCtrl.searchCondition('{"searchByDay": 2}');
        Test.stopTest();

        Assert.areEqual(3, listStudent.size()); 
    }

    @IsTest
    private static void testGetListClass() {
        List<Class__c> classes = new List<Class__c>();
        classes.add(new Class__c());
        classes.add(new Class__c());
        insert classes;

        Test.startTest();
        List<Class__c> result = LWC_SearchStudentCtrl.getListClass();
        Test.stopTest();

        classes = [SELECT Id FROM Class__c ORDER BY ClassCode__c ASC];
        Assert.areEqual(classes.size(), result.size());
        Assert.areEqual(classes[1].Id, result[1].Id);
    }

    @IsTest
    private static void testDelSelectedStudent() {
        Class__c cl = new Class__c();
        insert cl;

        List<Student__c> students = new List<Student__c>();
        for (Integer i = 0; i < 10; i++) {
            students.add(new Student__c(
                FirstName__c = 'Student',
                LastName__c = 'Test',
                Class_look__c = cl.Id,
                Gender__c = 'Male',
                BirthDay__c = Date.valueOf('2002-11-23')
            ));
        }
        insert students;

        List<String> studentCodeList = new List<String>();
        students = [SELECT Id, StudentCode__c FROM Student__c];
        for (Student__c st: students) {
            studentCodeList.add(st.StudentCode__c);
        }

        Test.startTest();
        LWC_SearchStudentCtrl.delSelectedStudent(studentCodeList);
        Test.stopTest();

        List<Student__c> result = [SELECT Id FROM Student__c];
        Assert.areEqual(0, result.size());
    }
}