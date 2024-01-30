/**
 * クラス名：LWC_DetailStudentCtrl
 * クラス概要：Detail student controller
 * @created：2024/01/12 Tran Dinh Phuc
 * @modified：
 */
public with sharing class LWC_DetailStudentCtrl {

    /**
     * getStudentByID
     * @param：String studentId
     * @return：Student__c
     * @created：2024/01/12 Tran Dinh Phuc
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
                StudentCode__c,
                LearningStatus__c,
                GPAScore__c,
                TotalCredit__c
                FROM Student__c 
                WHERE Id = :studentId
            ];
        } catch (Exception e) {
            throw new CustomException(e.getMessage());
        }
    }

    /**
     * getListSemester
     * @param：なし
     * @return：List<Semester__c>
     * @created：2024/01/30 Tran Dinh Phuc
     * @modified：
     */
    @AuraEnabled
    public static List<Semester__c> getListSemester(){
        try {
            return 
                [
                    SELECT 
                    ID,
                    Name 
                    FROM Semester__c 
                    ORDER BY Name ASC
                ];
        } catch (Exception e) {
            throw new CustomException(e.getMessage());
        }
    }

    /**
     * getSubjectScore
     * @param：String studentId
     * @return：List<SubjectScore__c>
     * @created：2024/01/30 Tran Dinh Phuc
     * @modified：
     */
    @AuraEnabled
    public static List<SubjectScore__c> getSubjectScore(String studentId){
        try {
            return 
            [
                SELECT 
                Id,
                Semester_look__r.Id, 
                Semester_look__r.Name, 
                Subject_look__r.Name,
                Subject_look__r.SubjectCode__c,
                Subject_look__r.CourseCredit__c, 
                AverageScore__c,
                Status__c,
                (SELECT Id, ExamType__c, Score__c FROM Score__r)
                FROM SubjectScore__c 
                WHERE Student_look__c = :studentId
                ORDER BY Subject_look__r.Name
            ];
        } catch (Exception e) {
            throw new CustomException(e.getMessage());
        }
    }

    public class CustomException extends Exception {}
}