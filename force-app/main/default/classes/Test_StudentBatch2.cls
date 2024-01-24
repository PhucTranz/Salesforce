public with sharing class Test_StudentBatch2 implements Database.Batchable<sObject>{
    public Database.QueryLocator start(Database.BatchableContext bc) {
        return Database.getQueryLocator('SELECT Id, Class_look__c FROM Student__c');
    }

    public void execute(Database.BatchableContext bc, List<Student__c> students) {
        List<Class__c> classes = [SELECT Id, ClassCode__c FROM Class__c ORDER BY ClassCode__c];
    
        Map<Integer,String> mapClasses = new Map<Integer,String>();
        for (Class__c cl: classes) {
            mapClasses.put(Integer.valueOf(cl.ClassCode__c), cl.Id);
        }
        
        Integer a = null;
        Integer b = null;
        if (!classes.isEmpty()) {
            a = Integer.valueOf(classes[0].ClassCode__c);
            b = Integer.valueOf(classes[classes.size() - 1].ClassCode__c);
        }
        
        if (a != null && b != null){
            for (Student__c student: students) {
                if (student.Class_look__c != null) {
                    Integer randomClass = Integer.valueOf(Math.random() * (b - a + 1)) + a;
                    student.Class_look__c = mapClasses.get(randomClass);
                }
            }
        }
        
        update students;
    }

    public void finish(Database.BatchableContext bc) {
        System.debug('oke');
    }
}