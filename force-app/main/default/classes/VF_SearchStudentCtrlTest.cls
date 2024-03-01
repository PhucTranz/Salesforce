@IsTest
private class VF_SearchStudentCtrlTest {
    @isTest
    static void testLoadDataByName() {
        Class__c testClass = new Class__c();
        insert testClass;

        List<Student__c> testStudents = new List<Student__c>();
        for(Integer i = 0; i < 10; i++) {
            testStudents.add(new Student__c(
                FirstName__c = 'John',
                LastName__c = 'Doe' + i,
                Name = 'John Doe ' + i,
                Class_look__c = testClass.Id,
                Gender__c = 'Male',
                BirthDay__c = Date.valueOf('2002-11-23')
            ));
        }
        insert testStudents;

        VF_SearchStudentCtrl controller = new VF_SearchStudentCtrl();
        controller.searchByName = testStudents[0].FirstName__c;

        Test.startTest();
        controller.search();
        Test.stopTest();

        Assert.areEqual(10, controller.totalRecords, 'Total records should match');
        Assert.areEqual(2, controller.totalPages, 'Total pages should match');
    }

    @isTest
    static void testLoadDataByStudentCode() {
        Class__c testClass = new Class__c();
        insert testClass;

        List<Student__c> testStudents = new List<Student__c>();
        for(Integer i = 0; i < 10; i++) {
            testStudents.add(new Student__c(
                FirstName__c = 'John',
                LastName__c = 'Doe' + i,
                Class_look__c = testClass.Id,
                Gender__c = 'Male',
                BirthDay__c = Date.valueOf('2002-11-23')
            ));
        }
        insert testStudents;
        testStudents = [SELECT Id, StudentCode__c FROM Student__c];

        VF_SearchStudentCtrl controller = new VF_SearchStudentCtrl();
        controller.searchByStudentCode = testStudents[2].StudentCode__c;

        Test.startTest();
        controller.loadData();
        Test.stopTest();

        Assert.areEqual(1, controller.totalRecords, 'Total records should match');
        Assert.areEqual(1, controller.totalPages, 'Total pages should match');
        Assert.areEqual(testStudents[2].Id, controller.students[0].Id, 'Student should match');
    }

    @isTest
    static void testLoadDataByGender() {
        Class__c testClass = new Class__c();
        insert testClass;

        List<Student__c> testStudents = new List<Student__c>();
        for(Integer i = 0; i < 10; i++) {
            testStudents.add(new Student__c(
                FirstName__c = 'John',
                LastName__c = 'Doe' + i,
                Class_look__c = testClass.Id,
                Gender__c = 'Male',
                BirthDay__c = Date.valueOf('2002-11-23')
            ));
        }
        insert testStudents;

        VF_SearchStudentCtrl controller = new VF_SearchStudentCtrl();
        controller.searchByGender = 'Male';

        Test.startTest();
        controller.loadData();
        Test.stopTest();

        Assert.areEqual(10, controller.totalRecords, 'Total records should match');
        Assert.areEqual(2, controller.totalPages, 'Total pages should match');
    }

    @isTest
    static void testLoadDataByClass() {
        Class__c testClass = new Class__c();
        insert testClass;

        List<Student__c> testStudents = new List<Student__c>();
        for(Integer i = 0; i < 10; i++) {
            testStudents.add(new Student__c(
                FirstName__c = 'John',
                LastName__c = 'Doe' + i,
                Class_look__c = testClass.Id,
                Gender__c = 'Male',
                BirthDay__c = Date.valueOf('2002-11-23')
            ));
        }
        insert testStudents;

        VF_SearchStudentCtrl controller = new VF_SearchStudentCtrl();
        controller.searchByClass = testClass.Id;

        Test.startTest();
        controller.loadData();
        Test.stopTest();

        Assert.areEqual(10, controller.totalRecords, 'Total records should match');
        Assert.areEqual(2, controller.totalPages, 'Total pages should match');
    }

    @isTest
    static void testLoadDataByBirthDay() {
        Class__c testClass = new Class__c();
        insert testClass;

        List<Student__c> testStudents = new List<Student__c>();
        for(Integer i = 0; i < 10; i++) {
            testStudents.add(new Student__c(
                FirstName__c = 'John',
                LastName__c = 'Doe' + i,
                Class_look__c = testClass.Id,
                Gender__c = 'Male',
                BirthDay__c = Date.valueOf('2002-11-23')
            ));
        }
        insert testStudents;

        VF_SearchStudentCtrl controller = new VF_SearchStudentCtrl();
        controller.searchByBirthday = Date.valueOf('2002-11-23');

        Test.startTest();
        controller.loadData();
        Test.stopTest();

        Assert.areEqual(10, controller.totalRecords, 'Total records should match');
        Assert.areEqual(2, controller.totalPages, 'Total pages should match');
    }

    @isTest
    static void testLoadDataByYear() {
        Class__c testClass = new Class__c();
        insert testClass;

        List<Student__c> testStudents = new List<Student__c>();
        for(Integer i = 0; i < 10; i++) {
            testStudents.add(new Student__c(
                FirstName__c = 'John',
                LastName__c = 'Doe' + i,
                Class_look__c = testClass.Id,
                Gender__c = 'Male',
                BirthDay__c = Date.valueOf('2002-11-23')
            ));
        }
        insert testStudents;

        VF_SearchStudentCtrl controller = new VF_SearchStudentCtrl();
        controller.searchByYear = 2002;

        Test.startTest();
        controller.loadData();
        Test.stopTest();

        Assert.areEqual(10, controller.totalRecords, 'Total records should match');
        Assert.areEqual(2, controller.totalPages, 'Total pages should match');
    }

    @isTest
    static void testLoadDataByMonth() {
        Class__c testClass = new Class__c();
        insert testClass;

        List<Student__c> testStudents = new List<Student__c>();
        for(Integer i = 0; i < 10; i++) {
            testStudents.add(new Student__c(
                FirstName__c = 'John',
                LastName__c = 'Doe' + i,
                Class_look__c = testClass.Id,
                Gender__c = 'Male',
                BirthDay__c = Date.valueOf('2002-11-23')
            ));
        }
        insert testStudents;

        VF_SearchStudentCtrl controller = new VF_SearchStudentCtrl();
        controller.searchByMonth = 11;

        Test.startTest();
        controller.loadData();
        Test.stopTest();

        Assert.areEqual(10, controller.totalRecords, 'Total records should match');
        Assert.areEqual(2, controller.totalPages, 'Total pages should match');
    }

    @isTest
    static void testLoadDataByDay() {
        Class__c testClass = new Class__c();
        insert testClass;

        List<Student__c> testStudents = new List<Student__c>();
        for(Integer i = 0; i < 10; i++) {
            testStudents.add(new Student__c(
                FirstName__c = 'John',
                LastName__c = 'Doe' + i,
                Class_look__c = testClass.Id,
                Gender__c = 'Male',
                BirthDay__c = Date.valueOf('2002-11-23')
            ));
        }
        insert testStudents;

        VF_SearchStudentCtrl controller = new VF_SearchStudentCtrl();
        controller.searchByDay = 23;

        Test.startTest();
        controller.loadData();
        Test.stopTest();

        Assert.areEqual(10, controller.totalRecords, 'Total records should match');
        Assert.areEqual(2, controller.totalPages, 'Total pages should match');
    }

    @IsTest
    private static void testGetPages() {
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

        Assert.areEqual(6, count);
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

        Assert.areEqual(6, count);
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

        Assert.areEqual(7, count);
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

        Assert.areEqual(11, count);
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

        Assert.areEqual(11, count);
    }

    @IsTest
    private static void testSetStudent() {
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

        Test.startTest();
        VF_SearchStudentCtrl ctrl = new VF_SearchStudentCtrl();
        ctrl.studentId = student.Id;
        ctrl.setStudent();
        Test.stopTest();

        testClass = [SELECT Id, Name FROM Class__c WHERE Id =: testClass.Id];
        Assert.areEqual(student.Id, ctrl.student.Id, 'Student Id should match');
        Assert.areEqual(testClass.Name, ctrl.className, 'Class name should match');
    }

    @IsTest
    private static void testSetStudentWithNull() {
        Test.startTest();
        VF_SearchStudentCtrl ctrl = new VF_SearchStudentCtrl();
        ctrl.setStudent();
        Test.stopTest();
        
        Assert.areEqual(null, ctrl.student.FirstName__c, 'Student Id should match');
    }

    @IsTest
    private static void testGetOptions() {
        List<Class__c> listClass = new List<Class__c>();
        listClass.add(new Class__c());
        listClass.add(new Class__c());
        insert listClass;

        Test.startTest();
        VF_SearchStudentCtrl ctrl = new VF_SearchStudentCtrl();
        List<SelectOption> listSelectOptions = ctrl.getOptions();
        Test.stopTest();

        listClass = [SELECT Id, Name FROM Class__c];
        Assert.areEqual(listClass.size() + 1, listSelectOptions.size(), 'Number of options should match number of test classes');
        for (Integer i = 1; i < listSelectOptions.size(); i++) {
            Assert.areEqual(listClass[i-1].Id, listSelectOptions[i].getValue(), 'Option value should match class Id');
            Assert.areEqual(listClass[i-1].Name, listSelectOptions[i].getLabel(), 'Option label should match class Name');
        }
    }

    @IsTest
    private static void testGetGenderOptions() {
        Test.startTest();
        VF_SearchStudentCtrl ctrl = new VF_SearchStudentCtrl();
        List<SelectOption> listGenderOptions = ctrl.getGenderOptions();
        Test.stopTest();

        Assert.areEqual(3, listGenderOptions.size(), 'Number of options should match number of test classes');
    }

    @IsTest
    private static void testGetFirstPage() {
        VF_SearchStudentCtrl ctrl = new VF_SearchStudentCtrl();

        Test.startTest();
        PageReference page = ctrl.getFirstPage();
        Test.stopTest();

        Assert.areEqual(1, ctrl.pageNumber);
        Assert.areEqual(null, page);
    }

    @IsTest
    private static void testHandlePreviousPage() {
        VF_SearchStudentCtrl ctrl = new VF_SearchStudentCtrl();
        ctrl.pageNumber = 3;

        Test.startTest();
        PageReference page = ctrl.handlePreviousPage();
        Test.stopTest();

        Assert.areEqual(2, ctrl.pageNumber);
        Assert.areEqual(null, page);
    }

    @IsTest
    private static void testHandleNextPage() {
        VF_SearchStudentCtrl ctrl = new VF_SearchStudentCtrl();
        ctrl.pageNumber = 3;

        Test.startTest();
        PageReference page = ctrl.handleNextPage();
        Test.stopTest();

        Assert.areEqual(4, ctrl.pageNumber);
        Assert.areEqual(null, page);
    }

    @IsTest
    private static void testGetlastPage() {
        VF_SearchStudentCtrl ctrl = new VF_SearchStudentCtrl();
        ctrl.totalPages = 3;

        Test.startTest();
        PageReference page = ctrl.getlastPage();
        Test.stopTest();

        Assert.areEqual(3, ctrl.pageNumber);
        Assert.areEqual(null, page);
    }

    @IsTest
    private static void testMoveToPage() {
        VF_SearchStudentCtrl ctrl = new VF_SearchStudentCtrl();
        ctrl.pageNumber = 3;

        Test.startTest();
        PageReference page = ctrl.moveToPage();
        Test.stopTest();

        Assert.areEqual(null, page);
    }

    @IsTest
    private static void testHasPreviousPage() {

        Test.startTest();
        VF_SearchStudentCtrl ctrl = new VF_SearchStudentCtrl();
        ctrl.pageNumber = 3;
        Test.stopTest();

        Assert.areEqual(true, ctrl.hasPreviousPage);
    }

    @IsTest
    private static void testHasNotPreviousPage() {

        Test.startTest();
        VF_SearchStudentCtrl ctrl = new VF_SearchStudentCtrl();
        ctrl.pageNumber = 1;
        Test.stopTest();

        Assert.areEqual(false, ctrl.hasPreviousPage);
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
        VF_SearchStudentCtrl ctrl = new VF_SearchStudentCtrl();
        ctrl.student = student;
        ctrl.createStudent();
        Test.stopTest();

        Assert.areEqual(student.Id, ctrl.students[0].Id);
    }

    @IsTest
    private static void testCreateStudentFail() {

        Student__c student = new Student__c(
            FirstName__c = 'Student',
            LastName__c = 'Test',
            Gender__c = 'Male',
            BirthDay__c = Date.valueOf('2002-11-23')
        );

        VF_SearchStudentCtrl ctrl = new VF_SearchStudentCtrl();
        ctrl.student = student;

        Test.startTest();
        ctrl.createStudent();
        Test.stopTest();
        
        Assert.areEqual(0, ctrl.students.size());
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

        Test.startTest();
        VF_SearchStudentCtrl ctrl = new VF_SearchStudentCtrl();
        ctrl.student = student;
        ctrl.updateStudent();
        Test.stopTest();

        List<ApexPages.Message> messages = ApexPages.getMessages();
        try {
            Assert.areEqual('Update successful', messages.get(0).getSummary());
        } catch (Exception e) {
            Assert.isTrue(false);
        }
    }

    @IsTest
    private static void testUpdateStudentFail() {
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
        VF_SearchStudentCtrl ctrl = new VF_SearchStudentCtrl();
        ctrl.student = student;
        ctrl.updateStudent();
        Test.stopTest();

        List<ApexPages.Message> messages = ApexPages.getMessages();
        try {
            Assert.areNotEqual('Update successful', messages.get(0).getSummary());
        } catch (Exception e) {
            Assert.isTrue(false);
        }
    }

    @IsTest
    private static void testDeleteStudentSuccess() {
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
        VF_SearchStudentCtrl ctrl = new VF_SearchStudentCtrl();
        ctrl.student = student;
        ctrl.deleteStudent();
        Test.stopTest();

        List<ApexPages.Message> messages = ApexPages.getMessages();
        try {
            Assert.areEqual('Delete successful', messages.get(0).getSummary());
        } catch (Exception e) {
            Assert.isTrue(false);
        }
    }

    @IsTest
    private static void testDeleteStudentFail() {
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
        VF_SearchStudentCtrl ctrl = new VF_SearchStudentCtrl();
        ctrl.student = student;
        ctrl.deleteStudent();
        Test.stopTest();

        List<ApexPages.Message> messages = ApexPages.getMessages();
        try {
            Assert.areNotEqual('Delete successful', messages.get(0).getSummary());
        } catch (Exception e) {
            Assert.isTrue(false);
        }
    }

    @Istest
    private static void testDeleteSelectedStudentSuccess() {
        Class__c cl = new Class__c();
        insert cl;

        List<Student__c> students = new List<Student__c>();
        for(Integer i = 0; i < 5; i++) {
            students.add( new Student__c(
                FirstName__c = 'Student',
                LastName__c = String.valueOf(i+1),
                Class_look__c = cl.Id,
                Gender__c = 'Male',
                BirthDay__c = Date.valueOf('2002-11-23')
            ));
        }
        insert students;

        VF_SearchStudentCtrl ctrl = new VF_SearchStudentCtrl();
        for (Student__c st : ctrl.students) {
            ctrl.selectedStudent.put(st.StudentCode__c, true);
        }

        Test.startTest();
        ctrl.deleteSelectedStudent();
        Test.stopTest();

        students = [SELECT Id FROM Student__c];
        Assert.areEqual(0, students.size());

        List<ApexPages.Message> messages = ApexPages.getMessages();
        try {
            Assert.areEqual('Delete successful', messages.get(0).getSummary());
        } catch (Exception e) {
            Assert.isTrue(false);
        }
    }

    @IsTest
    private static void testSelectedAllStudent() {
        Class__c cl = new Class__c();
        insert cl;

        List<Student__c> students = new List<Student__c>();
        for(Integer i = 0; i < 5; i++) {
            students.add( new Student__c(
                FirstName__c = 'Student',
                LastName__c = String.valueOf(i+1),
                Class_look__c = cl.Id,
                Gender__c = 'Male',
                BirthDay__c = Date.valueOf('2002-11-23')
            ));
        }
        insert students;

        VF_SearchStudentCtrl ctrl = new VF_SearchStudentCtrl();

        Test.startTest();
        ctrl.selectAllStudent();
        Test.stopTest();

        Assert.areEqual(5, ctrl.countSelected);
    }

    @IsTest
    private static void testClearSelectedAllStudent() {
        Class__c cl = new Class__c();
        insert cl;

        List<Student__c> students = new List<Student__c>();
        for(Integer i = 0; i < 5; i++) {
            students.add( new Student__c(
                FirstName__c = 'Student',
                LastName__c = String.valueOf(i+1),
                Class_look__c = cl.Id,
                Gender__c = 'Male',
                BirthDay__c = Date.valueOf('2002-11-23')
            ));
        }
        insert students;

        VF_SearchStudentCtrl ctrl = new VF_SearchStudentCtrl();
        for (Student__c st : ctrl.students) {
            ctrl.selectedStudent.put(st.StudentCode__c, true);
        }

        Test.startTest();
        ctrl.clearSelectedStudent();
        Test.stopTest();

        for (String key : ctrl.selectedStudent.keySet()) {
            Assert.areEqual(false, ctrl.selectedStudent.get(key));
        }
        Assert.areEqual(0, ctrl.countSelected);
    }

    @IsTest
    private static void testSelectStudent() {
        Class__c cl = new Class__c();
        insert cl;

        List<Student__c> students = new List<Student__c>();
        for(Integer i = 0; i < 5; i++) {
            students.add( new Student__c(
                FirstName__c = 'Student',
                LastName__c = String.valueOf(i+1),
                Class_look__c = cl.Id,
                Gender__c = 'Male',
                BirthDay__c = Date.valueOf('2002-11-23')
            ));
        }
        insert students;
        
        students = [SELECT Id, StudentCode__c FROM Student__c];

        VF_SearchStudentCtrl ctrl = new VF_SearchStudentCtrl();
        ctrl.studentCode = students[0].StudentCode__c;
        
        Test.startTest();
        ctrl.selectStudent();
        Test.stopTest();
        
        Assert.areEqual(false, ctrl.selectedStudent.get(students[0].StudentCode__c));
    }
}