/**
 * クラス名：VF_DetailStudentCtrl
 * クラス概要：View student's information
 * @created：2023/12/14 Tran Dinh Phuc
 * @modified：
 */
public with sharing class VF_DetailStudentCtrl {

    public Student__c student {get; set;}
    public String className {get; set;}

    /**
     * クラス名：VF_DetailStudentCtrl
     * @created：2023/12/14 Tran Dinh Phuc
     * @modified：
     */
    public VF_DetailStudentCtrl() {
        String studentId = ApexPages.currentPage().getParameters().get('studentId');
        this.student = [SELECT Address__c, BirthDay__c, Class_look__c, FirstName__c, Gender__c, LastName__c, StudentCode__c FROM Student__c WHERE Id = :studentId];
        Class__c cl = [SELECT Name FROM Class__c WHERE Id = :student.Class_look__c];
        this.className = cl.Name;
    }

}