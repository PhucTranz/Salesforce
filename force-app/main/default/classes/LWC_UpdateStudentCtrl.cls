/**
 * クラス名：LWC_UpdateStudentCtrl
 * クラス概要：Update student controller
 * @created：2024/01/11 Tran Dinh Phuc
 * @modified：
 */
public with sharing class LWC_UpdateStudentCtrl {

    /**
     * getStudentByID
     * @param：String studentId
     * @return：Student__c
     * @created：2024/01/11 Tran Dinh Phuc
     * @modified：
     */
    @AuraEnabled
    public static Student__c getStudentByID(String studentId){
        try {
            return 
            [
                SELECT 
                Id,
                Address__c, 
                BirthDay__c, 
                Class_look__r.Name, 
                FirstName__c, 
                Gender__c, 
                LastName__c, 
                StudentCode__c 
                FROM Student__c 
                WHERE Id = :studentId
            ];
        } catch (Exception e) {
            throw new CustomException(e.getMessage());
        }
    }

    /**
     * updateStudent
     * @param：Student__c student
     * @return：なし
     * @created：2024/01/11 Tran Dinh Phuc
     * @modified：
     */
    @AuraEnabled
    public static void updateStudent(Student__c student){
        try{
            if(String.isNotBlank(student.FirstName__c) && String.isNotBlank(student.LastName__c)) {
                student.Name = student.FirstName__c.left(39) + ' ' +  student.LastName__c.left(39);
            } else if (String.isBlank(student.FirstName__c)) {
                student.Name = student.LastName__c.left(80);
            } else if (String.isBlank(student.LastName__c)) {
                student.Name = student.FirstName__c.left(80);
            }

            update student;
        } catch (Exception e) {
            throw new CustomException(e.getMessage());
        }
    }

    public class CustomException extends Exception {}
}