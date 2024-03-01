@IsTest
private class T01_StudentTriggerHandlerTest {
    @IsTest
    private static void testBeforeInsertOrUpdate() {
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

        Test.startTest();
        T01_StudentTriggerHandler.beforeInsertOrUpdate(students);
        Test.stopTest();

        Assert.isTrue(!students[0].HasErrors());
    }

    @IsTest
    private static void testBeforeInsertOrUpdate_Exception1() {
        Class__c cl = new Class__c();
        insert cl;

        List<Student__c> students = new List<Student__c>();
        for (Integer i = 0; i < 5; i++) {
            students.add( new Student__c());
        }

        Test.startTest();
        T01_StudentTriggerHandler.beforeInsertOrUpdate(students);
        Test.stopTest();

        Assert.areEqual('値を入力してください: LastName__c, FirstName__c, Class_look__c, BirthDay__c, Gender__c', students[0].getErrors()[0].getMessage());
    }

    @IsTest
    private static void testBeforeInsertOrUpdate_Exception2() {
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
                BirthDay__c = Date.valueOf('2022-11-23')
            ));
        }

        Test.startTest();
        T01_StudentTriggerHandler.beforeInsertOrUpdate(students);
        Test.stopTest();

        Assert.areEqual('学生の年齢が無効です。有効な年齢は18歳以上です。', students[0].getErrors()[0].getMessage());
    }

    @IsTest
    private static void testAfterInsert() {
        Class__c cl = new Class__c(NumberOfStudent__c = 0);
        insert cl;

        List<Student__c> students = new List<Student__c>();
        for (Integer i = 0; i < 10; i++) {
            students.add( new Student__c(
                FirstName__c = 'Student',
                LastName__c = 'Test',
                Class_look__c = cl.Id,
                Gender__c = 'Male',
                BirthDay__c = Date.valueOf('2022-11-23'),
                LearningStatus__c = 'Enrolled'
            ));
        }

        Test.startTest();
        T01_StudentTriggerHandler.afterInsert(students);
        Test.stopTest();

        Class__c updatedClass = [SELECT Id, NumberOfStudent__c FROM Class__c WHERE Id =: cl.Id];
        Assert.areEqual(10, updatedClass.NumberOfStudent__c);
    }

    @IsTest
    private static void testAfterDelete() {
        Class__c cl = new Class__c(NumberOfStudent__c = 10);
        insert cl;

        List<Student__c> students = new List<Student__c>();
        for (Integer i = 0; i < 10; i++) {
            students.add( new Student__c(
                FirstName__c = 'Student',
                LastName__c = 'Test',
                Class_look__c = cl.Id,
                Gender__c = 'Male',
                BirthDay__c = Date.valueOf('2022-11-23'),
                LearningStatus__c = 'Enrolled'
            ));
        }

        Test.startTest();
        T01_StudentTriggerHandler.afterDelete(students);
        Test.stopTest();

        Class__c updatedClass = [SELECT Id, NumberOfStudent__c FROM Class__c WHERE Id =: cl.Id];
        Assert.areEqual(0, updatedClass.NumberOfStudent__c);
    }

    @IsTest
    private static void testAfterUpdate() {
        List<Class__c> classes = new List<Class__c>();
        classes.add(new Class__c(NumberOfStudent__c = 3));
        classes.add(new Class__c(NumberOfStudent__c = 0));
        insert classes;

        List<Student__c> oldStudents = new List<Student__c>();
        for (Integer i = 0; i < 3; i++) {
            oldStudents.add( new Student__c(
                FirstName__c = 'Student',
                LastName__c = 'Test',
                Class_look__c = classes[0].Id,
                Gender__c = 'Male',
                BirthDay__c = Date.valueOf('2022-11-23'),
                LearningStatus__c = 'Enrolled'
            ));
        }

        List<Student__c> newStudents = new List<Student__c>();
        for (Student__c st : oldStudents) {
            Student__c newStudent = st.clone();
            newStudent.Class_look__c = classes[1].Id;
            newStudents.add(newStudent);
        }
        
        Test.startTest();
        T01_StudentTriggerHandler.afterUpdate(oldStudents, newStudents);
        Test.stopTest();

        List<Class__c> updatedClasses = [SELECT Id, NumberOfStudent__c FROM Class__c WHERE Id IN :classes];
        Assert.areEqual(0, updatedClasses[0].NumberOfStudent__c);
        Assert.areEqual(3, updatedClasses[1].NumberOfStudent__c);
    }

    @IsTest
    private static void testBeforeDelete() {
        Class__c cl = new Class__c();
        insert cl;

        List<Student__c> students = new List<Student__c>();
        for (Integer i = 0; i < 3; i++) {
            students.add( new Student__c(
                FirstName__c = 'Student',
                LastName__c = 'Test',
                Class_look__c = cl.Id,
                Gender__c = 'Male',
                BirthDay__c = Date.valueOf('2022-11-23'),
                LearningStatus__c = 'Enrolled'
            ));
        }

        List<SubjectScore__c> subjectScore = new List<SubjectScore__c>();
        for (Student__c st: students) {
            subjectScore.add(new SubjectScore__c(Student_look__c = st.Id));
            subjectScore.add(new SubjectScore__c(Student_look__c = st.Id));
        }
        insert subjectScore;

        Test.startTest();
        T01_StudentTriggerHandler.beforeDelete(students);
        Test.stopTest();

        List<SubjectScore__c> result = [SELECT Id FROM SubjectScore__c WHERE Student_look__c IN :students];
        Assert.areEqual(0, result.size());
    }
}