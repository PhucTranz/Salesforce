/**
 * クラス名：CMP_SearchStudentCtrl
 * クラス概要：Search student controller
 * @created：2023/12/26 Tran Dinh Phuc
 * @modified：
 */
public with sharing class CMP_SearchStudentCtrl {
    /**
     * クラス名：CMP_SearchStudentCtrl
     * @created：2023/12/26 Tran Dinh Phuc
     * @modified：
     */
    public CMP_SearchStudentCtrl() {

    }

    /**
     * getAllStudent
     * @param：String searchByName
     * @param：String searchByClass
     * @param：String searchByStudentCode
     * @param：String searchByGender
     * @param：Date searchByBirthday
     * @param：Integer searchByYear
     * @param：Integer searchByMonth
     * @param：Integer searchByDay
     * @return：List<Student__c>
     * @created：2024/01/03 Tran Dinh Phuc
     * @modified：
     */
    @AuraEnabled
    public static List<Student__c> getAllStudent(String searchByName, String searchByClass, String searchByStudentCode, String searchByGender, 
                                                Date searchByBirthday, Integer searchByYear, Integer searchByMonth, Integer searchByDay){
        List<Student__c> students = new List<Student__c>();
        String query = 'SELECT Id';
        query += ', Name';
        query += ', Address__c';
        query += ', Gender__c';
        query += ', StudentCode__c';
        query += ', Class__r.Name';
        query += ', BirthDay__c';
        query += ' FROM Student__c';

        List<String> lstWhereConditions = new List<String>();             

        if (String.isNotBlank(searchByName)) {
            lstWhereConditions.add(' Name LIKE \'%' + String.escapeSingleQuotes(searchByName.trim()) + '%\'');
        }

        if (String.isNotBlank(searchByStudentCode)) {
            lstWhereConditions.add(' StudentCode__c LIKE \'%' + String.escapeSingleQuotes(searchByStudentCode.trim()) + '%\'');
        }

        if (String.isNotBlank(searchByGender)) {
            lstWhereConditions.add(' Gender__c = ' + Boolean.valueOf(searchByGender));
        }

        if (String.isNotBlank(searchByClass)) {
            lstWhereConditions.add(' Class__c = :searchByClass');
        }

        if (searchByBirthday != null) {
            lstWhereConditions.add(' BirthDay__c = :searchByBirthday');
        }

        if(searchByYear != 0 && searchByYear != null){
            lstWhereConditions.add(' CALENDAR_YEAR(BirthDay__c) = :searchByYear');
        }

        if(searchByMonth != 0 && searchByMonth != null){
            lstWhereConditions.add(' CALENDAR_MONTH(BirthDay__c) = :searchByMonth');
        }

        if(searchByDay != 0 && searchByDay != null){
            lstWhereConditions.add(' DAY_IN_MONTH(BirthDay__c) = :searchByDay');
        }

        if (!lstWhereConditions.isEmpty()) {
            String whereClause = String.join( lstWhereConditions, ' AND ' );
            query += ' WHERE' + whereClause;
        }
        
        query += ' ORDER BY StudentCode__c DESC';
        students = Database.query(query);
        return students;
    }

    /**
     * getListClass
     * @param：なし
     * @return：List<Class__c>
     * @created：2024/05/01 Tran Dinh Phuc
     * @modified：
     */
    @AuraEnabled
    public static List<Class__c> getListClass(){
        try {
            return 
                [
                    SELECT 
                    ID, 
                    ClassCode__c, 
                    Name 
                    FROM Class__c 
                    ORDER BY ClassCode__c ASC
                ];
        } catch (Exception e) {
            throw new CustomException(e.getMessage());
        }
    }

    /**
     * getStudentByID
     * @param：String studentId
     * @return：Student__c
     * @created：2023/12/28 Tran Dinh Phuc
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

    
    /**
     * delStudentByID
     * @param：String studentId
     * @return：なし
     * @created：2023/12/28 Tran Dinh Phuc
     * @modified：
     */
    @AuraEnabled
    public static void delStudentByID(String studentId){
        try {
            Database.delete(studentId);
        } catch (Exception e) {
            throw new CustomException(e.getMessage());
        }
    }

    /**
     * delSelectedStudent
     * @param：List<String> studentCodes
     * @return：なし
     * @created：2023/12/28 Tran Dinh Phuc
     * @modified：
     */
    @AuraEnabled
    public static void delSelectedStudent(List<String> studentCodes){
        try {
            List<Student__c> listStudent = [SELECT Id FROM Student__c WHERE StudentCode__c = :studentCodes];
            delete listStudent;
        } catch (Exception e) {
            throw new CustomException(e.getMessage());
        }
    }

    public class CustomException extends Exception {}
}