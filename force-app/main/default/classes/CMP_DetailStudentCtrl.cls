/**
 * クラス名：CMP_DetailStudentCtrl
 * クラス概要：Detail student controller
 * @created：2023/12/27 Tran Dinh Phuc
 * @modified：
 */
public with sharing class CMP_DetailStudentCtrl {
    /**
     * クラス名：CMP_DetailStudentCtrl
     * @created：2023/12/27 Tran Dinh Phuc
     * @modified：
     */
    public CMP_DetailStudentCtrl() {

    }

    /**
     * getStudentByID
     * @param：String studentId
     * @return：Student__c
     * @created：2023/12/27 Tran Dinh Phuc
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
                Class__r.Name, 
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

    public class CustomException extends Exception {}
}