public with sharing class Test_StudentTriggerHandler {
    //update number of students in class when delete student
    public static void afterDeleteHandeler(List<Student__c> students) {
        try {
            Map<Id,Integer> classCount = new Map<Id, Integer>();

            for (Student__c student: students) {
                if (classCount.containsKey(student.Class_look__c)) {
                    Integer value = classCount.get(student.Class_look__c) + 1;
                    classCount.put(student.Class_look__c, value);
                } else {
                    classCount.put(student.Class_look__c, 1);
                }
            }

            List<Class__c> classes = [SELECT Id, NumberOfStudent__c FROM Class__c WHERE Id = :classCount.keySet()];

            for (Class__c cl: classes) {
                cl.NumberOfStudent__c -= classCount.get(cl.Id);
            }

            update classes;
        } catch (Exception e) {
            System.debug(e);
        }
    }
    
    //update number of students in class when insert new student
    public static void afterInsertHandler(List<Student__c> students) {
        try {
            Map<Id,Integer> classCount = new Map<Id, Integer>();

            for (Student__c student: students) {
                if (classCount.containsKey(student.Class_look__c)) {
                    Integer value = classCount.get(student.Class_look__c) + 1;
                    classCount.put(student.Class_look__c, value);
                } else {
                    classCount.put(student.Class_look__c, 1);
                }
            }

            List<Class__c> classes = [SELECT Id, NumberOfStudent__c FROM Class__c WHERE Id = :classCount.keySet()];

            for (Class__c cl: classes) {
                cl.NumberOfStudent__c += classCount.get(cl.Id);
            }

            update classes;
        } catch (Exception e) {
            System.debug(e);
        }
    }

    //update number of students in class when edit student
    public static void afterUpdateHandler(List<Student__c> oldStudents, List<Student__c> newStudents) {
        try {
            afterInsertHandler(newStudents);
            afterDeleteHandeler(oldStudents);
            List<Id> studentIds = new List<Id>();
            for (Student__c student : newStudents) {
                studentIds.add(student.Id);
            }
            makeAddressUpdateFutureCall(studentIds);
        } catch (Exception e) {
            System.debug(e);
        }
    }

    @future
    public static void makeAddressUpdateFutureCall(List<Id> studentIds) {
        List<Student__c> students = [SELECT Id, Address__c FROM Student__c WHERE Id IN :studentIds];
        for (Student__c student : students) {
            student.Address__c = 'Test @future v01';
        }
        update students;
    }

    public static void beforeUpdateHandler(List<Student__c> oldStudents, List<Student__c> newStudents){
        for (Student__c student: newStudents) {
            try {
                if (student.BirthDay__c.year() < 1995) {
                    throw new CustomException();
                }
            } catch (CustomException e) {
                student.addError('Year of birth must be greater than 1995');
            }
        }
    }

    public class CustomException extends Exception {}
}