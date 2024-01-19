/**
 * クラス名：LWC_SearchStudentCtrl
 * クラス概要：Search student controller
 * @created：2024/01/08 Tran Dinh Phuc
 * @modified：
 */
public with sharing class LWC_SearchStudentCtrl {

    /**
     * クラス名：StudentSearchDTO
     * クラス概要：DTO
     * @created：2024/01/11 Tran Dinh Phuc
     * @modified：
     */
    public class StudentSearchDTO {
        @AuraEnabled 
        public String searchByName {get; set;}
        @AuraEnabled 
        public String searchByClass {get; set;}
        @AuraEnabled 
        public String searchByStudentCode {get; set;}
        @AuraEnabled 
        public String searchByGender {get; set;}        
        @AuraEnabled 
        public Date searchByBirthday {get; set;}
        @AuraEnabled
        public Integer searchByYear {get; set;}
        @AuraEnabled 
        public Integer searchByMonth {get; set;}
        @AuraEnabled 
        public Integer searchByDay {get; set;}
    }

    /**
     * searchCondition
     * @param：String searchByName
     * @param：String searchByClass
     * @param：String searchByStudentCode
     * @param：String searchByGender
     * @param：Date searchByBirthday
     * @param：Integer searchByYear
     * @param：Integer searchByMonth
     * @param：Integer searchByDay
     * @return：List<Student__c>
     * @created：2024/01/08 Tran Dinh Phuc
     * @modified：
     */
    @AuraEnabled
    public static List<Student__c> searchCondition(String searchJSON){
        StudentSearchDTO searchDTO = (StudentSearchDTO) JSON.deserialize(searchJSON, StudentSearchDTO.class);
        
        String searchByClass = searchDTO.searchByClass;
        Date searchByBirthDay = searchDTO.searchByBirthday;
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

        if (String.isNotBlank(searchDTO.searchByName)) {
            lstWhereConditions.add(' Name LIKE \'%' + String.escapeSingleQuotes(searchDTO.searchByName.trim()) + '%\'');
        }

        if (String.isNotBlank(searchDTO.searchByStudentCode)) {
            lstWhereConditions.add(' StudentCode__c LIKE \'%' + String.escapeSingleQuotes(searchDTO.searchByStudentCode.trim()) + '%\'');
        }

        if (String.isNotBlank(searchDTO.searchByGender)) {
            lstWhereConditions.add(' Gender__c = ' + Boolean.valueOf(searchDTO.searchByGender));
        }

        if (String.isNotBlank(searchDTO.searchByClass)) {
            lstWhereConditions.add(' Class__c = :searchByClass');
        }

        if (searchDTO.searchByBirthday != null) {
            lstWhereConditions.add(' BirthDay__c = :searchByBirthDay');
        }

        if(searchDTO.searchByYear != 0 && searchDTO.searchByYear != null){
            lstWhereConditions.add(' CALENDAR_YEAR(BirthDay__c) = ' + searchDTO.searchByYear);
        }

        if(searchDTO.searchByMonth != 0 && searchDTO.searchByMonth != null){
            lstWhereConditions.add(' CALENDAR_MONTH(BirthDay__c) = ' + searchDTO.searchByMonth);
        }

        if(searchDTO.searchByDay != 0 && searchDTO.searchByDay != null){
            lstWhereConditions.add(' DAY_IN_MONTH(BirthDay__c) = ' + searchDTO.searchByDay);
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
     * @created：2024/01/09 Tran Dinh Phuc
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
     * delSelectedStudent
     * @param：List<String> studentCodes
     * @return：なし
     * @created：2024/01/10 Tran Dinh Phuc
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