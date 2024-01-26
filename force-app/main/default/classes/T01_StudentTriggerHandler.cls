public without sharing class T01_StudentTriggerHandler {

    public static void beforeInsertOrUpdate(List<Student__c> newStudents) {
        for (Student__c student : newStudents) {
            List<String> listErr = new List<String>();
            
            if (String.isBlank(student.LastName__c)) {
                listErr.add(' LastName__c');
            }
            if (String.isBlank(student.FirstName__c)) {
                listErr.add(' FirstName__c');
            }
            if (String.isBlank(student.Class_look__c)) {
                listErr.add(' Class_look__c');
            }
            if (student.BirthDay__c != null) {
                Integer currentYear = System.now().year();
                if (currentYear - student.BirthDay__c.year() < 18) {
                    student.BirthDay__c.addError('学生の年齢が無効です。有効な年齢は18歳以上です。');
                }
            } else {
                listErr.add(' BirthDay__c');
            }
            if (String.isBlank(student.Gender__c)) {
                listErr.add(' Gender__c');
            }

            if (listErr.size() > 0) {
                String message = '値を入力してください: '+ String.join(listErr, ', ');
                student.addError(message);
            }
        }
    }

    public static void afterInsert(List<Student__c> newStudents) {
        try {
            Map<Id,Integer> classCount = new Map<Id, Integer>();

            for (Student__c student: newStudents) {
                if (student.LearningStatus__c == 'Enrolled') {
                    if (classCount.containsKey(student.Class_look__c)) {
                        Integer value = classCount.get(student.Class_look__c) + 1;
                        classCount.put(student.Class_look__c, value);
                    } else {
                        classCount.put(student.Class_look__c, 1);
                    }
                }
            }

            List<Class__c> classes = [SELECT Id, NumberOfStudent__c FROM Class__c WHERE Id = :classCount.keySet()];

            for (Class__c cl: classes) {
                cl.NumberOfStudent__c += classCount.get(cl.Id);
            }
            if (classes.size() > 0) {
                update classes;
            }
        } catch (Exception e) {
            System.debug(e);
        }
    }

    public static void afterDelete(List<Student__c> oldStudents) {
        try {
            Map<Id,Integer> classCount = new Map<Id, Integer>();

            for (Student__c student: oldStudents) {
                if (student.LearningStatus__c == 'Enrolled') {
                    if (classCount.containsKey(student.Class_look__c)) {
                        Integer value = classCount.get(student.Class_look__c) + 1;
                        classCount.put(student.Class_look__c, value);
                    } else {
                        classCount.put(student.Class_look__c, 1);
                    }
                }
            }

            List<Class__c> classes = [SELECT Id, NumberOfStudent__c FROM Class__c WHERE Id = :classCount.keySet()];

            for (Class__c cl: classes) {
                cl.NumberOfStudent__c -= classCount.get(cl.Id);
            }
            if (classes.size() > 0) {
                update classes;
            }
        } catch (Exception e) {
            System.debug(e);
        }
    }

    public static void afterUpdate(List<Student__c> oldStudents, List<Student__c> newStudents) {
        afterDelete(oldStudents);
        afterInsert(newStudents);
    }

    public static void beforeDelete(List<Student__c> oldStudents) {
        try {
            List<String> studentIds = new List<String>();
            for (Student__c student: oldStudents) {
                studentIds.add(student.Id);
            }

            List<SubjectScore__c> subjectScores = [SELECT Id FROM SubjectScore__c WHERE Student_look__c =: studentIds];
            if (subjectScores.size() > 0) {
                delete subjectScores;
            }
        } catch (Exception e) {
            System.debug(e);
        }
    }
}