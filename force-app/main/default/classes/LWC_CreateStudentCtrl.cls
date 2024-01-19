/**
 * クラス名：LWC_CreateStudentCtrl
 * クラス概要：Create student controller
 * @created：2024/01/11 Tran Dinh Phuc
 * @modified：
 */
public with sharing class LWC_CreateStudentCtrl {
    
    /**
     * createStudent
     * @param：Student__c student
     * @return：なし
     * @created：2024/01/11 Tran Dinh Phuc
     * @modified：
     */
    @AuraEnabled
    public static void createStudent(String studentJson){
        try {
            Student__c student = (Student__c) JSON.deserialize(studentJson, Student__c.class);
            
            if(String.isNotBlank(student.FirstName__c) && String.isNotBlank(student.LastName__c)) {
                student.Name = student.FirstName__c.left(39) + ' ' +  student.LastName__c.left(39);
            } else if (String.isBlank(student.FirstName__c)) {
                student.Name = student.LastName__c.left(80);
            } else if (String.isBlank(student.LastName__c)) {
                student.Name = student.FirstName__c.left(80);
            }
            
            insert student;
        } catch (Exception e) {
            throw new CustomException(e.getMessage());
        }
    }

    public class CustomException extends Exception {}
}