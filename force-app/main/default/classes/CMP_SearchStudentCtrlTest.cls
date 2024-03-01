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
        List<Student__c> listStudent= CMP_SearchStudentCtrl.getAllStudent('', cl.Id, '', '', null, 0, 0, 0);
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
        List<Student__c> listStudent= CMP_SearchStudentCtrl.getAllStudent('', '', students[0].StudentCode__c, '', null, 0, 0, 0);
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
        List<Student__c> listStudent= CMP_SearchStudentCtrl.getAllStudent('', '', '', 'Male', null, 0, 0, 0);
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
        List<Student__c> listStudent= CMP_SearchStudentCtrl.getAllStudent('', '', '', '', Date.valueOf('2003-11-23'), 0, 0, 0);
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
        List<Student__c> listStudent= CMP_SearchStudentCtrl.getAllStudent('', '', '', '', null, 2003, 0, 0);
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
        List<Student__c> listStudent= CMP_SearchStudentCtrl.getAllStudent('', '', '', '', null, 0, 11, 0);
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
        List<Student__c> listStudent= CMP_SearchStudentCtrl.getAllStudent('', '', '', '', null, 0, 0, 2);
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
        List<Class__c> result = CMP_SearchStudentCtrl.getListClass();
        Test.stopTest();

        classes = [SELECT Id FROM Class__c ORDER BY ClassCode__c ASC];
        Assert.areEqual(classes.size(), result.size());
        Assert.areEqual(classes[1].Id, result[1].Id);
    }

    @IsTest
    private static void testGetStudentById() {
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

        Test.startTest();
        Student__c result = CMP_SearchStudentCtrl.getStudentByID(student.Id);
        Test.stopTest();

        Assert.areEqual(student.Id, result.Id);
    }

    @IsTest
    private static void testGetStudentByID_Exception() {
        Boolean error = false;
        Test.startTest();
        try {
            Student__c result = CMP_SearchStudentCtrl.getStudentByID('invalidId');
        } catch (Exception e) {
            error = true;
        }
        Test.stopTest();

        Assert.isTrue(error);
    }

    @IsTest
    private static void testDelStudentById() {
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

        Test.startTest();
        CMP_SearchStudentCtrl.delStudentByID(student.Id);
        Test.stopTest();

        Boolean deleteSuccess = false;
        try {
            Student__c result = [SELECT Id FROM Student__c WHERE Id =: student.Id];
        } catch (Exception e) {
            deleteSuccess = true;
        }
        Assert.isTrue(deleteSuccess);
    }

    @IsTest
    private static void testDelStudentById_Exception() {
        Boolean error = false;
        Test.startTest();
        try {
            CMP_SearchStudentCtrl.delStudentByID('invalidId');
        } catch (Exception e) {
            error = true;
        }
        Test.stopTest();

        Assert.isTrue(error);
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
        CMP_SearchStudentCtrl.delSelectedStudent(studentCodeList);
        Test.stopTest();

        List<Student__c> result = [SELECT Id FROM Student__c];
        Assert.areEqual(0, result.size());
    }

    @isTest
    private static void testConstructor() {
        Test.startTest();
        CMP_SearchStudentCtrl ctrl = new CMP_SearchStudentCtrl();
        Test.stopTest();
        Assert.isTrue(true);
    }
}