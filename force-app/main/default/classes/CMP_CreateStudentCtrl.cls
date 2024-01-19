/**
 * クラス名：CMP_CreateStudentCtrl
 * クラス概要：Create student controller
 * @created：2023/12/25 Tran Dinh Phuc
 * @modified：
 */
public with sharing class CMP_CreateStudentCtrl {
    /**
     * クラス名：CMP_CreateStudentCtrl
     * @created：2023/12/25 Tran Dinh Phuc
     * @modified：
     */
    public CMP_CreateStudentCtrl() {
        
    }

    /**
     * init
     * @param：なし
     * @return：Student__c
     * @created：2023/12/25 Tran Dinh Phuc
     * @modified：
     */
    @AuraEnabled
    public static Student__c init(){
        try {
            return new Student__c();
        } catch (Exception e) {
            throw new CustomException(e.getMessage());
        }
    }

    /**
     * createStudent
     * @param：Student__c student
     * @return：なし
     * @created：2023/12/27 Tran Dinh Phuc
     * @modified：
     */
    @AuraEnabled
    public static void createStudent(Student__c student){
        try {
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